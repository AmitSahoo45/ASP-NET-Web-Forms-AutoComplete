using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PracProject
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Title = "This title is being set from code behind.";
            else
            {
                if (txtData.Text == null || txtData.Text == "")
                {
                    Title = "It cannot be null";
                    return;
                }

                Title = " " + txtData.Text;

                txtShowText.Text = "Hello, Welcome to ASP.NET Tutorials";
            }
        }

        protected void btnSendInfo_Click(object sender, EventArgs e)
        {
        }
    }
}