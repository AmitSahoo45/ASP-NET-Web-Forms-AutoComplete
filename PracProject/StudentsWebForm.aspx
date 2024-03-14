<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentsWebForm.aspx.cs" Inherits="PracProject.StudentsWebForm" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Combo Box Demo</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                <asp:ScriptManager ID="ScriptManager1" runat="server" />

                <cc1:ComboBox
                    ID="ComboBoxForNames"
                    runat="server"
                    Style="display: inline;"
                    AutoCompleteMode="SuggestAppend"
                    AutoPostBack="True"
                    DataSourceID="StudentSrcAll"
                    DataTextField="StdName"
                    DataValueField="StudentId"
                    MaxLength="0">
                </cc1:ComboBox>

                <asp:SqlDataSource
                    ID="StudentSrcAll"
                    runat="server"
                    ConnectionString="<%$ ConnectionStrings:PracticeDBEntity %>"
                    SelectCommand="SELECT [StdName], [StudentId] FROM [TempStudent]"></asp:SqlDataSource>
            </div>

            --------------------------------------------

            <div>
                <cc1:ComboBox
                    ID="TextComboBoxNames"
                    runat="server"
                    AutoCompleteMode="Suggest"
                    AutoPostBack="True"
                    MaxLength="0"
                    Style="display: inline;" DataSourceID="SqlStudentSrc" DataTextField="name" DataValueField="empId">
                </cc1:ComboBox>
                <asp:SqlDataSource ID="SqlStudentSrc" runat="server" ConnectionString="<%$ ConnectionStrings:PracticeDBEntity %>" SelectCommand="stprc_Users_GetAllUsers_SearchByName" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="TextComboBoxNames" Name="search" PropertyName="SelectedValue" Type="String" DefaultValue=" " />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>


            <div>
                
            </div>
        </div>
    </form>
</body>
</html>
