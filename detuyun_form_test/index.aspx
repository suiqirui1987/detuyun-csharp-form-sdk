<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="detuyun_form_test.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <%
        /// (回调中的所有信息均为 UTF_8 编码，签名验证的时候需要注意编码是否一致)
        string bucket = "abcdd"; /// 空间名
        string form_api_key = "faith196";///
        string form_api_secret = "fhx442gh1n1qmeuqyvmtf5nt2uk482"; /// 表单 API 功能的密匙（请访问得图云管理后台首页的Access Key管理页面获取）


        Dictionary<string, object> options = new Dictionary<string, object>();
        options.Add("bucket",bucket);
        options.Add("access_key","faith196");
        options.Add("expiration", (DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0)).TotalSeconds + 600);/// 授权过期时间
        options.Add("save_name","/{year}/{mon}/{random}{.suffix}"); /// 文件名生成格式，请参阅 API 文档
        options.Add("content_length_range","0,1024000"); /// 限制文件大小，可选
        options.Add("image_width_range", "100,1024000");/// 限制图片宽度，可选
        options.Add("image_height_range","100,1024000");/// 限制图片高度，可选
        options.Add("return_url","http://api.detuyun.com/sdk/php-form-sdk/return.php");/// 页面跳转型回调地址
        options.Add("notify_url","http://api.detuyun.com/sdk/php-form-sdk/notify.php");/// 服务端异步回调地址, 请注意该地址必须公网可以正常访问

        string optionsJson = Newtonsoft.Json.JsonConvert.SerializeObject(options);
        string policy = System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(optionsJson));
        //string sign = GetMD5(policy + "&" + form_api_secret); /// 表单 API 功能的密匙（请访问得图云管理后台首页的Access Key管理页面获取）
        
        
        System.Security.Cryptography.MD5 md5Hasher = System.Security.Cryptography.MD5.Create();
        byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(policy + "&" + form_api_secret));
        StringBuilder sBuilder = new StringBuilder();
        for(int i=0;i<data.Length;i++)
        {
            sBuilder.Append(data[i].ToString("x2"));
        }
        string sign = sBuilder.ToString();
    %>
    <form action="http://api.detuyun.com/" method="post" enctype="multipart/form-data">
	<input type="hidden" name="postdata" value="<%=policy %>" />
	<input type="hidden" name="signature" value="<%=sign %>" />
	<input type="file" name="file" />
	<input type="submit" />
</form>
</body>
</html>
