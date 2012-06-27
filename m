From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 01/12] f81232: correct stubbed termios handler
Date: Tue, 26 Jun 2012 19:22:32 -0700
Message-ID: <20120627022232.GA32709@kroah.com>
References: <20120622153600.1405.15575.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40713 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751159Ab2F0CWe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Jun 2012 22:22:34 -0400
Content-Disposition: inline
In-Reply-To: <20120622153600.1405.15575.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Fri, Jun 22, 2012 at 04:36:42PM +0100, Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>=20
>  drivers/usb/serial/f81232.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.=
c
> index 499b15f..acd3267 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -177,6 +177,7 @@ static void f81232_set_termios(struct tty_struct =
*tty,
>  		return;
> =20
>  	/* Do the real work here... */
> +	tty_termios_copy_hw(&tty->termios, old_termios);
>  }

This patch breaks the build:

drivers/usb/serial/f81232.c: In function =E2=80=98f81232_set_termios=E2=
=80=99:
drivers/usb/serial/f81232.c:180:2: warning: passing argument 1 of =E2=80=
=98tty_termios_copy_hw=E2=80=99 from incompatible pointer type [enabled=
 by default]
include/linux/tty.h:454:13: note: expected =E2=80=98struct ktermios *=E2=
=80=99 but argument is of type =E2=80=98struct ktermios **=E2=80=99

I know the driver isn't complete, but it should at least build :)

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
