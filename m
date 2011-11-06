From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH] serial: samsung: Fix build for non-Exynos4210 devices
Date: Sun, 6 Nov 2011 21:43:45 +0530
Message-ID: <CAJuYYwQakbLqM46gVexB4Evby-aHA11hAx4N4Nw4mdYXp_yEOQ@mail.gmail.com>
References: <1320426984-17525-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1320426984-17525-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Alan Cox <alan@linux.intel.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Mark,

On 4 November 2011 22:46, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> exynos4120_serial_drv_data is only defined when building with support
> for Exynos4210 so use the already provided define to ensure that we
> don't reference it when building for other SoCs.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I missed that one. Thanks for the fix.

The Samsung device tree patches will not be merged in v3.2 merge
window. So should this fix be merged into the uart dt support patch or
should this be a separate patch?

Thanks,
Thomas.

> ---
> =A0drivers/tty/serial/samsung.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsun=
g.c
> index efe3756..7272eee 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1649,7 +1649,7 @@ MODULE_DEVICE_TABLE(platform, s3c24xx_serial_dr=
iver_ids);
> =A0#ifdef CONFIG_OF
> =A0static const struct of_device_id s3c24xx_uart_dt_match[] =3D {
> =A0 =A0 =A0 =A0{ .compatible =3D "samsung,exynos4210-uart",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .data =3D &exynos4210_serial_drv_data }=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .data =3D EXYNOS4210_SERIAL_DRV_DATA },
> =A0 =A0 =A0 =A0{},
> =A0};
> =A0MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
> --
> 1.7.7.1
>
>
