From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 2/2] serial: mxs-auart: Allow device tree probing
Date: Sat, 16 Jun 2012 10:01:45 +0800
Message-ID: <20120616020143.GB29663@S2101-09.ap.freescale.net>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com>
 <201206151816.55567.marex@denx.de>
 <CAOMZO5AFaWGEfEhVs1TVc0c_Wp6aB7FT5zKHEoiucLnuWGg8zA@mail.gmail.com>
 <201206151900.21740.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:36350
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750923Ab2FPCBf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Jun 2012 22:01:35 -0400
Content-Disposition: inline
In-Reply-To: <201206151900.21740.marex@denx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, snijsure@grid-net.com, rob.herring@calxeda.com, Grant Likely <grant.likely@secretlab.ca>, kernel@pengutronix.de, linux-serial@vger.kernel.org, matt@grid-net.com, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>

On Fri, Jun 15, 2012 at 07:00:21PM +0200, Marek Vasut wrote:
> But we don't care if the non-DT case gets broken anyway *. It's unsupported and 
> will be removed.
> 
We have to care about non-DT case before all those non-DT users (board
files) get removed from the tree.

-- 
Regards,
Shawn

