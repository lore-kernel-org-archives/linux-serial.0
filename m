From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC 00/24] OMAP serial driver flow control fixes, and
 preparation for DMA engine conversion
Date: Sat, 6 Oct 2012 16:50:44 +0100
Message-ID: <20121006165044.30528336@pyramind.ukuu.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-serial@vger.kernel.org

On Sat, 6 Oct 2012 13:38:03 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> Hi,
> 
> This series of patches fixes multiple flow control issues with the OMAP
> serial driver, and prepares the driver for DMA engine conversion.  We
> require hardware assisted flow control to work properly for DMA support
> otherwise we have no way to properly pause the transmitter.

All the generic parts

Acked-by: Alan Cox <alan@linux.intel.com>
