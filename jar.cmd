// 将文件夹打包成可执行的jar包 完整目录是 C:\Users\Administrator\Desktop\11\CaptureScreen\bin\*
cd C:\Users\Administrator\Desktop\11\CaptureScreen
jar cvfm CaptureScreen.jar bin\META-INF\MANIFEST.MF -C bin/ .
