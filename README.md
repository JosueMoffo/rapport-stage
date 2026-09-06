# Rapport de stage - AGT Infra

Rapport de stage rédigé en LaTeX, documentant la conception et le
développement d'AGT Infra (plateforme interne de gestion d'infrastructure
et de supervision) au sein d'AG Technologies.

---

## Sommaire

- [Prérequis](#prérequis)
- [Compilation](#compilation)
- [Arborescence du projet](#arborescence-du-projet)
- [Points de personnalisation](#points-de-personnalisation)
- [Conventions de rédaction](#conventions-de-rédaction)
- [Limites connues et contournements](#limites-connues-et-contournements)
- [Workflow de rédaction recommandé](#workflow-de-rédaction-recommandé)

---

## Prérequis

- Une distribution LaTeX complète : [TeX Live](https://www.tug.org/texlive/)
  (Linux/Windows) ou [MacTeX](https://www.tug.org/mactex/) (macOS).
- `latexmk` (inclus dans TeX Live/MacTeX).
- `biber` (moteur bibliographique, inclus dans TeX Live/MacTeX).
- Alternative sans installation locale : [Overleaf](https://www.overleaf.com/)
  (voir section Limites connues pour les ajustements nécessaires).

---

## Compilation

Compilation complète (texte + bibliographie + glossaire), PDF généré à la
racine, fichiers auxiliaires isolés dans `build/` :

```bash
mkdir -p build
latexmk -pdf -aux-directory=build main.tex
```

`latexmk` enchaîne automatiquement les passes nécessaires
(`pdflatex` -> `biber` -> `makeglossaries` -> `pdflatex` x2).

Nettoyage des fichiers auxiliaires générés :

```bash
latexmk -c -aux-directory=build
```

**Sur Overleaf :** importer le dossier complet, vérifier que le
compilateur du projet est réglé sur `pdfLaTeX` (Menu > Compiler),
et définir `main.tex` comme fichier maître si nécessaire (Menu > Main
document).

---

## Arborescence du projet

rapport-stage/
├── main.tex # Fichier maître, assemble tout le document
├── glossaire.tex # Acronymes (alimente la liste des abréviations)
├── biblio.bib # Sources bibliographiques
├── scan_structure_raport.sh # Génère un instantané du projet pour l'IA
│
├── config/ # Configuration centralisée (éditer ici en priorité)
│ ├── 00_preambule.tex # Packages, police, bascules (impression/police)
│ ├── 01_couleurs.tex # Palette de couleurs du document
│ ├── 02_styles.tex # Style des titres, en-têtes, blocs de code
│ └── 03_metadonnees.tex # Titre, auteur, tuteurs, dates
│
├── front/ # Pages liminaires
│ ├── page_garde.tex
│ ├── remerciements.tex
│ └── liste_abreviations.tex
│
├── chapters/ # Corps du rapport, un fichier par chapitre
│ ├── 00_introduction.tex
│ ├── 01_presentation_entreprise.tex
│ ├── 02_contexte_problematique.tex
│ ├── 02_etat_art.tex
│ ├── 03_analyse_conception.tex
│ ├── 04_implementation.tex
│ ├── 05_resultats_bilan.tex
│ └── 06_conclusion.tex
│
├── annexes/
│ └── annexe_a.tex
│
└── assets/ # Images, schémas, captures d'écran (à créer)


---

## Points de personnalisation

Toute modification globale doit passer par `config/`, jamais par une
édition directe dans un chapitre.

| Je veux modifier... | Fichier à éditer | Ligne concernée |
|---|---|---|
| La couleur d'accent (titres, liens) | `config/01_couleurs.tex` | `reportprimary` |
| Le titre, l'auteur, les tuteurs | `config/03_metadonnees.tex` | `\rapport...` |
| Le motif ornemental et sa taille (page de garde, en-têtes) | `config/04_ornements.tex` | `\agtOrnCorner`, `\agtOrnSide`, `\agtOrnHeader`, `\agtOrnFooter` |
| Basculer entre Times New Roman réel et clone métrique | `config/00_preambule.tex` | `\usetruetnrtrue/false` |
| Basculer version imprimable (liens noirs) / numérique (liens colorés) | `config/00_preambule.tex` | `\modeimpressiontrue/false` |
| Le style des blocs de code | `config/02_styles.tex` | `\lstdefinestyle{codeagt}` |
| Ajouter un acronyme | `glossaire.tex` | `\newacronym{...}` |
| Ajouter un chapitre | `main.tex` + nouveau fichier dans `chapters/` | `\include{}` |

---

## Conventions de rédaction

- **Un chapitre = un fichier** dans `chapters/`, inclus via `\include{}`
  dans `main.tex`. Ne jamais écrire deux chapitres dans le même fichier.
- **Aucune couleur, police ou métadonnée en dur** dans un chapitre :
  toujours passer par les commandes définies dans `config/`.
- **Images** : à placer dans `assets/`, référencées via
  `\includegraphics{assets/nom_fichier.png}`, toujours accompagnées
  d'un `\caption{}` et d'un `\label{fig:...}`.
- **Extraits de code** : utiliser l'environnement `lstlisting` (style
  `codeagt` déjà configuré), jamais de code collé brut dans le texte.
- **Renvois internes** : utiliser `\label{}` / `\ref{}` (jamais de
  numéro de chapitre/figure écrit en dur, pour rester cohérent si
  l'ordre change).
- **Tableaux à plusieurs colonnes** : privilégier des colonnes à largeur
  fixe (`p{...}`) et des symboles courts avec légende plutôt que du texte
  long, pour éviter tout débordement.
- **Accents français** : toujours utiliser les caractères accentués
  corrects (é, è, à, ù, ç, î, ô), y compris dans les titres de
  chapitre/section.
- **Marqueurs de travail en cours** : chaque section à compléter
  contient un commentaire `% TODO : ...` explicite. Rechercher
  `TODO` dans le projet pour lister le travail restant.

---

## Limites connues et contournements

| Limite | Cause | Contournement déjà en place |
|---|---|---|
| Times New Roman non disponible (Overleaf, Linux sans polices MS) | Police propriétaire Microsoft | `mathptmx` (pdfLaTeX) ou `Liberation Serif` (XeLaTeX) en repli automatique |
| JetBrains Mono non disponible en pdfLaTeX | Police non standard TeX Live | Repli sur `\ttfamily` (police mono par défaut), visuellement proche |
| Compilation glossaire échoue avec un simple `pdflatex` | `makeglossaries` nécessite une passe externe (appel `makeindex`) | Utiliser `latexmk -pdf -aux-directory=build main.tex`, qui gère l'enchaînement complet |
| Figures qui "dérivent" dans le mauvais chapitre | Comportement par défaut de LaTeX avec les flottants | `\FloatBarrier` (package `placeins`) disponible, à insérer en fin de chapitre si besoin |
| Liens colorés gênants à l'impression | `hyperref` avec `colorlinks=true` | Bascule `\modeimpressiontrue` dans `config/00_preambule.tex` |
| Débordement de texte dans un tableau à colonnes larges | `tabularx`/`X` répartit l'espace mais ne force pas la coupure de mots longs | Utiliser `p{...}` (largeur fixe) et des symboles courts |
| `pgfornament` non installé (distribution TeX incomplète) | Package parfois absent d'une installation minimale | Installer via `tlmgr install pgfornament pgf` |
| Compilation plus lente sur la page de garde | Bordure ornementale complète (`\pageborderornament`) génère de nombreux motifs vectoriels | Effet limité à la page de garde uniquement, pas répété sur chaque page (voir `config/04_ornements.tex`) |
| Motif exact du mini-sommaire ou de l'ornement pas conforme aux attentes | Rendu visuel non prévisualisable sans compilation réelle | Compiler et signaler l'erreur ou le rendu à corriger, comme pour toute nouvelle fonctionnalité visuelle |

---

## Workflow de rédaction recommandé

1. Compléter `config/03_metadonnees.tex` (titre exact, noms des tuteurs,
   dates de stage).
2. Rédiger chapitre par chapitre, dans l'ordre du plan (`chapters/00_...`
   à `chapters/07_...`).
3. Compiler régulièrement (`latexmk -pdf -aux-directory=build main.tex`)
   pour détecter les erreurs tôt plutôt qu'à la fin.
4. Exécuter `./scan_structure_raport.sh` en début de nouvelle session IA
   pour transmettre le contexte complet du projet sans le surcharger.
5. Tenir à jour `TODO.md` à la racine du projet à chaque session de
   rédaction.
6. Relecture finale : vérifier l'absence de `% TODO` restants, la
   cohérence des renvois (`\ref{}`), et la bibliographie complète.