import '../models/pm_character.dart';

class CharactersRepository {
  final List<PmCharacter> _characters = const [
    PmCharacter(
      id: 'yi_sang',
      name: 'Yi Sang',
      sinnerNumber: '01',
      originWork: 'The Wings, Crow\'s Eye View',
      author: 'Yi Sang',
      shortLore: 'Интеллектуал, чьи грехи связаны с бездействием и отчуждением.',
      detailedLore:
          'Yi Sang основан на корейском поэте Yi Sang и его произведениях '
          '«The Wings» и «Crow’s Eye View». Его история полна тем апатии, '
          'отчуждения и чувства лишности.',
      tags: ['Sloth', 'Gloom', 'Поэт'],
    ),
    PmCharacter(
      id: 'faust',
      name: 'Faust',
      sinnerNumber: '02',
      originWork: 'Faust',
      author: 'Johann Wolfgang von Goethe',
      shortLore:
          'Гениальная учёная, заключившая опасные сделки ради знания и силы.',
      detailedLore:
          'Faust опирается на трагедию Гёте «Фауст», где стремление к абсолютному '
          'знанию приводит к сделке с демоном.',
      tags: ['Pride', 'Учёный'],
    ),
    PmCharacter(
      id: 'don_quixote',
      name: 'Don Quixote',
      sinnerNumber: '03',
      originWork: 'Don Quixote',
      author: 'Miguel de Cervantes',
      shortLore: 'Рыцарка‑фанатичка, живущая идеалами и иллюзиями.',
      detailedLore:
          'Don Quixote основана на романе Сервантеса. Как и оригинал, она одержима '
          'идеей героизма и рыцарства, зачастую игнорируя реальность.',
      tags: ['Wrath', 'Рыцарь'],
    ),
    PmCharacter(
      id: 'ryoshu',
      name: 'Ryoshu',
      sinnerNumber: '04',
      originWork: 'Hell Screen',
      author: 'Ryūnosuke Akutagawa',
      shortLore:
          'Художница, одержимая эстетикой насилия и совершенством композиции.',
      detailedLore:
          'Ryoshu вдохновлена рассказом «Адская картина» Акутагавы: художник, '
          'ради идеальной картины, идёт на жертвы.',
      tags: ['Wrath', 'Художник'],
    ),
    PmCharacter(
      id: 'meursault',
      name: 'Meursault',
      sinnerNumber: '05',
      originWork: 'The Stranger',
      author: 'Albert Camus',
      shortLore:
          'Эмоционально отстранённый человек, живущий в абсурдном мире.',
      detailedLore:
          'Meursault основан на романе Камю «Посторонний», где герой реагирует '
          'на события с пугающим безразличием.',
      tags: ['Sloth', 'Абсурдизм'],
    ),
    PmCharacter(
      id: 'hong_lu',
      name: 'Hong Lu',
      sinnerNumber: '06',
      originWork: 'Dream of the Red Chamber',
      author: 'Cao Xueqin',
      shortLore:
          'Наследник из аристократической семьи, окружённый роскошью и трагедиями.',
      detailedLore:
          'Hong Lu отсылает к роману «Сон в красном тереме», где жизнь аристократии '
          'медленно разрушается.',
      tags: ['Lust', 'Аристократ'],
    ),
    PmCharacter(
      id: 'heathcliff',
      name: 'Heathcliff',
      sinnerNumber: '07',
      originWork: 'Wuthering Heights',
      author: 'Emily Brontë',
      shortLore:
          'Одержимый мститель, разрываемый между любовью и ненавистью.',
      detailedLore:
          'Heathcliff вдохновлён героем «Грозового перевала»: разрушительная страсть '
          'и жажда мести определяют его характер.',
      tags: ['Wrath', 'Месть'],
    ),
    PmCharacter(
      id: 'ishmael',
      name: 'Ishmael',
      sinnerNumber: '08',
      originWork: 'Moby-Dick',
      author: 'Herman Melville',
      shortLore: 'Морячка, пережившая одержимую погоню за чудовищем в море.',
      detailedLore:
          'Ishmael отсылает к рассказчику «Моби Дика». Темы выживания и одержимости '
          'перекликаются с её историей.',
      tags: ['Gloom', 'Море'],
    ),
    PmCharacter(
      id: 'rodion',
      name: 'Rodion',
      sinnerNumber: '09',
      originWork: 'Crime and Punishment',
      author: 'Fyodor Dostoevsky',
      shortLore:
          'Человек, балансирующий между оправданием преступления и тяжестью вины.',
      detailedLore:
          'Rodion вдохновлён «Преступлением и наказанием». В центре — идея '
          '«особого человека» и неизбежность наказания.',
      tags: ['Pride', 'Вина'],
    ),
    PmCharacter(
      id: 'sinclair',
      name: 'Sinclair',
      sinnerNumber: '10',
      originWork: 'Demian',
      author: 'Hermann Hesse',
      shortLore:
          'Подросток, разрываемый между «миром света» и «миром тьмы».',
      detailedLore:
          'Sinclair основан на романе «Демиан». Становление личности и поиск пути '
          '— центральные мотивы.',
      tags: ['Gloom', 'Самопознание'],
    ),
    PmCharacter(
      id: 'outis',
      name: 'Outis',
      sinnerNumber: '11',
      originWork: 'The Odyssey',
      author: 'Homer',
      shortLore: 'Тактик и стратег, скрывающий своё настоящее имя.',
      detailedLore:
          'Outis («Никто») отсылает к Одиссею: обман как инструмент выживания, хитрость '
          'и манипуляция.',
      tags: ['Pride', 'Тактик'],
    ),
    PmCharacter(
      id: 'gregor',
      name: 'Gregor',
      sinnerNumber: '12',
      originWork: 'The Metamorphosis',
      author: 'Franz Kafka',
      shortLore:
          'Человек, превратившийся в «насекомое» под тяжестью вины и долга.',
      detailedLore:
          'Gregor вдохновлён героем «Превращения» Кафки: чувство вины и отчуждение '
          'определяют его образ.',
      tags: ['Sloth', 'Отчуждение'],
    ),
    PmCharacter(
      id: 'dante',
      name: 'Dante',
      sinnerNumber: '13',
      originWork: 'Divine Comedy',
      author: 'Dante Alighieri',
      shortLore:
          'Проводник и наблюдатель, путешествующий через круги ада.',
      detailedLore:
          'Dante основан на авторе «Божественной комедии» и выполняет роль проводника '
          'через грехи и наказания.',
      tags: ['Pride', 'Проводник'],
    ),
  ];

  List<PmCharacter> getAll() => _characters;

  PmCharacter getById(String id) =>
      _characters.firstWhere((c) => c.id == id);
}