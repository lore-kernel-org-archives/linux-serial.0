From: Greg KH <greg@kroah.com>
Subject: Re: Bug in 8250.c - uninitialized FIFOs
Date: Fri, 3 Dec 2010 10:45:36 -0800
Message-ID: <20101203184536.GA17665@kroah.com>
References: <4CF92F40.5070004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:39428 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753508Ab0LCStG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 3 Dec 2010 13:49:06 -0500
Content-Disposition: inline
In-Reply-To: <4CF92F40.5070004@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?utf-8?B?T25kxZllaiBQdcW+bWFu?= <puzman@gmail.com>
Cc: linux-serial@vger.kernel.org

On Fri, Dec 03, 2010 at 06:56:16PM +0100, Ond=C5=99ej Pu=C5=BEman wrote=
:
> Here is the patch to correct the bug created against 2.6.36.1:
>=20
> diff -Naur a/drivers/serial/8250.c b/drivers/serial/8250.c
> --- a/drivers/serial/8250.c     2010-11-22 20:03:49.000000000 +0100
> +++ b/drivers/serial/8250.c     2010-12-03 18:32:54.000000000 +0100
> @@ -1952,6 +1952,8 @@
>        unsigned char lsr, iir;
>        int retval;
>=20
> +       up->port.fifosize =3D uart_config[up->port.type].fifo_size;
> +       up->tx_loadsz =3D uart_config[up->port.type].tx_loadsz;
>        up->capabilities =3D uart_config[up->port.type].flags;
>        up->mcr =3D 0;
>=20
>=20
> The patch should work on most 2.6.x kernels.
> I hope that someone will be able to put that in the official kernel t=
ree.

I would like to include it, but I need it in a form I can apply it in.
Your email client turned the tabs to spaces, and I need a
"Signed-off-by:" line in order to be able to apply it.  Take a look at
the file, Documentation/SubmittingPatches for details about this.

Care to fix this and resend it so I can apply it?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
