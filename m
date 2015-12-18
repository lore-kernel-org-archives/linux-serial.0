From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 05/11] tty: serial: 8250: Remove else after return
Date: Fri, 18 Dec 2015 07:37:26 -0800
Message-ID: <56742836.2050004@hurleysoftware.com>
References: <1450437723-2978-1-git-send-email-anton.wuerfel@fau.de>
 <1450437723-2978-6-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450437723-2978-6-git-send-email-anton.wuerfel@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Wuerfel <anton.wuerfel@fau.de>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Desmond Liu <desmondl@broadcom.com>, Wang Long <long.wanglong@huawei.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Peter Hung <hpeter@gmail.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Adam Lee <adam.lee@canonical.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Phillip Raffeck <phillip.raffe>
List-Id: linux-serial@vger.kernel.org

On 12/18/2015 03:21 AM, Anton Wuerfel wrote:
> This patch fixes checkpatch warnings about unnecessary else blocks af=
ter
> return statements.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

See note below.

> Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
> Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
> CC: linux-kernel@i4.cs.fau.de
> ---
>  drivers/tty/serial/8250/8250_pci.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/=
8250/8250_pci.c
> index 7f9f245..09157fa 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -805,10 +805,10 @@ static int pci_netmos_9900_numports(struct pci_=
dev *dev)
> =20
>  	pi =3D (c & 0xff);
> =20
> -	if (pi =3D=3D 2) {
> +	if (pi =3D=3D 2)
>  		return 1;
> -	} else if ((pi =3D=3D 0) &&
> -			   (dev->device =3D=3D PCI_DEVICE_ID_NETMOS_9900)) {
> +
> +	if ((pi =3D=3D 0) && (dev->device =3D=3D PCI_DEVICE_ID_NETMOS_9900)=
) {
>  		/* two possibilities: 0x30ps encodes number of parallel and
>  		 * serial ports, or 0x1000 indicates *something*. This is not
>  		 * immediately obvious, since the 2s1p+4s configuration seems

checkpatch missed this comment style because it's what netdev uses.
Not a problem, though. We're not quite so formal here.

> @@ -816,12 +816,11 @@ static int pci_netmos_9900_numports(struct pci_=
dev *dev)
>  		 * advertising the same function 3 as the 4s+2s1p config.
>  		 */
>  		sub_serports =3D dev->subsystem_device & 0xf;
> -		if (sub_serports > 0) {
> +		if (sub_serports > 0)
>  			return sub_serports;
> -		} else {
> -			dev_err(&dev->dev, "NetMos/Mostech serial driver ignoring port on=
 ambiguous config.\n");
> -			return 0;
> -		}
> +
> +		dev_err(&dev->dev, "NetMos/Mostech serial driver ignoring port on =
ambiguous config.\n");
> +		return 0;
>  	}
> =20
>  	moan_device("unknown NetMos/Mostech program interface", dev);
>=20
