using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PracProject
{
    public partial class Students : System.Web.UI.Page
    {
        private SqlConnection _cn = new SqlConnection(ConfigurationManager.ConnectionStrings["PracticeDBEntity"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlResults.Items.Clear();
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            string search = txtSearch.Text.Trim();
            search = search.ToLower();

            if (!string.IsNullOrEmpty(search))
            {
                _cn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM TempStudent WHERE StdName LIKE @SearchQuery", _cn);
                cmd.Parameters.AddWithValue("@SearchQuery", "%" + search + "%");

                SqlDataReader rdr = cmd.ExecuteReader();

                if (rdr.HasRows)
                {
                    ddlResults.Items.Clear();
                    while (rdr.Read())
                    {
                        ListItem item = new ListItem(rdr["StdName"].ToString(), rdr["StudentId"].ToString());
                        ddlResults.Items.Add(item);
                    }
                }
                else
                {
                    ddlResults.Items.Clear();
                    ddlResults.Items.Add(new ListItem("No results found", "-1"));
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string selectedName = ddlResults.SelectedValue;
            if (selectedName != "-1")
            {
                _cn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM TempStudent WHERE StudentId = @StdID", _cn);
                cmd.Parameters.AddWithValue("@StdID", selectedName);

                SqlDataReader rdr = cmd.ExecuteReader();

                if (rdr.HasRows)
                {
                    while (rdr.Read())
                    {
                        txtName.Text = rdr["StdName"].ToString();
                        txtId.Text = rdr["StudentId"].ToString();
                        txtCGPA.Text = rdr["Stdcgpa"].ToString();
                    }
                }
            }
        }
    }
}