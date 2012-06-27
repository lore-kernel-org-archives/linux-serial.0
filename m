From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 05/12] kobil_sct: Fix some bogus tty handling
Date: Tue, 26 Jun 2012 19:24:04 -0700
Message-ID: <20120627022404.GA3314@kroah.com>
References: <20120622153600.1405.15575.stgit@localhost.localdomain>
 <20120622154251.1405.12270.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120622154251.1405.12270.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 22, 2012 at 04:43:22PM +0100, Alan Cox wrote:
> Stuff noticed while doing the termios conversion.
>=20
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>=20
>  drivers/usb/serial/kobil_sct.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobi=
l_sct.c
> index fafeabb..0852472 100644
> --- a/drivers/usb/serial/kobil_sct.c
> +++ b/drivers/usb/serial/kobil_sct.c
> @@ -192,8 +192,8 @@ static void kobil_init_termios(struct tty_struct =
*tty)
>  {
>  	/* Default to echo off and other sane device settings */
>  	tty->termios->c_lflag =3D 0;
> -	tty->termios->c_lflag &=3D ~(ISIG | ICANON | ECHO | IEXTEN | XCASE)=
;
> -	tty->termios->c_iflag =3D IGNBRK | IGNPAR | IXOFF;
> +	tty->termios->c_iflag &=3D ~(ISIG | ICANON | ECHO | IEXTEN | XCASE)=
;
> +	tty->termios->c_iflag |=3D IGNBRK | IGNPAR | IXOFF;
>  	/* do NOT translate CR to CR-NL (0x0A -> 0x0A 0x0D) */
>  	tty->termios->c_oflag &=3D ~ONLCR;
>  }
> @@ -588,7 +588,7 @@ static void kobil_set_termios(struct tty_struct *=
tty,
>  	if (priv->device_type =3D=3D KOBIL_USBTWIN_PRODUCT_ID ||
>  			priv->device_type =3D=3D KOBIL_KAAN_SIM_PRODUCT_ID) {
>  		/* This device doesn't support ioctl calls */
> -		*tty->termios =3D *old;
> +		tty_termios_copy_hw(tty->termios, old_termios);
>  		return;
>  	}
> =20

This patch also breaks the build:

drivers/usb/serial/kobil_sct.c: In function =E2=80=98kobil_set_termios=E2=
=80=99:
drivers/usb/serial/kobil_sct.c:591:37: error: =E2=80=98old_termios=E2=80=
=99 undeclared (first use in this function)
drivers/usb/serial/kobil_sct.c:591:37: note: each undeclared identifier=
 is reported only once for each function it appears in
