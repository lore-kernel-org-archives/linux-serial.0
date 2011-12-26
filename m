From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/2 v2] imx: Add save/restore functions for UART control
 regs
Date: Mon, 26 Dec 2011 09:58:30 +0800
Message-ID: <20111226015829.GI8240@S2100-06.ap.freescale.net>
References: <1324544273-9820-1-git-send-email-dirk.behme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:59340
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752986Ab1LZBpA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 25 Dec 2011 20:45:00 -0500
Content-Disposition: inline
In-Reply-To: <1324544273-9820-1-git-send-email-dirk.behme@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, Dirk Behme <dirk.behme@gmail.com>, linux-serial@vger.kernel.org, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Saleem Abdulrasool <compnerd@compnerd.org>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

On Thu, Dec 22, 2011 at 09:57:52AM +0100, Dirk Behme wrote:
> Factor out the uart save/restore functionality instead of
> having the same code several times in the driver.
> 
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> CC: Saleem Abdulrasool <compnerd@compnerd.org>
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> CC: Fabio Estevam <festevam@gmail.com>
> CC: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
> CC: linux-serial@vger.kernel.org
> CC: Alan Cox <alan@linux.intel.com>

I queued this for 3.3, and will send a pull-request to Greg.

-- 
Regards,
Shawn

