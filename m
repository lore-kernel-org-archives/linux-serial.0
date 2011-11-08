From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] serial: samsung: Fix build for non-Exynos4210 devices
Date: Tue, 08 Nov 2011 14:00:31 +0900
Message-ID: <04ea01cc9dd3$5725b110$05711330$%kim@samsung.com>
References: <1320426984-17525-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAJuYYwQakbLqM46gVexB4Evby-aHA11hAx4N4Nw4mdYXp_yEOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:15455 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab1KHFAc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 Nov 2011 00:00:32 -0500
In-reply-to: <CAJuYYwQakbLqM46gVexB4Evby-aHA11hAx4N4Nw4mdYXp_yEOQ@mail.gmail.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Thomas Abraham' <thomas.abraham@linaro.org>, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: 'Alan Cox' <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Thomas Abraham wrote:
>=20
> Hi Mark,
>=20
> On 4 November 2011 22:46, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > exynos4120_serial_drv_data is only defined when building with suppo=
rt
> > for Exynos4210 so use the already provided define to ensure that we
> > don't reference it when building for other SoCs.
> >
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>=20
> I missed that one. Thanks for the fix.
>=20
> The Samsung device tree patches will not be merged in v3.2 merge
> window. So should this fix be merged into the uart dt support patch o=
r
> should this be a separate patch?
>=20

Hi all,

Okay, I will pick this up on 'next-samung-dt' tree which will be sent t=
o
upstream in next time.

As a note, I need to sort out the tree based on v3.2-rc1 then will appl=
y
this.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
>=20
> > ---
> > =A0drivers/tty/serial/samsung.c | =A0 =A02 +-
> > =A01 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/sams=
ung.c
> > index efe3756..7272eee 100644
> > --- a/drivers/tty/serial/samsung.c
> > +++ b/drivers/tty/serial/samsung.c
> > @@ -1649,7 +1649,7 @@ MODULE_DEVICE_TABLE(platform,
> s3c24xx_serial_driver_ids);
> > =A0#ifdef CONFIG_OF
> > =A0static const struct of_device_id s3c24xx_uart_dt_match[] =3D {
> > =A0 =A0 =A0 =A0{ .compatible =3D "samsung,exynos4210-uart",
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .data =3D &exynos4210_serial_drv_data=
 },
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .data =3D EXYNOS4210_SERIAL_DRV_DATA =
},
> > =A0 =A0 =A0 =A0{},
> > =A0};
> > =A0MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
> > --
> > 1.7.7.1
> >
> >

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
