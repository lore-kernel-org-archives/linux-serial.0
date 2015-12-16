From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 11/11] tty: serial: 8250: Delete commented code
Date: Wed, 16 Dec 2015 09:05:26 -0800
Message-ID: <567199D6.4050106@hurleysoftware.com>
References: <1450280177-4460-1-git-send-email-anton.wuerfel@fau.de>
 <1450280177-4460-12-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1450280177-4460-12-git-send-email-anton.wuerfel@fau.de>
Sender: linux-parisc-owner@vger.kernel.org
To: Anton Wuerfel <anton.wuerfel@fau.de>, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Desmond Liu <desmondl@broadcom.com>, Wang Long <long.wanglong@huawei.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Peter Hung <hpeter@gmail.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Adam Lee <adam.lee@canonical.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Phillip Raffeck <phillip.raffeck@fau.de>
List-Id: linux-serial@vger.kernel.org

Hi Anton,

On 12/16/2015 07:36 AM, Anton Wuerfel wrote:
> This patch removes code which has been commented out. It serves no
> documentary purposes and decreases the readability of the remaining c=
ode.
> Furthermore the comment style causes checkpatch warnings. If this cod=
e
> should ever be needed again, git keeps track of it.

This is bad idea.

I can count on one hand the number of times I've tried to find deleted
code in git. How would you go about finding all deleted sub-vendor
ids in the 16.5M-line Linux source tree, say since 2.6.32?

Regards,
Peter Hurley

> Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
> Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
> CC: linux-kernel@i4.cs.fau.de
> ---
>  drivers/tty/serial/8250/8250_pci.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/=
8250/8250_pci.c
> index 3bc0303..9136f0f 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -4928,16 +4928,9 @@ static struct pci_device_id serial_pci_tbl[] =3D=
 {
>  	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
>  		0x1208, 0x0004, 0, 0,
>  		pbn_b0_4_921600 },
> -/*	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
> -		0x1402, 0x0002, 0, 0,
> -		pbn_b0_2_921600 }, */
> -/*	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
> -		0x1404, 0x0004, 0, 0,
> -		pbn_b0_4_921600 }, */
>  	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF1,
>  		0x1208, 0x0004, 0, 0,
>  		pbn_b0_4_921600 },
> -
>  	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF2,
>  		0x1204, 0x0004, 0, 0,
>  		pbn_b0_4_921600 },
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-parisc"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
