function varargout = BatchReg(varargin)
% BATCHREG MATLAB code for BatchReg.fig
%      BATCHREG, by itself, creates a new BATCHREG or raises the existing
%      singleton*.
%
%      H = BATCHREG returns the handle to a new BATCHREG or the handle to
%      the existing singleton*.
%
%      BATCHREG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BATCHREG.M with the given input arguments.
%
%      BATCHREG('Property','Value',...) creates a new BATCHREG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BatchReg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BatchReg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BatchReg

% Last Modified by GUIDE v2.5 14-Jan-2014 18:23:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BatchReg_OpeningFcn, ...
                   'gui_OutputFcn',  @BatchReg_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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


% --- Executes just before BatchReg is made visible.
function BatchReg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BatchReg (see VARARGIN)

% Choose default command line output for BatchReg
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BatchReg wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BatchReg_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_SelectBaseline.
function pushbutton_SelectBaseline_Callback(hObject, eventdata, handles)
%select file of aseline mesh
[handles.baselineFileName, baselinePathName, filterIndex] = uigetfile('*.stl', 'Select Baseline Mesh');
handles.baselineFilePath = fullfile(baselinePathName, handles.baselineFileName);
[handles.fv1] = stlread(fullfile(baselinePathName,handles.baselineFileName))
% eventdata  reserved - to be defined in a future version of MATLAB

% Update text box next to it
set(handles.textBox_SelectBaseline, 'String', handles.baselineFilePath);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_SelectTarget.
function pushbutton_SelectTarget_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_SelectTarget (see GCBO)
[handles.targetPathName] = uigetdir('', 'Select Folder Containing Alligned Meshes');
%Update textbox
set(handles.textBox_SelectTarget, 'String', handles.targetPathName);
[handles.data]=dir(fullfile(handles.targetPathName,'*.stl'));

guidata(hObject, handles);


% --- Executes on button press in pushbutton_SelectDestination.
function pushbutton_SelectDestination_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_SelectDestination (see GCBO)
[handles.regPathName] = uigetdir('', 'Select Folder to Save Registered Meshes');

%Update corresponding textbox
set(handles.textBox_SelectDestination, 'String', handles.regPathName);

guidata(hObject, handles);


% --- Executes on button press in pushbutton_Register.
function pushbutton_Register_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Register (see GCBO)
%Create directory containing info of all .stl files in folder

for i = 1:length(handles.data);
    
    [handles.filename] = handles.data(i).name; %set filename to name of current file from data table
    
    [handles.fv2] = stlread(fullfile(handles.targetPathName,handles.filename));
    
    [handles.fv1, handles.fv2]= translate(handles.fv1, handles.fv2);
    
    [handles.centroid1, handles.centroid2] = faceCentroid(handles.fv1, handles.fv2);

    overplot(handles.fv1,handles.fv2)%%%%%%%%%image output of alignment
    
    [handles.W_2] = displacementMag4(handles.centroid2, handles.fv1, handles.fv2, 30, 1); 
    %[handles.D1x, handles.rho] = displacementMag3(handles.centroid2, handles.fv1.vertices, handles.fv2.vertices, handles.fv2.faces, 50);
    %[handles.W_2] = morphedMesh(handles.D1x, handles.fv1.vertices, handles.fv1.faces);
    
    final_plot(handles.W_2,i)
    
    [handles.saveName] = ['reg_' handles.data(i).name];
    [handles.saveFilePath] = fullfile(handles.regPathName, handles.saveName);
    stlwrite(handles.saveFilePath, handles.W_2);

end

% Update handles structure
guidata(hObject, handles);



function textBox_SelectBaseline_Callback(hObject, eventdata, handles)
% hObject    handle to textBox_SelectBaseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textBox_SelectBaseline as text
%        str2double(get(hObject,'String')) returns contents of textBox_SelectBaseline as a double


% --- Executes during object creation, after setting all properties.
function textBox_SelectBaseline_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textBox_SelectBaseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textBox_SelectTarget_Callback(hObject, eventdata, handles)
% hObject    handle to textBox_SelectTarget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textBox_SelectTarget as text
%        str2double(get(hObject,'String')) returns contents of textBox_SelectTarget as a double


% --- Executes during object creation, after setting all properties.
function textBox_SelectTarget_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textBox_SelectTarget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textBox_SelectDestination_Callback(hObject, eventdata, handles)
% hObject    handle to textBox_SelectDestination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textBox_SelectDestination as text
%        str2double(get(hObject,'String')) returns contents of textBox_SelectDestination as a double


% --- Executes during object creation, after setting all properties.
function textBox_SelectDestination_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textBox_SelectDestination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
