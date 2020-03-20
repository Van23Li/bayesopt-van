function res = permutation_and_combination(A)
% A ÎªcellÀàĞÍ
dim = size(A,2);
output_param = [];
output_param2 = [];
input_param = [];
input_param2 = [];
for idx = 1 : dim
   if idx == dim
       output_param = [output_param, 'n', num2str(idx)];
       output_param2 = [output_param2, 'res(:,', num2str(idx), ')'];
       input_param = [input_param, 'A{',num2str(idx), '}'];
       input_param2 = [input_param2, 'reshape(n', num2str(idx),',[],1)'];
   else
       output_param = [output_param, 'n', num2str(idx), ','];
       output_param2 = [output_param2, 'res(:,', num2str(idx), '),'];
       input_param = [input_param, 'A{',num2str(idx), '},'];
       input_param2 = [input_param2, 'reshape(n', num2str(idx),',[],1),'];
   end
end
func_name1 = ['[', output_param, '] = ndgrid(', input_param, ');'];
eval(func_name1);
func_name2 = ['[', output_param2, '] = deal(', input_param2, ');'];
eval(func_name2);
end