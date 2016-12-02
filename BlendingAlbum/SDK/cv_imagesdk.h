/********************************************
 *  Author: Yuheng Chen, chyh1990@gmail.com
 *  Date:   14.02.2014
 *******************************************/
#ifndef CV_INTERFACE_IMAGESDK_H
#define CV_INTERFACE_IMAGESDK_H

/*!
 * \file cv_imagesdk.h
 * \author Yuheng Chen (chyh1990@gmail.com)
 * \date 2014.2.14
 */

#include "cv_common_internel.h"

//>> CONFIG_IMAGE_SDK_API_CURVE_ADJUST

enum CV_CURVE_ADJ_TYPE {
	CV_CURVE_ADJ_INVERSE,	///< 对图像进行取反色处理
	CV_CURVE_BRIGHT,	/// 变亮
	CV_CURVE_DIM,		/// 降低亮度
	CV_CURVE_CONTRAST,	/// 增对比度
	CV_CURVE_REDUCECONTRAST,	// 减对比度
};
/// @brief 对图片曲线进行调整，调节亮度或对比度
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// @param kind 进行变换的类型
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// out 输出图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
CV_SDK_API
cv_result_t cv_imagesdk_curve_adjustment(
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
	enum CV_CURVE_ADJ_TYPE kind
);

//>> CONFIG_IMAGE_SDK_API_GAMMA_CORRECT

/// @brief 对图片进行Gamma校正
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// @param gamma Gamma参数
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// out 输出图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
CV_SDK_API
cv_result_t cv_imagesdk_gamma_correct(
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
	float gamma);

//>> CONFIG_IMAGE_SDK_API_COLOR_TRANSFER

/// @brief 将src图片的色调换成target图片的色调
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// src 输入待调色图片， 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// target 输入目标色调图片，支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与src一致
/// mask 输入掩码图片，支持yuv,nv12,nv21,bgra,bgr，gray格式， 推荐gray格式， 宽高必须与src一致
/// out 输出图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
CV_SDK_API
cv_result_t cv_imagesdk_naive_color_transfer(
	unsigned char *img_src, cv_pixel_format fmt_src, int w_src, int h_src, int s_src,
	unsigned char *img_target, cv_pixel_format fmt_target, int w_target, int h_target, int s_target,
	unsigned char *img_mask, cv_pixel_format fmt_mask, int w_mask, int h_mask, int s_mask,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out,int s_out);

//>> CONFIG_IMAGE_SDK_API_GAUSSIAN_BLUR

/// @brief 对图片进行高斯模糊处理
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// out 输出图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
/// @param diam 直径，数值越大则图像越模糊，但会增加运行时间
/// @param sigma 方差，数值越大则图像越模糊，不会增加运行时间
CV_SDK_API
cv_result_t cv_imagesdk_gaussian_blur(
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
	int diam, float sigma);

//>> CONFIG_IMAGE_SDK_API_MINMAX_FILTER

enum CV_MINMAX_FILTER_TYPE {
	CV_MINMAX_FILTER_MIN,	///< 在最大最小值滤波中使用最小
	CV_MINMAX_FILTER_MAX, 	///< 在最大最小值滤波中使用最大
};
/// @brief 对图片进行最小值或者最大值滤波
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持gray格式
/// out 输出图像 支持gray格式， 宽高必须与输入一致
/// @param type 进行滤波的类型，可以选择CV_MINMAX_FILTER_MIN和CV_MINMAX_FILTER_MAX
/// @param width 滤波半径
CV_SDK_API
cv_result_t cv_imagesdk_minmax_filter(
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
	enum CV_MINMAX_FILTER_TYPE type, int width);

//>> CONFIG_IMAGE_SDK_API_PHOTO_QUALITY

typedef struct {
	double non_zero_percent;	///< 非空比例
	double clarity_contrast;	///< 清晰对比程度， 暂时无效
	double simplicity;		///< 简单程度[FIX ME]
	double dark;			///< 暗度
	double sharpness;		///< 锐度
} cv_imagesdk_photo_quality_t;

/// @brief 对图片质量进行评分
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// @param quality 指向保存评分结果的指针，空间由用户分配，该参数不能为NULL
CV_SDK_API
cv_result_t cv_imagesdk_photo_quality(
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	cv_imagesdk_photo_quality_t *quality);

//>> CONFIG_IMAGE_SDK_API_AFFINE_ESTIMATE

/// @brief 快速匹配两张图片的位移
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// a 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// b 输入图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式，宽高与a一致
/// @param plist 返回指向结果数组的指针
/// @param out_len 返回输出点的个数
CV_SDK_API
cv_result_t cv_imagesdk_affine_estimate(
	unsigned char *img_a, cv_pixel_format fmt_a, int w_a, int h_a, int s_a,
	unsigned char *img_b, cv_pixel_format fmt_b, int w_b, int h_b, int s_b,
	cv_pointi_t **plist, int *out_len);
/// @brief 释放affine的结果
/// @param plist affine的结果数组指针
CV_SDK_API
void cv_imagesdk_release_affine_result(
	cv_pointi_t *plist);

//>> CONFIG_IMAGE_SDK_API_FAST_PATCH_MATCH

/// @brief 对于图上每个patch找最相似的另一个patch
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// @param ann 输出相对应的点数组，由用户分配
/// @param patch_w patch的宽度，必须是2^k,且>4
/// @param non_local 最小距离，为x和y方向距离绝对值之和
CV_SDK_API
cv_result_t cv_imagesdk_fast_patch_match(
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	cv_pointi_t *ann, int patch_w, float non_local);


//>> CONFIG_IMAGE_SDK_API_MAGIC_COLOR

#define CV_MAGIC_COLOR_NHIST 4 ///< MagicColor RGB直方图维数

/// @brief 将图中选中的颜色保留，其他颜色转换成灰度色
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// out 输出图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
/// @param hist 用于指定对应的颜色是否被选中保留
CV_SDK_API
cv_result_t cv_imagesdk_magic_color(
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
	int hist[CV_MAGIC_COLOR_NHIST][CV_MAGIC_COLOR_NHIST][CV_MAGIC_COLOR_NHIST]);

//>> CONFIG_IMAGE_SDK_API_RGBA_TO_GRAY

/// @brief 对彩色图转换成灰度图
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr,gray格式
/// out 输出图像 支持gray格式， 宽高必须与输入一致
CV_SDK_API
cv_result_t cv_imagesdk_rgba_to_gray(
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out
);

//>> CONFIG_IMAGE_SDK_API_SMART_CONTRAST

/// @brief 对图片的对比度进行智能处理
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// out 输出图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
/// @param matting 是否进行matting操作，0不进行，输出结果画质较低，消耗时间短；1则进行matting，画质较高，但是花费更多时间
CV_SDK_API
cv_result_t cv_imagesdk_smart_contrast(
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
	bool matting
);

//>> CONFIG_IMAGE_SDK_API_DETAIL_ENHANCE

/// @brief 对图片进行细节增强
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// out 输出图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
CV_SDK_API
cv_result_t cv_imagesdk_detail_enhance(
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out
);

//>> CONFIG_IMAGE_SDK_API_FAST_DENOISE

/// @brief 快速去除图片中的噪声
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// out 输出图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
/// @param sigma 平滑参数，数值越大图像也将越模糊，典型值为50
CV_SDK_API
cv_result_t cv_imagesdk_fast_denoise(
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
	float sigma
);

//>> CONFIG_IMAGE_SDK_API_GRABCUT

/// @brief 能够从图像中分割出前景
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// mask 掩码图像,用于输入和输出 支持yuv,nv12,nv21,bgra,bgr,gray格式， 推荐gray格式， 宽高必须与in一致
/// @param rect 用于限定进行分割图像范围的矩形区域
CV_SDK_API
cv_result_t cv_imagesdk_grabcut(
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_mask, cv_pixel_format fmt_out, int w_mask, int h_mask, int s_mask,
	cv_rect_t rect
);

//>> CONFIG_IMAGE_SDK_API_AUTOCOLOR
/// @brief 对图像做自动白平衡处理
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// out 输出图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
/// @param whitebalance 是否做白平衡(true or false)
/// $param brightadjust 是否做亮度调节(true or false)
CV_SDK_API
cv_result_t cv_imagesdk_autocolor(
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
	bool whitebalance, bool brightadjust);

//>> CONFIG_IMAGE_SDK_API_DEHAZE

//image sdk begin

/// @brief 图像曝光情况，可根据实际场景设置，设置为CV_LIGHT_NORMAL可满足大多数场景
enum CV_LIGHT_TYPE {
	CV_LIGHT_NORMAL,   ///< 正常亮度
	CV_LIGHT_LOW_LIGHT,///< 低亮度, 暂时无效
	CV_LIGHT_BACK_LIGHT///< 背光拍照
};

/// @brief 对图像做去雾处理
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// out 输出图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
/// @param thickness 预估输入图像雾气浓度(0-1)，可根据实际场景调节，设为1可满足大多数场景
/// @param type 输入图像曝光情况
CV_SDK_API
cv_result_t cv_imagesdk_dehaze(
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
	float thickness, enum CV_LIGHT_TYPE type);

//>> CONFIG_IMAGE_SDK_API_NIGHT_ENHANCE

/// @brief 对图片进行夜视增强,智能增强图像中比较暗的部分
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// out 输出图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
/// @param strength 亮度提升强度，根据实际场景调节，范围0-1,推荐使用0.5
/// @param matting 是否进行matting操作，0不进行，输出结果画质较低，消耗时间短；1则进行matting，画质较高，但是花费更多时间
CV_SDK_API
cv_result_t cv_imagesdk_night_enhance(
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
	float strength, bool matting
);

//>> CONFIG_IMAGE_SDK_API_PENCILSKETCH

/// @brief 对图像做铅笔画处理
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// tex 输入纹理图像  支持yuv,nv12,nv21,bgra,bgr，gray格式， 推荐gray格式
/// out 输出图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
/// @param length 画笔的长度(0-35), 推荐17
/// @param edgeStyle 边缘风格 0 现实风格 1 艺术风格，推荐1
/// @param bcolor 图像颜色 0 灰度图 1 彩色图， 推荐1
CV_SDK_API
cv_result_t cv_imagesdk_pencilsketch(
	unsigned char* img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char* img_tex, cv_pixel_format fmt_tex, int w_tex, int h_tex, int s_tex,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
	int length, int edgeStyle, bool bcolor
);

//>> CONFIG_IMAGE_SDK_API_UPSCALE
/// @brief 对图像做超分辨率处理
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// out 输出图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须等于输入宽高*放大倍数
/// @param zoomFactor 放大的倍数(0-3)，典型值2.0
/// @param lambda 优化强度(1-2),典型值2.0
/// @param max_iter 优化次数(1-3),典型值1
/// @param bsharp 是否锐化(true or false)
CV_SDK_API
cv_result_t cv_imagesdk_upscale(
	unsigned char*img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
	float zoomFactori, float lambda, int max_iter, bool sharp);

//>> CONFIG_IMAGE_SDK_API_MPEG_BLOCK_REMOVAL

/// @brief 去除视频图像中的MPEG块状效应
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// out 输出图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
/// @param strength 用来控制输出图像光滑的程度(0-1),建议设为0.5
CV_SDK_API
cv_result_t cv_imagesdk_mpeg_block_removal(
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
	float strength
);

//>> CONFIG_IMAGE_SDK_API_SHARPEN

/// @brief 对图像做锐化处理
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// out 输出图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
/// @param amount 用来控制图像锐化的程度(0-2)
CV_SDK_API
cv_result_t cv_imagesdk_sharpen(
	unsigned char*img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
	float amount
);

//>> CONFIG_IMAGE_SDK_API_POSSION_BLEND

/// @brief 将两张图片进行泊松融合，输入的背景图、前景图和mask图片的宽高都必须相同
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// bg 输入待融合的背景图片  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// fg 输入待融合的前景图片 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与bg一致
/// mask 输入掩码图像  支持yuv,nv12,nv21,bgra,bgr，gray格式， 推荐gray格式，宽高必须与bg一致
/// out 输出图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与bg一致
CV_SDK_API
cv_result_t cv_imagesdk_possion_blending(
	unsigned char *img_bg, cv_pixel_format fmt_bg, int w_bg, int h_bg, int s_bg,
	unsigned char *img_fg, cv_pixel_format fmt_fg, int w_fg, int h_fg, int s_fg,
	unsigned char *img_mask, cv_pixel_format fmt_mask, int w_mask, int h_mask, int s_mask,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out);

//>> CONFIG_IMAGE_SDK_API_CLASSIFY

/// @brief 创建图像分类句柄
/// @param[in] model 载入cnn模型
/// @param[out] handle 输出已初始化的图像分类句柄所在地址
/// @return 成功返回CV_OK, 否则返回错误类型
CV_SDK_API cv_result_t
cv_common_classifier_cnn_create(
	cv_model_t model,
	cv_handle_t *handle
);

/// @brief 图像分类
/// @param[in] handle 已初始化的图像分类句柄
/// @param[in] image 输入图片的图像数据, 不支持灰度图像, 推荐BGR格式
/// @param[out] scores 置信度数组, sdk内部分配, 需要调用 cv_classifier_cnn_release_result() 释放
/// @param[out] scores_count 置信度数组的个数
CV_SDK_API
cv_result_t
cv_common_classifier_cnn_classify(
	cv_handle_t handle,
	const cv_image* image,
	cv_classifier_result_t **scores,
	int *scores_count
);

/// @brief 根据id获取标签代表的类名
/// @param[in] handle 已初始化的图像分类句柄
/// @param[in] idx 输入标签号
/// @param[out] name 标签名称(utf8格式)
CV_SDK_API cv_result_t
cv_common_classifier_cnn_get_labelname(
	cv_handle_t handle,
	int idx,
	char name[256]
);

/// @brief 过滤置信度过低的类别
/// @param[in] handle 已初始化的图像分类句柄
/// @param[in] scores 输入置信度数组, sdk内部分配分类, 需要调用 cv_classifier_cnn_release_result() 释放
/// @param[in] scores_count 输入置信度数组的个数
/// @param[out] labels 输出类别数组, sdk内部分配, 需要调用 cv_classifier_cnn_release_result() 释放
/// @param[out] labels_num 输出类别数目
CV_SDK_API cv_result_t
cv_common_classifier_cnn_filter(
	cv_handle_t handle,
	cv_classifier_result_t *scores,
	int scores_count,
	cv_classifier_result_t **labels,
	int *labels_num
);

/// @brief 释放置信度数组
/// @param[in] labels 类别数组
/// @param[in] labels_num 类别数目
CV_SDK_API  void
cv_common_classifier_cnn_release_result(
	cv_classifier_result_t *labels,
	int labels_num
);

/// @brief 销毁图像分类句柄
/// @param[in] handle 已初始化的图像分类句柄
CV_SDK_API void
cv_common_classifier_cnn_destroy(
	cv_handle_t handle
);

CV_SDK_API cv_result_t
cv_common_classify_load_model(
    const char *file,
    cv_model_t *model
);

CV_SDK_API void
cv_common_classify_unload_model(
    cv_model_t m
);

//>> CONFIG_IMAGE_SDK_API_FEATURE

/// @brief 提取图像特征，返回特征数据长度，可以把返回数组编码成字符串后存储起来以便以后使用
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// @param p_feature 特征数据，需要调用cv_verify_release_feature函数释放
/// @param feature_blob_size 可以是NULL；如果不为NULL,返回p_feature指向空间的大小，与cv_feature_header_t中的len相同
CV_SDK_API cv_result_t
cv_imagesdk_get_feature(
	const unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	cv_feature_t **p_feature, unsigned int *feature_blob_size
);

/// @brief 特征信息编码成字符串，编码后的字符串用于保存
/// @param feature 输入的特征信息
/// @param feature_str 输出的编码后的字符串,由用户分配和释放
CV_SDK_API cv_result_t
cv_imagesdk_serialize_feature(
	const cv_feature_t *feature,
	char *feature_str
);


/// @brief 解码字符串成特征信息
/// @param feature_str 输入的待解码的字符串，api负责分配内存，需要调用cv_imagesdk__release_feature释放
CV_SDK_API cv_feature_t *
cv_imagesdk_deserialize_feature(
	const char *feature_str
);

/// @brief 图像验证
/// @param feature1 第一张图像特征信息
/// @param feature2 第二张图像特征信息
/// @param score 图像验证相似度得分
CV_SDK_API cv_result_t
cv_imagesdk_compare_feature(
	const cv_feature_t *feature1,
	const cv_feature_t *feature2,
	float *score
);

/// @brief 释放提取图像特征时分配的空间
/// @param feature 提取到的图像特征信息
CV_SDK_API void
cv_imagesdk_release_feature(
	cv_feature_t *feature
);

//>> CONFIG_IMAGE_SDK_API_TONE
/// @brief 创建图像色调调整句柄
/// @param model_path 模型路径
CV_SDK_API cv_handle_t
cv_imagesdk_create_imagetone(
	const char* model_path);

/// @brief 对图像做色调调整处理
/// @param tone_handle已初始化的图像色调调整句柄
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// out 输出图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
/// @param strength 滤镜效果强度，根据实际场景调节，范围0-1,推荐使用1.0
CV_SDK_API cv_result_t
cv_imagesdk_imagetone(
	cv_handle_t tone_handle,
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
    float strength, int numThreads);

/// @brief 对图像做色调调整处理
/// @param tone_handle已初始化的图像色调调整句柄
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持bgra,rgba格式
/// out 输出图像 支持bgra,rgba格式， 宽高必须与输入一致
/// @param strength 滤镜效果强度，根据实际场景调节，范围0-1,推荐使用1.0
CV_SDK_API cv_result_t
cv_imagesdk_imagetone_yuv(
	cv_handle_t tone_handle,
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
    float strength, int numThreads);

/// @brief 对图像做融合调整处理
/// @param *Img 图片的数据数组
/// orgImg 输入原始图像  支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// fullImg 输入尺度为最大值时的图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
/// blendImg 融合后的图像 支持yuv,nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
/// @param lenght 图像数据数组的大小, 输入和输出的必须是一致
/// @param strength 滤镜效果强度，根据实际场景调节，范围0-1,推荐使用1.0
CV_SDK_API cv_result_t
cv_imagesdk_blending(
        cv_handle_t tone_handle,
        unsigned char *orgImg, unsigned char *fullImg, unsigned char *blendImg, const int lenght, const float strength);

/// @brief 对图像做BGRA空间转换
/// @param img 图片的数据数组
/// @param length 图像数据数组的大小
/// @param nChannels 输入图像通道数，这里要求必须为4
CV_SDK_API
cv_result_t
cv_imagesdk_changeBGRAspace(
    unsigned char *img, int length, int nChannels);

/// @brief 释放图像色调调整句柄
/// @param tone_handle已初始化的图像色调调整句柄
CV_SDK_API void
cv_imagesdk_destroy_imagetone(
	cv_handle_t tone_handle);

//>> CONFIG_IMAGE_SDK_API_DYNAMIC_TONE
/// @brief 创建图像色调调整句柄
/// @param model_path 模型路径
CV_SDK_API cv_handle_t
cv_imagesdk_create_dynamic_imagetone(
	const char* model_path);

/// @brief 对图像做色调调整处理(GPU)
/// @param tone_handle已初始化的图像色调调整句柄
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// out 输出图像 支持nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
/// @param strength 滤镜效果强度，根据实际场景调节，范围0-1,推荐使用1.0
/// @param start 调节每一行中滤镜处理开始的位置，根据实际场景调节，范围0-1,推荐使用1.0
/// @param end 调节每一行中滤镜处理结束的位置，根据实际场景调节，范围0-1,推荐使用1.0
CV_SDK_API cv_result_t
cv_imagesdk_dynamic_imagetone_buffer(
	cv_handle_t tone_handle,
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
    float strength, float start, float end);

/// @brief 对图像做色调调整处理(GPU) 此接口针对不在opengl环境中执行函数的用户
/// @param tone_handle已初始化的图像色调调整句柄
/// @param img_* 图片的数据数组
/// @param fmt_* 图片的类型
/// @param w_* 图片的宽度(以像素为单位)
/// @param h_* 图片的高度(以像素为单位)
/// @param s_* 图片的跨度（以字节计算）
/// in 输入图像  支持nv12,nv21,bgra,bgr格式， 推荐bgr格式
/// out 输出图像 支持nv12,nv21,bgra,bgr格式， 推荐bgr格式， 宽高必须与输入一致
/// @param strength 滤镜效果强度，根据实际场景调节，范围0-1,推荐使用1.0
/// @param start 调节每一行中滤镜处理开始的位置，根据实际场景调节，范围0-1,推荐使用1.0
/// @param end 调节每一行中滤镜处理结束的位置，根据实际场景调节，范围0-1,推荐使用1.0
CV_SDK_API cv_result_t
cv_imagesdk_dynamic_imagetone_picture(
	cv_handle_t tone_handle,
	unsigned char *img_in, cv_pixel_format fmt_in, int w_in, int h_in, int s_in,
	unsigned char *img_out, cv_pixel_format fmt_out, int w_out, int h_out, int s_out,
    float strength, float start, float end);

/// @brief 对图像做色调调整处理(GPU) 
/// @param tone_handle已初始化的图像色调调整句柄
/// @param textureid_* 纹理id,仅支持RGBA纹理
/// @param image_width 图片的宽度(以像素为单位)
/// @param image_height 图片的高度(以像素为单位)
/// @param strength 滤镜效果强度，根据实际场景调节，范围0-1,推荐使用1.0
/// @param start 调节每一行中滤镜处理开始的位置，根据实际场景调节，范围0-1,推荐使用1.0
/// @param end 调节每一行中滤镜处理结束的位置，根据实际场景调节，范围0-1,推荐使用1.0
CV_SDK_API cv_result_t
cv_imagesdk_dynamic_imagetone_texture(
	cv_handle_t tone_handle,
    unsigned int textureid_src,
    int image_width, int image_height,
    unsigned int textureid_dst,
    float strength, float start, float end);

/// @brief 释放图像色调调整句柄
/// @param tone_handle已初始化的图像色调调整句柄
CV_SDK_API void
cv_imagesdk_destroy_dynamic_imagetone(
	cv_handle_t tone_handle);


//>> CONFIG_API_END__

#endif /* end of include guard: CV_IMAGESDK_H */
