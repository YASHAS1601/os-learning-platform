import 'package:flutter/foundation.dart';
import '../../../core/services/supabase_service.dart';
import '../models/bookmark_model.dart';

/// Repository for handling user bookmarks in Supabase
class BookmarkRepository {
  final SupabaseService _supabaseService;

  BookmarkRepository({SupabaseService? supabaseService})
      : _supabaseService = supabaseService ?? SupabaseService.instance;

  /// Get all bookmarks for current user
  Future<List<BookmarkModel>> getBookmarks({String? itemType}) async {
    if (!_supabaseService.isInitialized) return [];
    final uid = _supabaseService.userId;
    if (uid == null) return [];

    try {
      var query = _supabaseService.client
          .from('bookmarks')
          .select()
          .eq('user_id', uid);

      if (itemType != null) {
        query = query.eq('item_type', itemType);
      }

      final response = await query.order('created_at', ascending: false);

      return (response as List)
          .map((json) => BookmarkModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error fetching bookmarks: $e');
      return [];
    }
  }

  /// Check if a specific item is bookmarked
  Future<bool> isBookmarked(String itemType, String itemId) async {
    if (!_supabaseService.isInitialized) return false;
    final uid = _supabaseService.userId;
    if (uid == null) return false;

    try {
      final response = await _supabaseService.client
          .from('bookmarks')
          .select('id')
          .eq('user_id', uid)
          .eq('item_type', itemType)
          .eq('item_id', itemId)
          .maybeSingle();

      return response != null;
    } catch (e) {
      debugPrint('Error checking bookmark status: $e');
      return false;
    }
  }

  /// Add a bookmark
  Future<BookmarkModel?> addBookmark(String itemType, String itemId) async {
    if (!_supabaseService.isInitialized) return null;
    final uid = _supabaseService.userId;
    if (uid == null) return null;

    try {
      final bookmark = BookmarkModel(
        userId: uid,
        itemType: itemType,
        itemId: itemId,
        createdAt: DateTime.now(),
      );

      final response = await _supabaseService.client
          .from('bookmarks')
          .insert(bookmark.toJson())
          .select()
          .single();

      return BookmarkModel.fromJson(response);
    } catch (e) {
      debugPrint('Error adding bookmark: $e');
      return null;
    }
  }

  /// Remove a bookmark
  Future<bool> removeBookmark(String itemType, String itemId) async {
    if (!_supabaseService.isInitialized) return false;
    final uid = _supabaseService.userId;
    if (uid == null) return false;

    try {
      await _supabaseService.client
          .from('bookmarks')
          .delete()
          .eq('user_id', uid)
          .eq('item_type', itemType)
          .eq('item_id', itemId);

      return true;
    } catch (e) {
      debugPrint('Error removing bookmark: $e');
      return false;
    }
  }

  /// Toggle bookmark status (returns new state: true if bookmarked, false if removed)
  Future<bool> toggleBookmark(String itemType, String itemId) async {
    final currentlyBookmarked = await isBookmarked(itemType, itemId);
    if (currentlyBookmarked) {
      await removeBookmark(itemType, itemId);
      return false;
    } else {
      await addBookmark(itemType, itemId);
      return true;
    }
  }
}
