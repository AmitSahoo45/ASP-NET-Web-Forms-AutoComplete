<h2>I used to be <%= Title %></h2>
        Now I am this. 
        <% Title = "Hi, welcome to ASP.NET"; %>
        <h2 id="title"> This is title <%: Title %>.</h2>

WHat is happening here???

Here the value of title at line 1 is About.
then at line 3 I am setting the value of title as "Hi, welcome to ASP.NET";
why are we putting ;??? because it acts we are directly embedding server side code into the markup of an ASPX page, that's why ; marks as the end of the statement. 
The result will be like this

Output:
```
I used to be About
Now I am this.
THis is title Hi, welcome to ASP.NET.
Your application description page.
```

lets say I make title as 
 <% Title = "<i>Hi, welcome to ASP.NET<i>"; %>
 now if i do 
 `<h2 id="title"> This is title <%: Title %>.</h2>`
 this will show
 This is title <i>Hi, welcome to ASP.NET<i>.
 else it will 
 show `Hi, welcome to ASP.NET`
<%= will do HTML encoding
and : will just how it as a text
but this is not a good practice as using html directly on the page we are making it suspectible to script injections

## Common ASPX Syntax - 
1. `<%@ %>` - page directives or preprocessor directives. 
in the page directives we specify the language, we specify the video, register different user controlls. namespaces etc.

2. controlls
<asp:someControl........ runat="server"></asp:someControl>
these are the controls

runat server attribute??? - indicates to the asp.net preprocessor that this needs special treatment. it will be sent to the preprocessor and it will actually look for a control called as some controll. 

asp: is a prefix 
asp:someControll this will search for some control that has been named in some namespace. 
in this case it would be system.web.ui.webcontrolls


3. `<% %>`
This is inline code. 
you can do anything here like make descison tree and all those stuff here........
this is not a good practice as this can lead to spaghetti code

4. `<%= %>` write to the response stream
this is used for writing inline expressions, that outputs the results of the expression directly into the html response stream. 
shorthand for embedding server side code directly within the HTML Markup of an ASPX page, allowing you to directly generate content based on server side logic or data. 
However this is not a good practice. 
this can cause script injections. Therefore we want to encode it, therefore we need to use 

5. `<%: %>`
The result would be the same but it will be encoded. 

6. `<%$ %>` - expression evaluation
The `<%$ %>` syntax in ASP.NET is used for expression evaluation, specifically for accessing application-level resources or data binding expressions. This syntax allows you to reference resources or expressions that are defined outside the current context of the page or control, such as in the Web.config file, resource files, or data binding expressions.

You can use <%$ %> to access resources defined in your application's resource files (e.g., App_GlobalResources or App_LocalResources). This is particularly useful for localization, where you might have different strings for different languages.

**Example:**
Suppose you have a resource file named Resources.resx with a string named WelcomeMessage that has different values for different cultures. You can access this resource in your ASPX page like this:

```aspx
<asp:Label ID="WelcomeLabel" runat="server" Text="<%$ Resources:WelcomeMessage %>"></asp:Label>
```

This will set the Text property of the WelcomeLabel control to the value of WelcomeMessage from the resource file, based on the current culture.

we can do that for data binding expressions and as well. 


7. `<%# %>` - Data Binding - 
used to bind data from a data source to a control. This is useful for displaying data from a database or other data sources in your web application.


8. `<%#: %>` - Encoded Data Binding - 

9. `<%-- --%>`
this is used for commenting. 


## Understanding Code Behind Files

The connection between the code behind file and aspx file is mentioned here......
`<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="PracProject.About" %>`

Page_Load will be automatically getting invoked when the page is getting loaded. 


## Handling PostBack Data

