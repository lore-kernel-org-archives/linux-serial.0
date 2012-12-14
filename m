From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] mxs: uart: allow setting RTS from software
Date: Fri, 14 Dec 2012 14:11:59 +0000
Message-ID: <20121214141159.GM13292@decadent.org.uk>
References: <1355329913-27666-1-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35920 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754791Ab2LNOMF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Dec 2012 09:12:05 -0500
Content-Disposition: inline
In-Reply-To: <1355329913-27666-1-git-send-email-s.trumtrar@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: linux-serial@vger.kernel.org, stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>, Huang Shijie <b32955@freescale.com>

On Wed, Dec 12, 2012 at 05:31:53PM +0100, Steffen Trumtrar wrote:
> With the patch "serial: mxs-auart: fix the wrong RTS hardware flow control" the
> mainline mxs-uart driver now sets RTSEN only when hardware flow control is
> enabled via software. It is not possible any longer to set RTS manually via
> software. However, the manual modification is a valid operation.
> Regain the possibility to set RTS via software and only set RTSEN when hardware
> flow control is explicitly enabled via settermios cflag CRTSCTS.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
[...]

This is not the correct way to submit a patch to stable.  See
Documentation/stable_kernel_rules.txt

Ben.

-- 
Ben Hutchings
We get into the habit of living before acquiring the habit of thinking.
                                                              - Albert Camus
