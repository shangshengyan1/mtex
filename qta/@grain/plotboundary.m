function varargout = plotboundary(grains,varargin)
% plot grain boundaries
%
%% Syntax
%  plotboundary(grains)
%  plotboundary(grains,'LineSpec',...)
%  plotboundary(grains,'property',...)
%  plotboundary(grains,'property',@rotation)
%  plotboundary(grains,'property','colorcoding',...)
%
%% Options
%  property       - phase, angle, @rotation, @orientation
%
%% See also
% grain/plot grain/plotgrains grain/misorientation

% default plot options
varargin = set_default_option(varargin,...
  get_mtex_option('default_plot_options'));

property = lower(get_option(varargin,'property',[]));

newMTEXplot;
selector(gcf);

%%

[phase uphase] = get(grains,'phase');

p = polygon( grains );
h = plot(p,'color',[0.8 0.8 0.8]);


if strcmpi(property,'phase')
  
  pair = pairs(grains);
  pair(pair(:,1) == pair(:,2),:) = [];
  
  if ~isempty(pair)
    
    pair = unique(sort(pair,2),'rows');
    
    np = length(uphase);
    
    [i j] = find(triu(ones(np)));
    code = full(sparse(i,j,1:length(i)));
    code = code + triu(code,1)';
    
    d = phase(pair);
    ndx = diff(d,[],2) == 0; % delete same phase
    pair(ndx,:) = [];
    d(ndx,:) = [];
    
    c(uphase) = 1:length(uphase);
    d = c(d);
    
    pair(:,3) = code(sub2ind(size(code),d(:,1),d(:,2)));
    
    h(end+1) = plot(p, 'pair', pair, varargin{:} );    
    
  end
  
elseif ~isempty(property)

  CS = get(grains,'CS');
  
  for ph=uphase
    %neighboured grains per phase
    ndx = phase == ph;
    grains_phase = grains(ndx);

    pair = pairs(grains_phase);
    pair(pair(:,1) == pair(:,2),:) = []; % self reference

    if ~isempty(pair)   

      pair = unique(sort(pair,2),'rows');

      % boundary angle
      o = get(grains_phase,'orientation');
      
      om = o(pair(:,1)) .\ o(pair(:,2));
      
      if isa(property,'quaternion')
        
        epsilon = get_option(varargin,'delta',2*degree,'double');

        ind = any(find(om,property,epsilon),2);
        
        pair = pair(ind,:);

      elseif ~check_option(varargin,'colorcoding')

        d = angle( om )./degree;
        pair(:,3) = d;

      else

        cc = get_option(varargin,'colorcoding');

        d = orientation2color(om,cc,varargin{:});
        pair(:,3:5) = d;

      end

      h = [h plot(p(ndx), 'pair', pair, varargin{:} )];
      
    end

  end
  
else 
  
   optiondraw(h,varargin{:});
  
end

selector(gcf,grains,p,h);

if check_option(varargin,'colorcoding');
  setappdata(gcf,'CS',CS);
	setappdata(gcf,'r',get_option(varargin,'r',xvector,'vector3d')); 
	setappdata(gcf,'colorcenter',get_option(varargin,'colorcenter',[]));
	setappdata(gcf,'colorcoding',cc);
	setappdata(gcf,'options',extract_option(varargin,'antipodal'));
end

if nargout > 0
  varargout{1} = h;
end