From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH V4 0/7]  tty: serial: lpuart: add imx7ulp support
Date: Wed, 21 Jun 2017 13:01:23 +0000
Message-ID: <AM3PR04MB306B649ADC54EF1C6A7191D80DA0@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1497322554-24463-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497322554-24463-1-git-send-email-aisheng.dong@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "A.s. Dong" <aisheng.dong@nxp.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, Andy Duan <fugang.duan@nxp.com>, "stefan@agner.ch" <stefan@agner.ch>, Mingkai Hu <mingkai.hu@nxp.com>, "Y.b. Lu" <yangbo.lu@nxp.com>, "nikita.yoush@cogentembedded.com" <nikita.yoush@cogentembedded.com>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "dongas86@gmail.com" <dongas86@gmail.com>
List-Id: linux-serial@vger.kernel.org

Ping...

> -----Original Message-----
> From: Dong Aisheng [mailto:aisheng.dong@nxp.com]
> Sent: Tuesday, June 13, 2017 10:56 AM
> To: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> gregkh@linuxfoundation.org; jslaby@suse.com; Andy Duan; stefan@agner.ch;
> Mingkai Hu; Y.b. Lu; nikita.yoush@cogentembedded.com;
> andy.shevchenko@gmail.com; dongas86@gmail.com; A.s. Dong
> Subject: [PATCH V4 0/7] tty: serial: lpuart: add imx7ulp support
>=20
> The lpuart in imx7ulp is basically the same as ls1021a. It's also
> 32 bit width register, but unlike ls1021a, it's little endian.
> Besides that, imx7ulp lpuart has a minor different register layout from
> ls1021a that it has four extra registers (verid, param, global,
> pincfg) located at the beginning of register map, which are currently not
> used by the driver and less to be used later.
>=20
> Furthermore, this patch serial also add a new more accurate baud rate
> calculation method as MX7ULP can't divide a suitable baud rate with the
> default setting.
>=20
> Currently the new baud rate calculation is only enabled on MX7ULP.
> However, i guess the Layerscape may also be able to use it as there seems
> to be no difference in baud rate setting register after checking the
> Layerscape Reference Manual.
>=20
> As i don't have Layerscape boards, i can't test it, so i only enable it
> for MX7ULP by default to avoid a potential break.
>=20
> I copied LayerScape guys in this series and hope they can help test later=
.
> If it works on Layerscape as well, then they can switch to the new settin=
g
> too and totally remove the old stuff.
>=20
> ChangeLog:
> v3->v4:
>  * Minor changes.
>    1) Remove one duplicated blank line
>    2) Removed on unneeded semicolon in switch catched by 0day Robot
> v2->v3:
>  * Remove global lpuart_is_be.
>    Instead use struct uart_port's iotype member.
>    lpuart32_read/write API prototype is also updated to use the iotype to
>    distingush the endians. And most importantly, this way also works with
>    earlycon.
>=20
> v1->v2:
>  * Patch 2/4/5 chagned, other no changes.
>    See individuals for details.
>=20
> Dong Aisheng (7):
>   tty: serial: lpuart: introduce lpuart_soc_data to represent SoC
>     property
>   tty: serial: lpuart: refactor lpuart32_{read|write} prototype
>   tty: serial: lpuart: add little endian 32 bit register support
>   dt-bindings: serial: fsl-lpuart: add i.MX7ULP support
>   tty: serial: lpuart: add imx7ulp support
>   tty: serial: lpuart: add earlycon support for imx7ulp
>   tty: serial: lpuart: add a more accurate baud rate calculation method
>=20
>  .../devicetree/bindings/serial/fsl-lpuart.txt      |   2 +
>  drivers/tty/serial/fsl_lpuart.c                    | 286 ++++++++++++++-=
-
> -----
>  2 files changed, 201 insertions(+), 87 deletions(-)
>=20
> --
> 2.7.4
