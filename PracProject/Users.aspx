<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="PracProject.Users" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="mb-4 container container-fluid d-flex justify-content-center align-items-center flex-column my-4">
            <h1>CRUD using Stored Procedures</h1>

            <div>
                <div>
                    <h2 style="margin: 0 0 1rem 0;">Insert New User</h2>
                    <div>
                        <asp:TextBox ID="txtName" runat="server" placeholder="Name"></asp:TextBox>
                        <asp:TextBox ID="txtSalary" runat="server" placeholder="Salary"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="regexValidator" runat="server"
                            ControlToValidate="txtSalary"
                            ErrorMessage="Please enter a valid integer value for salary."
                            ValidationExpression="^\d+$"
                            Display="Dynamic" />
                        <asp:TextBox ID="txtCity" runat="server" placeholder="City"></asp:TextBox>
                        <asp:Button ID="btnInsert" runat="server" Text="Insert" OnClick="btnInsert_Click" />
                    </div>
                </div>

                <div style="margin: 1rem 0 1rem 0; border-top: 1px solid #000f">
                    <div style="margin: 0.75rem 0;">
                        <asp:Label ID="lblMessage" runat="server" Text="Search for a User :"></asp:Label>
                        <asp:TextBox
                            ID="strprocSearchTxt"
                            runat="server"
                            AutoPostBack="True"
                            OnTextChanged="strprocSearchTxt_TextChanged"
                            Text=""
                            ClientIDMode="Static" />
                        <asp:Button
                            ID="btnSearchStrProc"
                            runat="server"
                            Text="Search"
                            OnClientClick="__doPostBack('<%= strprocSearchTxt.ClientID %>', ''); return false;" />

                        <asp:Button
                            ID="btnShowAllStrProc"
                            runat="server"
                            Text="Show All"
                            OnClick="resetStrProcSearch_Click" />
                    </div>
                </div>
            </div>

            <div>

                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:PracticeDBEntity %>"
                    SelectCommand="stprc_Users_GetAllUsers_SearchByName" SelectCommandType="StoredProcedure"
                    DeleteCommand="stprc_Users_DeleteFromUsers" DeleteCommandType="StoredProcedure"
                    InsertCommand="stprc_User_InsertIntoTable" InsertCommandType="StoredProcedure"
                    UpdateCommand="stprc_Users_UpdateUser" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter DefaultValue=" " Name="search" Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="name" Type="String" />
                        <asp:Parameter Name="salary" Type="Int32" />
                        <asp:Parameter Name="city" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="empId" Type="Int32" />
                        <asp:Parameter Name="name" Type="String" />
                        <asp:Parameter Name="salary" Type="Int32" />
                        <asp:Parameter Name="city" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>

                <asp:GridView
                    ID="GridView2"
                    runat="server"
                    AutoGenerateColumns="False"
                    BackColor="#DEBA84"
                    BorderColor="#DEBA84"
                    BorderStyle="None" BorderWidth="1px"
                    CellPadding="3" CellSpacing="2"
                    DataKeyNames="empId" DataSourceID="SqlDataSource2" AllowPaging="True" AllowSorting="True">
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkSelectAll" runat="server" AutoPostBack="True" OnCheckedChanged="chkSelectAll_CheckedChanged" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelect" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="empId" HeaderText="Employee ID" InsertVisible="False" ReadOnly="True" SortExpression="empId" />
                        <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                        <asp:BoundField DataField="salary" HeaderText="Salary" SortExpression="salary" />
                        <asp:BoundField DataField="city" HeaderText="City" SortExpression="city" />
                        <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="False" />
                    </Columns>
                    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                    <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                    <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#FFF1D4" />
                    <SortedAscendingHeaderStyle BackColor="#B95C30" />
                    <SortedDescendingCellStyle BackColor="#F1E5CE" />
                    <SortedDescendingHeaderStyle BackColor="#93451F" />
                </asp:GridView>
            </div>

            <asp:Button ID="btnDeleteSelected" runat="server" Text="Delete Selected" OnClick="btnDeleteSelected_Click" CssClass="my-3 btn btn-danger" />
        </div>

        <div>
            <asp:ScriptManager ID="UsersScriptManager" runat="server"></asp:ScriptManager>
            <h1>Without Stored Procedure</h1>

            <div>
                <asp:TextBox
                    ID="searchText"
                    runat="server"
                    AutoPostBack="True"
                    OnTextChanged="searchText_TextChanged" />

                <asp:Button
                    ID="btnShowAll"
                    runat="server"
                    Text="Show All"
                    OnClick="resetSearch_Click" />
            </div>

            <div>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PracticeDBEntity %>" DeleteCommand="DELETE FROM [Users] WHERE [empId] = @empId" InsertCommand="INSERT INTO [Users] ([name], [salary], [city]) VALUES (@name, @salary, @city)" SelectCommand="SELECT * FROM [Users]" UpdateCommand="UPDATE [Users] SET [name] = @name, [salary] = @salary, [city] = @city WHERE [empId] = @empId">
                    <DeleteParameters>
                        <asp:Parameter Name="empId" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="name" Type="String" />
                        <asp:Parameter Name="salary" Type="Int32" />
                        <asp:Parameter Name="city" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="name" Type="String" />
                        <asp:Parameter Name="salary" Type="Int32" />
                        <asp:Parameter Name="city" Type="String" />
                        <asp:Parameter Name="empId" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="empId" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="empId" HeaderText="empId" InsertVisible="False" ReadOnly="True" SortExpression="empId" />
                        <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                        <asp:BoundField DataField="salary" HeaderText="salary" SortExpression="salary" />
                        <asp:BoundField DataField="city" HeaderText="city" SortExpression="city" />
                        <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </div>
        </div>
    </form>


    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/bootstrap.rtl.min.css" rel="stylesheet" />
</body>
</html>
