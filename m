From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] tty: of_serial: support for 32 bit accesses
Date: Wed, 15 Jun 2011 07:27:48 -0600
Message-ID: <BANLkTimfXsqbhsCf0ZfhU8JewOaoJNWPeA@mail.gmail.com>
References: <1308142199-17972-1-git-send-email-jamie@jamieiles.com> <1308142199-17972-2-git-send-email-jamie@jamieiles.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57975 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337Ab1FON2J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Jun 2011 09:28:09 -0400
Received: by ywe9 with SMTP id 9so215959ywe.19
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2011 06:28:08 -0700 (PDT)
In-Reply-To: <1308142199-17972-2-git-send-email-jamie@jamieiles.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Alan Cox <alan@linux.intel.com>

On Wed, Jun 15, 2011 at 6:49 AM, Jamie Iles <jamie@jamieiles.com> wrote=
:
> Some platforms e.g. TI Davinci require 32-bit accesses to the UARTs.
> The of_serial driver currently registers all UARTs as UPIO_MEM. =A0Ad=
d a
> new attribute "io-width" to allow the port to be registered with
> different IO width requirements.
>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
> =A0.../devicetree/bindings/tty/serial/of-serial.txt =A0 | =A0 =A03 ++=
+
> =A0drivers/tty/serial/of_serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 17 +++++++++++++++++
> =A02 files changed, 20 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/tty/serial/of-serial.t=
xt b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
> index b0c52c2..1771cda 100644
> --- a/Documentation/devicetree/bindings/tty/serial/of-serial.txt
> +++ b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
> @@ -21,6 +21,9 @@ Optional properties:
> =A0- reg-shift : quantity to shift the register offsets by.
> =A0- used-by-rtas : set to indicate that the port is in use by the fi=
rmware and
> =A0 should not be registered.
> +- io-width : the size (in bytes) of the IO accesses that should be p=
erformed
> + =A0on the device. =A0There are some systems that require 32-bit acc=
esses to the
> + =A0UART (e.g. TI davinci).
>
> =A0Example:
>
> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_s=
erial.c
> index 4675243..50810a0 100644
> --- a/drivers/tty/serial/of_serial.c
> +++ b/drivers/tty/serial/of_serial.c
> @@ -65,6 +65,23 @@ static int __devinit of_platform_serial_setup(stru=
ct platform_device *ofdev,
>
> =A0 =A0 =A0 =A0port->irq =3D irq_of_parse_and_map(np, 0);
> =A0 =A0 =A0 =A0port->iotype =3D UPIO_MEM;
> + =A0 =A0 =A0 prop =3D of_get_property(np, "io-width", &prop_size);
> + =A0 =A0 =A0 if (prop && (prop_size =3D=3D sizeof(u32))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (be32_to_cpup(prop)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->iotype =3D UPIO_M=
EM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 4:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->iotype =3D UPIO_M=
EM32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&ofdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"uns=
upported io width (%d bytes)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0be32=
_to_cpup(prop));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;

Nit: since this is failing out, it should be dev_err instead of
dev_warn, but otherwise:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0port->type =3D type;
> =A0 =A0 =A0 =A0port->uartclk =3D be32_to_cpup(clk);
> =A0 =A0 =A0 =A0port->flags =3D UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UP=
=46_IOREMAP
> --
> 1.7.4.1
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
