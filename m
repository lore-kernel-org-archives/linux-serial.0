From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 06/11] serial: 8250_dma: adjust DMA address of the UART
Date: Tue, 12 Apr 2016 09:46:06 +0300
Message-ID: <20160412064606.GC26606@kuha.fi.intel.com>
References: <1460379071-132591-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1460379071-132591-7-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460379071-132591-7-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 11, 2016 at 03:51:06PM +0300, Andy Shevchenko wrote:
> Some UARTs, e.g. one is used in Intel Quark, have a different address base for
> DMA operations. Introduce an additional field (per RX and TX DMA channels) in
> struct uart_8250_dma to cover those cases.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

FWIW

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


Thanks,

-- 
heikki
