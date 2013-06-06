From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6] tty: serial: add Freescale lpuart driver support
Date: Thu, 6 Jun 2013 13:05:19 -0700
Message-ID: <20130606200519.GA1644@kroah.com>
References: <1370309270-21019-1-git-send-email-b35083@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:52268 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab3FFUFU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Jun 2013 16:05:20 -0400
Content-Disposition: inline
In-Reply-To: <1370309270-21019-1-git-send-email-b35083@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingchang Lu <b35083@freescale.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, s.hauer@pengutronix.de

On Tue, Jun 04, 2013 at 09:27:50AM +0800, Jingchang Lu wrote:
> Add Freescale lpuart driver support. The lpuart device
> can be found on Vybrid VF610 and Layerscape LS-1 SoCs.
>=20
> Signed-off-by: Jingchang Lu <b35083@freescale.com>

This breaks the build on x86 systems with:
  CC [M]  drivers/tty/serial/fsl_lpuart.o
drivers/tty/serial/fsl_lpuart.c: In function =E2=80=98lpuart_probe=E2=80=
=99:
drivers/tty/serial/fsl_lpuart.c:751:2: error: implicit declaration of f=
unction =E2=80=98of_alias_get_id=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]

so I can't take this :(

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
