type
  Node = record
    data: integer;
    next: integer;
  end;

var
  list: array[1..10] of Node;
  head, freeIndex: integer;

procedure InitializeList;
var
  i: integer;
begin
  for i := 1 to 10 do
  begin
    list[i].next := i + 1;
  end;
  list[10].next := 0; // Последний элемент списка
  head := 0; // Голова списка
  freeIndex := 1; // Начальный свободный индекс
end;

procedure DisplayList;
var
  current: integer;
begin
  current := head;
  writeln('Содержимое списка:');
  while current <> 0 do
  begin
    writeln(list[current].data);
    current := list[current].next;
  end;
end;

procedure AddNode(data: integer);
var
  newIndex, current: integer;
begin
  if freeIndex <> 0 then
  begin
    newIndex := freeIndex;
    freeIndex := list[freeIndex].next;

    list[newIndex].data := data;
    list[newIndex].next := 0;

    if head = 0 then
      head := newIndex
    else
    begin
      current := head;
      while list[current].next <> 0 do
        current := list[current].next;
      list[current].next := newIndex;
    end;
  end
  else
    writeln('Список полон, невозможно добавить новый элемент.');
end;

procedure DeleteNode(data: integer);
var
  current, prev: integer;
begin
  current := head;
  prev := 0;

  while (current <> 0) and (list[current].data <> data) do
  begin
    prev := current;
    current := list[current].next;
  end;

  if current <> 0 then
  begin
    if prev = 0 then
      head := list[current].next
    else
      list[prev].next := list[current].next;
    list[current].next := freeIndex;
    freeIndex := current;
  end
  else
    writeln('Элемент не найден.');
end;

var
  choice, data: integer;

begin
  InitializeList;

  repeat
    writeln('Меню:');
    writeln('1. Вывести список');
    writeln('2. Добавить элемент');
    writeln('3. Удалить элемент');
    writeln('0. Выход');
    write('Выберите действие: ');
    readln(choice);

    case choice of
      1: DisplayList;
      2: begin
           write('Введите данные для нового элемента: ');
           readln(data);
           AddNode(data);
         end;
      3: begin
           write('Введите данные элемента для удаления: ');
           readln(data);
           DeleteNode(data);
         end;
    end;
  until choice = 0;
end.