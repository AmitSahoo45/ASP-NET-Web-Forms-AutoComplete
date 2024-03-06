<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Students.aspx.cs" Inherits="PracProject.Students" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Getting all Students Names</h2>

    <asp:TextBox ID="txtSearch" runat="server" AutoPostBack="true" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
    <asp:DropDownList ID="ddlResults" runat="server"></asp:DropDownList>

    <asp:Button ID="btnSubmit" runat="server" Text="Search Students" OnClick="btnSubmit_Click" />

    <div class="">
        <asp:TextBox ID="txtName" runat="server" Enabled="false"></asp:TextBox>
        <asp:TextBox ID="txtId" runat="server" Enabled="false"></asp:TextBox>
        <asp:TextBox ID="txtCGPA" runat="server" Enabled="false"></asp:TextBox>
    </div>

</asp:Content>
