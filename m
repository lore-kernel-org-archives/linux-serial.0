From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 2/2] serial: mxs-auart: Allow device tree probing
Date: Mon, 18 Jun 2012 08:25:43 -0700
Message-ID: <20120618152543.GA15267@kroah.com>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com>
 <1340024769-7122-1-git-send-email-fabio.estevam@freescale.com>
 <20120618133338.GD19249@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55595 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab2FRPZt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Jun 2012 11:25:49 -0400
Received: by dady13 with SMTP id y13so7091184dad.19
        for <linux-serial@vger.kernel.org>; Mon, 18 Jun 2012 08:25:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120618133338.GD19249@S2101-09.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, marex@denx.de, rob.herring@calxeda.com, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

On Mon, Jun 18, 2012 at 09:33:40PM +0800, Shawn Guo wrote:
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

Fine with me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

