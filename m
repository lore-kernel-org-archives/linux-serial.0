From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH/RFC 4/8] serial: pxa: Add fifo-size and {big,native}-endian properties
Date: Wed, 12 Nov 2014 10:02:22 +0100
Message-ID: <3584682.xS3Glp9BQh@wuerfel>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com> <1415781993-7755-5-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:53786 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbaKLJCp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 04:02:45 -0500
In-Reply-To: <1415781993-7755-5-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, tushar.behera@linaro.org, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

On Wednesday 12 November 2014 00:46:29 Kevin Cernekee wrote:
> diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> index 21b7d8b..78ed7ee 100644
> --- a/drivers/tty/serial/pxa.c
> +++ b/drivers/tty/serial/pxa.c
> @@ -60,13 +60,19 @@ struct uart_pxa_port {
>  static inline unsigned int serial_in(struct uart_pxa_port *up, int offset)
>  {
>         offset <<= 2;
> -       return readl(up->port.membase + offset);
> +       if (!up->port.big_endian)
> +               return readl(up->port.membase + offset);
> +       else
> +               return ioread32be(up->port.membase + offset);
>  }

How about making this a different UPIO type and using UPIO_MEM32/UPIO_MEM32BE
to tell the difference rather than a separate flag?

	Arnd
