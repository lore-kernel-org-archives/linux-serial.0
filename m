From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH 4/5] mips: msp71xx/serial: add workaround for DW UART
Date: Wed, 17 Aug 2011 14:51:11 +0100
Message-ID: <20110817135111.GB6586@pulham.picochip.com>
References: <1313399875-11006-1-git-send-email-jamie@jamieiles.com>
 <1313399875-11006-5-git-send-email-jamie@jamieiles.com>
 <20110817125633.GC16422@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36002 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab1HQNvQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Aug 2011 09:51:16 -0400
Received: by wyg24 with SMTP id 24so685323wyg.19
        for <linux-serial@vger.kernel.org>; Wed, 17 Aug 2011 06:51:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110817125633.GC16422@linux-mips.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, arnd@arndb.de, Alan Cox <alan@linux.intel.com>

On Wed, Aug 17, 2011 at 01:56:33PM +0100, Ralf Baechle wrote:
> On Mon, Aug 15, 2011 at 10:17:54AM +0100, Jamie Iles wrote:
> 
> > The Synopsys DesignWare UART in pmc-sierra msp71xx has an extra feature
> > where the UART detects a write attempt to the LCR whilst busy and raises
> > an interrupt.  The driver needs to clear the interrupt and rewrite the
> > LCR.  Move this into platform code and out of the 8250 driver.
> > 
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Alan Cox <alan@linux.intel.com>
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> 
> Not quite the way I'd have done it but looks like it's going to work.
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks Ralf.  Out of interest, what would you have done differently?

Jamie
