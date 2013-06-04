From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/3] serial: imx: Fix warning when
 !CONFIG_SERIAL_IMX_CONSOLE
Date: Tue, 4 Jun 2013 07:10:39 +0200
Message-ID: <20130604051039.GF32299@pengutronix.de>
References: <1370314308-11637-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60988 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab3FDFKp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Jun 2013 01:10:45 -0400
Content-Disposition: inline
In-Reply-To: <1370314308-11637-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: gregkh@linuxfoundation.org, shawn.guo@linaro.org, b35083@freescale.com, kernel@pengutronix.de, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Mon, Jun 03, 2013 at 11:51:46PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When CONFIG_SERIAL_IMX_CONSOLE is not selected the following build warnings
> appear:

My take on this would be to remove CONFIG_SERIAL_IMX_CONSOLE completely
and make it mandatory. I know traditionally console support is optional
for all UART drivers, but is it really worth it to have these few bytes
saved?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
