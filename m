From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] 8250: add workaround for MPC8[356]xx UART break IRQ
 storm
Date: Fri, 2 Dec 2011 11:30:59 +0000
Message-ID: <20111202113059.15d73840@lxorguk.ukuu.org.uk>
References: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>
	<1322783258-20443-4-git-send-email-paul.gortmaker@windriver.com>
	<4ED812E4.60905@freescale.com>
	<4ED81632.3030809@windriver.com>
	<176AE2A1-6AA2-4F14-942F-8ED77AB1DBEC@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39286 "EHLO
	earthlight.etchedpixels.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754100Ab1LBL3m (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Dec 2011 06:29:42 -0500
In-Reply-To: <176AE2A1-6AA2-4F14-942F-8ED77AB1DBEC@kernel.crashing.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Scott Wood <scottwood@freescale.com>, gregkh@suse.de, alan@linux.intel.com, linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

> > OK, I'll simply change the above to CONFIG_PPC then.
> 
> It does, the bug is in the uart IP which I don't think we ever plan on fixing, so 32 or 64-bit parts will have it for ever and ever ;)

It should be runtime selected, there should be no ifdefs here.

