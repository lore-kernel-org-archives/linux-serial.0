From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_dma: sync regions for device before transfer
Date: Fri, 13 Jun 2014 16:05:04 +0300
Message-ID: <20140613130504.GA1171@xps8300>
References: <1402588278-15109-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64335 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbaFMNFP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 13 Jun 2014 09:05:15 -0400
Content-Disposition: inline
In-Reply-To: <1402588278-15109-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Hi Andy,

On Thu, Jun 12, 2014 at 06:51:18PM +0300, Andy Shevchenko wrote:
> The documentation says that we have to sync DMA regions after CPU access and
> before any DMA transfer is going on. The actual DMA for buffer happens when we
> call dmaengine_submit() (*). The original code syncs data after this call which
> might lead to the corrupted data in actual stream.
> 
> (*) Accordingly to the Documentation/dmaengine.txt the dmaengine_submit call
> shouldn't do the transfer, but some DMA controller drivers abuse this rule.
> Thus, we would like to have this patch until all DMA controller drivers will be
> fixed. Even after that it will be harmless.

It's probable better that we directly fix the DMA engine drivers
instead of working around the issue here.


Thanks,

-- 
heikki
