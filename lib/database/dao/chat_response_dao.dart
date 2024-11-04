import 'package:chat_gemini/database/database.dart';
import 'package:drift/drift.dart';

part 'chat_response_dao.g.dart';

@DriftAccessor(tables: [ChatResponse])
class ChatResponseDao extends DatabaseAccessor<AppDatabase>
    with _$ChatResponseDaoMixin {
  ChatResponseDao(super.db);

  // clear table
  Future<int> clearTable() async {
    return await delete(chatResponse).go();
  }

  // insert chat response
  Future<int> addChatResponse(
      ChatResponseCompanion chatResponseCompanion) async {
    return await into(chatResponse).insert(
      chatResponseCompanion,
      mode: InsertMode.insert,
    );
  }

  // Fetch list for chat item
  Future<List<ChatResponseData>> fetchChatResponsesForSync() async {
    return await (select(chatResponse)..where((tbl) => tbl.id.isNotNull()))
        .get();
  }

  //Fetch a limited data

  Future<List<ChatResponseData>> fetchLimitedChat({
    required int limit, // Number of items per page
    required int page, // Page number (starting from 1)
  }) async {
    final offset = (page - 1) * limit;
    return await (select(chatResponse)
          ..where((tbl) => tbl.id.isNotNull())
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])
          ..limit(limit, offset: offset)) // Limit results and apply offset
        .get();
  }

  // get the total chat count
  Future<int> getTotalChatCount() async {
    final result = await customSelect(
      'SELECT COUNT(*) AS total FROM chat_response',
      readsFrom: {chatResponse},
    ).getSingle();
    return result.data['total'] as int;
  }

  // Delete chat response record
  Future<int> deleteChatResponseRecord(int id) async {
    return await (delete(chatResponse)..where((tbl) => tbl.id.equals(id))).go();
  }

// Delete multiple chat response records
  Future<int> deleteListOfChatResponseRecords(List<int> ids) async {
    return await (delete(chatResponse)..where((tbl) => tbl.id.isIn(ids))).go();
  }

  // Update chat response
  Future<int> updateChatResponseRecord(
      {required int id, String? response, String? updateDate}) async {
    // Fetch the existing record
    final existingRecord = await (select(chatResponse)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();

    // Use the old value if the new value is null
    final newValue = response ?? existingRecord.response;

    return await (update(chatResponse)..where((tbl) => tbl.id.equals(id)))
        .write(ChatResponseCompanion(
            response: Value(newValue), updatedAt: Value(updateDate)));
  }
}
