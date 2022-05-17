function varargout = untitled4(varargin)
% UNTITLED4 MATLAB code for untitled4.fig
%      UNTITLED4, by itself, creates a new UNTITLED4 or raises the existing
%      singleton*.
%
%      H = UNTITLED4 returns the handle to a new UNTITLED4 or the handle to
%      the existing singleton*.
%
%      UNTITLED4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED4.M with the given input arguments.
%
%      UNTITLED4('Property','Value',...) creates a new UNTITLED4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled4

% Last Modified by GUIDE v2.5 10-May-2022 03:07:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled4_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled4_OutputFcn, ...
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


% --- Executes just before untitled4 is made visible.
function untitled4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled4 (see VARARGIN)

% Choose default command line output for untitled4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in karsilastir.
function karsilastir_Callback(hObject, eventdata, handles)
% hObject    handle to karsilastir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in resimekle.
function resimekle_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile('*.*', 'Pick a MATLAB code file');
set(handles.edit1,'String',filename);
    if isequal(filename,0) || isequal(pathname,0)
       disp('User pressed cancel')
    else
       filename=strcat(pathname,filename);
       a=imread(filename);
       axes(handles.axes1);
       imshow(a);
       handles.o=a;
       guidata(hObject, handles);
    end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in kbeyaz.
function kbeyaz_Callback(hObject, eventdata, handles)
% hObject    handle to kbeyaz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clc;
x = get(handles.edit1,'String');
 
vidFrame = imread(x);
 %%subplot(1,3,1)
 
 imshow(vidFrame)
 axes(handles.axes2); %%Resmin GUI'de görüntülenmesi 
 handles.o=vidFrame;
 guidata(hObject, handles);
 
%% Bu thresholder algoritması 
%% görüntüdeki levhayı BINARY formatına dönüştürür
%% Algoritma için resmi HSV formatına dönüştürüyoruz 
I = rgb2hsv(vidFrame); %%Thresholder için resmi HSV formatına dönüştürüyoruz 

% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.745;
channel1Max = 0.020;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.290;
channel2Max = 1.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.337;
channel3Max = 1.000;

% Create mask based on chosen histogram thresholds
sliderBW = ( (I(:,:,1) >= channel1Min) | (I(:,:,1) <= channel1Max) ) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBW;

%%subplot(1,3,2)
%%figure
imshow(BW) %% Çıkan resmi GUI'de görüntülüyoruz
axes(handles.axes3);
handles.o=BW;
guidata(hObject,handles);

 

%% Temizlik aşaması

%% strel komudu binary türünde gereksiz öğeleri filtreler
%% 3 yarıçapındafiltreleme yaptırıyoruz

diskElem = strel('disk',3);
Ibwopen = imopen(BW,diskElem);
%%subplot(1,3,3)
%%figure
imshow(Ibwopen)
axes(handles.axes4); %% Filtrenen fotoyu ekranda gösteriyoruz
handles.o=Ibwopen;
guidata(hObject, handles);

%% Blob Analizi
%% ekrandaki binary öğelerini işler.
%% Thresholder algoritmasının bize çıkardığı resmin konumuna erişmek için Blob analizi kullanırız


hBlobAnalysis = vision.BlobAnalysis('MinimumBlobArea',1000, ...
    'MaximumBlobArea',100000);
[objArea,objCentroid,bboxOut]= step(hBlobAnalysis,Ibwopen);

%% Levhayı karşılaştırmak için ekrandan koparıp yeni bir resim olarak atarız
%%imtool(Ibwopen);
disp(bboxOut)
  cropped = imcrop(Ibwopen,[bboxOut(1,1) bboxOut(1,2) bboxOut(1,3) bboxOut(1,4)]);
 

%% Levhanın olduğu yere bir kare ekleyerek levhanın yerini gösteriririz

Ishape = insertShape(vidFrame,'rectangle',bboxOut,'Linewidth',15);
 

%%figure
%%subplot(1,2,1)
 
imshow(Ishape)
%%axes(handles.axes5);
%handles.o=Ishape;
%%guidata(hObject, handles);

%% Karsılastırma

templateKlasoru = 'C:\Users\Cihan\Desktop\Templa\';
%% Taslakların olduğu klasörü gösteriyoruz
 

%% Bu kısımda elimizdeki resmi taslaktaki her resim ile karşılaştırıyoruz

%%cropped = rgb2gray(cropped);

 fileFolder = fullfile(templateKlasoru);
dirOutput = dir(fullfile(fileFolder,'*.png'));
fileNames = {dirOutput.name};
numFrames = numel(fileNames);

yeniKopardim =  imresize(cropped, [110, 110]);

  enBuyukOran=0; %% Benzerlik oranını tutan değişken
  hangiDegerYakin = 0; %% Hangi değerin levhamız olduğunu tutan değişken

  for i=1:length(fileNames) %% Elimizdeki resmi TEMP klasöründeki her resim ile karşılaştırıyoruz
     resimYolu = append(templateKlasoru,fileNames{i});
     templateResim = imread(resimYolu);

       templateResim = rgb2gray(templateResim); %%resmi 2 boyutlu hale indirgiyoruz
%% normxcorr bir karşılaştırma fonksiyonudur
%% C2 değişkeni benzerlik oranını tutar. bu oranın en büyük olduğu taslak aranan Levhadır.
 C2 = normxcorr2(templateResim,yeniKopardim); 
  karsilastirmaOrani =  max(C2(:));
     if karsilastirmaOrani>enBuyukOran
      enBuyukOran = karsilastirmaOrani;
      hangiDegerYakin = i;
     end
  end


disp(karsilastirmaOrani)
 
 levhalar = ["BİSİKLET GİREMEZ" "DİKKAT LEVHASI" "ÇIKIŞ YOK" "OTOBÜS GİREMEZ" "SAĞA DÖNÜŞ YOK" "SOLA DÖNÜŞ YOK" "DUR LEVHASI" "TIR GİREMEZ" "U DÖNÜŞÜ YASAKTIR" "YOL VER"];
disp(levhalar(hangiDegerYakin))
set(handles.text3,'String',levhalar(hangiDegerYakin))

% --- Executes on button press in ksiyah. 
%% IKINCI BUTON KISMI --- 
function ksiyah_Callback(hObject, eventdata, handles)
% hObject    handle to ksiyah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
x = get(handles.edit1,'String');
 
vidFrame = imread(x);
 %%subplot(1,3,1)
 
 imshow(vidFrame)
 axes(handles.axes2);
 handles.o=vidFrame;
 guidata(hObject, handles);
 
% Convert RGB image to chosen color space
I = rgb2hsv(vidFrame);

% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.000;
channel1Max = 1.000;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.000;
channel2Max = 1.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000;
channel3Max = 0.969;

% Create mask based on chosen histogram thresholds
sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBW;

%%subplot(1,3,2)
%%figure
imshow(BW)
axes(handles.axes3);
handles.o=BW;
guidata(hObject,handles);


%% Temizlik aşaması
diskElem = strel('disk',3);
Ibwopen = imopen(BW,diskElem);
%%subplot(1,3,3)
%%figure
imshow(Ibwopen)
axes(handles.axes4);
handles.o=Ibwopen;
guidata(hObject, handles);

%% Blob Analizi

hBlobAnalysis = vision.BlobAnalysis('MinimumBlobArea',1000, ...
    'MaximumBlobArea',100000);
[objArea,objCentroid,bboxOut]= step(hBlobAnalysis,Ibwopen);

%% Koparma Islemi
%%imtool(Ibwopen);
disp(bboxOut)
  cropped = imcrop(Ibwopen,[bboxOut(1,1) bboxOut(1,2) bboxOut(1,3) bboxOut(1,4)]);
 

%% Foto son

Ishape = insertShape(vidFrame,'rectangle',bboxOut,'Linewidth',15);
 

%%figure
%%subplot(1,2,1)
imshow(Ishape)
%%axes(handles.axes5);
%handles.o=Ishape;
%%guidata(hObject, handles);

%% Karsılastırma

templateKlasoru = 'C:\Users\Cihan\Desktop\Templa\';
 

%%cropped = rgb2gray(cropped);

 fileFolder = fullfile(templateKlasoru);
dirOutput = dir(fullfile(fileFolder,'*.png'));
fileNames = {dirOutput.name};
numFrames = numel(fileNames);
yeniKopardim =  imresize(cropped, [110, 110]);

  enBuyukOran=0;
  hangiDegerYakin = 0;

  for i=1:length(fileNames)
     resimYolu = append(templateKlasoru,fileNames{i});
     templateResim = imread(resimYolu);

       templateResim = rgb2gray(templateResim);

 C2 = normxcorr2(templateResim,yeniKopardim);
  karsilastirmaOrani =  max(C2(:));
     if karsilastirmaOrani>enBuyukOran
      enBuyukOran = karsilastirmaOrani;
      hangiDegerYakin = i;
     end
  end


  
  disp(enBuyukOran)
 
 levhalar = ["BİSİKLET GİREMEZ" "DİKKAT LEVHASI" "ÇIKIŞ YOK" "OTOBÜS GİREMEZ" "SAĞA DÖNÜŞ YOK" "SOLA DÖNÜŞ YOK" "DUR LEVHASI" "TIR GİREMEZ" "U DÖNÜŞÜ YASAKTIR" "YOL VER"];
disp(levhalar(hangiDegerYakin))
set(handles.text3,'String',levhalar(hangiDegerYakin))
