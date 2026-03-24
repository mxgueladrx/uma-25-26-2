# Walkthrough — COVID Survey Data Cleaning (Student 40)

## What was done

Completed the existing notebook [Notebook_Limpieza_EncuestaCOVID_ENUNCIADO.ipynb](file:///home/miguel/Desktop/uma-25-26-2/AC1/p1ia/Notebook_Limpieza_EncuestaCOVID_ENUNCIADO.ipynb) by filling in all 24 TODO code cells with working, justified code covering all 12 sections.

### Key decisions and techniques applied

| Section | Techniques | Details |
|---------|-----------|---------|
| **0–1** | Data loading | 120 rows (4681–4800) for student code 40 |
| **3** | Missing normalization | Strip whitespace, empty strings → NaN, "NA"/"N/A"/etc → NaN |
| **5** | Global audit | Duplicates check, suspicious values, numeric-as-text detection |
| **P1** | CP zero-padding, sex normalization, numeric conversion | Created `*_clean` columns; extracted travel indicators |
| **P2** | Ordinal encoding, pet aggregation | Security measures averaged; convivientes fixed ("O"→0, etc) |
| **P3** | Disease counting, comorbidity indicator | Counted diseases per block (34–39); smoking/alcohol ordinal |
| **P4** | Symptom binarization & grouping | Created `numero_sintomas` + respiratory/digestive/neurological |
| **P5** | Vaccine counting, COVID indicators | PCR/antibody binary; vaccine count |
| **7** | Median imputation (age, weight/height by sex), mode (sex) | NaN preserved for binary health vars (informative absence) |
| **8** | IQR + z-score outlier detection | Boxplots/histograms for age, weight, height; correction |
| **9** | IMC, one-hot/ordinal encoding, MinMax/Z-score, discretization | Age groups (OMS), IMC categories, symptom groups |
| **10** | 15-variable model dataset | Justified selection with correlation analysis |

## Deliverables generated

| File | Size | Content |
|------|------|---------|
| [Auditoria_EncuestaCOVID_40.xlsx](file:///home/miguel/Desktop/uma-25-26-2/AC1/p1ia/Auditoria_EncuestaCOVID_40.xlsx) | 17 KB | Column-by-column audit (153 rows) |
| [DatosEncuestaCOVID_limpio_40.xlsx](file:///home/miguel/Desktop/uma-25-26-2/AC1/p1ia/DatosEncuestaCOVID_limpio_40.xlsx) | 38 KB | 120 clean rows with derived columns |
| [DatosEncuestaCOVID_modelo_40.xlsx](file:///home/miguel/Desktop/uma-25-26-2/AC1/p1ia/DatosEncuestaCOVID_modelo_40.xlsx) | 11 KB | 120 rows × 15 variables for modeling |

## Verification

- ✅ Notebook executed end-to-end via `jupyter nbconvert --execute`
- ✅ All 3 Excel files generated with correct sizes
- ✅ `df_limpio`: 120 rows with all cleaned/derived columns
- ✅ `df_modelo`: 120 rows × 15 justified variables
- ✅ `auditoria`: one row per original column with problems/strategies
