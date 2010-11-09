From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] serial: 8250: fix uninitialized compiler warning
Date: Tue, 9 Nov 2010 09:01:23 -0800
Message-ID: <20101109090123.6a12f3f2.randy.dunlap@oracle.com>
References: <1289321723.2260.14.camel@cowboy>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:57238 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab0KIRDB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Nov 2010 12:03:01 -0500
In-Reply-To: <1289321723.2260.14.camel@cowboy>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: dave@gnu.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux-serial@vger.kernel.org

On Tue, 09 Nov 2010 13:55:23 -0300 Davidlohr Bueso wrote:

> From: Davidlohr Bueso <dave@gnu.org>
>=20
> This addresses:
>=20
>   CC [M]  drivers/serial/8250.o
> drivers/serial/8250.c: In function =E2=80=98serial8250_shutdown=E2=80=
=99:
> drivers/serial/8250.c:1696: warning: =E2=80=98i=E2=80=99 may be used =
uninitialized in this function
> drivers/serial/8250.c:1696: note: =E2=80=98i=E2=80=99 was declared he=
re

so in your analysis of this compiler warning, was the warning correct &=
 justified,
or was it false?  I.e., is the init to NULL needed?

If it was false, could we just quieten the warning by using:

	struct irq_info *unitialized_var(i);

plus #include <linux/compiler.h> ?


> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  drivers/serial/8250.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index 4d8e14b..f734eee 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -1693,7 +1693,7 @@ static int serial_link_irq_chain(struct uart_82=
50_port *up)
> =20
>  static void serial_unlink_irq_chain(struct uart_8250_port *up)
>  {
> -	struct irq_info *i;
> +	struct irq_info *i =3D NULL;
>  	struct hlist_node *n;
>  	struct hlist_head *h;
> =20
> --=20


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your cod=
e ***
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
