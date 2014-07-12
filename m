From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] tty: serial: fsl_lpuart: add 32-bit register
 interface support
Date: Fri, 11 Jul 2014 17:51:22 -0700
Message-ID: <20140712005122.GA31974@kroah.com>
References: <1405057302-26041-1-git-send-email-jingchang.lu@freescale.com>
 <1405057302-26041-3-git-send-email-jingchang.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42748 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbaGLAqx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Jul 2014 20:46:53 -0400
Content-Disposition: inline
In-Reply-To: <1405057302-26041-3-git-send-email-jingchang.lu@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingchang Lu <jingchang.lu@freescale.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jul 11, 2014 at 01:41:42PM +0800, Jingchang Lu wrote:
> This add the 32-bit register version LPUART support with big-endian
> byte order.
>=20
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 653 ++++++++++++++++++++++++++++++=
+++++++++-
>  1 file changed, 643 insertions(+), 10 deletions(-)

You didn't even test build this patch:

  CC [M]  drivers/tty/serial/fsl_lpuart.o
drivers/tty/serial/fsl_lpuart.c: In function =E2=80=98lpuart_suspend=E2=
=80=99:
drivers/tty/serial/fsl_lpuart.c:1856:22: error: =E2=80=98lpuart32_reg=E2=
=80=99 undeclared (first use in this function)
   uart_suspend_port(&lpuart32_reg, &sport->port);
                      ^

No quicker way to make me grumpy...

Please take some time to do this right.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
