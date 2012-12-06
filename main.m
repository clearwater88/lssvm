close all;

nSamples = 100;
[x,y] = makeData(nSamples);

w0 = [-5:0.1:5];
w1 = [-5:0.1:5];
%wInit = 10*rand(2,1)-5;
wInit = [0;0];

loss_LSSVM = zeros(numel(w0),numel(w1));
loss_CCCP = zeros(numel(w0),numel(w1));
loss_new = zeros(numel(w0),numel(w1));

for (i=1:numel(w0))
    for (j=1:numel(w1))
        [loss_LSSVM(i,j),loss_CCCP(i,j),loss_new(i,j)] = getLosses(x,y,[w0(i);w1(j)],wInit);
    end
end

assert(~any(loss_LSSVM(:) > loss_new(:)));
assert(~any(loss_new(:) > loss_CCCP(:)));

% plot(w1,loss_LSSVM,'b'); hold on;
% plot(w1,loss_CCCP,'g'); hold on;
% plot(w1,loss_new,'r'); hold on;
% legend('lssvm','cccp','new');

figure(1);
h1 = surf(w0,w1,loss_LSSVM); hold on;
h2 = surf(w0,w1,loss_CCCP); hold on;
h3 = surf(w0,w1,loss_new); hold on;

set(h2,'facealpha',0.3);
set(h2,'facealpha',0.6);
legend('lssvm','cccp','new');
xlabel('w0');
ylabel('w1');


[~,ind] = min(loss_LSSVM(:));
[w0m_lssvm,w1_lssvm] = ind2sub(size(loss_LSSVM),ind)

display(['LSSVM min: ', num2str(w0(w0m_lssvm)),'/',num2str(w1(w1_lssvm))]);

[~,ind] = min(loss_CCCP(:));
[w0m_cccp,w1_cccp] = ind2sub(size(loss_CCCP),ind)

display(['CCCP min: ', num2str(w0(w0m_cccp)),'/', num2str(w1(w1_cccp))]);

[~,ind] = min(loss_new(:));
[w0m_new,w1_new] = ind2sub(size(loss_new),ind)

display(['new min: ', num2str(w0(w0m_new)),'/', num2str(w1(w1_new))]);
% 




% loss_LSSVM_same = zeros(numel(w1),1);
% loss_CCCP_same = zeros(numel(w1),1);
% loss_new_same = zeros(numel(w1),1);
% for (i=1:numel(w0))
%     loss_LSSVM_same(i) = loss_LSSVM(i,i);
%     loss_CCCP_same(i) = loss_CCCP(i,i);
%     loss_new_same(i) = loss_new(i,i);
% end
% 
% figure(2);
% plot(w1,loss_LSSVM_same,'b'); hold on;
% plot(w1,loss_CCCP_same,'g'); hold on;
% plot(w1,loss_new_same,'r'); hold on;
% legend('llsvm','cccp','new');