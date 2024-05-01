type
  Comparator = function(a, b: integer): boolean;

function AComparator(a, b: integer): boolean;
begin
  AComparator := a < b;
end;

function BComparator(a, b: integer): boolean;
begin
  BComparator := a > b;
end;

procedure SelectionSort(var arr: array of integer; comparator: Comparator);
var
  i, j, minIdx, temp: integer;
begin
  for i := 0 to Length(arr) - 2 do
  begin
    minIdx := i;
    for j := i + 1 to Length(arr) - 1 do
    begin
      if comparator(arr[j], arr[minIdx]) then
        minIdx := j;
    end;
    temp := arr[minIdx];
    arr[minIdx] := arr[i];
    arr[i] := temp;
  end;
end;

procedure Heapify(var arr: array of integer; n, i: integer; comparator: Comparator);
var
  largest, left, right: integer;
begin
  largest := i;
  left := 2 * i + 1;
  right := 2 * i + 2;

  if (left < n) and comparator(arr[left], arr[largest]) then
    largest := left;

  if (right < n) and comparator(arr[right], arr[largest]) then
    largest := right;

  if largest <> i then
  begin
    Swap(arr[i], arr[largest]);
    Heapify(arr, n, largest, comparator);
  end;
end;

procedure HeapSort(var arr: array of integer; comparator: Comparator);
var
  i: integer;
begin
  for i := Length(arr) div 2 - 1 downto 0 do
    Heapify(arr, Length(arr), i, comparator);

  for i := Length(arr) - 1 downto 1 do
  begin
    Swap(arr[0], arr[i]);
    Heapify(arr, i, 0, comparator);
  end;
end;

procedure ReadDataFromFile(var arr: array of integer; filename: string);
var
  fileData: TextFile;
  i: integer;
begin
  AssignFile(fileData, filename);
  Reset(fileData);

  i := 0;
  while not Eof(fileData) do
  begin
    Readln(fileData, arr[i]);
    Inc(i);
  end;

  CloseFile(fileData);
end;

procedure WriteDataToFile(arr: array of integer; filename: string);
var
  fileData: TextFile;
  i: integer;
begin
  AssignFile(fileData, filename);
  Rewrite(fileData);

  for i := 0 to Length(arr) - 1 do
    Writeln(fileData, arr[i]);

  CloseFile(fileData);
end;

var
  data: array of integer;
  i: integer; 
begin
  SetLength(data, 10);
  ReadDataFromFile(data, 'input.txt');
  Writeln('Данные до сортировки:');
  for i := 0 to Length(data) - 1 do
    Write(data[i], ' ');
  Writeln;

  SelectionSort(data, AComparator);
  Writeln('Данные после сортировки:');
  for i := 0 to Length(data) - 1 do
    Write(data[i], ' ');
  Writeln;

  WriteDataToFile(data, 'output.txt');
end.
