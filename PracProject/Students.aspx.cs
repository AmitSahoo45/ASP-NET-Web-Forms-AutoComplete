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
    public partial class Students : System.Web.UI.Page
    {
        private SqlConnection _cn = new SqlConnection(ConfigurationManager.ConnectionStrings["PracticeDBEntity"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Debug.WriteLine("page loaded for the first time");
                ddlResults.Items.Clear();
                ddlResults.Items.Add(new ListItem("Select a student", "-1"));
                txtName.Text = "Name";
                txtId.Text = "Roll no";
                txtCGPA.Text = "CGPA";
            }

            Debug.WriteLine("Page loaded");
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
                    ddlResults.Items.Add(new ListItem("Select a student", "-1"));
                    while (rdr.Read())
                    {
                        ListItem item = new ListItem(rdr["StdName"].ToString(), rdr["StudentId"].ToString());
                        ddlResults.Items.Add(item);
                    }
                    return;
                }


                ddlResults.Items.Clear();
                ddlResults.Items.Add(new ListItem("No results found", "-1"));
                return;
            }

            ddlResults.Items.Clear();
            ddlResults.Items.Add(new ListItem("Select a student", "-1"));
        }

        protected void DdlResults_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedId = ddlResults.SelectedValue;
            _cn.Open();

            try
            {
                if (selectedId != "-1")
                {
                    SqlCommand cmd = new SqlCommand("SELECT * FROM TempStudent WHERE StudentId = @StdID", _cn);
                    cmd.Parameters.AddWithValue("@StdID", selectedId);

                    SqlDataReader rdr = cmd.ExecuteReader();

                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            txtSearch.Text = rdr["StdName"].ToString();
                            txtName.Text = rdr["StdName"].ToString();
                            txtId.Text = rdr["StudentId"].ToString();
                            txtCGPA.Text = rdr["Stdcgpa"].ToString();
                        }
                        return;
                    }
                    return;
                }

                txtName.Text = "";
                txtId.Text = "";
                txtCGPA.Text = "";
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }
            finally
            {
                _cn.Close();
            }
        }

    }
}