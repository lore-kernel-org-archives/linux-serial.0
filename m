From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3 2/2] serial: mxs-auart: Allow device tree probing
Date: Fri, 15 Jun 2012 18:16:55 +0200
Message-ID: <201206151816.55567.marex@denx.de>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com> <20120615160635.GP31565@S2101-09.ap.freescale.net> <CAOMZO5BB5G5gvbcqDa2uB3hR-_o7XpcgXR9Ha+Xd7ZLpCqaOVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:33630 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932369Ab2FOQQ7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Jun 2012 12:16:59 -0400
In-Reply-To: <CAOMZO5BB5G5gvbcqDa2uB3hR-_o7XpcgXR9Ha+Xd7ZLpCqaOVw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, snijsure@grid-net.com, rob.herring@calxeda.com, Grant Likely <grant.likely@secretlab.ca>, kernel@pengutronix.de, linux-serial@vger.kernel.org, matt@grid-net.com, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>

Dear Fabio Estevam,

> On Fri, Jun 15, 2012 at 1:06 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> >> +MODULE_DEVICE_TABLE(platform, mxs_auart_devtype);
> > 
> > ...
> > 
> >> +             .id_table = mxs_auart_devtype,
> > 
> > I do not think we need these.
> 
> WIthout this, the non-dt kernel does not probe correctly.

But we don't support non-DT kernel anymore.

Best regards,
Marek Vasut
