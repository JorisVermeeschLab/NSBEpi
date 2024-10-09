# NSBEpi <br />Nanopore sequencing-based episignature detection

## Instructions for usage

To test the SVM classifier with the provided [data/supplementary](data/methylation_data_illumina_nanopore_samples_controls.xlsx), run the [SVM_read_excel.ipynb](SVM_read_excel.ipynb) notebook with Jupyter Notebook, VS Code or Google Colab.


## Running the Pipeline on External Data

To process external data through the NSBEpi pipeline, follow these steps. Ensure all necessary dependencies are installed before proceeding.

### Prerequisites

- **Modkit**: Ensure your BED-methyl files are generated using Modkit.
- **Bedtools**: Bedtools is required for the extraction of episignature loci.

  You can verify the installation by running:
  ```bash
  bedtools --version
  ```

  If not installed, you can install it via:
  ```bash
  sudo apt-get install bedtools
  ```

### Step 1: Preprocess BED-methyl Files

1. In the folder containing your BED-methyl files, first run the [`remove_extra_col.sh`](https://github.com/JorisVermeeschLab/NSBEpi/blob/main/bed_processing_episignature_extraction/bedmethyl_processing/remove_extra_col.sh) script to remove unnecessary columns. This will retain only the first 11 columns.

   Navigate to the folder containing the `remove_extra_col.sh` script:
   ```bash
   cd NSBEpi/bed_processing_episignature_extraction/bedmethyl_processing/
   ```

2. Run the script:
   ```bash
   ./remove_extra_col.sh <path_to_bedmethyl_files>
   ```

3. (Optional) If your BED-methyl files have chromosome annotations with the `chr` prefix (e.g., `chr1`, `chr2`, etc.), you need to run the [`remove_chr.sh`](https://github.com/JorisVermeeschLab/NSBEpi/blob/main/bed_processing_episignature_extraction/bedmethyl_processing/remove_chr.sh) script to remove this prefix.

   In the `remove_chr.sh` script, set the `input_folder` path to the directory containing your BED-methyl files:
   ```bash
   # path to folder with bedmethyl files
   input_folder="/path/to/your/bedmethyl/files"
   ```

4. Run the script:
   ```bash
   ./remove_chr.sh
   ```

   The output files will have the same basename as the input files, but with `_noChr` added before the `.bed` extension.

   **Example**:
   If your input file is `sample1.bed`, the output file will be `sample1_noChr.bed`.

5. After preprocessing the BED-methyl files, you are ready to proceed to the next step.

### Step 2: Extract Episignature-Specific Loci

Once your BED-methyl files are preprocessed, use the [`extract_episignatures.sh`](https://github.com/JorisVermeeschLab/NSBEpi/blob/main/bed_processing_episignature_extraction/episignature_extraction/extract_episignatures.sh) script to extract episignature loci.

1. Navigate to the directory containing the `extract_episignatures.sh` script:
   ```bash
   cd NSBEpi/bed_processing_episignature_extraction/episignature_extraction/
   ```

2. Modify the `extract_episignatures.sh` script to set your file paths:
   - **`group1_path`**: Set this to the path of the folder containing the episignature loci files from [hg38_episignature_cordinates](https://github.com/JorisVermeeschLab/NSBEpi/tree/main/hg38_episignature_cordinates).
   - **`group2_path`**: Set this to the path of the folder containing your preprocessed BED-methyl files.
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

   This script will extract episignature-specific loci from your BED-methyl files and save the results in the specified `output_folder`.

### Step 3: Continue with Further Analysis

Once the extraction is complete, the output files will be in the specified output directory, ready for further analysis with the NSBEpi pipeline.

---
