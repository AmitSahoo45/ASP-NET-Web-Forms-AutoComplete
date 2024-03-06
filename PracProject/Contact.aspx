<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="PracProject.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <h4>Testing with Title</h4>

        <h2>I used to be <%= Title %></h2>
        Now I am this. 
        <%: DateTime.Now.ToString("MM/dd/yyyy") %>
        <h2 id="title">This is title <%= Title %>.</h2>
        <h3>Your application description page.</h3>
        <p>Use this area to provide additional information.</p>
        <p>Today's date is:</p>
        <p>&nbsp;</p>
        <p>&nbsp;<%: DateTime.Now.ToString("MM/dd/yyyy") %></p>

        <asp:TextBox ID="txtShowText" runat="server" Enabled="false" style="width: 400px; padding: 1rem; border: none; border-radius: 8px;"/>

        <asp:TextBox ID="txtData" runat="server"></asp:TextBox>
        <asp:Button ID="btnSendInfo" runat="server" Text="Send User Data" OnClick="btnSendInfo_Click" />

        <br /><br /><br /><br /><br /><br />



    </main>
</asp:Content>
