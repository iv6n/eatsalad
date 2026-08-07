import 'package:eatsalad/home/tabs/catalog/models/models.dart';

/// Catálogo de muestra, usado como demo cuando la app corre sin una
/// `LOYVERSE_API_KEY` configurada (ver [MenuCubit.getMenu]) — así el menú,
/// la búsqueda, el carrito y el checkout se pueden probar de punta a punta
/// sin depender de una cuenta real de Loyverse.
///
/// El orden de las categorías le importa a la UI existente
/// ([ScrollablePositionedListPage]/[MenuItem]): la primera categoría se
/// muestra con [ComboCard], la segunda con [SaladCard], y el resto como
/// lista con [ItemCard].
final List<Category> mockCategories = [
  const Category('mock-combos', 'Combos', 'FF7A45'),
  const Category('mock-ensaladas', 'Ensaladas', '4CAF50'),
  const Category('mock-bowls', 'Bowls', 'FFA726'),
  const Category('mock-bebidas', 'Bebidas', '29B6F6'),
  const Category('mock-extras', 'Extras y aderezos', '8D6E63'),
];

final List<Item> mockItems = [
  // Combos
  const Item(
    id: 'mock-combo-1',
    itemName: 'Combo Ejecutivo',
    description: 'Ensalada César + agua fresca + postre del día.',
    categoryId: 'mock-combos',
    variants: Variant('mock-combo-1-v1', 'mock-combo-1', 'CMB-01', 129),
  ),
  const Item(
    id: 'mock-combo-2',
    itemName: 'Combo Fitness',
    description: 'Bowl de pollo a la parrilla + smoothie verde.',
    categoryId: 'mock-combos',
    variants: Variant('mock-combo-2-v1', 'mock-combo-2', 'CMB-02', 139),
  ),
  const Item(
    id: 'mock-combo-3',
    itemName: 'Combo Pareja',
    description: 'Dos ensaladas a elegir + dos bebidas.',
    categoryId: 'mock-combos',
    variants: Variant('mock-combo-3-v1', 'mock-combo-3', 'CMB-03', 219),
  ),
  // Ensaladas
  const Item(
    id: 'mock-ensalada-1',
    itemName: 'César con pollo',
    description: 'Lechuga romana, pollo a la parrilla, parmesano, crutones.',
    categoryId: 'mock-ensaladas',
    variants: Variant('mock-ensalada-1-v1', 'mock-ensalada-1', 'ENS-01', 89),
  ),
  const Item(
    id: 'mock-ensalada-2',
    itemName: 'Griega',
    description: 'Pepino, jitomate, aceituna kalamata, queso feta, orégano.',
    categoryId: 'mock-ensaladas',
    variants: Variant('mock-ensalada-2-v1', 'mock-ensalada-2', 'ENS-02', 85),
  ),
  const Item(
    id: 'mock-ensalada-3',
    itemName: 'Kale y quinoa',
    description:
        'Kale masajeado, quinoa, arándano, almendra, vinagreta cítrica.',
    categoryId: 'mock-ensaladas',
    variants: Variant('mock-ensalada-3-v1', 'mock-ensalada-3', 'ENS-03', 92),
  ),
  const Item(
    id: 'mock-ensalada-4',
    itemName: 'Caprese',
    description: 'Jitomate, mozzarella fresca, albahaca, aceite de oliva.',
    categoryId: 'mock-ensaladas',
    variants: Variant('mock-ensalada-4-v1', 'mock-ensalada-4', 'ENS-04', 88),
  ),
  // Bowls
  const Item(
    id: 'mock-bowl-1',
    itemName: 'Bowl de salmón',
    description: 'Arroz integral, salmón sellado, aguacate, edamame.',
    categoryId: 'mock-bowls',
    variants: Variant('mock-bowl-1-v1', 'mock-bowl-1', 'BWL-01', 145),
  ),
  const Item(
    id: 'mock-bowl-2',
    itemName: 'Bowl mexicano',
    description: 'Frijol, elote, pico de gallo, pollo adobado, aguacate.',
    categoryId: 'mock-bowls',
    variants: Variant('mock-bowl-2-v1', 'mock-bowl-2', 'BWL-02', 99),
  ),
  const Item(
    id: 'mock-bowl-3',
    itemName: 'Bowl vegano',
    description: 'Garbanzo rostizado, hummus, vegetales asados, tahini.',
    categoryId: 'mock-bowls',
    variants: Variant('mock-bowl-3-v1', 'mock-bowl-3', 'BWL-03', 94),
  ),
  // Bebidas
  const Item(
    id: 'mock-bebida-1',
    itemName: 'Agua fresca de pepino',
    description: '500 ml, endulzada al gusto.',
    categoryId: 'mock-bebidas',
    variants: Variant('mock-bebida-1-v1', 'mock-bebida-1', 'BEB-01', 32),
  ),
  const Item(
    id: 'mock-bebida-2',
    itemName: 'Smoothie verde',
    description: 'Espinaca, piña, manzana, jengibre.',
    categoryId: 'mock-bebidas',
    variants: Variant('mock-bebida-2-v1', 'mock-bebida-2', 'BEB-02', 45),
  ),
  const Item(
    id: 'mock-bebida-3',
    itemName: 'Limonada de fresa',
    description: '500 ml.',
    categoryId: 'mock-bebidas',
    variants: Variant('mock-bebida-3-v1', 'mock-bebida-3', 'BEB-03', 38),
  ),
  // Extras
  const Item(
    id: 'mock-extra-1',
    itemName: 'Pollo a la parrilla extra',
    description: '100 g adicionales.',
    categoryId: 'mock-extras',
    variants: Variant('mock-extra-1-v1', 'mock-extra-1', 'EXT-01', 28),
  ),
  const Item(
    id: 'mock-extra-2',
    itemName: 'Aderezo vinagreta balsámica',
    description: '60 ml.',
    categoryId: 'mock-extras',
    variants: Variant('mock-extra-2-v1', 'mock-extra-2', 'EXT-02', 12),
  ),
  const Item(
    id: 'mock-extra-3',
    itemName: 'Aguacate extra',
    description: 'Media pieza.',
    categoryId: 'mock-extras',
    variants: Variant('mock-extra-3-v1', 'mock-extra-3', 'EXT-03', 18),
  ),
];
