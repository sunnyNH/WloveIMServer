import MySQLProvider

extension Config {
    public func setup() throws {
        // allow fuzzy conversions for these types
        // (add your own types here)
        Node.fuzzy = [Row.self, JSON.self, Node.self]

        try setupProviders()
        try setupPreparations()
        
        //游戏的,im的
        LoginServer().registered()
        MessageServer().registered()
        GobangServer().registered()
        AudioServer().registered()
    }
    
    private func setupProviders() throws {
        try addProvider(MySQLProvider.Provider.self)
    }

    private func setupPreparations() throws {
        preparations.append(Message.self)
        preparations.append(Session.self)
        preparations.append(Group.self)
        preparations.append(Member.self)
        
        //游戏的
        preparations.append(GameRoom.self)
        preparations.append(GameMember.self)
    }
}



func registeredRoute() {
    GobangController().registeredRouting()
}
