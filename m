From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] serial:ifx6x60:Prevent data transfer when IFX6x60 port
 is shutdown
Date: Thu, 1 Nov 2012 11:48:20 +0000
Message-ID: <20121101114820.52c280be@bob.linux.org.uk>
References: <1351673647.4445.25.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10960 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815Ab2KALql (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Nov 2012 07:46:41 -0400
In-Reply-To: <1351673647.4445.25.camel@bichao>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: chao bi <chao.bi@intel.com>
Cc: linux-serial@vger.kernel.org, richardx.r.gorby@intel.com, chuansheng.liu@intel.com, jun.d.chen@intel.com

On Wed, 31 Oct 2012 16:54:07 +0800
chao bi <chao.bi@intel.com> wrote:

> 
> This patch is to implement following 2 places to avoid potential
> error when IFX6x60 port shutdown: 1) Clear Flag
> IFX_SPI_STATE_IO_AVAILABLE to disable data transfer when Modem port
> is shutdown; 2) Clear Flag IFX_SPI_STATE_IO_IN_PROGRESS and
> IFX_SPI_STATE_IO_READY when reopen port. This is because last port
> shutdown may happen when SPI/DMA transfer is in progress, if the last
> data transfer is not completed(for example due to modem reset), the
> Flag IFX_SPI_STATE_IO_IN_PROGRESS will be set forever, so when IFX
> port is activated again, IFX_SPI_STATE_IO_IN_PROGRESS will prevent
> transferring data forever. And if don't clear IFX_SPI_STATE_IO_READY,
> it may cause one more SPI frame transferring in spit there is not
> data need to be transfer.
> 
> cc: liu chuansheng <chuansheng.liu@intel.com>
> cc: Chen Jun <jun.d.chen@intel.com>
> Signed-off-by: channing <chao.bi@intel.com>


Acked-by: Alan Cox <alan@linux.intel.com>
