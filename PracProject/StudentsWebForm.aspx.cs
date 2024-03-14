using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PracProject
{
    public partial class StudentsWebForm : System.Web.UI.Page
    {
        private SqlConnection _cn = new SqlConnection(ConfigurationManager.ConnectionStrings["PracticeDBEntity"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void OnTextChangeForComboBox(object sender, EventArgs e)
        {
            try
            {
                string searchQuery = TextComboBoxNames.Text;
                SqlCommand cmd = new SqlCommand("stprc_Users_GetAllUsers_SearchByName", _cn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@name", searchQuery);
                _cn.Open();

                TextComboBoxNames.Items.Clear();

                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                    TextComboBoxNames.Items.Add(dr["name"].ToString());

                _cn.Close();
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message.ToString());
            }
        }

    }
}