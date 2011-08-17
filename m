From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 4/5] mips: msp71xx/serial: add workaround for DW UART
Date: Wed, 17 Aug 2011 13:56:33 +0100
Message-ID: <20110817125633.GC16422@linux-mips.org>
References: <1313399875-11006-1-git-send-email-jamie@jamieiles.com>
 <1313399875-11006-5-git-send-email-jamie@jamieiles.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37149 "EHLO linux-mips.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752864Ab1HQM6E (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Aug 2011 08:58:04 -0400
Content-Disposition: inline
In-Reply-To: <1313399875-11006-5-git-send-email-jamie@jamieiles.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-serial@vger.kernel.org, arnd@arndb.de, Alan Cox <alan@linux.intel.com>

On Mon, Aug 15, 2011 at 10:17:54AM +0100, Jamie Iles wrote:

> The Synopsys DesignWare UART in pmc-sierra msp71xx has an extra feature
> where the UART detects a write attempt to the LCR whilst busy and raises
> an interrupt.  The driver needs to clear the interrupt and rewrite the
> LCR.  Move this into platform code and out of the 8250 driver.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

Not quite the way I'd have done it but looks like it's going to work.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
