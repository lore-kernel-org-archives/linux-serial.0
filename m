From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/4] serial/arc-uart: switch to devicetree based probing
Date: Fri, 11 Jan 2013 20:17:04 +0000
Message-ID: <201301112017.04270.arnd@arndb.de>
References: <1357885223-19243-1-git-send-email-vgupta@synopsys.com> <201301111133.43507.arnd@arndb.de> <50EFFDAA.6060204@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53320 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385Ab3AKURJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Jan 2013 15:17:09 -0500
In-Reply-To: <50EFFDAA.6060204@synopsys.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>

On Friday 11 January 2013, Vineet Gupta wrote:
> On Friday 11 January 2013 05:03 PM, Arnd Bergmann wrote:

> > Quick question about the name though: is this UART only used
> > on ARC, or is it something that synopsys licenses to other
> > parties as well? If the latter is true, we might want to 
> > add a more generic "compatible" value for those that use
> > it on another architecture.
> 
> It's not licensed as standalone IP - since its not a standard 8250. It is only
> (but actively) used on the internal FPGA flows from ARC days.
> 
Ok, thanks for the confirmation.

	Arnd
