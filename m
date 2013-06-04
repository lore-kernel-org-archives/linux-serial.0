From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6] tty: serial: add Freescale lpuart driver support
Date: Tue, 04 Jun 2013 11:11:57 +0200
Message-ID: <2240836.PbCUa091WM@wuerfel>
References: <1370309270-21019-1-git-send-email-b35083@freescale.com> <B56CDBE15CE27145A4B77D2D24263E851CEFD9@039-SN1MPN1-003.039d.mgd.msft.net> <CAOMZO5DzVhh4REj5S=cVVVrGzxmTxY9s_h_6ZQ-G8wOxi+KG=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56014 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab3FDJMN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Jun 2013 05:12:13 -0400
In-Reply-To: <CAOMZO5DzVhh4REj5S=cVVVrGzxmTxY9s_h_6ZQ-G8wOxi+KG=A@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <festevam@gmail.com>, Lu Jingchang-B35083 <B35083@freescale.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tuesday 04 June 2013 00:08:27 Fabio Estevam wrote:
> On Tue, Jun 4, 2013 at 12:02 AM, Lu Jingchang-B35083
> <B35083@freescale.com> wrote:
> 
> > [Lu Jingchang-B35083]
> >   SERIAL_FSL_LPUART_CONSOLE depends on SERIAL_FSL_LPUART=y in the patch as below, when SERIAL_FSL_LPUART is configured as module, it can't be configured as console. Thanks!
> 
> Why to prevent using the console of the driver is built as module?

All serial port drivers do this. IIRC the reason is that the console
has to be started from console_initcall(), which is not available in
modules.

	Arnd
