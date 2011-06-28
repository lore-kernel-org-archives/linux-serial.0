From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH 2/7] serial/8250: move alchemy I/O handler to platform code
Date: Tue, 28 Jun 2011 13:29:19 +0200
Message-ID: <BANLkTin9=5Yp6W8S6hSuUZ8w08eUhRxxQw@mail.gmail.com>
References: <1309211120-2803-1-git-send-email-arnd@arndb.de>
	<1309211120-2803-3-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64706 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757318Ab1F1L3W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Jun 2011 07:29:22 -0400
In-Reply-To: <1309211120-2803-3-git-send-email-arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ralf Baechle <ralf@linux-mips.org>, linux-serial@vger.kernel.org

On Mon, Jun 27, 2011 at 11:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Only one platform ever sets the UPIO_AU iotype, so it's
> cleaner to define the handlers in the code that actually
> requires it, rather than building the same logic into
> every 8250 driver.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Manuel Lauss <manuel.lauss@googlemail.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: linux-serial@vger.kernel.org
> ---
> =A0arch/mips/alchemy/common/platform.c | =A0 50 +++++++++++++++++++++=
+++++++++
> =A0drivers/tty/serial/8250.c =A0 =A0 =A0 =A0 =A0 | =A0 58 -----------=
------------------------
> =A02 files changed, 50 insertions(+), 58 deletions(-)
>
> diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/=
common/platform.c
> index 3b2c18b..750441f 100644
> --- a/arch/mips/alchemy/common/platform.c
> +++ b/arch/mips/alchemy/common/platform.c
[...]
> @@ -55,6 +103,8 @@ static void alchemy_8250_pm(struct uart_port *port=
, unsigned int state,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0UP=
=46_FIXED_TYPE, =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.type =A0 =A0 =A0 =A0 =A0 =3D PORT_165=
50A, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pm =A0 =A0 =A0 =A0 =A0 =A0 =3D alchem=
y_8250_pm, =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .serial_in =A0 =A0 =A0=3D au_serial_in,=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .serial_out =A0 =A0 =3D au_serial_out =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0}

This is very strange:  Just this part alone (leaving 8250.c intact)
screws everything up.
The assembly for au_serial_in/out is identical in both 8250.o and
arch/mips/alchemy/common/platform.o (renamed the functions here obvious=
ly)
I have no idea what's wrong...

Manuel
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
