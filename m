From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 00/11] serial: 8250: split LPSS to 8250_lpss, enable
 DMA on Quark
Date: Tue, 3 May 2016 15:55:50 -0700
Message-ID: <20160503225550.GA6599@kroah.com>
References: <1461764894-14891-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461764894-14891-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Apr 27, 2016 at 04:48:03PM +0300, Andy Shevchenko wrote:
> This is combined series of two things:
> - split out the Intel LPSS specific driver from 8250_pci into 8250_lpss
> - enable DMA support on Intel Quark UART
> 
> The patch has been tested on few Intel SoCs / platforms. In any case I would
> like to ask Bryan to do independent test.
> 
> This is targeting serial subsystem, thus it would be nice to get and Ack from
> Vinod first. Moreover, the series depends on [1] that is now under review. On
> the other hand Vinod proposed to take it through dma-slave tree. Greg?

I think if you don't take them through the tty tree, you might have
merge issues :(

Also, I don't have the full series in my mbox, can you resend the whole
thing please?  Or did not all patches get sent to me?

I'm dropping this from my queue now,

thanks,

greg k-h
