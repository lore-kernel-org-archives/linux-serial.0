From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 00/11] serial: 8250: split LPSS to 8250_lpss, enable
 DMA on Quark
Date: Wed, 20 Apr 2016 18:59:10 +0530
Message-ID: <20160420132910.GB2274@localhost>
References: <1460379071-132591-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460379071-132591-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 11, 2016 at 03:51:00PM +0300, Andy Shevchenko wrote:
> This is combined series of two things:
> - split out the Intel LPSS specific driver from 8250_pci into 8250_lpss
> - enable DMA support on Intel Quark UART
> 
> The patch has been tested on few Intel SoCs / platforms.
> 
> This is targeting serial subsystem, thus it would be nice to get and Ack from Vinod first.
> Moreover, the series depends on [1] that is now under review.
> 
> That's why I asked Vinod to create immutable tag / branch for the [1] and the
> dependants (at least one more, which is sata_dwc_460ex).

The dmaengine bits look fine to me but this is dependent on another dw
series which is undergoing changes.

I was thinking that it might be easier to merge the series thru dmaengine
tree if Greg is okay with it. If not once all dw patches are merged I will
give immutable signed tag

Thanks
-- 
~Vinod
