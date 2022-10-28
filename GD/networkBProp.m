function [yGrad,varargout]=networkBProp(network,yintVal)
%
% Description: perform back propagation for a neural-network.
% Usage: [yGrad]=networkBProp(network,yintVal)
%        [yGrad,yGrad_Struct]=networkBProp(network,yintVal)
%    Inputs:
%        network  : Structure array of network.
%        yintVal  : Intermediate values for forward propagation.
%    Output:
%        yGrad        : Gradient vector of the output with respect to the
%                       weights.
%        yGrad_Struct : Gradient vector organized in structured array by
%                       the layers.
%
nLayer=length(network);
xDim=size(yintVal(1).Output);
nPts=xDim(2);
%
% Initialize the chain rule matrix.
%
wDim=size(network(nLayer).Weight);
nOutput=wDim(1);
ChainMatrix=ones(nOutput,nOutput,nPts);
for iPts=1:nPts
    ChainMatrix(:,:,iPts)=diag(yintVal(nLayer+1).Grad(:,iPts));
end
yGrad_Struct=struct('Grad',cell(1,nLayer));
%
% Loop over layers
%
nWeight=zeros(1,nLayer);
for iLayer=nLayer:-1:1
    %
    % Derivative of the output with respect to the iLayer's ceofficients is
    % given by the back propagated derivative chain multiplied by
    % derivative of the iLayer's output with respect to its weights which
    % has the form
    %      s'(a^Tx)*x.
    %
    wDim=size(network(iLayer).Weight);
    nWeight(iLayer)=numel(network(iLayer).Weight);
    yGrad_Struct(iLayer).Grad=zeros(wDim(1),wDim(2),nOutput,nPts);
    for iPts=1:nPts
        for iOutput=1:nOutput
            InputVect=[yintVal(iLayer).Output(:,iPts)',1];
            yGrad_Struct(iLayer).Grad(:,:,iOutput,iPts)=(ChainMatrix(iOutput,:,iPts)')*InputVect;
        end
    end
    %
    % Back propagate the derivative chain to the next layer.
    %
    if iLayer>1
        newChainMatrix=zeros(nOutput,wDim(2)-1,nPts);
        for iPts=1:nPts
            newChainMatrix(:,:,iPts)=ChainMatrix(:,:,iPts)*network(iLayer).Weight(:,1:end-1)*diag(yintVal(iLayer).Grad(:,iPts));
        end
        ChainMatrix=newChainMatrix;
    end
end
yGrad=zeros(nOutput,sum(nWeight),nPts);
iWeight=0;
for iLayer=1:nLayer
    for iOutput=1:nOutput
        for iPts=1:nPts
            yGrad(iOutput,iWeight+[1:nWeight(iLayer)],iPts)=reshape(yGrad_Struct(iLayer).Grad(:,:,iOutput,iPts),[1,nWeight(iLayer),1]);
        end
    end
    iWeight=iWeight+nWeight(iLayer);
end
if nargout>1
    varargout{1}=yGrad_Struct;
end
return
end