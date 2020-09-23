VERSION 5.00
Begin VB.UserControl VistaProg 
   ClientHeight    =   3600
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4800
   ScaleHeight     =   3600
   ScaleWidth      =   4800
   ToolboxBitmap   =   "VistaProg.ctx":0000
   Begin VB.Image BarLeft 
      Height          =   225
      Left            =   0
      Picture         =   "VistaProg.ctx":0312
      Top             =   0
      Width           =   30
   End
   Begin VB.Image Barright 
      Height          =   225
      Left            =   1950
      Picture         =   "VistaProg.ctx":03CC
      Top             =   0
      Width           =   30
   End
   Begin VB.Image Barmain 
      Height          =   225
      Left            =   0
      Picture         =   "VistaProg.ctx":0486
      Stretch         =   -1  'True
      Top             =   0
      Width           =   15
   End
   Begin VB.Image righton 
      Height          =   225
      Left            =   765
      Picture         =   "VistaProg.ctx":0540
      Top             =   1245
      Width           =   30
   End
   Begin VB.Image rightoff 
      Height          =   225
      Left            =   765
      Picture         =   "VistaProg.ctx":05FA
      Top             =   960
      Width           =   30
   End
   Begin VB.Image lefton 
      Height          =   225
      Left            =   540
      Picture         =   "VistaProg.ctx":06B4
      Top             =   1245
      Width           =   30
   End
   Begin VB.Image leftoff 
      Height          =   225
      Left            =   540
      Picture         =   "VistaProg.ctx":076E
      Top             =   960
      Width           =   30
   End
   Begin VB.Image Barback 
      Height          =   225
      Left            =   15
      Picture         =   "VistaProg.ctx":0828
      Stretch         =   -1  'True
      Top             =   0
      Width           =   1665
   End
End
Attribute VB_Name = "VistaProg"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'###########################################################'
'       Vistaprog.ctl                                       '
'       Simple and stable Vista style progressbar           '
'       By Lloyd Pharazyn                                   '
'       lpharazyn@hotmail.com                               '
'###########################################################'

Option Explicit 'blah

Private barMin As Long 'holds the min value for progressbar
Private barValue As Long 'holds the current value for progressbar
Private barMax As Long 'holds the max value for progressbar

Private Sub Barmaininner_Click()

End Sub

Private Sub Image1_Click()

End Sub

Private Sub UserControl_Resize() 'aligns the images so they will resize with the control
On Error Resume Next
With UserControl
.Height = 225
Barright.Left = .ScaleWidth - Barright.Width
Barback.Width = .ScaleWidth
End With
Bar_Draw
End Sub

Public Property Let Value(ByVal val As Long) 'making sure the value doesn't go below min or above max
    If val > barMax Then val = barMax
    If val < barMin Then val = barMin
    barValue = val
    Bar_Draw 'update the progressbar to display the current value
    PropertyChanged "Value"
End Property

Public Property Get Value() As Long 'reading the current value
    Value = barValue
End Property

Public Property Let Max(ByVal val As Long) 'making sure the max is valid and above the min
    If val < 1 Then val = 1
    If val <= barMin Then val = barMin + 1
    barMax = val
    If Value > barMax Then Value = barMax
    Bar_Draw 'update the progressbar to display the current value
    PropertyChanged "Max"
End Property
Public Property Get Max() As Long 'reading the min value
    Max = barMax
End Property

Public Property Let Min(ByVal val As Long) 'making sure the min is valid and below the max
    If val >= barMax Then val = Max - 1
    If val < 0 Then val = 0
    barMin = val
    If Value < barMin Then Value = barMin
    Bar_Draw 'update the progressbar to display the current value
    PropertyChanged "Min"
End Property
Public Property Get Min() As Long 'reading the min value
    Min = barMin
End Property

Private Sub UserControl_InitProperties() 'this is what the the control starts of with when placed in design-time
    Max = 100
    Min = 0
    Value = 50
End Sub

Private Sub UserControl_ReadProperties(PropBag As PropertyBag) 'this will load the values while in design-time
    On Error Resume Next
    Max = PropBag.ReadProperty("Max", 100)
    Min = PropBag.ReadProperty("Min", 0)
    Value = PropBag.ReadProperty("Value", 50)
End Sub

Private Sub UserControl_WriteProperties(PropBag As PropertyBag) 'this will save the values while in design-time
    PropBag.WriteProperty "Max", Max, 100
    PropBag.WriteProperty "Min", Min, 0
    PropBag.WriteProperty "Value", Value, 50
End Sub

Private Sub Bar_Draw() 'this is where the calculating is done to display the bar
Dim i, s, z, y, q As Long
    i = barMax: s = barValue: z = barMax 'getting the needed values incase we need to alter them
    y = (s * 100 / z) 'this is finding out what the current value is in a percentage compared to the max
    q = (y * UserControl.Width / 100) 'we now convert the percentage to a mesurement compared to the usercontrols width
If s = 0 Then Barmain.Width = 15: Barright.Picture = rightoff.Picture: BarLeft.Picture = leftoff.Picture 'this will make the progressbar grey if the current value is 0
If s >= 1 Then BarLeft.Picture = lefton.Picture: Barmain.Width = q 'if the current value is above 1 then display the start of bar as green and stretch the progress to display current value
If s = z Then Barright.Picture = righton.Picture Else If s < z Then Barright.Picture = rightoff.Picture 'if the progressbar is maxed then make the end green
End Sub
