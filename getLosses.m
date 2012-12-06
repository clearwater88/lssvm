function [costs_LSSVM,costs_CCCP,costs_new] = getLosses(x,y,w,wInit)
    margin = 1;
    % nData x |h| x |y|, which selects first or second dim
       
    inds = sub2ind([numel(y),2],(1:size(y,1))',y+1);
    feat = bsxfun(@times,x,reshape(w,[1,1,2]));
    
    %% LSSVM
    feat1(:,:,1) = bsxfun(@plus,feat(:,:,1),margin*(y~=0));
    feat1(:,:,2) = bsxfun(@plus,feat(:,:,2), margin*(y~=1));
    
    costs1_LSSVM = max(max(feat1,[],2),[],3);
    
    costs2_LSSVM = squeeze(max(feat,[],2));
    costs2_LSSVM = costs2_LSSVM(inds);
    
    costs_LSSVM = sum(costs1_LSSVM-costs2_LSSVM) + 0.5*sum(w.^2);
    %% LSSVM
    
    costs1_CCCP = costs1_LSSVM;
    
    % replace max over h with best h from previous w value (wInit)
    featPrev = bsxfun(@times,x,reshape(wInit,[1,1,2]));
    [~,costs2_CCCP_h_inds] = max(featPrev,[],2);
    for (i=1:2)
        hUse = costs2_CCCP_h_inds(:,:,i);
        hInd = sub2ind([numel(y),2,2],(1:size(y,1))',hUse,i*ones(numel(y),1)); 
        feat2_CCCP(:,i) = feat(hInd);
    end
    % replace max over h with best h from previous w value
    
    costs2_CCCP = feat2_CCCP(inds);    
    
    costs_CCCP = sum(costs1_CCCP-costs2_CCCP) + 0.5*sum(w.^2);
    
    assert(~any(-costs2_LSSVM > -costs2_CCCP));
    
    feat1_new = feat2_CCCP;
    costs1_p1_new = feat1_new(inds);
    indsFalse = sub2ind([numel(y),2],(1:size(y,1))',~y+1);
    costs1_p2_new = squeeze(max(feat,[],2));
    costs1_p2_new = costs1_p2_new(indsFalse)+1;
    costs1_new = max(costs1_p1_new,costs1_p2_new);
    
    costs2_new = costs2_CCCP;
    costs_new = sum(costs1_new-costs2_new) + 0.5*sum(w.^2);
    assert(~any(-costs2_LSSVM > -costs2_new));
    
    assert(~any(costs_LSSVM(:) > costs_new(:)));
    assert(~any(costs_new(:) > costs_CCCP(:)));

end