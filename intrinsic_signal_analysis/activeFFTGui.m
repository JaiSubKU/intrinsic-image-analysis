function varargout = activeFFTGui(varargin)
% ACTIVEFFTGUI MATLAB code for activeFFTGui.fig
%      ACTIVEFFTGUI, by itself, creates a new ACTIVEFFTGUI or raises the existing
%      singleton*.
%
%      H = ACTIVEFFTGUI returns the handle to a new ACTIVEFFTGUI or the handle to
%      the existing singleton*.
%
%      ACTIVEFFTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACTIVEFFTGUI.M with the given input arguments.
%
%      ACTIVEFFTGUI('Property','Value',...) creates a new ACTIVEFFTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before activeFFTGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to activeFFTGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help activeFFTGui

% Last Modified by GUIDE v2.5 06-Jan-2018 22:30:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @activeFFTGui_OpeningFcn, ...
                   'gui_OutputFcn',  @activeFFTGui_OutputFcn, ...
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


% --- Executes just before activeFFTGui is made visible.
function activeFFTGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to activeFFTGui (see VARARGIN)

% Choose default command line output for activeFFTGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes activeFFTGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = activeFFTGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function imWidth_Callback(hObject, eventdata, handles)
% hObject    handle to imWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imWidth as text
%        str2double(get(hObject,'String')) returns contents of imWidth as a double


% --- Executes during object creation, after setting all properties.
function imWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function imHeight_Callback(hObject, eventdata, handles)
% hObject    handle to imHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imHeight as text
%        str2double(get(hObject,'String')) returns contents of imHeight as a double


% --- Executes during object creation, after setting all properties.
function imHeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nFrames_Callback(hObject, eventdata, handles)
% hObject    handle to nFrames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nFrames as text
%        str2double(get(hObject,'String')) returns contents of nFrames as a double


% --- Executes during object creation, after setting all properties.
function nFrames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nFrames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function acqHz_Callback(hObject, eventdata, handles)
% hObject    handle to acqHz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of acqHz as text
%        str2double(get(hObject,'String')) returns contents of acqHz as a double


% --- Executes during object creation, after setting all properties.
function acqHz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to acqHz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stimRepHz_Callback(hObject, eventdata, handles)
% hObject    handle to stimRepHz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stimRepHz as text
%        str2double(get(hObject,'String')) returns contents of stimRepHz as a double


% --- Executes during object creation, after setting all properties.
function stimRepHz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stimRepHz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in getStarted.
function getStarted_Callback(hObject, eventdata, handles)
% hObject    handle to getStarted (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ActiveFFTmonitor_updated_4_Jai_singleFileVersion(handles);



function tempDir_Callback(hObject, eventdata, handles)
% hObject    handle to tempDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tempDir as text
%        str2double(get(hObject,'String')) returns contents of tempDir as a double


% --- Executes during object creation, after setting all properties.
function tempDir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tempDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in getTempDir.
function getTempDir_Callback(hObject, eventdata, handles)
% hObject    handle to getTempDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder=uigetdir;
if strcmp(folder(end),'\')
    handles.tempDir.String=folder;
else
    handles.tempDir.String=[folder,'\'];
end
guidata(hObject, handles);