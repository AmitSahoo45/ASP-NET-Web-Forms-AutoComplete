<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Students.aspx.cs" Inherits="PracProject.Students" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Get student info</h2>

    <asp:Label ID="lblSearch" runat="server" Text="Search a Student Name: &nbsp;" AssociatedControlID="txtSearch" class="mr-3"></asp:Label>
    <asp:TextBox ID="txtSearch" runat="server" AutoPostBack="true" OnTextChanged="txtSearch_TextChanged" CssClass="border-0 p-2 mb-3 shadow-lg"></asp:TextBox>

    <div class="form-group mb-3">
        <asp:DropDownList ID="ddlResults" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DdlResults_SelectedIndexChanged" class="form-control"></asp:DropDownList>
    </div>


    <div class="form-group">
        <asp:TextBox ID="txtName" runat="server" Enabled="false" class="form-control" placeholder="Name"></asp:TextBox>
        <asp:TextBox ID="txtId" runat="server" Enabled="false" class="form-control" placeholder="ID"></asp:TextBox>
        <asp:TextBox ID="txtCGPA" runat="server" Enabled="false" class="form-control" placeholder="CGPA"></asp:TextBox>
    </div>


    <div class="border-3"></div>



    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/bootstrap.rtl.min.css" rel="stylesheet" />
</asp:Content>
