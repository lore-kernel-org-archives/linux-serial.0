From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 2/2] serial: mxs-auart: Allow device tree probing
Date: Mon, 18 Jun 2012 15:36:15 +0200
Message-ID: <201206181536.16011.marex@denx.de>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com> <1340024769-7122-1-git-send-email-fabio.estevam@freescale.com> <20120618133338.GD19249@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:41828 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab2FRNgV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Jun 2012 09:36:21 -0400
In-Reply-To: <20120618133338.GD19249@S2101-09.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, rob.herring@calxeda.com, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

Dear Shawn Guo,

> On Mon, Jun 18, 2012 at 10:06:09AM -0300, Fabio Estevam wrote:
> > Allow device tree probing.
> > 
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Alan Cox <alan@linux.intel.com>
> > Cc: <linux-serial@vger.kernel.org>
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> > Changes since v3:
> > - Remove unneeded mxs_auart_devtype
> > Changes since v2:
> > - Change compatible string
> > - Add aliases information in bindings doc
> > - Remove unneeded mxs_auart_probe_pdev function
> > - Remove "ifdef CONFIG_OF"
> > - Remove of_match_ptr wrapper
> > Changes since v1:
> > - Merged patches 3 and 5 from v1 into this one
> 
> Hi Greg,
> 
> May I have your ack to have the patch go through arm-soc tree, so that
> we can possibly start converting those non-DT board files over to DT?
> 
> Regards,
> Shawn

Good, I should be back on 20th to the denx board.
