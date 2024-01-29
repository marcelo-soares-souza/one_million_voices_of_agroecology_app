import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:one_million_voices_of_agroecology_app/configs/config.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Image.asset(
              'assets/images/logo.png',
              width: 250,
              height: 250,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                """
The One Million Voices citizen science initiative is a project implemented by the Agroecology TPP in collaboration with partners from Agroecology Map, the Asian Farmers Association (AFA), Groundswell International, the facilitator of the McKnight Andes Community of Practice, and knowledge partners from ETH Citizen Science Centre Zurich.

The initiative’s goal is to develop a tool, or a series of tools, that enable farmers, producer organizations, consumers and other potential end users around the world to 

1) inclusively participate in agroecology movements, 

2) support sustainable adoption of agroecology, 

3) contribute to the collection, co-creation and sharing of information to fill key knowledge gaps on the performance of agroecology. """,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ),
            InkWell(
              child: Text('Click here to read more',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      )),
              onTap: () => launchUrl(Uri.parse(Config.aboutPage)),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
