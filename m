From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH] serial: sh-sci: Use platform_get_irq_optional() for
 optional interrupts
Date: Wed, 2 Oct 2019 04:49:48 +0000
Message-ID: <TYAPR01MB4544E8D4235AA2DF1D81BEC3D89C0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20191001180743.1041-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001180743.1041-1-geert+renesas@glider.be>
Content-Language: ja-JP
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Stephen Boyd <swboyd@chromium.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Geert-san,

> From: Geert Uytterhoeven, Sent: Wednesday, October 2, 2019 3:08 AM
>=20
> As platform_get_irq() now prints an error when the interrupt does not
> exist, scary warnings may be printed for optional interrupts:
>=20
>     sh-sci e6550000.serial: IRQ index 1 not found
>     sh-sci e6550000.serial: IRQ index 2 not found
>     sh-sci e6550000.serial: IRQ index 3 not found
>     sh-sci e6550000.serial: IRQ index 4 not found
>     sh-sci e6550000.serial: IRQ index 5 not found
>=20
> Fix this by calling platform_get_irq_optional() instead for all but the
> first interrupts, which are optional.
>=20
> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to =
platform_get_irq*()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is a fix for v5.4-rc1.

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

And, I tested this patch on R-Car H3. So,

Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda
