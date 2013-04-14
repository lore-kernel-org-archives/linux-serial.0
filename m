From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] tty/serial: add MVF uart driver support
Date: Sun, 14 Apr 2013 10:42:40 +0200
Message-ID: <20130414084240.GY1906@pengutronix.de>
References: <1365750655-3530-1-git-send-email-b35083@freescale.com>
 <CAOMZO5D-uQQJAc6zAMkF9ViR0KWg4q7cPr7+pLdfyAm9gtPyTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59423 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab3DNImo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Apr 2013 04:42:44 -0400
Content-Disposition: inline
In-Reply-To: <CAOMZO5D-uQQJAc6zAMkF9ViR0KWg4q7cPr7+pLdfyAm9gtPyTA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Jingchang Lu <b35083@freescale.com>, linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org

On Sat, Apr 13, 2013 at 05:41:26PM -0300, Fabio Estevam wrote:
> On Fri, Apr 12, 2013 at 4:10 AM, Jingchang Lu <b35083@freescale.com> wrote:
> > It adds Freescale Vybrid Family uart driver support
> >
> > Signed-off-by: Jingchang Lu <b35083@freescale.com>
> > ---
> >  drivers/tty/serial/Kconfig       |   17 +
> >  drivers/tty/serial/Makefile      |    1 +
> >  drivers/tty/serial/mvf.c         | 1246 ++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/serial_core.h |    3 +
> >  4 files changed, 1267 insertions(+)
> >  create mode 100644 drivers/tty/serial/mvf.c
> 
> Would it be possible to add Vybrid support into the existing imx serial port?

That's completely different hardware.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
