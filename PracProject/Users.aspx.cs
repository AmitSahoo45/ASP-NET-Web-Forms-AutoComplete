using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Diagnostics;

namespace PracProject
{
    public partial class Users : System.Web.UI.Page
    {
        private readonly SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PracticeDBEntity"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void searchText_TextChanged(object sender, EventArgs e)
        {
            string searchQuery = searchText.Text.Trim();
            SqlDataSource1.SelectCommand = "SELECT * FROM [Users] WHERE [name] LIKE '%" + searchQuery + "%'";
            GridView1.DataBind();
        }

        protected void resetSearch_Click(object sender, EventArgs e)
        {
            searchText.Text = "";
            SqlDataSource1.SelectCommand = "SELECT * FROM [Users]";
            GridView1.DataBind();
        }

        // --------------------------------------------------
        // From here it is for using stored proc one. 

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            try
            {
                SqlDataSource2.InsertParameters["name"].DefaultValue = txtName.Text;
                SqlDataSource2.InsertParameters["salary"].DefaultValue = txtSalary.Text;
                SqlDataSource2.InsertParameters["city"].DefaultValue = txtCity.Text;

                SqlDataSource2.Insert();
                GridView2.DataBind();

                txtName.Text = "";
                txtSalary.Text = "";
                txtCity.Text = "";
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message.ToString());
            }
        }

        protected void strprocSearchTxt_TextChanged(object sender, EventArgs e)
        {
            try
            {
                SqlDataSource2.SelectParameters["search"].DefaultValue = strprocSearchTxt.Text;
                GridView2.DataBind();
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message.ToString());
            }
        }

        protected void resetStrProcSearch_Click(object sender, EventArgs e)
        {
            try
            {
                strprocSearchTxt.Text = " ";
                SqlDataSource2.SelectParameters["search"].DefaultValue = " ";
                GridView2.DataBind();
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message.ToString());
            }
        }

        protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                CheckBox chkSelectAll = (CheckBox)GridView2.HeaderRow.FindControl("chkSelectAll");
                foreach (GridViewRow row in GridView2.Rows)
                {
                    CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                    if (chkSelect != null)
                        chkSelect.Checked = chkSelectAll.Checked;
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message.ToString());
            }
        }

        protected void btnDeleteSelected_Click(object sender, EventArgs e)
        {
            try
            {
                List<int> selectedEmpIds = new List<int>();

                foreach (GridViewRow row in GridView2.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                        if (chkSelect.Checked)
                        {
                            int empId = Convert.ToInt32(GridView2.DataKeys[row.RowIndex].Value);
                            selectedEmpIds.Add(empId);
                        }
                    }
                }

                DeleteMultipleUsers(selectedEmpIds);
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message.ToString());
            }
        }

        private void DeleteMultipleUsers(List<int> empIds)
        {
            try
            {
                connection.Open();

                SqlCommand command = new SqlCommand("stprc_Users_DeleteMultipleUsers", connection);
                command.CommandType = CommandType.StoredProcedure;

                DataTable empIdsTable = new DataTable();
                empIdsTable.Columns.Add("empId", typeof(int));

                foreach (int empId in empIds)
                    empIdsTable.Rows.Add(empId);

                SqlParameter parameter = command.Parameters.AddWithValue("@empIds", empIdsTable);
                parameter.SqlDbType = SqlDbType.Structured;
                parameter.TypeName = "dbo.IntTableType";
                command.ExecuteNonQuery();

                GridView2.DataBind();
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message.ToString());
            }
        }

    }
}