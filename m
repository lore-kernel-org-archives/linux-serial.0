From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] serial: imx: Let device core handle pinctrl
Date: Mon, 27 May 2013 15:15:06 +0800
Message-ID: <20130527071505.GJ7782@S2101-09.ap.freescale.net>
References: <1369618985-9658-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:23054
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753852Ab3E0HOw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 May 2013 03:14:52 -0400
Content-Disposition: inline
In-Reply-To: <1369618985-9658-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: gregkh@linuxfoundation.org, kernel@pengutronix.de, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Sun, May 26, 2013 at 10:43:04PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit ab78029 (drivers/pinctrl: grab default handles from device core)
> we can rely on device core for handling pinctrl, so remove 
> devm_pinctrl_get_select_default() from the driver.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Both,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

