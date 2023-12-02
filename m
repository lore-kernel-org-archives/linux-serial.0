Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NB4TNb6I"
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244FAB2
	for <linux-serial@vger.kernel.org>; Fri,  1 Dec 2023 17:02:47 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-280351c32afso2573510a91.1
        for <linux-serial@vger.kernel.org>; Fri, 01 Dec 2023 17:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701478966; x=1702083766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ON7TKe5HRlUXmxrdzzQVwohGw5eKAdzkW1tIPF6YTsU=;
        b=NB4TNb6IY7ZhOfZ5oMWolytwvOLDDzpH6zzVP4BPz1KGWTNXOpO//13euXMPia+8O9
         tjRdsNThvgoZJ5nnD7uTYy21q7aXbuSGiF6ZukSHXW1npHHklMES3ckZgO51elXDBrHo
         xUS2CROcbOyhr1prd7LaoaACVeR7uOfm4g7+o1SMX+j37+BDarG2lFaQ9QMvCOUx22ld
         0RmmFVziO1lpbiCrtXyZ1mlNES+sN0Pq4M92YkRSdnMu2J4yjctKbVDs9StpsjjVaZw+
         YSH3Z1oCor0y2MpYh9QEULZbySoTaFUWV3EwhQnl7vxuZTn8ncEh/ZMv09Kp1A3rb/Hd
         7BUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701478966; x=1702083766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ON7TKe5HRlUXmxrdzzQVwohGw5eKAdzkW1tIPF6YTsU=;
        b=xD1iyF9upM3/OYXZ+uw2P0vPtaiatm+yjAKftVej4RUdfUZdRc7kljlqeMJtxdif7f
         +JqR+0i2sewg8zDTBstjyRgIWagGW0RmhcW1wzS+9yWNPLbvryo0JisqTsJwBibZfMdw
         xz5cofoy4w6ibIwjUxbnLJ4wEgWkyiTjqO0LcfMFzbk1OE3P6VEXzaE+1hJtfDA2v/uO
         lcHVkd7HoIbojIgKT3vyF7/DNyOF8DTF/C2l3cy/8vuSKFB1WPYDTAsbkQhgDFfA64fE
         ojHLvLAJJH4c3ze6x9x4+PO1S/N1wgFDBTt89CdzlJ7rFAdm1UzQaBxKYDhKzg3pgd30
         vzHA==
X-Gm-Message-State: AOJu0YxTMASIv5ECzWIeevZrRgshka3rU71iJtRNLFI/UA9E4cZquQcv
	yiO5EmU4mnh47qYZyMgTEG9rFzQo91y6+oTk14kPvQ==
X-Google-Smtp-Source: AGHT+IEIJQTcxf2fR+Siy6DreRVrtY2OvPfv8TUAGPOb86XUUOoNnIM/iRPTYAZgTV8wPy36xz+rJ2xLVYlHHq85ZnU=
X-Received: by 2002:a17:90a:4385:b0:286:6cc1:781d with SMTP id
 r5-20020a17090a438500b002866cc1781dmr352836pjg.96.1701478966597; Fri, 01 Dec
 2023 17:02:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201160925.3136868-1-peter.griffin@linaro.org> <20231201160925.3136868-17-peter.griffin@linaro.org>
In-Reply-To: <20231201160925.3136868-17-peter.griffin@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 1 Dec 2023 19:02:35 -0600
Message-ID: <CAPLW+4mxzu4d_9i=ouDGtnSRMbhibfBnT5aXhkC4cGEC1bm6Bw@mail.gmail.com>
Subject: Re: [PATCH v5 16/20] watchdog: s3c2410_wdt: Add support for Google
 gs101 SoC
To: Peter Griffin <peter.griffin@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org, 
	tomasz.figa@gmail.com, s.nawrocki@samsung.com, linus.walleij@linaro.org, 
	wim@linux-watchdog.org, linux@roeck-us.net, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, saravanak@google.com, 
	willmcvicker@google.com, soc@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, kernel-team@android.com, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 10:11=E2=80=AFAM Peter Griffin <peter.griffin@linaro=
.org> wrote:
>
> This patch adds the compatibles and drvdata for the Google
> gs101 SoC found in Pixel 6, Pixel 6a & Pixel 6 pro phones.
>
> Similar to Exynos850 it has two watchdog instances, one for
> each cluster and has some control bits in PMU registers.
>
> gs101 also has the dbgack_mask bit in wtcon register, so
> we also enable QUIRK_HAS_DBGACK_BIT.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/watchdog/s3c2410_wdt.c | 47 ++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wd=
t.c
> index 39f3489e41d6..c1ae71574457 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -68,6 +68,13 @@
>  #define EXYNOSAUTOV9_CLUSTER0_WDTRESET_BIT     25
>  #define EXYNOSAUTOV9_CLUSTER1_WDTRESET_BIT     24
>
> +#define GS_CLUSTER0_NONCPU_OUT                 0x1220
> +#define GS_CLUSTER1_NONCPU_OUT                 0x1420
> +#define GS_CLUSTER0_NONCPU_INT_EN              0x1244
> +#define GS_CLUSTER1_NONCPU_INT_EN              0x1444
> +#define GS_CLUSTER2_NONCPU_INT_EN              0x1644
> +#define GS_RST_STAT_REG_OFFSET                 0x3B44
> +
>  /**
>   * DOC: Quirk flags for different Samsung watchdog IP-cores
>   *
> @@ -269,6 +276,30 @@ static const struct s3c2410_wdt_variant drv_data_exy=
nosautov9_cl1 =3D {
>                   QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_CNT_EN,
>  };
>
> +static const struct s3c2410_wdt_variant drv_data_gs101_cl0 =3D {
> +       .mask_reset_reg =3D GS_CLUSTER0_NONCPU_INT_EN,
> +       .mask_bit =3D 2,
> +       .mask_reset_inv =3D true,
> +       .rst_stat_reg =3D GS_RST_STAT_REG_OFFSET,
> +       .rst_stat_bit =3D 0,
> +       .cnt_en_reg =3D GS_CLUSTER0_NONCPU_OUT,
> +       .cnt_en_bit =3D 8,
> +       .quirks =3D QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_MASK_RESET | Q=
UIRK_HAS_PMU_CNT_EN |

Please keep it at 80 characters limit.

> +                 QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_DBGACK_BIT,
> +};
> +
> +static const struct s3c2410_wdt_variant drv_data_gs101_cl1 =3D {
> +       .mask_reset_reg =3D GS_CLUSTER1_NONCPU_INT_EN,
> +       .mask_bit =3D 2,
> +       .mask_reset_inv =3D true,
> +       .rst_stat_reg =3D GS_RST_STAT_REG_OFFSET,
> +       .rst_stat_bit =3D 1,
> +       .cnt_en_reg =3D GS_CLUSTER1_NONCPU_OUT,
> +       .cnt_en_bit =3D 7,
> +       .quirks =3D QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_MASK_RESET | Q=
UIRK_HAS_PMU_CNT_EN |

Please keep it at 80 characters limit.

> +                 QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_DBGACK_BIT,
> +};
> +
>  static const struct of_device_id s3c2410_wdt_match[] =3D {
>         { .compatible =3D "samsung,s3c2410-wdt",
>           .data =3D &drv_data_s3c2410 },
> @@ -284,6 +315,8 @@ static const struct of_device_id s3c2410_wdt_match[] =
=3D {
>           .data =3D &drv_data_exynos850_cl0 },
>         { .compatible =3D "samsung,exynosautov9-wdt",
>           .data =3D &drv_data_exynosautov9_cl0 },
> +       { .compatible =3D "google,gs101-wdt",
> +         .data =3D &drv_data_gs101_cl0 },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
> @@ -604,9 +637,10 @@ s3c2410_get_wdt_drv_data(struct platform_device *pde=
v, struct s3c2410_wdt *wdt)
>         }
>
>  #ifdef CONFIG_OF
> -       /* Choose Exynos850/ExynosAutov9 driver data w.r.t. cluster index=
 */
> +       /* Choose Exynos850/ExynosAutov9/gs101 driver data w.r.t. cluster=
 index */

Please keep it at 80 characters limit. Also, maybe just make it more
generic and mention "Exynos9 platforms" instead of listing all SoCs?

Other than that:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>


>         if (variant =3D=3D &drv_data_exynos850_cl0 ||
> -           variant =3D=3D &drv_data_exynosautov9_cl0) {
> +           variant =3D=3D &drv_data_exynosautov9_cl0 ||
> +           variant =3D=3D &drv_data_gs101_cl0) {
>                 u32 index;
>                 int err;
>
> @@ -619,9 +653,12 @@ s3c2410_get_wdt_drv_data(struct platform_device *pde=
v, struct s3c2410_wdt *wdt)
>                 case 0:
>                         break;
>                 case 1:
> -                       variant =3D (variant =3D=3D &drv_data_exynos850_c=
l0) ?
> -                               &drv_data_exynos850_cl1 :
> -                               &drv_data_exynosautov9_cl1;
> +                       if (variant =3D=3D &drv_data_exynos850_cl0)
> +                               variant =3D &drv_data_exynos850_cl1;
> +                       else if (variant =3D=3D &drv_data_exynosautov9_cl=
0)
> +                               variant =3D &drv_data_exynosautov9_cl1;
> +                       else if (variant =3D=3D &drv_data_gs101_cl0)
> +                               variant =3D &drv_data_gs101_cl1;
>                         break;
>                 default:
>                         return dev_err_probe(dev, -EINVAL, "wrong cluster=
 index: %u\n", index);
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
