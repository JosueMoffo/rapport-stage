# TODO - Rapport de stage AGT Infra

Suivi d'avancement de la redaction. A mettre a jour a chaque session.
Statuts : `[ ]` a faire · `[~]` en cours · `[x]` termine.

---

## Squelette du rapport (structure validee le 2026-09-03, numerotation
## reelle corrigee le 2026-09-04 : Analyse et conception = chapitre 3,
## Implementation = chapitre 4, Resultats et bilan = chapitre 5)

1. Introduction generale [fait]
2. Presentation de l'entreprise d'accueil [fait]
3. Etat de l'art [fait]
4. Analyse et conception [fait]
   - 3.1 Analyse des besoins [fait]
   - 3.2 Architecture generale [fait]
   - 3.3 Modelisation des donnees [fait]
   - 3.4 Comportements cles [fait]
5. Implementation [fait]
   - 4.1 Environnement et outils de developpement [fait]
   - 4.2 Methodologie de travail [fait]
   - 4.3 Realisations par module [fait]
   - 4.4 Difficultes rencontrees [fait]
   - 4.5 Deploiement (diagramme de deploiement) [fait]
6. Resultats et bilan [fait]
   - Resultats obtenus (tableau synthese 14 domaines) [fait]
   - Parcours applicatif de bout en bout (diagramme d'activite) [fait]
   - Apercu de l'application (8 captures commentees) [fait]
   - Tests et validation (2 depots de test crees specifiquement) [fait]
   - Limites actuelles et perspectives [fait]
   - Risques et plans de contournement [fait]
7. Conclusion generale [fait]

Diagrammes reels du chapitre 3 (9, tous ancres dans le cahier des
charges) : contexte, cas d'utilisation RBAC, cas d'utilisation
Serveurs-Conteneurs, architecture generale, package, classes RBAC/IBAC,
classes Serveurs-Conteneurs, etat-transition publication,
etat-transition connectivite serveur, sequence resolution permission,
sequence connexion serveur, sequence deploiement. Diagramme de
deploiement physique du chapitre 4 (section 4.5, generique/portable).
Diagramme d'activite du chapitre 5 (parcours brancher/deployer/publier).

Images stockees dans `assets/diagrams/` (diagrammes) et
`assets/screenshots/` (captures d'ecran), convention `NN-nom.png` (NN =
numero de chapitre reel). Noms de fichiers en ASCII, sans accent
(compilation LaTeX). Icones technologiques dans `assets/icons/`.


---

## Instructions permanentes de redaction

Ces regles s'appliquent a tous les chapitres, sans qu'il soit necessaire
de les repeter a chaque session.

**Langue et style**
1. Vocabulaire accessible, eviter le jargon non explique (introduire
   l'acronyme ou le terme technique la premiere fois, via `glossaire.tex`
   si recurrent).
2. Aucun tiret cadratin (—) ni demi-cadratin (–) : utiliser des tirets
   courts (-), virgules ou parentheses.
3. Ton neutre et factuel, en particulier pour toute comparaison avec des
   outils/entreprises existants (jamais de denigrement ni d'eloge
   disproportionne, cf. methodologie du chapitre Etat de l'art).
4. Pas de phrases toutes faites ni de remplissage generique : chaque
   paragraphe doit apporter une information concrete, propre au contexte
   AGT Infra.
5. Utiliser l'expression "console web" plutot que "terminal web" pour
   designer l'acces terminal integre a l'interface d'AGT Infra.

**Sourcing et rigueur**
6. Toute affirmation factuelle sur un outil, une technologie ou une
   entreprise tierce doit etre verifiee par recherche web a jour (pas de
   memoire non verifiee), puis citee via `\cite{}` avec entree
   correspondante dans `biblio.bib`.
7. Ne jamais recopier de texte source verbatim : toujours reformuler avec
   ses propres mots.
8. Ne jamais inventer un chiffre, une date, un nom propre, ou un fait
   concernant AG Technologies ou AGT Infra : si l'information manque, la
   signaler explicitement au lieu de la deviner.

**Forme et livraison**
9. demande explicite si une image est pertinante pour un point precis.
10. Fichiers complets livres a chaque modification (jamais de diff
    partiel), precedes du chemin et du statut `[nouveau]`/`[modifie]`,
    numerotes `X/N`.
11. Aucune couleur, police, metadonnee ou valeur repetee en dur dans un
    chapitre : toujours passer par `config/`.

**Methode de travail**
12. Avant de rediger un chapitre, poser d'abord les questions de cadrage
    necessaires (comme pour l'Etat de l'art), pas de contenu generique en
    attendant les reponses.
13. `TODO.md` mis a jour a la fin de chaque session (cases cochees + note
    de session horodatee).
14. Toujours verification qu'il y a pas de fautes d'orthographe ou de grammaire. Toujours  utiliser les caractères accentués français corrects (é, è,
    à, ù, ç, î, ô, etc.), y compris dans les titres de chapitre/section,
    jamais de version sans accent.
15. Pour tout tableau à colonnes multiples, utiliser des colonnes a
    largeur fixe (`p{...}`) plutot que `tabularx`/`X`, avec des expressions courtes, pour
    eviter tout debordement de texte entre colonnes.

16. (fusionnee dans la regle 17 ci-dessous)

17. Canevas obligatoire pour chaque chapitre numérote (`\chapter{...}`) :
    - `\label{...}` juste après le `\chapter{...}`
    - Un court paragraphe de présentation du chapitre (3-5 phrases,
      annonçant les sections à venir), portant la lettrine
      `\agtlettrine{Lettre}{reste du mot}` sur son premier mot
    - `\minisommaire` juste après ce paragraphe, jamais avant
    - Puis les sections (`\section{...}`)
    Ne s'applique pas aux chapitres non numérotés (Introduction,
    Conclusion, Remerciements) : ceux-ci n'ont ni lettrine ni
    minisommaire, et peuvent utiliser des titres non numerotes
    (`\section*{...}`) pour structurer leur contenu.

18. L'ancien chapitre "Contexte et problematique" a ete supprime et son
    contenu fusionne dans l'introduction generale (sections non
    numerotees "Contexte et problematique" et "Structure du rapport").
    Toute information factuelle qui y est citee doit provenir d'un
    document source reel (ex : cahier des charges), jamais devinee.

---

## Configuration et pages liminaires

- [x] Squelette LaTeX initialisé (config/, chapters/, front/, annexes/)
- [x] Compilation vérifiée (latexmk -pdf -aux-directory=build main.tex)
- [x] Script scan_structure_raport.sh opérationnel
- [x] Correction globale des accents manquants sur tous les fichiers
- [x] Correction du débordement d'en-tête et du tableau du chapitre 3
- [~] Style visuel ENSPY/Legrand Orange Book intégré (bordure page de
      garde, en-têtes/pieds ornementés, bloc de chapitre coloré,
      mini-sommaire par chapitre, lettrine) : à valider par compilation,
      nouveaux packages jamais testés ensemble jusqu'ici (pgfornament,
      tikz, lettrine, etoc)
- [x] `config/03_metadonnees.tex` : dates de stage renseignées
      (06 juillet 2026 - 05 août 2026)
- [ ] `config/03_metadonnees.tex` : renseigner nom complet de l'auteur,
      formation, école, tuteurs
- [ ] `front/page_garde.tex` : ajouter logo école / logo AG Technologies
      (dossier `assets/` à créer)
- [ ] `front/remerciements.tex` : rédiger

## Introduction generale

- [x] Contexte general et cadre du stage (entreprise, dates, mission)
- [x] Contexte et problematique (fusionne depuis l'ancien chapitre 2,
      sourcee sur le cahier des charges : AGT-BOT, AGT ERP, MboaPay,
      absence de point de controle unique)
- [x] Objectifs du projet (objectif general + 7 objectifs specifiques,
      sources sur le cahier des charges v2 : principe "chef d'orchestre",
      domaines fonctionnels principaux)
- [x] Feuille de route (listing par chapitre avec renvoi \ref{}, plutot
      qu'un simple paragraphe de transition)
- [ ] Relecture finale par Josue

## Chapitre 1 - Presentation de l'entreprise d'accueil

- [x] Section 1.1 : activite et organisation d'AG Technologies (redigee
      a partir du contenu reel du site ag-technologies.tech)
- [x] Section 1.2 : environnement technique avant AGT Infra
      (VPS mutualise srv1434223 : AGT-BOT, team-tool, AGT TaskFlow,
      gestion manuelle SSH)
- [x] Canevas de chapitre (lettrine + paragraphe de presentation avant
      minisommaire) applique retroactivement
- [ ] Relecture finale du chapitre par Josue

## Chapitre "Etat de l'art"

- [x] Criteres de comparaison definis (8 criteres, section 3.2)
- [x] Recherche des caracteristiques reelles des 6 outils compares
      (Portainer, Rancher, Proxmox VE, Cockpit, Ansible AWX/Semaphore,
      Coolify), sources datees 2025-2026
- [x] Redaction complete des sous-sections 3.3 (panorama)
- [x] Tableau comparatif rempli (`tab:comparatif-etat-art`)
- [x] Synthese et justification du developpement interne redigee
- [x] Neutralite du ton verifiee (aucune solution denigree, limites
      d'AGT Infra assumees explicitement en fin de chapitre)
- [x] Sources ajoutees a `biblio.bib` (17 references)
- [x] Terminologie "terminal web" remplacee par "console web"
- [ ] Relecture finale du chapitre par Josue
- [ ] Renommage cosmetique de `chapters/02_etat_art.tex` a envisager
      (numerotation reelle du chapitre a decale d'un cran, non urgent
      car les numeros de chapitre sont generes automatiquement par
      LaTeX et non lies au nom de fichier)

## Chapitre "Analyse et conception" (chapitre 3 reel)

- [x] Canevas de chapitre (lettrine + paragraphe + minisommaire)
- [x] 3.1 Analyse des besoins : contexte (diagramme + perimetre en
      listes), acteurs (liste), synthese des exigences (tableau sans
      colonnes techniques, NF reparties en 3 categories : utilisateurs /
      organisationnelles / systemes externes), 2 diagrammes de cas
      d'utilisation (RBAC, Serveurs-Conteneurs) + 2 cas detailles
      (creer/affecter un role, deployer une application)
- [x] 3.2 Architecture generale : diagramme d'architecture globale
      (frontiere AGT Infra / systemes externes, flux SSH centralise,
      webhook Netdata hors SSH) + diagramme de package
- [x] 3.3 Modelisation des donnees : diagramme de classes Controle
      d'acces (RBAC/IBAC, refus explicite via PermissionDirecte) +
      diagramme de classes Serveurs-Conteneurs
- [x] 3.4 Comportements cles : etat-transition publication,
      etat-transition connectivite serveur, sequence resolution de
      permission, sequence connexion d'un nouveau serveur, sequence
      deploiement (automatique/manuel)
- [x] Verifier noms de fichiers images sans accent dans
      `assets/diagrams/` (ex: diagramme sequence resolution permission
      mal nomme a la source, corrige en `03-diagramme_seq_resolution_permission.png`
      dans le texte final)
- [ ] Relecture finale du chapitre par Josue

## Chapitre "Implementation" (chapitre 4 reel)

- [x] Canevas de chapitre (lettrine + paragraphe + minisommaire)
- [x] 4.1 Environnement et outils de developpement : justification par
      contrainte de conception (pas de comparatif avec alternatives),
      3 tableaux (backend/frontend/outils transverses) avec logos,
      logos manquants signales explicitement (SQLAlchemy, Alembic,
      Pydantic, TypeScript, Tailwind, Nginx, Certbot)
- [x] 4.2 Methodologie de travail : cycle audit -> plan ->
      implementation -> test (redige au style impersonnel, sans "je"),
      traçabilite des decisions (D-XX/B-XX/S-NN), continuite entre
      sessions, note finale sur l'usage d'un assistant IA
- [x] 4.3 Realisations par module (5 modules, niveau technique avec
      mecanismes concrets sans extrait de code, structure en listes) :
      Serveurs/Conteneurs, Deploiement continu, Publication applicative,
      Supervision continue, RBAC/IBAC dynamique - source : TODO du code
      et scan_structure.txt du projet
- [x] 4.4 Difficultes rencontrees et solutions apportees (restructure en
      listes constat/solution) : absence d'environnement de test
      representatif (VPS Hostinger + VM VirtualBox), montee en charge du
      perimetre en cours de stage, remise en cause du modele RBAC fige,
      coordination de plusieurs systemes externes
- [x] 4.5 Deploiement : diagramme de deploiement generique (portable,
      sans specificite d'hebergeur), procedure pas a pas avec commandes
      (clonage, verification des ports, configuration Nginx, demarrage
      de la stack, verification locale, test du nom de domaine),
      redeploiement continu (CI/CD + script de secours)
- [x] Verifier noms de fichiers images sans accent dans
      `assets/diagrams/`
- [ ] Relecture finale du chapitre par Josue

## Chapitre "Resultats et bilan"

- [x] Resultats obtenus
- [x] Workflows (diagrammes d'activite)
- [x] Captures d'ecran de l'application AGT Infra
- [x] Limites actuelles et perspectives (backup, montee en charge
      automatique, securite active, generalisation IBAC, resilience et
      point unique de defaillance pour MboaPay)
- [x] Section risques et plans de contournement (source : cahier des
      charges, table des risques)
- [ ] Relecture finale du chapitre par Josue

## Bibliographie

- [x] 3 sources techniques initiales (FastAPI, SQLAlchemy, Netdata)
- [x] 17 sources ajoutees pour le chapitre Etat de l'art
- [ ] Completer au fil de la redaction des chapitres suivants

## Conclusion generale

- [x] Rappel du contexte et de la demarche
- [x] Bilan du projet (liste des domaines realises + limites assumees)
- [x] Competences techniques developpees (liste)
- [x] Bilan personnel (methode de travail, remise en question, travail
      en equipe) - contenu fourni par Josue
- [x] Apport pour le projet professionnel (confirmation orientation
      DevOps/SecOps, decouverte du platform engineering) - contenu
      fourni par Josue
- [ ] Relecture finale par Josue

## Annexes

- [x] Annexe A : 3 extraits de code representatifs, choisis pour
      illustrer des mecanismes deja modelises dans le rapport plutot que
      du code arbitraire :
  - [x] Orchestration des phases de deploiement + rollback automatique
        (deployment_engine.py, _build_steps + boucle d'execution)
  - [x] Synchronisation Git idempotente (deployment_phases.py,
        run_git_sync_phase, capture PREV_COMMIT)
  - [x] Resolution d'une permission, refus explicite prioritaire
        (deps.py, check_permission, 5 etapes alignees sur le diagramme
        de sequence du chapitre 3)
- [ ] Annexe B : demonstration video (lien(s) YouTube d'AGT Infra), en
      attente de publication de la video par Josue

## Relecture finale (a faire en dernier)

- [ ] Recherche globale des `% TODO` restants dans le projet
- [ ] Verification des renvois internes (`\ref{}`, `\label{}`)
- [ ] Verification liste des figures / tableaux / abreviations completes
- [ ] Coherence des temps verbaux et de la terminologie technique
- [ ] Export final version imprimable (`\modeimpressiontrue`) si necessaire

---

## Notes de session

- 2026-09-03 : squelette LaTeX initialise, compilation validee
  (probleme d'ordre de chargement des packages corrige), bibliographie
  testee. Chapitre 3 (Etat de l'art) redige integralement avec recherche
  web a jour (2025-2026) sur Portainer, Rancher, Proxmox VE, Cockpit,
  Ansible AWX/Semaphore, Coolify.
- 2026-09-03 (suite) : Chapitre 1 redige integralement (sections 1.1 et
  1.2), a partir du contenu reel fourni par Josue (copie du site
  ag-technologies.tech) et des precisions sur l'environnement technique
  avant AGT Infra. Dates de stage integrees dans
  `config/03_metadonnees.tex`. Regle 17 reformulee pour figer le canevas
  de chapitre (lettrine + paragraphe de presentation avant
  `\minisommaire`), applique retroactivement au chapitre 1.
- 2026-09-03 (suite) : Decision de supprimer l'ancien chapitre 2
  ("Contexte et problematique") et de fusionner son contenu dans
  l'introduction generale, sous deux titres non numerotes ("Contexte et
  problematique", "Structure du rapport"). Contenu source par le cahier
  des charges v2. `main.tex` mis a jour (retrait de l'`\include` du
  chapitre 2). Fichier `chapters/02_contexte_problematique.tex` a
  supprimer manuellement par Josue (orphelin, plus inclus dans la
  compilation).
- 2026-09-04 : Audit et refonte du squelette du rapport (voir section
  "Squelette du rapport" ci-dessus). Section 3.1 (Analyse des besoins)
  redigee integralement. Diagrammes de contexte et cas d'utilisation
  construits sous draw.io, compilation verifiee (latexmk, build a jour).
- 2026-09-04 (suite) : Chapitre 3 (Analyse et conception) redige
  integralement, sections 3.2 a 3.4. Neuf diagrammes construits sous
  draw.io a partir du cahier des charges (architecture globale, package,
  2 diagrammes de classes, 2 etats-transition, 3 sequences). Point de
  vigilance signale : coherence des noms de fichiers image (accents a
  eviter) entre `assets/diagrams/` et les `\includegraphics` du texte.
  Prochaine session : Chapitre "Implementation" (4.1 Environnement et
  outils de developpement, choix technologiques justifies a posteriori).

- 2026-09-04 (suite) : Chapitre 4 (Implementation) redige integralement,
  sections 4.1 a 4.5. Logos de technologies integres (conversion SVG a
  prevoir en PNG/PDF pour compatibilite pdfLaTeX, signalee explicitement).
  Section 4.3 (Realisations par module) construite a partir du TODO reel
  du code et de scan_structure.txt fournis par Josue, plutot que du
  cahier des charges seul, pour refleter l'etat d'avancement reel.
  Section 4.4 recadree suite a discussion : distinction entre bugs
  corriges (hors propos) et vraies difficultes de stage (environnement
  de test, perimetre evolutif, refonte RBAC, coordination de systemes
  externes). Diagramme de deploiement redessine en version generique et
  portable, a partir du guide de deploiement reel du VPS Hostinger, sans
  reprendre ses details specifiques (hostname, ports, utilisateur).
  Chapitre 4 entierement boucle.
  Prochaine session : Chapitre "Resultats et bilan" (resultats obtenus,
  workflows/diagrammes d'activite, captures d'ecran, tests et
  validation, limites/perspectives, section risques).

- 2026-09-10 : Ajout des sections liminaires manquantes : Resume
  (francais) et Abstract (anglais), chacun avec mots-cles, rediges par
  synthese du rapport existant, sans fait nouveau. Glossaire de termes
  ajoute (distinct de la liste d'abreviations existante), 19 entrees
  definies a partir d'un modele fourni par Josue, avec correction d'une
  entree obsolete ("Role") pour rester coherent avec la refonte RBAC/IBAC
  dynamique deja actee aux chapitres 3 et 4 (jeu de roles fixes remplace
  par un seul role immuable, le reste compose librement). `main.tex` mis
  a jour (front/resume, front/abstract, front/glossaire, glossaire_termes).
  Annexe A redigee integralement : 3 extraits de code representatifs
  fournis par Josue (deployment_engine.py, deployment_phases.py,
  deps.py), choisis pour illustrer des mecanismes deja modelises dans le
  rapport (sequence de phases + rollback, synchronisation Git idempotente,
  algorithme de resolution de permission deny-first). Annexe B laissee en
  attente (video de demonstration non encore publiee par Josue).
  **Rapport complet, y compris pages liminaires et annexes, a l'exception
  de l'annexe B (video) et de la relecture finale.**
  Prochaine session : relecture finale complete (voir section dediee),
  puis integration du lien video en annexe B des sa publication.