From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 2/2 v3] imx: add polled io uart methods
Date: Mon, 26 Dec 2011 09:59:25 +0800
Message-ID: <20111226015924.GJ8240@S2100-06.ap.freescale.net>
References: <1324544273-9820-1-git-send-email-dirk.behme@gmail.com>
 <1324544273-9820-2-git-send-email-dirk.behme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:59769
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752986Ab1LZBpx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 25 Dec 2011 20:45:53 -0500
Content-Disposition: inline
In-Reply-To: <1324544273-9820-2-git-send-email-dirk.behme@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, Dirk Behme <dirk.behme@gmail.com>, linux-serial@vger.kernel.org, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Saleem Abdulrasool <compnerd@compnerd.org>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

On Thu, Dec 22, 2011 at 09:57:53AM +0100, Dirk Behme wrote:
> From: Saleem Abdulrasool <compnerd@compnerd.org>
> 
> These methods are invoked if the iMX uart is used in conjuction with kgdb during
> early boot.  In order to access the UART without the interrupts, the kernel uses
> the basic polling methods for IO with the device.  With these methods
> implemented, it is now possible to enable kgdb during early boot over serial.
> 
> Signed-off-by: Saleem Abdulrasool <compnerd@compnerd.org>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> CC: Fabio Estevam <festevam@gmail.com>
> CC: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
> CC: linux-serial@vger.kernel.org
> CC: Alan Cox <alan@linux.intel.com>

I queued this for 3.3, and will send a pull-request to Greg.

-- 
Regards,
Shawn

