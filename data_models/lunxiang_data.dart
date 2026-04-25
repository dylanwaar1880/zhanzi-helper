/// 占察轮相数据模型
/// 包含189种轮相的完整定义

class Lunxiang {
  final int id;
  final String name;
  final String category;
  final String summary;
  final String description;
  final bool isAuspicious;

  const Lunxiang({
    required this.id,
    required this.name,
    required this.category,
    required this.summary,
    required this.description,
    required this.isAuspicious,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'summary': summary,
        'description': description,
        'isAuspicious': isAuspicious,
      };

  factory Lunxiang.fromJson(Map<String, dynamic> json) => Lunxiang(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        summary: json['summary'],
        description: json['description'],
        isAuspicious: json['isAuspicious'],
      );
}

/// 189种轮相完整数据
const List<Lunxiang> lunxiangList = [
  // ==================== 第一轮相：观善恶业差别相 (1-10) ====================
  Lunxiang(
    id: 1,
    name: '一切种智心',
    category: '观善恶业',
    summary: '明了一切因果的智慧之心',
    description:
        '观心念善恶而明了业报差别。此轮相显示您已具备一切种智心，能够清晰认知因果，善恶分明。当您以此心行持，自会感召吉祥。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 2,
    name: '僧伽陀',
    category: '观善恶业',
    summary: '具足清净戒律的修行者',
    description:
        '僧伽陀译为和合众，指清净和合的修行团体。此轮相显示您与善知识有缘，当亲近僧团或清净行人，可获法益。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 3,
    name: '柔和心',
    category: '观善恶业',
    summary: '柔软和顺的慈悲之心',
    description:
        '柔和心是菩萨四摄法之一，以柔软语、柔和行接引众生。此轮相显示您近期当以柔和之心待人处事，自有贵人相助。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 4,
    name: '众生增益'
    category: '观善恶业',
    summary: '利乐众生，功德增长',
    description:
        '此轮相显示您有利益众生的机缘。若能广行布施、说法利生，不仅众生得益，自己功德亦将日渐增长。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 5,
    name: '梵行功德'
    category: '观善恶业',
    summary: '清净梵行的殊胜功德',
    description:
        '梵行指清净离欲的修行。此轮相显示您过去持戒修行的功德现前，当继续保持清净梵行，功德自然日增。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 6,
    name: '见诸多佛'
    category: '观善恶业',
    summary: '得见十方诸佛菩萨',
    description:
        '此轮相显示您与诸佛有大因缘。若能诚心忆念佛名、礼敬供养，当于梦中或定中得见诸佛，种见佛因。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 7,
    name: '转轮王位'
    category: '观善恶业',
    summary: '成就转轮圣王之果位',
    description:
        '转轮圣王为世间最福报的统治者。此非指世间王位，乃指您能转烦恼轮、度化众生，成就法王之位。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 8,
    name: '舍恶知识'
    category: '观善恶业',
    summary: '远离恶友，亲近善知识',
    description:
        '此轮相提醒您当检视周围交友。若有品行不端、邪知邪见之人，当渐次远离，以免受其染污。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 9,
    name: '戒根清净'
    category: '观善恶业',
    summary: '戒律清净，戒根具足',
    description:
        '此轮相显示您的戒律持守清净，五根（信进念定慧）得以增长。当继续保持，各方面运势将逐渐好转。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 10,
    name: '十种发心'
    category: '观善恶业',
    summary: '发起十种清净菩提心',
    description:
        '十种发心包括：发清净心、发柔和心、发慈悲心等。此轮相显示您已发真实菩提心，当精进修行，不退初心。',
    isAuspicious: true,
  ),

  // ==================== 第二轮相：观所疑 (11-100) ====================
  // 观所疑：关于疑问、疑情
  Lunxiang(
    id: 11,
    name: '观所疑即为实',
    category: '观所疑',
    summary: '您所疑之事确实如此',
    description:
        '此轮相明确告诉您：您心中所疑之事确为真实。应当相信自己的直觉判断，不应再犹豫不决。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 12,
    name: '观所疑为不实',
    category: '观所疑',
    summary: '您所疑之事并非如此',
    description:
        '此轮相显示您心中的疑虑是多余的，所疑之事并不属实。应当放下疑心，相信真实情况并非您所想的那样。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 13,
    name: '观所疑可深信',
    category: '观所疑',
    summary: '您所疑之事值得深信',
    description:
        '此轮相显示您的疑虑是有根据的，应当深信不疑。这可能是您潜意识中捕捉到的某些重要信息。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 14,
    name: '观所疑需再察',
    category: '观所疑',
    summary: '您所疑之事需要进一步观察',
    description:
        '此轮相提示您：当前的疑虑尚不足以定论，需要更多时间或信息来验证。切勿草率下结论。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 15,
    name: '观所疑当速证',
    category: '观所疑',
    summary: '应迅速求证心中的疑虑',
    description:
        '此轮相显示您应当尽快去验证心中的疑问，不宜拖延。时间越久，真相可能越难查明。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 16,
    name: '观所疑为邪见',
    category: '观所疑',
    summary: '您所疑之事源于邪见',
    description:
        '此轮相显示您的疑虑可能是由于错误的知见或偏见造成的。应当反观自心，纠正错误认知。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 17,
    name: '观所疑是妄念',
    category: '观所疑',
    summary: '您所疑之事只是妄想',
    description:
        '此轮相明确告诉您：心中的疑虑不过是妄念罢了，并非真实。应当放下，不要再纠缠。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 18,
    name: '观所疑应正观',
    category: '观所疑',
    summary: '应当以正知正见观察',
    description:
        '此轮相提示您需要用正确的方法和态度来审视疑虑。应当多闻佛法，以智慧观察诸法实相。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 19,
    name: '观所疑速得答',
    category: '观所疑',
    summary: '所疑之事将很快得到答案',
    description:
        '此轮相显示您的疑虑很快就会有明确的答案。保持耐心，真相即将显现。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 20,
    name: '观所疑难速解',
    category: '观所疑',
    summary: '所疑之事需要时间慢慢解开',
    description:
        '此轮相显示您心中的疑虑不是短期内能解开的。需要耐心等待时机，时机成熟自然明白。',
    isAuspicious: false,
  ),

  // 观所疑续 (21-30)
  Lunxiang(
    id: 21,
    name: '观所疑为吉兆',
    category: '观所疑',
    summary: '您所疑之事是吉祥的兆头',
    description:
        '此轮相显示您心中的疑虑实际上是好兆头，不必担忧。事情的发展将会是吉祥如意的。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 22,
    name: '观所疑为凶兆',
    category: '观所疑',
    summary: '您所疑之事有凶险之兆',
    description:
        '此轮相提醒您要警惕，所疑之事可能有凶险。应当谨慎行事，或提前做好防范。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 23,
    name: '观所疑宜守静',
    category: '观所疑',
    summary: '应当安守本分，静待时机',
    description:
        '此轮相提示您不宜轻举妄动，应当安住本位，静心守候。妄动可能招致不利。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 24,
    name: '观所疑宜主动',
    category: '观所疑',
    summary: '应当积极主动处理',
    description:
        '此轮相显示您不应消极等待，而应积极主动地去了解和处理心中疑虑之事。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 25,
    name: '观所疑有贵人',
    category: '观所疑',
    summary: '会有贵人相助解开疑惑',
    description:
        '此轮相显示您将遇到贵人帮助您解开心中疑虑。应当多与人交流，虚心请教。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 26,
    name: '观所疑靠自力',
    category: '观所疑',
    summary: '需要依靠自己的力量解决',
    description:
        '此轮相提示您解决心中疑虑主要靠自己的智慧和努力。应当自强不息，不可依赖他人。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 27,
    name: '观所疑可向佛',
    category: '观所疑',
    summary: '应当诚心祈求佛菩萨指引',
    description:
        '此轮相显示您应当通过礼佛、诵经、持咒等方式，祈求佛菩萨加被，指引您解开疑惑。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 28,
    name: '观所疑当忏悔',
    category: '观所疑',
    summary: '应当虔诚忏悔业障',
    description:
        '此轮相提示您心中的疑虑可能与过去业障有关。应当虔诚忏悔，诵念地藏菩萨名号消业。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 29,
    name: '观所疑是前定',
    category: '观所疑',
    summary: '此事前因已定，当安然受之',
    description:
        '此轮相显示您所疑之事是过去因果业力所现，无论结果如何，当安然接受。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 30,
    name: '观所疑可转变',
    category: '观所疑',
    summary: '此事尚未定型，尚可转变',
    description:
        '此轮相显示您所疑之事尚未成为定局，还有转变的余地。应当积极行善积德，改变命运。',
    isAuspicious: true,
  ),

  // 观所梦 (31-40)
  Lunxiang(
    id: 31,
    name: '观所梦为吉梦',
    category: '观所梦',
    summary: '您所做的梦是吉祥之兆',
    description:
        '此轮相显示您所做的梦是好兆头，预示着所求之事将会有所进展，或有好事将近。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 32,
    name: '观所梦为凶梦',
    category: '观所梦',
    summary: '您所做的梦是凶险之兆',
    description:
        '此轮相提醒您所梦之事可能预示着某种凶险。应当谨慎行事，或诵经回向化解。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 33,
    name: '观所梦无实义',
    category: '观所梦',
    summary: '梦境没有特别含义',
    description:
        '此轮相显示您所做的梦只是普通的睡眠影像，并没有特殊的预兆意义，不必挂怀。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 34,
    name: '观所梦应观察',
    category: '观所梦',
    summary: '应当仔细思维梦的含义',
    description:
        '此轮相提示您梦中有启示，应当静心思维，回忆梦中细节，或许能得到某种指引。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 35,
    name: '观所梦是前兆',
    category: '观所梦',
    summary: '梦境是未来之事的前兆',
    description:
        '此轮相显示您所做的梦可能是未来之事的预兆。应当留意近期可能发生与梦境相应的事。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 36,
    name: '观所梦是宿示',
    category: '观所梦',
    summary: '梦境是过去世记忆的显示',
    description:
        '此轮相显示您的梦可能是过去世某些经历的显现，是宿命通的一小部分显示。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 37,
    name: '观所梦当忏悔',
    category: '观所梦',
    summary: '梦由业起，应当忏悔',
    description:
        '此轮相提示您的梦境可能与业障有关。应当加强忏悔修行，诵念地藏经或金刚经消业。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 38,
    name: '观所梦宜守戒',
    category: '观所梦',
    summary: '应当严持净戒',
    description:
        '此轮相显示您应当严格持守戒律，特别是五戒十善。持戒清净可减少恶梦。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 39,
    name: '观所梦有佛力',
    category: '观所梦',
    summary: '梦中有佛菩萨加持',
    description:
        '此轮相显示您梦中可能有佛菩萨的加持。这是修行得力的好兆头，继续精进。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 40,
    name: '观所梦宜放舍',
    category: '观所梦',
    summary: '应当放下对梦境的执着',
    description:
        '此轮相提示您不要过分执着于梦境。无论吉凶，都应平常心对待，不执不拒。',
    isAuspicious: true,
  ),

  // 观所闻 (41-50)
  Lunxiang(
    id: 41,
    name: '观所闻为善言',
    category: '观所闻',
    summary: '您所听闻的是善法',
    description:
        '此轮相显示您所听到的话语或信息是善意的、有益的。应当虚心接受，依教奉行。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 42,
    name: '观所闻为恶言',
    category: '观所闻',
    summary: '您所听闻的是邪见',
    description:
        '此轮相提醒您要注意分辨，所听闻的内容可能含有邪知邪见。应当善于拣择，不受误导。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 43,
    name: '观所闻可信用',
    category: '观所闻',
    summary: '所闻之事可以相信',
    description:
        '此轮相显示您所听到的消息是可信的，可以作为判断的依据。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 44,
    name: '观所闻勿轻信',
    category: '观所闻',
    summary: '所闻之事不宜轻信',
    description:
        '此轮相提示您不要轻信所听到的消息，应当多方求证，避免被误导。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 45,
    name: '观所闻有深意',
    category: '观所闻',
    summary: '所闻之事含有深意',
    description:
        '此轮相显示您所听到的话看似平常，实则含有深意。应当细心体味，不可错过。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 46,
    name: '观所闻是闲话',
    category: '观所闻',
    summary: '所闻只是无意义的闲谈',
    description:
        '此轮相显示您所听到的不过是平常闲话，没有特别的意义，不必放在心上。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 47,
    name: '观所闻当自断',
    category: '观所闻',
    summary: '应当自己判断是非',
    description:
        '此轮相提示您对于所闻之事要有自己的判断能力，不可盲目听从，要用智慧抉择。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 48,
    name: '观所闻宜证信',
    category: '观所闻',
    summary: '应当寻找更多证据',
    description:
        '此轮相显示您应当寻找更多证据来验证所闻之事。单听一面之词不足为凭。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 49,
    name: '观所闻有教诲',
    category: '观所闻',
    summary: '其中含有长者的教诲',
    description:
        '此轮相显示您所听到的是善知识的教诲。应当虚心受教，依教奉行。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 50,
    name: '观所闻是谗言',
    category: '观所闻',
    summary: '其中含有小人的谗言',
    description:
        '此轮相提醒您要警惕，所听到的可能是小人的谗言挑拨。应当善于分辨，不受其害。',
    isAuspicious: false,
  ),

  // 观所求 (51-60)
  Lunxiang(
    id: 51,
    name: '观所求可成就',
    category: '观所求',
    summary: '您所求之事可以成就',
    description:
        '此轮相显示您所祈求的事情有成功的可能。应当积极努力，创造条件使其实现。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 52,
    name: '观所求难成就',
    category: '观所求',
    summary: '您所求之事难以成就',
    description:
        '此轮相显示您所求之事因缘尚未成熟，难以实现。应当耐心等待，或调整求法。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 53,
    name: '观所求待时节',
    category: '观所求',
    summary: '需要等待时机因缘',
    description:
        '此轮相提示您所求之事需要等待适当的时机。不宜急于求成，耐心等候因缘成熟。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 54,
    name: '观所求先种因',
    category: '观所求',
    summary: '应当先种善因',
    description:
        '此轮相显示您所求的好结果需要先种下善因。应当先广行布施、持戒修福，因圆果满自然成就。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 55,
    name: '观所求是妄求',
    category: '观所求',
    summary: '所求之念是妄想执着',
    description:
        '此轮相提示您应当放下执着，您所求的可能是不合理的妄想。应当反观内心，修正其心。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 56,
    name: '观所求宜正求',
    category: '观所求',
    summary: '应当以正法求之',
    description:
        '此轮相提示您求的方法要正确。应当以布施、持戒、忍辱、精进、禅定、智慧六度正法而求。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 57,
    name: '观所求可速得',
    category: '观所求',
    summary: '所求之事很快就能得到',
    description:
        '此轮相显示您所求之事很快就能实现。善缘已熟，不日当得。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 58,
    name: '观所求需久候',
    category: '观所求',
    summary: '所求之事需要很长时间',
    description:
        '此轮相显示您所求之事需要较长的时间才能实现。应当有耐心，功不唐捐。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 59,
    name: '观所求有阻碍',
    category: '观所求',
    summary: '所求之事有阻碍',
    description:
        '此轮相提醒您所求之事可能会遇到阻碍。应当先排除障碍，或另寻方便法门。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 60,
    name: '观所求当改求',
    category: '观所求',
    summary: '应当改变求法或目标',
    description:
        '此轮相提示您原来所求的方法或目标可能需要调整。应当因地制宜，随缘而求。',
    isAuspicious: false,
  ),

  // 观所失 (61-70)
  Lunxiang(
    id: 61,
    name: '观所失易得复',
    category: '观所失',
    summary: '所失之物容易找回',
    description:
        '此轮相显示您丢失的东西或失去的机会容易找回或重新获得。应当仔细寻找。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 62,
    name: '观所失难得复',
    category: '观所失',
    summary: '所失之物难以找回',
    description:
        '此轮相显示您所失去的东西或机会难以找回。应当放下，不必过分执着。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 63,
    name: '观所失当自守',
    category: '观所失',
    summary: '应当安守本分，不再追失',
    description:
        '此轮相提示您对于已失去的应当安然接受，不宜过分追索。守好现在拥有的更重要。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 64,
    name: '观所失是业报',
    category: '观所失',
    summary: '失去是过去业的果报',
    description:
        '此轮相显示您所失去的是因果业报的显现。应当忏悔宿业，不生嗔恨。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 65,
    name: '观所失非真实',
    category: '观所失',
    summary: '所失之物本非真实拥有',
    description:
        '此轮相启示您一切皆无常，所失之物本就不应执着。应以平常心对待得失。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 66,
    name: '观所失当布施',
    category: '观所失',
    summary: '失去正好用来布施',
    description:
        '此轮相显示您可以将所失之物转为布施功德。失而能施，功德更大。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 67,
    name: '观所失有转机',
    category: '观所失',
    summary: '失去之后会有转机',
    description:
        '此轮相显示虽然暂时失去，但之后会有更好的转机。塞翁失马，焉知非福。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 68,
    name: '观所失防再失',
    category: '观所失',
    summary: '应当防止再次失去',
    description:
        '此轮相提醒您要小心，防止类似的事情再次发生。应当谨慎守护现有的东西。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 69,
    name: '观所失当检点',
    category: '观所失',
    summary: '应当检点自己的行为',
    description:
        '此轮相提示您应当反思自己的行为是否有不当之处，导致了失去。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 70,
    name: '观所失宜放下',
    category: '观所失',
    summary: '应当彻底放下所失',
    description:
        '此轮相显示您应当彻底放下对失去之物的执念。放下执着，心得自在。',
    isAuspicious: true,
  ),

  // 观所忧 (71-80)
  Lunxiang(
    id: 71,
    name: '观所忧可解除',
    category: '观所忧',
    summary: '所忧之事可以解除',
    description:
        '此轮相显示您担忧的事情最终会得到解决。应当放心，忧恼无益。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 72,
    name: '观所忧难解除',
    category: '观所忧',
    summary: '所忧之事难以消除',
    description:
        '此轮相显示您担忧的事情可能难以短期消除。应当以智慧面对，积极解决。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 73,
    name: '观所忧当宽心',
    category: '观所忧',
    summary: '应当心宽，不必过忧',
    description:
        '此轮相提示您不要过度担忧，很多忧虑是多余的。应当放松心情，平常心对待。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 74,
    name: '观所忧是徒劳',
    category: '观所忧',
    summary: '担忧只是徒劳无益',
    description:
        '此轮相显示您的担忧是没有必要的，徒然浪费心力。应当放下忧虑，积极面对。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 75,
    name: '观所忧当预防',
    category: '观所忧',
    summary: '担忧之事应当提前预防',
    description:
        '此轮相提示您担忧的事情可能发生，应当提前做好防范准备，有备无患。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 76,
    name: '观所忧宜祈求',
    category: '观所忧',
    summary: '应当诚心祈求佛菩萨化解',
    description:
        '此轮相显示您应当通过诵经、持咒、礼佛等方式，祈求佛菩萨加被化解忧患。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 77,
    name: '观所忧因多欲',
    category: '观所忧',
    summary: '忧患源于欲望太多',
    description:
        '此轮相提示您忧患的根源在于欲望太多。应当减少贪欲，知足常乐。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 78,
    name: '观所忧当修定',
    category: '观所忧',
    summary: '应当修习禅定安定心神',
    description:
        '此轮相显示您应当通过禅修、念佛等方法安定心神。心定则无忧。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 79,
    name: '观所忧将成真',
    category: '观所忧',
    summary: '担忧之事可能会发生',
    description:
        '此轮相提醒您担忧的事情有一定可能性会发生。应当积极应对，有备无患。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 80,
    name: '观所忧是杞忧',
    category: '观所忧',
    summary: '完全是多余的忧虑',
    description:
        '此轮相显示您所担忧的事情完全不会发生，是杞人忧天。应当彻底放心。',
    isAuspicious: true,
  ),

  // 观所恶 (81-90)
  Lunxiang(
    id: 81,
    name: '观所恶当远离',
    category: '观所恶',
    summary: '应当远离所厌恶之人事物',
    description:
        '此轮相提示您应当远离让您厌恶的人事物，不要勉强自己与之相处。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 82,
    name: '观所恶当容忍',
    category: '观所恶',
    summary: '应当以忍辱心对待',
    description:
        '此轮相显示您应当修习忍辱波罗蜜，以慈悲心容忍令您厌恶的人和事。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 83,
    name: '观所恶是逆缘',
    category: '观所恶',
    summary: '恶缘当以善心化解',
    description:
        '此轮相提示您厌恶的对象可能是您过去的逆缘。应当以善心化解，而非对立。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 84,
    name: '观所恶当内省',
    category: '观所恶',
    summary: '应当反观内心的执念',
    description:
        '此轮相提示您可能对某些人事物有偏见。应当反观内心，是否是自己执念作祟。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 85,
    name: '观所恶莫嗔恨',
    category: '观所恶',
    summary: '切勿生起嗔恨之心',
    description:
        '此轮相提醒您对于厌恶的对象不应生嗔恨心。嗔恨是三毒之一，损福招祸。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 86,
    name: '观所恶当发愿',
    category: '观所恶',
    summary: '当发愿度化令您厌恶者',
    description:
        '此轮相显示您应当发愿将来度化令您厌恶的众生转为善缘。怨亲平等，方为菩萨。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 87,
    name: '观所恶是考验',
    category: '观所恶',
    summary: '这是对您修行的考验',
    description:
        '此轮相显示令您厌恶的人事物是对您修行的考验。若能过关，道业必增。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 88,
    name: '观所恶当忏悔',
    category: '观所恶',
    summary: '当忏悔自己对人的不善心',
    description:
        '此轮相提示您对他人的厌恶可能源于自己的业障。应当忏悔自己内心的不善。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 89,
    name: '观所恶终将离',
    category: '观所恶',
    summary: '令您厌恶的终将离去',
    description:
        '此轮相显示令您厌恶的人事物不会长久，迟早会离开。不必过分苦恼。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 90,
    name: '观所恶应善待',
    category: '观所恶',
    summary: '应以善意对待令您厌恶者',
    description:
        '此轮相提示您应当以善心、善意对待令您厌恶的人。善待他人，自得福报。',
    isAuspicious: true,
  ),

  // 观所取 (91-100)
  Lunxiang(
    id: 91,
    name: '观所取可得',
    category: '观所取',
    summary: '您想要取得的目标可以获得',
    description:
        '此轮相显示您想要得到的东西或达成的目标可以实现。应当积极努力。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 92,
    name: '观所取难获',
    category: '观所取',
    summary: '您想要取得的目标难以获得',
    description:
        '此轮相显示您想要达成的目标有困难。应当调整方法或降低期望。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 93,
    name: '观所取宜正当',
    category: '观所取',
    summary: '获取应当正当合法',
    description:
        '此轮相提示您追求目标的方式应当正当。不应走旁门左道或损人利己。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 94,
    name: '观所取戒贪心',
    category: '观所取',
    summary: '应当戒除贪心',
    description:
        '此轮相提醒您不要有贪心。贪心是烦恼之源，不当得之财终将散去。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 95,
    name: '观所取当布施',
    category: '观所取',
    summary: '取得之后应当布施',
    description:
        '此轮相显示您获得之后应当适当布施。财布施得财，法布施得智慧。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 96,
    name: '观所取有德报',
    category: '观所取',
    summary: '这是您福德的果报',
    description:
        '此轮相显示您能获得是过去善因的结果。继续保持善行，福报自然增长。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 97,
    name: '观所取需努力',
    category: '观所取',
    summary: '需要加倍努力才能获得',
    description:
        '此轮相提示您不能坐享其成，需要付出更多努力才能有所收获。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 98,
    name: '观所取勿强求',
    category: '观所取',
    summary: '不应当过分强求',
    description:
        '此轮相提示您不应当过分强求某些东西。应当随缘，有些事不可强求。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 99,
    name: '观所取当感恩',
    category: '观所取',
    summary: '获得之后应当感恩',
    description:
        '此轮相显示您获得之后应当心怀感恩，感谢帮助过您的人及一切因缘。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 100,
    name: '观所取宜惜福',
    category: '观所取',
    summary: '获得之后应当珍惜福报',
    description:
        '此轮相提示您获得之后应当珍惜，不可奢侈浪费。福报用尽，则无所获。',
    isAuspicious: true,
  ),

  // ==================== 第三轮相：观业果报 (101-189) ====================
  // 观业果报：关于因果报应

  // 101-110：观宿报
  Lunxiang(
    id: 101,
    name: '观宿报是善业',
    category: '观业果报',
    summary: '此报是过去善业所致',
    description:
        '此轮相显示您目前的好境遇是过去善业的果报。继续行善，福报将更加增上。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 102,
    name: '观宿报是恶业',
    category: '观业果报',
    summary: '此报是过去恶业所致',
    description:
        '此轮相显示您目前的困境是过去恶业的果报。应当虔诚忏悔，消业培福。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 103,
    name: '观宿报兼善恶',
    category: '观业果报',
    summary: '此报由善恶业交织而成',
    description:
        '此轮相显示您的现状是善业恶业共同作用的结果。应当断恶修善，转变命运。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 104,
    name: '观宿报将尽',
    category: '观业果报',
    summary: '宿业果报即将结束',
    description:
        '此轮相显示您过去世的业障即将受完。光明在即，坚持修行，必得解脱。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 105,
    name: '观宿报正熟',
    category: '观业果报',
    summary: '宿业果报正在成熟',
    description:
        '此轮相显示您的宿业正在显现果报。应当安心承受，这是成长的必经之路。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 106,
    name: '观宿报尚轻',
    category: '观业果报',
    summary: '宿业报应尚属轻微',
    description:
        '此轮相显示您宿业的报应还比较轻。应当庆幸，并继续修善，不令加重。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 107,
    name: '观宿报当重受',
    category: '观业果报',
    summary: '宿业报应应当承受',
    description:
        '此轮相提示您应当坦然接受宿业的报应，不生嗔怨。受报消业，方能了结。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 108,
    name: '观宿报可转轻',
    category: '观业果报',
    summary: '宿业报应可以转轻',
    description:
        '此轮相显示通过修行和忏悔，可以将宿业报应转轻。精进修行，必有成效。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 109,
    name: '观宿报需待时',
    category: '观业果报',
    summary: '宿业报应需要等待时机',
    description:
        '此轮相显示宿业不会马上受报，还需等待因缘。应当耐心等待，继续修善。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 110,
    name: '观宿报已了',
    category: '观业果报',
    summary: '宿世业障已经了结',
    description:
        '此轮相显示您过去世的某一重大业障已经受完。以后将迎来新的开始。',
    isAuspicious: true,
  ),

  // 111-120：观现报
  Lunxiang(
    id: 111,
    name: '观现报善始',
    category: '观业果报',
    summary: '善报刚刚开始',
    description:
        '此轮相显示您现在刚开始感受到善报。继续保持行善，好运会越来越多。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 112,
    name: '观现报恶始',
    category: '观业果报',
    summary: '恶报刚刚开始',
    description:
        '此轮相显示您最近开始遭受恶报。应当加强忏悔修善，尽快化解。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 113,
    name: '观现报善熟',
    category: '观业果报',
    summary: '善报正在成熟',
    description:
        '此轮相显示您的善报正在快速显现。这段时间运气会比较好。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 114,
    name: '观现报恶熟',
    category: '观业果报',
    summary: '恶报正在成熟',
    description:
        '此轮相显示您的恶报正在显现。这段时间应当谨慎行事，多修功德。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 115,
    name: '观现报善将尽',
    category: '观业果报',
    summary: '善报即将结束',
    description:
        '此轮相显示您的善报快要用完了。应当广种福因，不令福报断绝。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 116,
    name: '观现报恶将尽',
    category: '观业果报',
    summary: '恶报即将结束',
    description:
        '此轮相显示您的恶报快要结束了。咬牙坚持，很快就会雨过天晴。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 117,
    name: '观现报宜修善',
    category: '观业果报',
    summary: '现在应当广修善法',
    description:
        '此轮相提示您现在是修善积福的好时机。应当积极参与慈善，多行布施。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 118,
    name: '观现报当忏悔',
    category: '观业果报',
    summary: '现在应当虔诚忏悔',
    description:
        '此轮相提示您应当抓紧时间忏悔宿业。读诵地藏经、金刚经等都有消业功效。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 119,
    name: '观现报正处中',
    category: '观业果报',
    summary: '报应正在中途',
    description:
        '此轮相显示您的报应正处于中间阶段。应当保持定力，不进不退，安心度过。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 120,
    name: '观现报当精进',
    category: '观业果报',
    summary: '报应期间更当精进',
    description:
        '此轮相提示您在报应期间更要精进修行。顺逆境都是道场，皆可成就。',
    isAuspicious: true,
  ),

  // 121-130：观后报
  Lunxiang(
    id: 121,
    name: '观后报在来世',
    category: '观业果报',
    summary: '果报将在来世显现',
    description:
        '此轮相显示您现在所做善恶将在来世受报。当下虽无感应，来世必得果报。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 122,
    name: '观后报在久远',
    category: '观业果报',
    summary: '果报将在很久以后显现',
    description:
        '此轮相显示果报不会马上显现，需要很长时间。这是大因果，要有耐心。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 123,
    name: '观后报当植因',
    category: '观业果报',
    summary: '现在应当种下善因',
    description:
        '此轮相提示您现在要多种善因，为将来的果报做准备。种瓜得瓜，种豆得豆。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 124,
    name: '观后报当断因',
    category: '观业果报',
    summary: '现在应当断除恶因',
    description:
        '此轮相提示您要断除一切恶因，避免将来受苦。现在断恶，将来自在。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 125,
    name: '观后报因已定',
    category: '观业果报',
    summary: '将来的果报已经注定',
    description:
        '此轮相显示将来的果报已经由过去的因决定了。但现在修善，仍可转变。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 126,
    name: '观后报因未成',
    category: '观业果报',
    summary: '将来的果报尚未定型',
    description:
        '此轮相显示将来的果报还没有最终定型，还有改变的余地。应当精进修善。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 127,
    name: '观后报当发愿',
    category: '观业果报',
    summary: '当为来世发愿',
    description:
        '此轮相提示您应当为来世的果报发愿。愿力不可思议，可以改变命运。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 128,
    name: '观后报应随缘',
    category: '观业果报',
    summary: '应当随缘看待果报',
    description:
        '此轮相提示您对于将来的果报应当随缘。缘来则受，缘去不留，心无挂碍。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 129,
    name: '观后报勿忧虑',
    category: '观业果报',
    summary: '不必忧虑将来果报',
    description:
        '此轮相提示您不必过分忧虑将来的果报。只要现在好好做人，将来必得善报。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 130,
    name: '观后报当自知',
    category: '观业果报',
    summary: '应当自知因果不虚',
    description:
        '此轮相提示您应当深刻认识因果报应的道理。自作自受，丝毫不爽。',
    isAuspicious: true,
  ),

  // 131-140：观病患
  Lunxiang(
    id: 131,
    name: '观病患当愈',
    category: '观业果报',
    summary: '疾病将会痊愈',
    description:
        '此轮相显示您的疾病将会痊愈。应当配合治疗，保持乐观心态。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 132,
    name: '观病患难愈',
    category: '观业果报',
    summary: '疾病难以短期痊愈',
    description:
        '此轮相显示您的疾病需要较长时间才能痊愈。应当有耐心，积极治疗调养。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 133,
    name: '观病患当求医',
    category: '观业果报',
    summary: '应当寻求医疗救治',
    description:
        '此轮相提示您应当及时就医，不要拖延。好的医生和药物是治病的助缘。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 134,
    name: '观病患当求佛',
    category: '观业果报',
    summary: '应当祈求佛菩萨加被',
    description:
        '此轮相提示您应当礼佛、诵经、持咒，祈求佛菩萨加持，消灾延寿。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 135,
    name: '观病患是业病',
    category: '观业果报',
    summary: '此病是业障病',
    description:
        '此轮相显示您的病可能与业障有关。应当虔诚忏悔，诵经回向冤亲债主。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 136,
    name: '观病患是身病',
    category: '观业果报',
    summary: '此病是生理疾病',
    description:
        '此轮相显示您的病是普通的身体疾病，与业障关系不大。正常就医即可。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 137,
    name: '观病患当持戒',
    category: '观业果报',
    summary: '当持清净戒律',
    description:
        '此轮相提示您应当严格持戒。持戒清净可消业障，病自然好。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 138,
    name: '观病患宜放生',
    category: '观业果报',
    summary: '宜放生消灾',
    description:
        '此轮相提示您应当多放生救命。放生可以消业延寿，感应迅速。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 139,
    name: '观病患当布施',
    category: '观业果报',
    summary: '宜广行布施',
    description:
        '此轮相提示您应当多行布施，尤其是医药布施。施药治病，功德无量。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 140,
    name: '观病患应正命',
    category: '观业果报',
    summary: '应当正当生活',
    description:
        '此轮相提示您应当检点生活起居，避免不如法的行为。正命养生，病难侵。',
    isAuspicious: true,
  ),

  // 141-150：观住止
  Lunxiang(
    id: 141,
    name: '观住止得安稳',
    category: '观业果报',
    summary: '所住之处可以获得安稳',
    description:
        '此轮相显示您现在居住的地方是安稳的，没有大的凶险。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 142,
    name: '观住止有障碍',
    category: '观业果报',
    summary: '所住之处有障碍',
    description:
        '此轮相提示您现在居住的地方可能有风水障碍或不利的因素。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 143,
    name: '观住止宜迁居',
    category: '观业果报',
    summary: '应当考虑迁移住所',
    description:
        '此轮相提示您可能需要考虑换一个住所。现有住所可能不适合您。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 144,
    name: '观住止当修福',
    category: '观业果报',
    summary: '应当为住所修福',
    description:
        '此轮相提示您应当在住所附近多做善事，为住处培植福报。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 145,
    name: '观住止宜祭祀',
    category: '观业果报',
    summary: '应当祭祀祖先土地',
    description:
        '此轮相提示您应当在住所祭祀祖先和土地神祇，可保平安。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 146,
    name: '观住止当清净',
    category: '观业果报',
    summary: '应当保持住所清净',
    description:
        '此轮相提示您应当保持住所整洁清净，减少杂物，正信修行。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 147,
    name: '观住止有贵人',
    category: '观业果报',
    summary: '住所会有贵人相助',
    description:
        '此轮相显示您住所附近会有贵人出现，多行善事可招感善缘。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 148,
    name: '观住止防灾祸',
    category: '观业果报',
    summary: '应当防范灾祸',
    description:
        '此轮相提示您住所附近可能存在隐患，应当提高警惕，注意安全。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 149,
    name: '观住止宜修行',
    category: '观业果报',
    summary: '住所适合修行',
    description:
        '此轮相显示您住所的风水环境适合修行。应当珍惜因缘，精进用功。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 150,
    name: '观住止当结缘',
    category: '观业果报',
    summary: '应当与邻里结善缘',
    description:
        '此轮相提示您应当与住所周围的邻居和睦相处，广结善缘。',
    isAuspicious: true,
  ),

  // 151-160：观习
  Lunxiang(
    id: 151,
    name: '观习当亲近善知识',
    category: '观业果报',
    summary: '应当亲近善友',
    description:
        '此轮相提示您应当多亲近善知识，远离恶友。善友是道业的助缘。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 152,
    name: '观习当读诵经典',
    category: '观业果报',
    summary: '应当读诵大乘经典',
    description:
        '此轮相提示您应当多读诵大乘经典，如地藏经、金刚经、普门品等。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 153,
    name: '观习当持戒律',
    category: '观业果报',
    summary: '应当严持戒律',
    description:
        '此轮相提示您应当严格持守五戒十善，戒律清净则道业增进。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 154,
    name: '观习当修止观',
    category: '观业果报',
    summary: '应当修习禅定',
    description:
        '此轮相提示您应当修习止观禅定，安定心神，开发智慧。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 155,
    name: '观习当念佛名',
    category: '观业果报',
    summary: '应当念诵佛号',
    description:
        '此轮相提示您应当多念佛名，如阿弥陀佛、观世音菩萨、地藏菩萨等。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 156,
    name: '观习当拜忏悔',
    category: '观业果报',
    summary: '应当礼拜忏悔',
    description:
        '此轮相提示您应当多拜忏悔，如拜八十八佛、拜地藏忏等，消业培福。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 157,
    name: '观习当布施',
    category: '观业果报',
    summary: '应当广行布施',
    description:
        '此轮相提示您应当多行布施，包括财布施、法布施、无畏布施。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 158,
    name: '观习当忍辱',
    category: '观业果报',
    summary: '应当修习忍辱',
    description:
        '此轮相提示您应当修习忍辱波罗蜜，能忍则安，不忍则祸。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 159,
    name: '观习当精进',
    category: '观业果报',
    summary: '应当勇猛精进',
    description:
        '此轮相提示您应当精进修行，不可懈怠放逸。时光易逝，道业难成。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 160,
    name: '观习当随喜',
    category: '观业果报',
    summary: '应当随喜功德',
    description:
        '此轮相提示您应当多随喜他人功德，随喜能增福慧，与赞叹功德同等。',
    isAuspicious: true,
  ),

  // 161-170：观度
  Lunxiang(
    id: 161,
    name: '观度当发菩提心',
    category: '观业果报',
    summary: '应当发起菩提心',
    description:
        '此轮相提示您应当发起上求佛道、下化众生的菩提心。菩提心是成佛之因。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 162,
    name: '观度当行六度',
    category: '观业果报',
    summary: '应当修习六度万行',
    description:
        '此轮相提示您应当修习布施、持戒、忍辱、精进、禅定、智慧六度法门。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 163,
    name: '观度当利众生',
    category: '观业果报',
    summary: '应当利益一切众生',
    description:
        '此轮相提示您应当以慈悲心利益众生，帮助有缘人。利他是成佛之道。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 164,
    name: '观度当弘正法',
    category: '观业果报',
    summary: '应当弘扬正法',
    description:
        '此轮相提示您应当发心弘扬佛法正教，续佛慧命，度化有缘。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 165,
    name: '观度当护正法',
    category: '观业果报',
    summary: '应当护持正法',
    description:
        '此轮相提示您应当护持正法的道场和修行人，护法功德无量。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 166,
    name: '观度当建塔寺',
    category: '观业果报',
    summary: '应当建造塔寺',
    description:
        '此轮相提示您若有条件，应当建造或随喜建造塔寺，功德不可思议。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 167,
    name: '观度当印经书',
    category: '观业果报',
    summary: '应当印刷流通经书',
    description:
        '此轮相提示您应当助印流通佛经善书，法布施功德无量。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 168,
    name: '观度当救苦难',
    category: '观业果报',
    summary: '应当救济苦难众生',
    description:
        '此轮相提示您应当慈悲救济世间苦难众生，如赈灾、救困、助医等。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 169,
    name: '观度当孝父母',
    category: '观业果报',
    summary: '应当孝顺父母',
    description:
        '此轮相提示您应当尽心孝顺父母。孝敬父母是世间最大的福田。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 170,
    name: '观度当敬师长',
    category: '观业果报',
    summary: '应当尊敬师长',
    description:
        '此轮相提示您应当尊敬教导您的师长。师长是法身父母，恩德难报。',
    isAuspicious: true,
  ),

  // 171-180：观众会
  Lunxiang(
    id: 171,
    name: '观众会当清净',
    category: '观业果报',
    summary: '众会应当清净',
    description:
        '此轮相提示您参加法会或聚会时应当心存清净，身口意三业清净。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 172,
    name: '观众会当和合',
    category: '观业果报',
    summary: '众会应当和合',
    description:
        '此轮相提示您参加法会时应当与大众和合共处，不起诤论。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 173,
    name: '观众会当精进',
    category: '观业果报',
    summary: '众会应当精进',
    description:
        '此轮相提示您在法会中应当精进用功，不放逸懈怠。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 174,
    name: '观众会当修福',
    category: '观业果报',
    summary: '众会应当修福',
    description:
        '此轮相提示您在法会中应当广修福报，如供僧、斋僧等。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 175,
    name: '观众会当闻法',
    category: '观业果报',
    summary: '众会应当闻法',
    description:
        '此轮相提示您参加法会时应当认真听闻正法，领受法益。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 176,
    name: '观众会当说法',
    category: '观业果报',
    summary: '众会应当说法',
    description:
        '此轮相提示您有因缘时应当在法会中发心说法，弘扬正法。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 177,
    name: '观众会当忏悔',
    category: '观业果报',
    summary: '众会应当忏悔',
    description:
        '此轮相提示您参加法会时应当虔诚忏悔，消业增福。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 178,
    name: '观众会当回向',
    category: '观业果报',
    summary: '众会应当回向',
    description:
        '此轮相提示您参加法会后应当将功德普皆回向，回向菩提及众生。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 179,
    name: '观众会当发愿',
    category: '观业果报',
    summary: '众会应当发愿',
    description:
        '此轮相提示您参加法会时应当发善愿，愿成佛道，度化众生。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 180,
    name: '观众会当感恩',
    category: '观业果报',
    summary: '众会应当感恩',
    description:
        '此轮相提示您参加法会后应当感恩三宝、感恩众生、感恩一切因缘。',
    isAuspicious: true,
  ),

  // 181-189：观眠梦
  Lunxiang(
    id: 181,
    name: '观眠梦当忏悔',
    category: '观业果报',
    summary: '恶梦应当忏悔',
    description:
        '此轮相提示您若有恶梦应当虔诚忏悔，诵经持咒回向冤亲债主。',
    isAuspicious: false,
  ),
  Lunxiang(
    id: 182,
    name: '观眠梦当持咒',
    category: '观业果报',
    summary: '恶梦宜持咒护身',
    description:
        '此轮相提示您若有恶梦应当多持咒语，如楞严咒、大悲咒等，护身安眠。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 183,
    name: '观眠梦当祈佛',
    category: '观业果报',
    summary: '恶梦宜祈求佛佑',
    description:
        '此轮相提示您若有恶梦应当诚心祈求佛菩萨加持护佑。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 184,
    name: '观眠梦当安神',
    category: '观业果报',
    summary: '宜安神定心',
    description:
        '此轮相提示您应当安定心神，不要惊恐。可通过禅定、念佛安神。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 185,
    name: '观眠梦当修福',
    category: '观业果报',
    summary: '恶梦宜修福化解',
    description:
        '此轮相提示您若有恶梦应当多修福报，如放生、布施等，化解业障。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 186,
    name: '观眠梦当正眠',
    category: '观业果报',
    summary: '应当正当睡眠',
    description:
        '此轮相提示您应当养成良好的睡眠习惯，右侧卧，不倒卧等。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 187,
    name: '观眠梦当净心',
    category: '观业果报',
    summary: '应当清净内心',
    description:
        '此轮相提示您睡眠不好可能是内心不清净。应当多读佛经，清净身口意。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 188,
    name: '观眠梦当见佛',
    category: '观业果报',
    summary: '梦见佛菩萨是好兆',
    description:
        '此轮相提示您若梦见佛菩萨是好兆头，是修行得力的征验。',
    isAuspicious: true,
  ),
  Lunxiang(
    id: 189,
    name: '观眠梦当圆满',
    category: '观业果报',
    summary: '修行即将圆满',
    description:
        '此轮相显示您长期以来的修行即将获得圆满果报。继续坚持，功不唐捐。',
    isAuspicious: true,
  ),
];

/// 根据ID获取轮相
Lunxiang? getLunxiangById(int id) {
  if (id < 1 || id > 189) return null;
  return lunxiangList[id - 1];
}

/// 根据三数之和获取轮相
Lunxiang? getLunxiangBySum(int sum) {
  // 和值范围是3-54
  if (sum < 3 || sum > 54) return null;
  // 使用映射表获取轮相
  // 3->1, 4->2, ..., 11->10, 12->11, ...
  // 189种轮相的和值映射
  final sumToId = _generateSumToIdMap();
  final id = sumToId[sum];
  if (id == null) return null;
  return getLunxiangById(id);
}

/// 生成和值到轮相ID的映射
Map<int, int> _generateSumToIdMap() {
  final map = <int, int>{};
  // 和值3-54，每个和值对应1-3种轮相
  // 3->1, 4->2, 5->3, 6->4, 7->5, 8->6, 9->7, 10->8, 11->9, 12->10
  // 13->11, 14->12, ... 54->189
  for (int sum = 3; sum <= 54; sum++) {
    // 从和值推算轮相ID
    // 简化处理：按顺序分配
    map[sum] = sum - 2; // 3->1, 4->2, ..., 54->52
  }
  // 补充到189
  // 和值53对应轮相151-160中的某个
  // 和值54对应轮相161-189中的某个
  map[53] = 170;
  map[54] = 189;
  return map;
}

/// 获取所有分类
List<String> getCategories() {
  final categories = <String>{};
  for (final lunxiang in lunxiangList) {
    categories.add(lunxiang.category);
  }
  return categories.toList()..sort();
}

/// 按分类获取轮相
List<Lunxiang> getLunxiangByCategory(String category) {
  return lunxiangList.where((l) => l.category == category).toList();
}

/// 获取吉祥轮相
List<Lunxiang> getAuspiciousLunxiang() {
  return lunxiangList.where((l) => l.isAuspicious).toList();
}

/// 获取不吉祥轮相
List<Lunxiang> getInauspiciousLunxiang() {
  return lunxiangList.where((l) => !l.isAuspicious).toList();
}
