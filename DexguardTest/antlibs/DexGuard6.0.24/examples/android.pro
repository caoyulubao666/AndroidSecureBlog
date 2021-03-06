#
# This DexGuard configuration file illustrates how to process Android
# applications, outside of the Android Development Tools.
# Usage:
#     java -jar dexguard.jar @android.pro
#
# If you're using the Android SDK, the Ant release build and Eclipse export
# already take care of the proper settings. You only need to enable DexGuard
# by commenting in the corresponding line in project.properties. You can still
# add project-specific configuration in proguard-project.txt.
#
# This configuration file is for custom, stand-alone builds.

# Specify the input jars, output jars, and library jars.
# Note that DexGuard reads Java bytecode (.class) and writes Dalvik code (.dex).

-injars  bin/classes
-injars  libs
-outjars bin/application.apk

-libraryjars /usr/local/android-sdk/platforms/android-15/android.jar
#-libraryjars /usr/local/android-sdk/add-ons/google_apis-7_r01/libs/maps.jar
# ...

# Sign the output apk.
-keystore         /home/user/.android/debug.keystore
-keystorepassword android
-keyalias         AndroiddebugKey
-keypassword      android

# Save the obfuscation mapping to a file, so you can de-obfuscate any stack
# traces later on.

-printmapping bin/classes-processed.map

# You can print out the seeds that are matching the keep options below.

-printseeds bin/classes-processed.seeds

# Align some types of files in the output archive.

-zipalign 4
-dontcompress resources.arsc,**.jpg,**.jpeg,**.png,**.gif,**.wav

# Convert the Java bytecode to Dalvik bytecode.

-dalvik

# Reduce the size of the output some more.

-repackageclasses ''
-allowaccessmodification

# Keep a fixed source file attribute and all line number tables to get line
# numbers in the stack traces.
# You can comment this out if you're not interested in stack traces.
#开启调试模式
-renamesourcefileattribute DexGuard
-keepattributes SourceFile,LineNumberTable

# RemoteViews might need annotations.

-keepattributes *Annotation*

#保持xml的属性名
# Keep the minimally required attribute names in the Android manifest file.

-keepresourcexmlattributenames
    manifest/installLocation,
    manifest/versionCode,
    manifest/application/*/intent-filter/*/name
#保持类
# Preserve all fundamental application classes.

-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider

# Preserve all View implementations, their special context constructors, and
# their setters.

-keep public class * extends android.view.View {
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
    public void set*(...);
}

# Preserve all classes that have special context constructors, and the
# constructors themselves.

-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}

# Preserve all classes that have special context constructors, and the
# constructors themselves.

-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

# Preserve all possible onClick handlers.

-keepclassmembers class * extends android.content.Context {
   public void *(android.view.View);
   public void *(android.view.MenuItem);
}

# Preserve the special fields of all Parcelable implementations.

-keepclassmembers class * implements android.os.Parcelable {
    static android.os.Parcelable$Creator CREATOR;
}

# Preserve static fields of inner classes of R classes that might be accessed
# through introspection.

-keepclassmembers class **.R$* {
  public static <fields>;
}

# Preserve annotated Javascript interface methods. 保持类成员

-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Preserve the required interface from the License Verification Library
# (but don't nag the developer if the library is not used at all).＃从授权验证库保存所需的接口＃（但不要唠叨开发商如果库根本没有被使用）。

-keep public interface com.android.vending.licensing.ILicensingService

-dontnote com.android.vending.licensing.ILicensingService

# The Android Compatibility library references some classes that may not be
# present in all versions of the API, but we know that's ok.

-dontwarn android.support.**

# Preserve all native method names and the names of their classes. 保留所有native名字

-keepclasseswithmembernames,includedescriptorclasses class * {
    native <methods>;
}
#保留枚举类型
# Preserve the special static methods that are required in all enumeration
# classes.

-keepclassmembers,allowoptimization enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
#保留序列化的类
# Explicitly preserve all serialization members. The Serializable interface
# is only a marker interface, so it wouldn't save them.
# You can comment this out if your application doesn't use serialization.
# If your code contains serializable classes that have to be backward 
# compatible, please refer to the manual.＃明确保留所有系列化的成员。 Serializable接口＃仅仅是一个标记接口，所以它不会保存。＃你可以注释掉它，如果你的应用程序不使用序列化。＃如果你的代码包含必须要落后序列化类＃兼容，请参阅说明书。

-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}
#保留某些类
# Your application may contain more items that need to be preserved; 
# typically classes that are dynamically created using Class.forName:

# -keep public class mypackage.MyClass
# -keep public interface mypackage.MyInterface
# -keep public class * implements mypackage.MyInterface

# If you wish, you can let the optimization step remove Android logging calls.
#去除日志
#-assumenosideeffects class android.util.Log {
#    public static boolean isLoggable(java.lang.String, int);
#    public static int v(...);
#    public static int i(...);
#    public static int w(...);
#    public static int d(...);
#    public static int e(...);
#}
