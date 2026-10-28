import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../models/chat_message.dart';
import '../models/tutor_context_model.dart';
import '../models/tutor_mode.dart';
import '../services/ai_tutor_service.dart';
import 'widgets/riyah_header.dart';
import 'widgets/riyah_mode_selector.dart';
import 'widgets/riyah_welcome_card.dart';
import 'widgets/tutor_context_banner.dart';

class AiTutorScreen extends StatefulWidget {
  final TutorContextModel? initialContext;
  final TutorMode initialMode;
  final VoidCallback? onOpenDrawer;

  const AiTutorScreen({
    super.key,
    this.initialContext,
    this.initialMode = TutorMode.askTutor,
    this.onOpenDrawer,
  });

  @override
  State<AiTutorScreen> createState() => _AiTutorScreenState();
}

class _AiTutorScreenState extends State<AiTutorScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final AITutorService _aiService = AITutorService();

  late TutorMode _selectedMode;
  late TutorContextModel? _currentContext;
  final List<ChatMessage> _messages = [];
  bool _isSending = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _selectedMode = widget.initialMode;
    _currentContext = widget.initialContext;
  }

  void _sendMessage(String text) async {
    final trimmedText = text.trim();
    if (trimmedText.isEmpty || _isSending) return;

    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: trimmedText,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
      mode: _selectedMode,
      context: _currentContext,
    );

    setState(() {
      _messages.add(userMsg);
      _isSending = true;
      _errorMessage = null;
    });

    _textController.clear();
    _scrollToBottom();

    try {
      final riyahMsg = await _aiService.sendMessage(
        prompt: trimmedText,
        mode: _selectedMode,
        context: _currentContext,
      );

      if (mounted) {
        setState(() {
          _messages.add(riyahMsg);
        });
        _scrollToBottom();
      }
    } catch (e) {
      if (mounted) {
        final errorText = e is RiyahException ? e.message : e.toString();
        setState(() {
          _errorMessage = errorText;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline_rounded, color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    errorText,
                    style: const TextStyle(fontSize: 12.5),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.red.shade900.withAlpha(230),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final accentPurple = isDark ? AppColors.neonPurple : AppColors.lightPurple;

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // Riyah Header
            RiyahHeader(onOpenDrawer: widget.onOpenDrawer),

            // Mode Selector Bar
            RiyahModeSelector(
              selectedMode: _selectedMode,
              onModeSelected: (mode) {
                setState(() {
                  _selectedMode = mode;
                });
              },
            ),

            const SizedBox(height: 6),

            // Active Context Banner (if context present)
            if (_currentContext != null && _currentContext!.hasContext)
              TutorContextBanner(
                contextData: _currentContext!,
                onClearContext: () {
                  setState(() {
                    _currentContext = null;
                  });
                },
              ),

            Divider(height: 1, color: isDark ? AppColors.glassBorder : const Color(0xFFE2E8F0)),

            // Main Content Area (Empty State Welcome Card vs Chat Message List)
            Expanded(
              child: _messages.isEmpty
                  ? RiyahWelcomeCard(
                      onModeSelected: (mode) {
                        setState(() {
                          _selectedMode = mode;
                        });
                      },
                      onPromptSelected: (prompt) {
                        _sendMessage(prompt);
                      },
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        return _RiyahChatBubble(message: msg);
                      },
                    ),
            ),

            // Inline Error Banner if present
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: GlassContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  borderRadius: 12,
                  borderColor: Colors.red.withAlpha(100),
                  color: Colors.red.withAlpha(20),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Colors.amberAccent, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(
                            fontSize: 11.5,
                            color: isDark ? Colors.red.shade200 : Colors.red.shade800,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 14),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          setState(() {
                            _errorMessage = null;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

            // Sending / Loading Indicator
            if (_isSending)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Row(
                  children: [
                    SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: accentPurple,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Riyah is analyzing Operating Systems context...",
                      style: TextStyle(
                        fontSize: 11,
                        color: accentPurple.withAlpha(200),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

            // Curated Gate Smashers YouTube Reference Dock attached above the chat input box
            _buildChatBoxReferenceDock(context, isDark),

            // Text Input Bar at bottom
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 4),
              child: GlassContainer(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                borderRadius: 24,
                borderColor: _selectedMode.color.withAlpha(70),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        maxLines: 4,
                        minLines: 1,
                        style: TextStyle(color: AppColors.text1(context), fontSize: 14),
                        onSubmitted: _sendMessage,
                        decoration: InputDecoration(
                          hintText: "Ask Riyah about ${_selectedMode.label}...",
                          hintStyle: TextStyle(color: AppColors.textM(context), fontSize: 13),
                          filled: false,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _selectedMode.color,
                          boxShadow: [
                            BoxShadow(
                              color: _selectedMode.color.withAlpha(isDark ? 120 : 60),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.send_rounded, color: Colors.black, size: 16),
                      ),
                      onPressed: () => _sendMessage(_textController.text),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBoxReferenceDock(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.video_library_rounded, size: 12, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight),
              const SizedBox(width: 4),
              Text(
                "Gate Smashers Reference Channels & Topics:",
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                  color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: AITutorService.gateSmashersYtResources.map((res) {
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () async {
                      final uri = Uri.tryParse(res['url'] ?? '');
                      if (uri != null) {
                        try {
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        } catch (_) {}
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.withAlpha(isDark ? 35 : 20),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.redAccent.withAlpha(isDark ? 140 : 100),
                          width: 0.9,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.play_circle_fill_rounded, size: 12, color: Colors.redAccent),
                          const SizedBox(width: 4),
                          Text(
                            res['tag'] ?? 'Video',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.red.shade200 : Colors.red.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _RiyahChatBubble extends StatelessWidget {
  final ChatMessage message;

  const _RiyahChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final isUser = message.isUser;
    final bubbleColor = isUser
        ? (isDark ? AppColors.neonCyan : AppColors.lightBlue)
        : (isDark ? AppColors.neonPurple : AppColors.lightPurple);

    final textColor = AppColors.text1(context);
    final codeBgColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9);
    final inlineCodeBgColor = isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);

    final String displayText = !isUser
        ? AITutorService.appendGateSmashersReferences(
            message.text,
            promptOrTopic: '${message.context?.topicTitle ?? ""} ${message.context?.questionText ?? ""}',
          )
        : message.text;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bubbleColor.withAlpha(30),
                border: Border.all(color: bubbleColor, width: 1.2),
              ),
              child: Icon(Icons.psychology_rounded, color: bubbleColor, size: 18),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: GlassContainer(
              padding: const EdgeInsets.all(14),
              borderRadius: 18,
              borderColor: bubbleColor.withAlpha(isDark ? 70 : 40),
              color: isUser
                  ? bubbleColor.withAlpha(isDark ? 25 : 15)
                  : AppColors.cardGlass(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isUser ? "You" : "Riyah",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: bubbleColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: message.mode.color.withAlpha(30),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          message.mode.label,
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: message.mode.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  isUser
                      ? SelectableText(
                          message.text,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 13.5,
                            height: 1.45,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MarkdownBody(
                              data: displayText,
                              selectable: true,
                              onTapLink: (text, href, title) async {
                                if (href != null && href.isNotEmpty) {
                                  final uri = Uri.tryParse(href);
                                  if (uri != null) {
                                    try {
                                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                                    } catch (_) {}
                                  }
                                }
                              },
                              extensionSet: md.ExtensionSet(
                                md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                                [
                                  BlockMathSyntax(),
                                  InlineMathSyntax(),
                                  ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
                                ],
                              ),
                              builders: {
                                'latex-inline': LatexElementBuilder(style: TextStyle(color: textColor, fontSize: 13.5)),
                                'latex-block': LatexElementBuilder(style: TextStyle(color: bubbleColor, fontSize: 14.5)),
                              },
                              styleSheet: MarkdownStyleSheet(
                                p: TextStyle(
                                  color: textColor,
                                  fontSize: 13.5,
                                  height: 1.5,
                                ),
                                h1: TextStyle(
                                  color: bubbleColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                ),
                                h2: TextStyle(
                                  color: bubbleColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                ),
                                h3: TextStyle(
                                  color: bubbleColor,
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w600,
                                  height: 1.35,
                                ),
                                strong: TextStyle(
                                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                  fontWeight: FontWeight.bold,
                                ),
                                em: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                                code: TextStyle(
                                  color: isDark ? AppColors.neonCyan : AppColors.lightBlue,
                                  backgroundColor: inlineCodeBgColor,
                                  fontFamily: 'monospace',
                                  fontSize: 12.5,
                                ),
                                codeblockPadding: const EdgeInsets.all(12),
                                codeblockDecoration: BoxDecoration(
                                  color: codeBgColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: bubbleColor.withAlpha(60),
                                    width: 1,
                                  ),
                                ),
                                blockquote: TextStyle(
                                  color: AppColors.textM(context),
                                  fontStyle: FontStyle.italic,
                                  fontSize: 13,
                                ),
                                blockquotePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                blockquoteDecoration: BoxDecoration(
                                  color: bubbleColor.withAlpha(15),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border(
                                    left: BorderSide(
                                      color: bubbleColor,
                                      width: 3,
                                    ),
                                  ),
                                ),
                                listBullet: TextStyle(
                                  color: bubbleColor,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.bold,
                                ),
                                horizontalRuleDecoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: bubbleColor.withAlpha(50),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            _buildQuickLinkChips(context, displayText, isDark),
                          ],
                        ),
                ],
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bubbleColor.withAlpha(30),
                border: Border.all(color: bubbleColor, width: 1.2),
              ),
              child: Icon(Icons.person_rounded, color: bubbleColor, size: 18),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickLinkChips(BuildContext context, String text, bool isDark) {
    final linkRegex = RegExp(r'\[([^\]]+)\]\((https?:\/\/[^\s\)]+)\)');
    final matches = linkRegex.allMatches(text);
    if (matches.isEmpty) return const SizedBox.shrink();

    final List<Widget> chips = [];
    for (final match in matches) {
      final rawLabel = match.group(1) ?? 'Resource';
      final url = match.group(2) ?? '';
      final isYouTube = url.contains('youtube.com') ||
          url.contains('youtu.be') ||
          rawLabel.toLowerCase().contains('youtube');

      final displayLabel = rawLabel
          .replaceAll('▶ ', '')
          .replaceAll('🌐 ', '')
          .replaceAll('YouTube: ', '')
          .replaceAll('Chrome/Web: ', '')
          .replaceAll('Web: ', '')
          .trim();

      chips.add(
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            final uri = Uri.tryParse(url);
            if (uri != null) {
              try {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              } catch (_) {}
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isYouTube
                  ? Colors.red.withAlpha(isDark ? 40 : 25)
                  : (isDark ? AppColors.neonCyan.withAlpha(35) : const Color(0xFFE0F2FE)),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isYouTube
                    ? Colors.redAccent.withAlpha(isDark ? 160 : 120)
                    : (isDark ? AppColors.neonCyan.withAlpha(160) : const Color(0xFF38BDF8)),
                width: 1.1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isYouTube ? Icons.play_circle_fill_rounded : Icons.open_in_browser_rounded,
                  size: 15,
                  color: isYouTube
                      ? (isDark ? Colors.redAccent : Colors.red.shade700)
                      : (isDark ? AppColors.neonCyan : const Color(0xFF0284C7)),
                ),
                const SizedBox(width: 6),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 240),
                  child: Text(
                    isYouTube ? "YouTube: $displayLabel" : "Web: $displayLabel",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isYouTube
                          ? (isDark ? Colors.red.shade200 : Colors.red.shade900)
                          : (isDark ? AppColors.neonCyan : const Color(0xFF0369A1)),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.link_rounded,
                size: 13,
                color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
              ),
              const SizedBox(width: 4),
              Text(
                "Recommended External Links",
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                  color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: chips,
          ),
        ],
      ),
    );
  }
}

class BlockMathSyntax extends md.InlineSyntax {
  BlockMathSyntax() : super(r'\$\$\s*([\s\S]+?)\s*\$\$|\\\[\s*([\s\S]+?)\s*\\\]');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final content = match.group(1) ?? match.group(2) ?? '';
    if (content.trim().isEmpty) return false;

    parser.addNode(md.Element('latex-block', [md.Text(content)]));
    return true;
  }
}

class InlineMathSyntax extends md.InlineSyntax {
  InlineMathSyntax() : super(r'(?<!\$)\$([^\$\n]+?)\$(?!\$)|\\((.+?)\\)');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final rawMatch = match.group(0) ?? '';
    String content = '';
    if (rawMatch.startsWith(r'\(') && rawMatch.endsWith(r'\)')) {
      content = rawMatch.substring(2, rawMatch.length - 2);
    } else {
      content = match.group(1) ?? match.group(2) ?? '';
    }

    if (content.trim().isEmpty) return false;

    parser.addNode(md.Element('latex-inline', [md.Text(content)]));
    return true;
  }
}

class LatexElementBuilder extends MarkdownElementBuilder {
  final TextStyle? style;

  LatexElementBuilder({this.style});

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final rawContent = element.textContent.trim();
    final cleanedContent = rawContent.replaceAll(r'\\', r'\');
    final effectiveStyle = style ?? preferredStyle;

    if (element.tag == 'latex-block') {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Math.tex(
            cleanedContent,
            textStyle: effectiveStyle,
            mathStyle: MathStyle.display,
            onErrorFallback: (err) => Text(
              r'$$ ' + rawContent + r' $$',
              style: effectiveStyle,
            ),
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Math.tex(
          cleanedContent,
          textStyle: effectiveStyle,
          mathStyle: MathStyle.text,
          onErrorFallback: (err) => Text(
            r'$' + rawContent + r'$',
            style: effectiveStyle,
          ),
        ),
      );
    }
  }
}

