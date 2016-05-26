From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v5 00/11] serial: 8250: split LPSS to 8250_lpss, enable
 DMA on Quark
Date: Thu, 26 May 2016 17:11:09 +0100
Message-ID: <1464279069.2351.4.camel@nexus-software.ie>
References: <1462547840-14091-1-git-send-email-andriy.shevchenko@linux.intel.com>
	  <1463065601.17131.319.camel@linux.intel.com>
	 <1463620733.4224.75.camel@nexus-software.ie>
	 <1464111448.31269.67.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464111448.31269.67.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-05-24 at 20:37 +0300, Andy Shevchenko wrote:
> Below results doesn't show DMA case (by the way, how did you disable
> DMA
> in 3.8.7?) for stock kernel.

The stock kernel on SPI flash for my early Gen1 is a non-DMA 8250
driver, so nothing needs to be done to that, it's basically just the
3.8.7 8250 in PIO mode.

> Anyway, I added preliminary support to change DMA mode run-time.
> Check
> my today topic/dw/qrk branch. It would be nice to see all 4 cases:
> DMA
> vs non-DMA on stock kernel (Yocto) and mine.

I'll have another look at your latest branch and run the same tests.

> 
> P.S. What is the point to test arbitrary tip branch?

Just tip-of-tree, we can benchmark against the 4.6 tag if you prefer.


---
bod
