function [newL] = remove_duplicates(L)
newL = L(1,:);
for i=2:size(L)
    if(newL(end,1)~=L(end,1))
        newL = [newL;L(i,:)];
    end
end

