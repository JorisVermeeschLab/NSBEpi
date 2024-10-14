# NSBEpi <br />Nanopore sequencing-based episignature detection

This repository provides instructions for extracting episignatures from Nanopore bedMethyl files and using SVMs for sample classification. It includes scripts for training SVMs on methylation data and classifying samples based on disease-specific episignatures associated with developmental disorders. The pipeline facilitates automated episignature detection, supporting both research and clinical diagnostics.

# Instructions for usage

## Running the Pipeline on Publication Data

To test the SVM classifier with the provided [data/supplementary](data/methylation_data_illumina_nanopore_samples_controls.xlsx), run the [SVM_read_excel.ipynb](SVM_read_excel.ipynb) notebook with Jupyter Notebook, VS Code or Google Colab.


## Running the Pipeline on External Data

To process external data through the NSBEpi pipeline, follow these steps. Ensure all necessary dependencies are installed before proceeding.

### Prerequisites

- **Bedtools**: Bedtools is required for the extraction of episignature loci.


### Step 1: Preprocess bedmethyl Files

1. In the folder containing your bedmethyl (NON STRAND SPECIFIC) files, first run the [`remove_extra_col.sh`](https://github.com/JorisVermeeschLab/NSBEpi/blob/main/bed_processing_episignature_extraction/bedmethyl_processing/remove_extra_col.sh) script to remove unnecessary columns. This will retain only the first 11 columns.

   Navigate to the folder containing the `remove_extra_col.sh` script:
   ```bash
   cd NSBEpi/bed_processing_episignature_extraction/bedmethyl_processing/
   ```

2. Run the script:
   ```bash
   ./remove_extra_col.sh <path_to_bedmethyl_files>
   ```

3. **(Optional)** If your bedmethyl files have chromosome annotations with the `chr` prefix (e.g., `chr1`, `chr2`, etc.), you need to run the [`remove_chr.sh`](https://github.com/JorisVermeeschLab/NSBEpi/blob/main/bed_processing_episignature_extraction/bedmethyl_processing/remove_chr.sh) script to remove this prefix.

   In the `remove_chr.sh` script, set the `input_folder` path to the directory containing your bedmethyl files:
   ```bash
   # path to folder with bedmethyl files
   input_folder="/path/to/your/bedmethyl/files"
   ```

4. Run the script:
   ```bash
   ./remove_chr.sh
   ```

   The output files will have the same basename as the input files, but with `_noChr` added before the `.bed` extension. **Before proceding to the next step, move the new files into a separate directory**

   **Example**:
   If your input file is `sample1.bed`, the output file will be `sample1_noChr.bed`.

5. After preprocessing the bedmethyl files, you are ready to proceed to the next step.

### Step 2: Extract Episignature-Specific Loci

Once your bedmethyl files are preprocessed, use the [`extract_episignatures.sh`](https://github.com/JorisVermeeschLab/NSBEpi/blob/main/bed_processing_episignature_extraction/episignature_extraction/extract_episignatures.sh) script to extract episignature loci.

1. Navigate to the directory containing the `extract_episignatures.sh` script:
   ```bash
   cd NSBEpi/bed_processing_episignature_extraction/episignature_extraction/
   ```

2. Modify the `extract_episignatures.sh` script to set your file paths:
   - **`group1_path`**: Set this to the path of the folder containing the episignature loci files from [hg38_episignature_cordinates](https://github.com/JorisVermeeschLab/NSBEpi/tree/main/hg38_episignature_cordinates).
   - **`group2_path`**: Set this to the path of the folder containing your preprocessed bedmethyl files.
   - **`output_folder`**: Set the name of the output folder where the results will be saved.

   Example:
   ```bash
   # path to bed files containing the episignature loci (hg38_episignature_cordinates)
   group1_path="../hg38_episignature_cordinates"
   # path to nanopore bedmethyl files
   group2_path="/path/to/your/bedmethyl/files"
   # name of the output directory
   output_folder="episignature_output"
   ```

3. Run the script:
   ```bash
   ./extract_episignatures.sh
   ```

   This script will extract episignature-specific loci from your bedmethyl files and save the results in the specified `output_folder`.

### Step 3: SVM Training and Sample Classification

1. After extracting the episignatures, the user needs to run the Python notebook [`SVM_read_from_bed.ipynb`](https://github.com/JorisVermeeschLab/NSBEpi/blob/main/SVM_read_from_bed.ipynb).

2. The notebook will first load Illumina-derived episignatures from the file [`no_strand_all_points_dict.pickle`](https://github.com/JorisVermeeschLab/NSBEpi/blob/main/data/no_strand_all_points_dict.pickle), which will be used for training the SVM classifier.

3. The user must then set the path to the bedmethyl files with the extracted episignatures from Step 2. These will be processed further in the notebook.

4. Before proceeding with SVM training and sample classification, users must set the list of sample names for their Nanopore data, ensuring the names are alphabetically ordered. Example:
   ```python
   # list of names of nanopore samples (in alphabetic order)
   new_column_names = ['sample1', 'sample2', 'sample3', 'Control1', 'Control2', 'Control3']
   ```

5. Finish executing the notebook to perform SVM training and get the classification results for each sample.

---
