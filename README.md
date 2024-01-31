**A Motion and Illumination Resistant Non-Contact Method Using Undercomplete Independent Component Analysis and Levenberg-Marquardt Algorithm**
This is an official implementation of U-LMA, and its Negentropy based variant in MATLAB environment.

![U-LMA](https://github.com/guptaankit894/U_LMA/assets/48688147/fb8d7aec-c37f-4ff8-a34a-5d61d80e3396)


This code requires a video of atleast 25 seconds as input and outputs the SNRs and mean heart rate values of both variants i.e., U-LMA, and U-Neg.

To estimate mean HR for both the variants, please run the following code:

[SNR_neg,SNR_LMA,Heart_Rate_neg,Heart_Rate_LMA]=ica_undercomplete('video.avi',ground_truth_HR).

While using this work, please cite it as following:
@article{gupta2022motion,
  title={A motion and illumination resistant non-contact method using undercomplete independent component analysis and Levenberg-Marquardt algorithm},
  author={Gupta, Ankit and Ravelo-Garc{\'\i}a, Antonio G and Dias, Fernando Morgado},
  journal={IEEE Journal of Biomedical and Health Informatics},
  volume={26},
  number={10},
  pages={4837--4848},
  year={2022},
  publisher={IEEE}
}
