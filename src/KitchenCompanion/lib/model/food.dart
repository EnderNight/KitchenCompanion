const String tableFood = 'food';

class FoodFields {
    
    static final List<String> columns = [
        id, name, quantity
    ];

    static const String id = '_id';
    static const String name = 'name';
    static const String quantity = 'quantity';
}

class Food {
    final int? id;
    final String name;
    final double quantity;

    const Food({
        this.id,
        required this.name,
        required this.quantity,
    });

    Map<String, dynamic> toMap() {
        return {
            'id': id,
            'name': name,
            'quantity': quantity,
        };
    }

    static Food fromMap(Map<String, dynamic> map) {
        return Food(id: map['id'], name: map['name'], quantity: map['quantity']);
    }

    Food copy({
        int? id,
        String? name,
        double? quantity,
    }) => Food(id: id ?? this.id, name: name ?? this.name, quantity: quantity ?? this.quantity);

    @override
    String toString() {
        return 'Food{id! $id, name: $name, quantity: $quantity}';
    }
}
