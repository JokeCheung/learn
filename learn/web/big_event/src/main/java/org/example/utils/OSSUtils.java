package org.example.utils;

import com.aliyun.oss.*;
import com.aliyun.oss.common.auth.DefaultCredentialProvider;
import com.aliyun.oss.common.comm.SignVersion;
import com.aliyun.oss.model.PutObjectRequest;
import com.aliyun.oss.model.PutObjectResult;

import java.io.InputStream;

public class OSSUtils {

    private final static String END_POINT = "https://oss-cn-shenzhen.aliyuncs.com";
    private final static String ACCESS_KEY_ID = "";
    private final static String ACCESS_KEY_SECRET = "";
    private final static String BUCKET_NAME = "mozu-20250206";
    private final static String REGION = "cn-shenzhen";

    public static String upload(String fileName, InputStream file) {

        DefaultCredentialProvider credentialsProvider = new DefaultCredentialProvider(ACCESS_KEY_ID, ACCESS_KEY_SECRET);


        // 创建OSSClient实例。
        ClientBuilderConfiguration clientBuilderConfiguration = new ClientBuilderConfiguration();
        clientBuilderConfiguration.setSignatureVersion(SignVersion.V4);
        OSS ossClient = OSSClientBuilder.create()
                .endpoint(END_POINT)
                .credentialsProvider(credentialsProvider)
                .clientConfiguration(clientBuilderConfiguration)
                .region(REGION)
                .build();

        String url = "";
        try {
            // 填写字符串。
            String content = "Hello OSS，你好世界";

            // 创建PutObjectRequest对象。
//            PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, objectName, new ByteArrayInputStream(content.getBytes()));
            PutObjectRequest putObjectRequest = new PutObjectRequest(BUCKET_NAME, fileName, file);


            // 如果需要上传时设置存储类型和访问权限，请参考以下示例代码。
            // ObjectMetadata metadata = new ObjectMetadata();
            // metadata.setHeader(OSSHeaders.OSS_STORAGE_CLASS, StorageClass.Standard.toString());
            // metadata.setObjectAcl(CannedAccessControlList.Private);
            // putObjectRequest.setMetadata(metadata);

            // 上传字符串。
            PutObjectResult result = ossClient.putObject(putObjectRequest);

//            https://mozu-20250206.oss-cn-shenzhen.aliyuncs.com/001.png
            url = "https://" + BUCKET_NAME + "." + END_POINT.substring(END_POINT.lastIndexOf("/") + 1) + "/" + fileName;
        } catch (OSSException oe) {
            System.out.println("Caught an OSSException, which means your request made it to OSS, "
                    + "but was rejected with an error response for some reason.");
            System.out.println("Error Message:" + oe.getErrorMessage());
            System.out.println("Error Code:" + oe.getErrorCode());
            System.out.println("Request ID:" + oe.getRequestId());
            System.out.println("Host ID:" + oe.getHostId());
        } catch (ClientException ce) {
            System.out.println("Caught an ClientException, which means the client encountered "
                    + "a serious internal problem while trying to communicate with OSS, "
                    + "such as not being able to access the network.");
            System.out.println("Error Message:" + ce.getMessage());
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }

        return url;
    }
}
