From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v5] tty: serial: imx: Allow UART to be a source for wakeup
Date: Mon, 26 Dec 2011 09:53:23 +0800
Message-ID: <20111226015322.GF8240@S2100-06.ap.freescale.net>
References: <1323434541-27689-1-git-send-email-festevam@gmail.com>
 <1323746628-25163-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:31640
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753101Ab1LZBkP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 25 Dec 2011 20:40:15 -0500
Content-Disposition: inline
In-Reply-To: <1323746628-25163-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, alan@linux.intel.com, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, Greg Kroah-Hartman <gregkh@suse.de>

On Tue, Dec 13, 2011 at 01:23:48AM -0200, Fabio Estevam wrote:
> Allow UART to be a source for wakeup from low power mode.
> 
> Tested on a MX27PDK by doing:
> 
> echo enabled > /sys/devices/platform/imx21-uart.0/tty/ttymxc0/power/wakeup
> 
> echo mem > /sys/power/state
> 
> and then pressing a key in the console will wakeup the sytem.
> 
> Suggested-by: Shawn Guo <shawn.guo@freescale.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---

I queued this for 3.3, and will send a pull-request to Greg.

-- 
Regards,
Shawn

