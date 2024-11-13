part of 'whats_new_service.dart';

class WhatsNewScreenModel {
  WhatsNewScreenModel({
    required this.titleTextStyle,
    required this.descriptionTextStyle,
    required this.iconBackgroundColor,
    required this.iconColor,
  });

  final TextStyle titleTextStyle;
  final TextStyle descriptionTextStyle;
  final Color iconBackgroundColor;
  final Color iconColor;
}

class WhatsNewScreen extends StatelessWidget {
  WhatsNewScreen({super.key, required this.model});

  final WhatsNewScreenModel model;

  @override
  Widget build(BuildContext context) {
    final whatsNewContent = WhatsNewService.instance._whatsNewDefinition!.content;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(whatsNewContent.title.tr()),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: model.iconBackgroundColor,
                              foregroundColor: model.iconColor,
                              child: Icon(
                                IconData(entry.materialIcon, fontFamily: 'MaterialIcons'),
                              ),
                            ),
                            const SizedBox(width: 32),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(entry.title.tr(), style: model.titleTextStyle),
                                  Text(entry.description.tr(), style: model.descriptionTextStyle),
                                ],
                              ),
                            ),
                          ],
                        )
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
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(whatsNewContent.buttonTitle.tr()))
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
