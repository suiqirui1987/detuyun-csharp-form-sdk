using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security;
using System.Text;

namespace detuyun_form_test
{
    public partial class _return : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string form_api_secret = "fhx442gh1n1qmeuqyvmtf5nt2uk482";
            string code = Request.QueryString["code"];
            string msg = Request.QueryString["msg"];
            string url = Request.QueryString["url"];
            string time = Request.QueryString["time"];
            string sign = Request.QueryString["sign"];
            if (string.IsNullOrEmpty(code) || string.IsNullOrEmpty(msg) || string.IsNullOrEmpty(url) || string.IsNullOrEmpty(time))
            {
                Response.StatusCode = 403;
                Response.End();
                return;
            }

            if (!string.IsNullOrEmpty(sign))
            {
                if (MD5(code + "&" + msg + "&" + url + "&" + time + "&" + form_api_secret) == sign)
                {
                    if (code == "200")
                    {
                        Response.Write("ok");
                    }
                    else
                    {
                        Response.Write("false");
                    }
                }
                else {
                    Response.StatusCode = 403;
                }
            }
            Response.End();
            return;
        }

        private string MD5(string input)
        {
            System.Security.Cryptography.MD5 md5Hasher = System.Security.Cryptography.MD5.Create();
            byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(input));
            StringBuilder sBuilder = new StringBuilder();
            for (int i = 0; i < data.Length; i++)
            {
                sBuilder.Append(data[i].ToString("x2"));
            }
            return sBuilder.ToString();
        }
    }

}