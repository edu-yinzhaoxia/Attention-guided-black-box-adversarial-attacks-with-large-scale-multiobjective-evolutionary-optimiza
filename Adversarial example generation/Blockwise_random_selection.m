%% Reduction with block-wise random selection
function RegionIndex = Blockwise_random_selection(ImageSize)
   Blocksize     = 4;
   NumofBlockRow = ceil(ImageSize(1)/Blocksize);
   NumofBlockCol = ceil(ImageSize(2)/Blocksize);
   NumofBlock    = NumofBlockRow * NumofBlockCol;
   RegionIndex   = zeros(1,NumofBlock);
   for i = 1 : NumofBlock
       if i > NumofBlock - NumofBlockCol && mod(i,NumofBlockCol)
           RowIndex = ImageSize(1)-Blocksize+1:1:ImageSize(1);
           ColIndex = Blocksize*(mod(i,NumofBlockCol)-1)+1:1:Blocksize*mod(i,NumofBlockCol);
       elseif i > NumofBlock - NumofBlockCol && ~mod(i,NumofBlockCol)
           RowIndex = ImageSize(1)-Blocksize+1:1:ImageSize(1);
           ColIndex = ImageSize(2)-Blocksize+1:1:ImageSize(2);
       elseif mod(i,NumofBlockCol)
           RowIndex = Blocksize*floor(i/NumofBlockCol)+1:1:Blocksize*ceil(i/NumofBlockCol);
           ColIndex = Blocksize*(mod(i,NumofBlockCol)-1)+1:1:Blocksize*mod(i,NumofBlockCol);
       else
           RowIndex = Blocksize*(floor(i/NumofBlockCol)-1)+1:1:Blocksize*floor(i/NumofBlockCol);
           ColIndex = ImageSize(2)-Blocksize+1:1:ImageSize(2);
       end
       Index1 = randperm(Blocksize);
       Index2 = randperm(Blocksize);
       RegionIndex(i) = sub2ind([ImageSize(1),ImageSize(2)],RowIndex(Index1(1)),ColIndex(Index2(1)));
   end
end