// class BaseNodeModel extends BaseModel {
//   static const double iconSize = 14;
//   static const double padding = 4.0;
//   static const double horizontalItemMargin = 6.0;
//   static const int gravityLeft = 0;
//   static const int gravityCenter = 0;
//   static const int gravityCenterVertical = 0;
//
//   static const int taskNormal = 0;
//   static const int taskDone = 1;
//   static const double nodeWidthDpMin = 50.0;
//
//   static const int? typeNormal = null;
//   static const int typeDetail = 2;
//   static const Color assignBgColor=Color(0xff0168FD);
//
//   BaseNodeModel(String text) : super(text);
//   List<NodeModel> children = [];
//   List<ConspectusModel> conspectuses = [];
//   List<BoundaryModel> boundaries = [];
//   List<CalloutModel> callouts = [];
//
//   //childNodes是否隐藏
//   bool isHidden = false;
//   BaseNodeModel? parent;
//   String? table;
//   String? note;
//   String? hyperlink;
//   List<NodeImage> imageData = [];
//
//   // 0左 1上 2右 3下 null下
//   int? imageLocation;
//   List<String> attachments = [];
//   String? audio;
//   int? remind;
//
//
//   // 图标
//   MarkerModelList markers = MarkerModelList();
//   int? priority; // 旧优先级
//   int? progress;
//
//   //这些都是网页端的格式
//   String? color;
//   String? background;
//   int? textSize;
//   String? fontStyle;
//   String? fontWeight;
//   int? imgWidth;
//   int? imgHeight;
//   String? imageTitle;
//
//   // 节点宽度
//   int? nodeWidthDp;
//   // 待办 0未完成、1已完成
//   int? task;
//
//   // 左上角坐标，绝对位置，自由布局才启用,DP值
//   double xDp = 0;
//   double yDp = 0;
//
//   // 作为自由布局根节点时的坐标, 相对于根节点的位置，DP值
//   double? freeXDp;
//   double? freeYDp;
//
//   // 线条类型
//   int? lineStyle;
//   // 线条效果
//   int? lineEffect;
//   // 线条颜色
//   int? lineColor;
//   // 线条宽度 单位DP
//   int? lineWidth;
//   // 背景形状
//   int? backgroundShape;
//   // 背景效果
//   int? backgroundEffect;
//   // 背景颜色
//   int? backgroundColor;
//   // 子节点布局
//   int? layout;
//
//   PowerPointNodeBinding? powerPointModel;
//
//   // Todo相关
//   String? sectionPath; // 仅在根导图1级节点使用，该节点对应的Section文件相对路径
//   int? type; // 类型，子任务or详情
//   List<String> assigns = [];
//   List<StoryBean> stories = [];
//   Map<String, dynamic> extendValues = {}; // 扩充属性，外部可自由定义 （key, value），不会存储
//
//   // 以下是不需要存储的属性
//   Rect? _drawLineBounds;
//
//   Rect get drawLineBounds => _drawLineBounds ?? bounds;
//
//   set drawLineBounds(Rect? value) {
//     _drawLineBounds = value;
//   }
//
//   bool get isDrawLineBoundsNull => _drawLineBounds == null;
//   bool _isVisible = true;
//
//   bool get isVisible {
//     return _isVisible && !isParentHide && !isHideForLayout;
//   }
//
//   set isVisible(bool value) {
//     _isVisible = value;
//   }
//
//   NodeBackground? _nodeBackground;
//
//   set nodeBackground(NodeBackground? value) {
//     final oldBackground = _nodeBackground;
//     if (oldBackground is MeasureNodeBackground) {
//       oldBackground.nodeModel = null;
//     }
//     _nodeBackground = value;
//     if (value is MeasureNodeBackground) {
//       value.nodeModel = this;
//     }
//   }
//
//   NodeBackground? get nodeBackground => _nodeBackground;
//   int hintTextColor = 0x88000000;
//   double measuredWidth = 0;
//   double measuredHeight = 0;
//   bool isDragging = false;
//   Rect boundsWithChildren = const Rect.fromLTRB(0.0, 0.0, 0.0, 0.0);
//
//   bool get isRootNode => parent == null;
//   int subChildrenSize = 0; // showView
//
//   // view信息（基于节点内部坐标系）
//   var renderer = NodeModelRenderer.instance;
//   double minWidth = 0;
//   double minHeight = 0;
//   MutableRect noteBounds = MutableRect.zero();
//   MutableRect hyperlinkBounds = MutableRect.zero();
//   MutableRect progressBounds = MutableRect.zero();
//   MutableRect priorityBounds = MutableRect.zero();
//   Map<MarkerModel, MutableRect> markerBounds = {};
//   MutableRect taskBounds = MutableRect.zero();
//   MutableRect remindBounds = MutableRect.zero();
//   Map<String, MutableRect> assignBounds = {};
//   Map<String, AssignUserBean> assignName = {};
//   Map<String, TextPainter> assignTextPainter = {};
//   Map<String, Color> assignBackgroundColor = {};
//
//   double? remindIconSize; // 需要动态计算，计算出来后存起来
//
//   Alignment gravity = Alignment.topLeft;
//   Map<String, MutableRect> imagesBounds = {};
//   static const clickNote = 1;
//   static const clickHyperlink = 2;
//   static const clickAttachment = 3;
//   static const clickAudio = 4;
//   static const clickTask = 5;
//   static const clickIcon = 6;
//   static const clickDescription = 7;
//   static const clickRemind = 8;
//   static const clickProgress = 9;
//   static const clickPriority = 10;
//   static const clickNone = -1;
//   Function(BaseNodeModel nodeModel, int type)? onNoteClick;
//   bool Function(BaseNodeModel nodeModel, double nodeX, double nodeY)? registerCustomItemClick;
//   void Function(BaseNodeModel nodeModel, MarkerModel markerModel, MutableRect bounds)? onMarkerClick;
//   void Function(BaseNodeModel nodeModel, String assignId, MutableRect bounds)? onAssignClick;
//   Function(BaseNodeModel nodeModel, ClickButton clickButton)? onNodeClick;
//   Function(BaseNodeModel nodeModel)? onNodeLongClick;
//   Function(BaseNodeModel nodeModel, NodeImage nodeImage)? onImageClick;
//   Function(BaseNodeModel nodeModel, NodeImage nodeImage)? onImageLongClick;
//
//   Paint shapePaint = Paint();
//   Paint shapeBackgroundPaint = Paint();
//
//   set viewTextAlign(TextAlign textAlign) {
//     textPainter.textAlign = textAlign;
//   }
//
//   bool get isParentHide {
//     bool checkParent(BaseNodeModel node) {
//       final parent = node.parent;
//       if (parent != null) {
//         if (parent.isHidden) {
//           return true;
//         } else {
//           return checkParent(parent);
//         }
//       } else {
//         return false;
//       }
//     }
//
//     return checkParent(this);
//   }
//
//   void addImages(List<NodeImage> images) {
//     imageData.addAll(images);
//   }
//
//   void deleteImage(List<NodeImage> images) {
//     final imageIndexes = <int>[];
//     for (int i = 0; i < images.length; i++) {
//       final nodeImage = images[i];
//       imageIndexes.add(imageData.indexOf(nodeImage));
//     }
//     for (var imageIndex in imageIndexes) {
//       if (imageIndex >= 0) {
//         imageData.removeAt(imageIndex);
//       }
//     }
//   }
//
//   void addSubNode(NodeModel addNode, {int? index}){
//     if (index == null) {
//       children.add(addNode);
//     } else {
//       children.insert(index, addNode);
//     }
//     addNode.parent = this;
//   }
//
//   void addConspectus(ConspectusModel conspectusModel, {int? floor}) {
//     if (floor == null) {
//       conspectuses.add(conspectusModel);
//     } else {
//       conspectuses.insert(floor, conspectusModel);
//     }
//     conspectusModel.parent = this;
//   }
//
//   void addBoundary(BoundaryModel boundaryModel, {int? floor}) {
//     if (floor == null) {
//       boundaries.add(boundaryModel);
//     } else {
//       boundaries.insert(floor, boundaryModel);
//     }
//     boundaryModel.parent = this;
//   }
//
//   void addCallout(CalloutModel calloutModel, {int? floor}) {
//     if (floor == null) {
//       callouts.add(calloutModel);
//     } else {
//       callouts.insert(floor, calloutModel);
//     }
//     calloutModel.parent = this;
//   }
//
//   List<String> getReferenceFiles() {
//     final reference = <String>[];
//     for (var image in imageData) {
//       reference.add(image.src);
//     }
//     for (var attachment in attachments) {
//       reference.add(attachment);
//     }
//     final audio = this.audio;
//     if (audio != null) {
//       reference.add(audio);
//     }
//     return reference;
//   }
//
//   /// 更新引用
//   void updateReferenceFiles(String Function(String reference) map) {
//     for (final image in imageData) {
//       final newSrc = map(image.src);
//       image.src = newSrc;
//     }
//     final newAttachment = attachments.map(map).toList();
//     attachments.clear();
//     attachments.addAll(newAttachment);
//
//     final oldAudio = audio;
//     if (oldAudio != null) {
//       audio = map(oldAudio);
//     }
//   }
//
//   void ergodicItsSubNode(ergodicCon ergodic, {bool withItself = false}) {
//     Queue queue = Queue<BaseNodeModel>();
//     if (withItself) {
//       queue.add(this);
//     } else {
//       queue.addAll(children);
//     }
//     while (queue.isNotEmpty) {
//       NodeModel poll = queue.removeLast();
//       bool result = ergodic(poll);
//       if (!result) break;
//       queue.addAll(poll.children);
//     }
//   }
//
//   void ergodicItsSubWithRangeBaseAndCallout(ergodicCon ergodic, {bool withItself = false}) {
//     Queue queue = Queue<BaseNodeModel>();
//     if (withItself) {
//       queue.add(this);
//     } else {
//       queue.addAll(children);
//     }
//     while (queue.isNotEmpty) {
//       final poll = queue.removeFirst();
//       final isContinue = ergodic(poll);
//       if (!isContinue) break;
//       queue.addAll(poll.conspectuses);
//       queue.addAll(poll.boundaries);
//       // 绘制的时候优先绘制外框再绘制节点，
//       queue.addAll(poll.children);
//       queue.addAll(poll.callouts);
//     }
//   }
//
//   void ergodicItsSubNodeWithoutHide(bool Function(BaseNodeModel next) ergodic) {
//     Queue<BaseNodeModel> queue = Queue<BaseNodeModel>();
//     queue.add(this);
//     while (queue.isNotEmpty) {
//       BaseNodeModel poll = queue.removeLast();
//       bool result = ergodic(poll);
//       if (!result) break;
//       if (!poll.isHidden) {
//         queue.addAll(poll.children);
//       }
//     }
//   }
//
//   void ergodicItsSubNodeWithConspectusCalloutWithoutHide(
//       bool Function(BaseNodeModel next) ergodic) {
//     final Queue<BaseNodeModel> queue = Queue<BaseNodeModel>();
//     queue.add(this);
//     while (queue.isNotEmpty) {
//       final poll = queue.removeLast();
//       final result = ergodic(poll);
//       if (!result) return;
//       if (!poll.isHidden) {
//         queue.addAll(poll.children);
//         queue.addAll(poll.conspectuses);
//       }
//       queue.addAll(poll.callouts);
//     }
//   }
//
//   void ergodicItsSubNodeWithConspectusAndCallout(
//       bool Function(BaseNodeModel next) ergodic,
//       {bool withItself = true}) {
//     final Queue<BaseNodeModel> queue = Queue();
//     if (withItself) {
//       queue.add(this);
//     } else {
//       queue
//         ..addAll(children)
//         ..addAll(conspectuses)
//         ..addAll(callouts);
//     }
//     while (queue.isNotEmpty) {
//       final poll = queue.removeFirst();
//       final result = ergodic(poll);
//       if (!result) {
//         return;
//       }
//       queue
//         ..addAll(poll.children)
//         ..addAll(poll.conspectuses)
//         ..addAll(poll.callouts);
//     }
//   }
//
//   void layoutTo(double left, double top, [double? right, double? bottom]) {
//     bounds = Rect.fromLTRB(left, top, right ?? left + measuredWidth,
//         bottom ?? top + measuredHeight);
//   }
//
//   void freeLayout(double left, double top) {
//     freeXDp = left;
//     freeYDp = top;
//   }
//
//   void parseContent(TreeModel treeModel) {
//     NodeHint? nodeHint = treeModel.nodeHint;
//     if (HtmlUtils.toPlainText(text).isEmpty && nodeHint != null) {
//       String hintText;
//       if (this is ConspectusModel) {
//         hintText = nodeHint.summary;
//       } else if (this is NodeModel) {
//         if (isRootNode) {
//           if (treeModel.isFreeRootGlobal(this)) {
//             hintText = nodeHint.floatingTopic;
//           } else {
//             hintText = nodeHint.centralTopic;
//           }
//         } else {
//           final parent = this.parent;
//           String ext;
//           if (nodeHint.isContainNum) {
//             if (parent == null) {
//               ext = "";
//             } else {
//               ext = " ${parent.children.indexOf(this as NodeModel) + 1}";
//             }
//           } else {
//             ext = "";
//           }
//
//           if (isTierIs(1)) {
//             hintText = "${nodeHint.topic}$ext";
//           } else {
//             hintText = "${nodeHint.subTopic}$ext";
//           }
//         }
//       } else if (this is CalloutModel) {
//         hintText = nodeHint.callout;
//       } else {
//         hintText = nodeHint.topic;
//       }
//       textPainter.text = buildHintTextSpan(hintText);
//     } else {
//       final baseStyle = task == taskDone ? TextStyle(
//         decoration: TextDecoration.lineThrough,
//         decorationThickness: 2,
//         color: Color(ColorUtils.setAlpha(baseTextColor, 0.7)),
//       ) : null;
//       textPainter.text = HtmlUtils.fromHtml(text, baseTextColor, baseTextSize, baseStyle: baseStyle);
//     }
//   }
//
//   setHintText(String hint){
//     textPainter.text = buildHintTextSpan(hint);
//   }
//
//   TextSpan buildHintTextSpan(String hintText) {
//     final baseStyle = task == taskDone ? TextStyle(
//       decoration: TextDecoration.lineThrough,
//       decorationThickness: 2,
//       color: Color(ColorUtils.setAlpha(baseTextColor, 0.7)),
//     ) : null;
//
//     return TextSpan(
//         style: TextStyle(
//             color: Color(baseTextColor),
//             fontSize: baseTextSize,
//             height:1.25,
//             decoration: task == taskDone ? TextDecoration.lineThrough : null
//         ).merge(baseStyle),
//         children: [
//           TextSpan(
//             text: hintText,
//           )
//         ]
//     );
//   }
//
//   List<PlaceholderSpan?> textPainterEmojis = [];
//   void measureText(TreeModel treeModel, double textMaxWidth, TextPainter textPainter, List<PlaceholderSpan?> emojis) {
//     renderer.measureText(this, treeModel, textMaxWidth, textPainter, emojis);
//   }
//
//   /// contentWidth 指定内容宽度，如表格布局，指定宽度之后可以居中布局节点
//   void measure(TreeModel treeModel, {double? contentWidth, double? contentHeight}) {
//     renderer.measure(this, treeModel, contentWidth: contentWidth, contentHeight: contentHeight);
//   }
//
//   MutableRectGroup measureContent(TreeModel treeModel, {double? requestWidth}) {
//     return renderer.measureContent(this, treeModel, requestWidth: requestWidth);
//   }
//
//   MutableRect measureAndLayoutText(
//       double left, double top, TreeModel treeModel, double nodeWidthDp) {
//     return renderer.measureAndLayoutText(
//         this, left, top, treeModel, nodeWidthDp);
//   }
//
//   // 基于Tree坐标系
//   void click(double x, double y, ClickButton clickButton) {
//     if (disable) return;
//     if (isHideForLayout) return;//isPPTModel：修改节点点击根结点处隐藏了还能点击
//     if (!bounds.contains(Offset(x, y))) {
//       return;
//     }
//     // 转换成node坐标
//     final double nodeX = x - bounds.left;
//     final double nodeY = y - bounds.top;
//     if (itemClick(nodeX, nodeY)) {
//       return;
//     }
//     onNodeClick?.call(this, clickButton);
//   }
//
//   Rect Function()? getHoverBounds(double x, double y) {
//     return renderer.getHoverBounds(this, x, y);
//   }
//
//   Rect toGlobalRect(MutableRect rect) {
//     return Rect.fromLTRB(bounds.left + rect.left, bounds.top + rect.top,
//         bounds.left + rect.right, bounds.top + rect.bottom);
//   }
//
//   bool itemClick(double nodeX, double nodeY) {
//     return renderer.itemClick(this, nodeX, nodeY);
//   }
//
//   void longClick(double x, double y) {
//     if (!bounds.contains(Offset(x, y))) {
//       return;
//     }
//     // 转换成node坐标
//     final double nodeX = x - bounds.left;
//     final double nodeY = y - bounds.top;
//     if (isSelected) {
//       if (imageData.isNotEmpty) {
//         for (var image in imageData) {
//           final imageBounds = imagesBounds[image.src];
//           if (imageBounds != null) {
//             if (imageBounds.contains(nodeX, nodeY)) {
//               onImageLongClick?.call(this, image);
//               return;
//             }
//           }
//         }
//       }
//     }
//     onNodeLongClick?.call(this);
//   }
//
//   final Paint paint = Paint()
//     ..isAntiAlias = true
//     ..filterQuality = FilterQuality.medium;
//   final Paint emptyImagePaint = Paint()
//     ..style = PaintingStyle.fill
//     ..color = const Color(0xff888888);
//
//
//   void draw(Canvas canvas, ImageRequester imageRequester, {Rect? movingBounds, bool forceDraw = false}) {
//     renderer.draw(this, canvas, imageRequester, movingBounds: movingBounds, forceDraw: forceDraw);
//   }
//
//   String getProgressAsset(int data) {
//     if (data >= 1 && data <= 9) {
//       return "assets/outline/ic_progress$data.png";
//     } else if (data == 10) {
//       return "assets/outline/ic_progress$data.png";
//     }
//     return "assets/outline/ic_progress1.png";
//   }
//
//   String getPriorityAsset(int data) {
//     if (data >= 1 && data <= 19) {
//       return "assets/outline/ic_priority$data.png";
//     }
//     return "assets/outline/ic_priority1.png";
//   }
//
//   String getTaskAssets(int task) {
//     if (task == taskNormal) {
//       return "packages/mpcore/assets/ic_task.png";
//     } else {
//       return "packages/mpcore/assets/ic_task_done.png";
//     }
//   }
//
//   void drawText(
//       Canvas canvas,
//       ImageRequester imageRequester,
//       TextPainter textPainter,
//       List<PlaceholderSpan?> textPainterEmojis,
//       MutableRect textBounds,
//       {Rect? movingBounds}) {
//     renderer.drawText(this, canvas, imageRequester, textPainter,
//         textPainterEmojis, textBounds);
//   }
//
//   int _calculateTier(BaseNodeModel nodeModel) {
//     if (nodeModel.isRootNode) {
//       return 0;
//     } else {
//       BaseNodeModel? parent = nodeModel.parent;
//       if (parent == null) {
//         return -1;
//       } else {
//         return _calculateTier(parent) + 1;
//       }
//     }
//   }
//
//   int calculateTier() {
//     return _calculateTier(this);
//   }
//
//   bool isTierIs(int tier) {
//     assert (tier >= 0);
//     BaseNodeModel? node = this;
//     int tierCount = 0;
//     while (node != null) {
//       if (tierCount > tier) {
//         return false;
//       }
//       if (node.isRootNode) {
//         return tierCount == tier;
//       } else {
//         node = node.parent;
//         tierCount++;
//       }
//     }
//     return false;
//   }
//
//   bool isTierLessThan(int than) {
//     assert (than >= 0);
//     BaseNodeModel? node = this;
//     int tierCount = 0;
//     while (node != null) {
//       if (tierCount >= than) {
//         return false;
//       }
//       if (node.isRootNode) {
//         return tierCount <= than;
//       } else {
//         node = node.parent;
//         tierCount++;
//       }
//     }
//     return false;
//   }
//
//   int recursiveCalculateBranch(BaseNodeModel nodeModel) {
//     final parentNode = nodeModel.parent;
//     if (parentNode == null) {
//       return -1;
//     } else {
//       if (parentNode.isRootNode) {
//         if (nodeModel is NodeModel) {
//           return parentNode.children.indexOf(nodeModel);
//         }
//         return -1;
//       } else {
//         return recursiveCalculateBranch(parentNode);
//       }
//     }
//   }
//
//   int calculateBranch() {
//     final conspectusParent = getMostRangeBaseParent();
//     if (conspectusParent != null) {
//       return conspectusParent.calculateBranch();
//     }
//     return recursiveCalculateBranch(this);
//   }
//
//   RangeBaseModel? getMostRangeBaseParent() {
//     RangeBaseModel? find;
//     BaseNodeModel? parent = this.parent;
//     while (parent != null) {
//       if(parent is RangeBaseModel) {
//         find = parent;
//       }
//       parent = parent.parent;
//     }
//     return find;
//   }
//
//   BaseNodeModel getRootNode() {
//     if (isRootNode) {
//       return this;
//     } else {
//       return parent?.getRootNode() ?? this;
//     }
//   }
//
//   bool isRootForComplex(int layout, int treeLayout) {
//     return identical(this, getRootNodeForComplex(layout, treeLayout));
//   }
//
//   BaseNodeModel? getRootNodeForComplex(int layout, int treeLayout) {
//     var node = this;
//     BaseNodeModel? find;
//     while (true) {
//       if (node.layout == layout) {
//         find = node;
//       } else {
//         if (node.layout != null) {
//           break;
//         }
//       }
//       if (node.isRootNode) {
//         if (node.layout == null && treeLayout == layout) {
//           find = node;
//         }
//         break;
//       }
//       final parent = node.parent;
//       if (parent == null) break;
//       node = parent;
//     }
//     return find;
//   }
//
//   bool isTierIsForComplex(int tier, int layout, int treeLayout) {
//     final nodeModel = this;
//     if (tier < 0) throw Exception("than must bigger than 0");
//     final complexRoot = nodeModel.getRootNodeForComplex(layout, treeLayout);
//     if (complexRoot == null) {
//       return false;
//     } else {
//       return complexRoot.calculateRelativeTier(nodeModel) == tier;
//     }
//   }
//
//   int calculateRelativeTier(BaseNodeModel to) {
//     final fromTier = calculateTier();
//     final toTier = to.calculateTier();
//     return toTier - fromTier;
//   }
//
//   bool isTierMoreThanForComplex(int than, int layout, int treeLayout) {
//     assert(than >= 0);
//     final complexRoot = getRootNodeForComplex(layout, treeLayout);
//     if (complexRoot == null) {
//       return false;
//     } else {
//       final relativeTier = complexRoot.calculateRelativeTier(this);
//       return relativeTier > than;
//     }
//   }
//
//   bool isInFishOrForm() {
//     var node = this;
//     while (true) {
//       if (node.layout == TreeValue.LAYOUT_FISH_RIGHT ||
//           node.layout == TreeValue.LAYOUT_FORM) {
//         return true;
//       }
//       final parent = node.parent;
//       if (parent == null) {
//         break;
//       } else {
//         node = parent;
//       }
//     }
//     return false;
//   }
//
//   bool isSameConspectusExist(int rangeFrom, int rangeTo) {
//     for (var conspectus in conspectuses) {
//       if (conspectus.rangeFrom == rangeFrom && conspectus.rangeTo == rangeTo) {
//         return true;
//       }
//     }
//     return false;
//   }
//
//   bool isSameBoundaryExist(int rangeFrom, int rangeTo) {
//     for (var boundary in boundaries) {
//       if (boundary.rangeFrom == rangeFrom && boundary.rangeTo == rangeTo) {
//         return true;
//       }
//     }
//     return false;
//   }
//
//   int? _getNodeLayout(BaseNodeModel nodeModel) {
//     if (nodeModel.layout == null) {
//       final parent = nodeModel.parent;
//       if (parent == null) {
//         return null;
//       }
//       return _getNodeLayout(parent);
//     }
//     return nodeModel.layout;
//   }
//
//   int? getLayout() {
//     return _getNodeLayout(this);
//   }
//
//   bool isConspectusChild() {
//     BaseNodeModel? parent = this.parent;
//     while (parent != null) {
//       if (parent is ConspectusModel) {
//         return true;
//       }
//       parent = parent.parent;
//     }
//     return false;
//   }
//
//   bool isRangeBaseChild() {
//     BaseNodeModel? parent = this.parent;
//     while (parent != null) {
//       if (parent is RangeBaseModel) {
//         return true;
//       }
//       parent = parent.parent;
//     }
//     return false;
//   }
//
//   bool isCalloutChild() {
//     BaseNodeModel? parent = this.parent;
//     while (parent != null) {
//       if (parent is CalloutModel) {
//         return true;
//       }
//       parent = parent.parent;
//     }
//     return false;
//   }
//
//   bool isConspectusOrItsChild() {
//     if (this is ConspectusModel) return true;
//     return isConspectusChild();
//   }
//
//   bool isRangeBaseOrItsChild() {
//     if (this is RangeBaseModel) return true;
//     return isConspectusChild();
//   }
//
//   bool isCalloutOrItsChild() {
//     if (this is CalloutModel) return true;
//     return isCalloutChild();
//   }
//
//   bool isChildOf(BaseNodeModel nodeModel) {
//     final thisParent = parent;
//     if (thisParent == null) {
//       return false;
//     }
//     var node = thisParent;
//     while (!identical(node, nodeModel)) {
//       final parent = node.parent;
//       if (parent != null) {
//         node = parent;
//       } else {
//         return false;
//       }
//     }
//     return true;
//   }
//
//   bool isNotNodeModelChild() {
//     var parent = this.parent;
//     while (parent != null) {
//       if (parent is! NodeModel) {
//         return true;
//       }
//       parent = parent.parent;
//     }
//     return false;
//   }
//
//   bool isNotNodeModelOrItsChild() {
//     if (this is! NodeModel) return true;
//     return isNotNodeModelChild();
//   }
//
//   ///获取此节点以上所有包含自定义布局的节点，不包括其本身，包括根节点
//   List<BaseNodeModel> getLayoutRoots() {
//     final roots = <BaseNodeModel>[];
//     var parent = this.parent;
//     while (parent != null) {
//       if (parent.layout != null || parent.isRootNode) {
//         roots.insert(0, parent);
//       }
//       parent = parent.parent;
//     }
//     return roots;
//   }
//
//   double getYConnectPoint(ThemeManager themeManager, TreeModel treeModel, bool isForTable, Rect? overrideBounds) {
//     if (themeManager.isBottomLineShape(treeModel, this, isForTable)) {
//       return overrideBounds == null ? bounds.bottom : overrideBounds.bottom;
//     } else {
//       return overrideBounds == null ? bounds.centerLeft.dy : overrideBounds.centerLeft.dy;
//     }
//   }
//
//   void translate(double dx, double dy) {
//     final left = bounds.left + dx;
//     final right = bounds.right + dx;
//     final top = bounds.top + dy;
//     final bottom = bounds.bottom + dy;
//     bounds = Rect.fromLTRB(left, top, right, bottom);
//   }
//
//   void layoutFree() {
//     bounds = Rect.fromLTRB(xDp, yDp, xDp + measuredWidth, yDp + measuredHeight);
//   }
//
//   Rect getSelectedBounds() {
//     const padding = 2;
//     return Rect.fromLTRB(bounds.left - padding, bounds.top - padding,
//         bounds.right + padding, bounds.bottom + padding);
//   }
//
//   bool checkIsCustom() {
//     if (lineStyle != null) return true;
//     if (lineColor != null) return true;
//     if (lineWidth != null) return true;
//     if (backgroundShape != null) return true;
//     if (backgroundFrameColor != null) return true;
//     if (backgroundColor != null) return true;
//     if (backgroundFrameEffect != null) return true;
//     if (backgroundFrameWidth != null) return true;
//     if (backgroundEffect != null) return true;
//     if (lineEffect != null) return true;
//     return false;
//   }
//
//
//   NodeType getNodeType(){
//     NodeType type=NodeType.normal;
//     bool isContainImg=imageData.isNotEmpty;
//     //判断该节点是否是纯文本/图片节点
//     if(isContainImg && text.isEmpty){
//       type=NodeType.imgOnly;
//     }
//     if(!isContainImg){
//       type=NodeType.textOnly;
//     }
//     return type;
//   }
// }
//
//
// abstract class BaseModel {
//   static const textAlignLeft = "left";
//   static const textAlignCenter = "center";
//   static const textAlignRight = "right";
//
//   BaseModel(this.text): id = IdentifyUtils.getNewId();
//   String? id;
//   String text;
//   String? textAlign;
//   bool _isHideForLayout = false;
//   set isHideForLayout(bool value) {
//     _isHideForLayout = value;
//     changeViewVisible(!value);
//   }
//   bool get isHideForLayout {
//     return _isHideForLayout;
//   }
//   bool isFocus = false;
//   // 是否已经完成布局
//   bool isLayout = false;
//   Rect bounds = Rect.zero;
//
//   int? backgroundFrameColor;
//   int? backgroundFrameEffect;
//   int? backgroundFrameWidth;
//
//   // view属性
//   double alpha = 1;
//   bool isHideText = false;
//   bool isSelected = false;
//   bool isHovered = false;
//   int baseTextColor = 0xff000000;
//   double baseTextSize = 14;
//   bool baseTextBold = false;
//
//   // 可用于存储一些扩展信息
//   Map<String, Object> tags = {};
//
//   // 禁用点击（BaseNodeModel）
//   bool disable = false;
//   Map<String, dynamic> viewData = {};
//   TextFieldBinder get textFieldBinder => TextFieldBinder(
//     baseModel: this,
//     currentText: TextFieldBinder.nodeText,
//     text: text,
//     textBounds: textBounds,
//     textPadding: textPadding,
//     setText: (text) {
//       this.text = text;
//     },
//     setHideText: (isHide) {
//       isHideText = isHide;
//     },
//   );
//   // BaseNodeModel是节点内坐标，Relationship是Tree坐标
//   Rect textPadding = Rect.zero;
//   MutableRect get textBoundsWithoutPadding {
//     return MutableRect(
//       textBounds.left + textPadding.left,
//       textBounds.top + textPadding.top,
//       textBounds.right - textPadding.right,
//       textBounds.bottom - textBounds.bottom,
//     );
//   }
//   MutableRect textBounds = MutableRect.zero();
//   bool textSingleLine = false;
//   TextPainter textPainter = TextPainter(
//     textWidthBasis: TextWidthBasis.parent,
//     textAlign: TextAlign.start,
//     textDirection: TextDirection.ltr,
//   );
//   TextPainter remindTextPainter = TextPainter(
//     textAlign: TextAlign.start,
//     textDirection: TextDirection.ltr,
//     strutStyle: const StrutStyle(),
//   );
//
//   void changeViewVisible(bool isVisible) {
//
//   }
//
//   TextAlign getTextAlign() {
//     switch (textAlign) {
//       case BaseModel.textAlignRight:
//         return TextAlign.right;
//       case BaseModel.textAlignCenter:
//         return TextAlign.center;
//       default:
//         return TextAlign.left;
//     }
//   }
//
// }