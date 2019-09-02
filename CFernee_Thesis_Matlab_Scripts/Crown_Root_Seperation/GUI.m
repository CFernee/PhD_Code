function varargout = GUI(varargin)
%GUI M-file for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('Property','Value',...) creates a new GUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to GUI_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      GUI('CALLBACK') and GUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in GUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 03-Mar-2014 12:09:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles)
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in GetBaselineMeshButton.
function GetBaselineMeshButton_Callback(hObject, eventdata, handles)
% Get file path for baseline mesh
[baselineFileName, baselinePathName, filterIndex] = uigetfile('*.stl', 'Select the baseline mesh .stl file');
handles.baselineFilePath = fullfile(baselinePathName, baselineFileName);
% Update text box next to it
set(handles.BaselinePathTextBox, 'String', handles.baselineFilePath);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in GetTargetMeshButton.
function GetTargetMeshButton_Callback(hObject, eventdata, handles)
% Get file path for target mesh
[targetFileName, targetPathName, filterIndex] = uigetfile('*.stl', 'Select the target mesh .stl file');
handles.targetPathName=targetPathName;
handles.targetFilePath = fullfile(targetPathName, targetFileName);
% Update text box next to it
set(handles.TargetPathTextBox, 'String', handles.targetFilePath)

% Update handles structure
guidata(hObject, handles);

function BaselinePathTextBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','Click the button to find file');
end

function TargetPathTextBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    set(hObject,'String','Click the button to find file');
end


function ReadStlButton_Callback(hObject, eventdata, handles)
% Reads .stl files and puts them into variables fv1 and fv2
% then translates both files to orientate the centre of volume about the origin.
% then plots translated meshes

%Read .stl files
fv1 = stlread(handles.baselineFilePath);
fv2 = stlread(handles.targetFilePath);

%Read .mat files
handles.EnamelList = load([handles.targetPathName '\EnamelList.mat']);

%Orientate the centre of volume about the origin
[handles.fv1, handles.fv2]=translate(fv1, fv2);

%Plot results
tripleplot(handles.fv1, handles.fv2, handles);

% Update handles structure
guidata(hObject, handles);

function axes1_CreateFcn(hObject, eventdata, handles)

function Xtran_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Xtran_Callback(hObject, eventdata, handles)

function Xtext_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Ytran_Callback(hObject, eventdata, handles)

function Ytran_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Ztran_Callback(hObject, eventdata, handles)

function Ztran_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ManuallyTranslateButton_Callback(hObject, eventdata, handles)

% Obtain values from text boxes for manual translation
x = str2num(get(handles.Xtran,'string'));
y = str2num(get(handles.Ytran,'string'));
z = str2num(get(handles.Ztran,'string'));

% Reset values in the box to 0
set(handles.Xtran, 'String', '0');
set(handles.Ytran, 'String', '0');
set(handles.Ztran, 'String', '0');

% Manually translate the Target mesh with the values given
handles.fv2 = manTranslate(handles.fv2, x, y, z);

% Plot the new mesh
tripleplot(handles.fv1, handles.fv2, handles);

% Update handles structure
guidata(hObject, handles);

function Yrot_Callback(hObject, eventdata, handles)

function Yrot_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Zrot_Callback(hObject, eventdata, handles)

function Zrot_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Xrot_Callback(hObject, eventdata, handles)

function Xrot_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ManuallyRotateButton_Callback(hObject, eventdata, handles)

% Obtain values from text boxes for manual translation
x = str2num(get(handles.Xrot,'string'));
y = str2num(get(handles.Yrot,'string'));
z = str2num(get(handles.Zrot,'string'));

% Reset values in the box to 0
set(handles.Xrot, 'String', '0');
set(handles.Yrot, 'String', '0');
set(handles.Zrot, 'String', '0');

% Manually translate the Target mesh with the values given
handles.fv2 = manRot(handles.fv2, x, y, z);

% Plot the new mesh
tripleplot(handles.fv1, handles.fv2, handles);

% Update handles structure
guidata(hObject, handles);

function ICPButton_Callback(hObject, eventdata, handles)
% Turn the interface off for processing.
InterfaceObj=findobj(hObject,'Enable','on');
set(InterfaceObj,'Enable','off');

% Set a wait bar (doesn't actually progress as calculation happens...)
h=waitbar(0, 'Calculating... (be aware progress bar will not move during this process)');
set(h,'windowstyle','modal');
% Rotates Target mesh to match Baseline closely
handles.fv2 = STLRotate(handles.fv1, handles.fv2);
close(h);

% Plot the new mesh
tripleplot(handles.fv1, handles.fv2, handles);

% Update handles structure
guidata(hObject, handles);

% Turn back on the interface
set(InterfaceObj,'Enable','on');

function DisplacementButton_Callback(hObject, eventdata, handles)
% Turn the interface (GUI) off for processing.
InterfaceObj=findobj(GUI,'Enable','on');
set(InterfaceObj,'Enable','off');

% Finds centroids of meshes
[handles.centroid1, handles.centroid2] = faceCentroid(handles.fv1, handles.fv2);

%Find displacement field vertors (D) and distances (rho) from baseline to
%target. Sampling nearest 50 target centroids to baseline vertex 
[handles.D1x] = displacement(handles.centroid2, handles.fv1.vertices, handles.fv2.vertices, handles.fv2.faces, 50);

[handles.W_2] = morphedMesh(handles.D1x, handles.fv1.vertices, handles.fv1.faces);
final_plot(handles.W_2,1)
% Update handles structure
guidata(hObject, handles);

% Turn back on the interface
set(InterfaceObj,'Enable','on');
 
% --- Executes on button press in saveStlButton.
function saveStlButton_Callback(hObject, eventdata, handles)
% Gets user to input name for save file, and saves the result as an stl
% file
[saveFileName, savePathName, filterIndex] = uiputfile('*.stl', 'Select filename for resulting stl file');
handles.saveFilePath = fullfile(savePathName, saveFileName);

%Save as .stl file
stlwrite(handles.saveFilePath, handles.W_2);

% Update text box next to it
set(handles.BaselinePathTextBox, 'String', handles.baselineFilePath);


% --- Executes on button press in SaveMatButton.
function SaveMatButton_Callback(hObject, eventdata, handles)
% Gets user to input name for save file, and saves the result as an mat
% file

W_2 = handles.W_2;
%Save as .mat file
uisave('W_2');


% --- Executes on button press in smoothButton.
function smoothButton_Callback(hObject, eventdata, handles)
% hObject    handle to smoothButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.W_2 = lp_smooth(handles.W_2);

% plot new smoothed figure
final_plot(handles.W_2);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_save_stl.
function pushbutton_save_stl_Callback(hObject, eventdata, handles)
% Gets user to input name for save file, and saves the result as an stl
% file

%[handles.savePathName] = uigetdir('G:\ImplantProject\SSM(E)\5.Individual_aligned_teeth_stl_files', 'Select filename for resulting stl file');
[saveFileName, savePathName, filterIndex] = uiputfile('*.stl', 'Select filename for resulting stl file');
handles.saveFilePath = fullfile(savePathName, saveFileName);

%Save as .stl file
stlwrite(handles.saveFilePath, handles.fv2);

% Update text box next to it
set(handles.BaselinePathTextBox, 'String', handles.baselineFilePath); 


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_save_ES.
function pushbutton_save_ES_Callback(hObject, eventdata, handles)
%Extract Crown mesh and save as sepearate .stl

handles.enamelSurface=meshExtract(handles.fv2,handles.EnamelList.enamFace4);

[saveFileName, savePathName, filterIndex] = uiputfile('*.stl', 'Select filename for enamel surface stl file');

handles.saveFilePath = fullfile(savePathName, saveFileName);

stlwrite(handles.saveFilePath, handles.enamelSurface);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
