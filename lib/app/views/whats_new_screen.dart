part of '../service/whats_new_service.dart';

extension WhatsNewTranslatedText on Map<String, String> {
  String tr(BuildContext context) {
    return this[Localizations.localeOf(context).languageCode] ?? this['de'] ?? '';
  }
}

class WhatsNewScreenModel {
  WhatsNewScreenModel({required this.bulletPointModel, required this.showModal});

  final bool showModal;
  final WhatsNewBulletPointModel bulletPointModel;
}

class WhatsNewScreen extends StatelessWidget {
  WhatsNewScreen({super.key, required this.model});

  final WhatsNewScreenModel model;

  @override
  Widget build(BuildContext context) {
    final whatsNewContent = WhatsNewService.instance.currentWhatsNewDefinition.content;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(whatsNewContent.title.tr(context)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var (index, entry) in whatsNewContent.entries.indexed) ...[
                        switch (entry.type) {
                          WhatsNewEntryType.bulletpoint =>
                            WhatsNewBulletPoint(model: model.bulletPointModel, entry: entry as WhatsNewEntryBulletpoint),
                          WhatsNewEntryType.image => WhatsNewImage(entry: entry as WhatsNewEntryImage),
                          WhatsNewEntryType.markdown => WhatsNewMarkdown(entry: entry as WhatsNewEntryMarkdown),
                          WhatsNewEntryType.link => WhatsNewLink(entry: entry as WhatsNewEntryLink),
                        }
                            .animate()
                            .move(
                                delay: (index + 1).seconds,
                                duration: 1.seconds,
                                curve: Curves.fastEaseInToSlowEaseOut,
                                begin: const Offset(0, 100),
                                end: Offset.zero)
                            .fade(),
                        const SizedBox(height: 32),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                      onPressed: () async {
                        if (await WhatsNewService.instance.moveToNextWhatsNewIfPossible()) {
                          WhatsNewRoute($extra: model).pushReplacement(context);
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(whatsNewContent.buttonTitle.tr(context)))
                  .animate()
                  .fade(duration: 1.seconds)
                  .move(
                      delay: (whatsNewContent.entries.length + 1).seconds,
                      duration: 1.seconds,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      begin: const Offset(0, 100),
                      end: Offset.zero),
            ],
          ),
        ),
      ),
    );
  }
}
