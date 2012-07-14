From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty: of_serial: add no-loopback-test property
Date: Sat, 14 Jul 2012 15:01:01 +0100
Message-ID: <20120714150101.1810c829@pyramind.ukuu.org.uk>
References: <1342267580-3672-1-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34105 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682Ab2GNN5i (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 14 Jul 2012 09:57:38 -0400
In-Reply-To: <1342267580-3672-1-git-send-email-juhosg@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org, linux-serial@vger.kernel.org

On Sat, 14 Jul 2012 14:06:20 +0200
Gabor Juhos <juhosg@openwrt.org> wrote:

> The loopback test mode is not implemented in all
> NS16550 compatible UARTs. The 8250 driver uses the
> UPF_SKIP_TEST flag to indicate this, however it is
> not possible to set this flag via device-tree.
> 
> Add a new 'no-loopback-test' property, and modify
> the of_serial driver to set the UPF_SKIP_TEST flag
> if the property is present.
> 
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>

Looks good to me but clashes with the sync of the termios changes, which
we urgently need to get in first.

Greg - I'll add this to my patch stack with the relevant changes so that
it doesn't get messed up.

Alan
