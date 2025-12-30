# Human Landmarks

このリポジリは，姿勢推定によってアバターを動作させるトラッキングアプリケーションにおいて，推定結果を定義するためのものです．

以下のアプリケーションとの連携を目的として作成されました．

- [VioletSolver](https://github.com/ec-k/VioletSolver)
- [MediapipeAndKinectInferencer](https://github.com/ec-k/MediapipeAndKinectInferencer)

通常，Proto ファイルのみを各アプリケーションで利用し，それぞれで生成することが考えられます．しかし，その手間を省くため，`Runtime/`ディレクトリには`protoc`で生成されたファイルがあらかじめ格納されており，すぐに利用できる状態になっています．

また，Unity Package Manager (UPM) として利用できるよう，`.meta`ファイルも含まれています．このパッケージをご自身のアプリケーションで利用する際は，[GitDependencyResolverForUnity](https://github.com/mob-sakai/GitDependencyResolverForUnity)の利用を推奨します．

## ビルド方法

`build_proto.ps1`を PowerShell から実行してください．これにより，C# 用のビルド済みファイルが`Runtime`ディレクトリ内に生成・配置されます．

## 動作環境

- Windows 11: 動作確認済み
- その他 OS: 未確認
