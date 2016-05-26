From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v5 00/11] serial: 8250: split LPSS to 8250_lpss, enable
 DMA on Quark
Date: Thu, 26 May 2016 17:36:29 +0100
Message-ID: <1464280589.2351.19.camel@nexus-software.ie>
References: <1462547840-14091-1-git-send-email-andriy.shevchenko@linux.intel.com>
	   <1463065601.17131.319.camel@linux.intel.com>
	  <1463620733.4224.75.camel@nexus-software.ie>
	 <1464111448.31269.67.camel@linux.intel.com>
	 <1464113301.31269.79.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464113301.31269.79.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-05-24 at 21:08 +0300, Andy Shevchenko wrote:
> On Tue, 2016-05-24 at 20:37 +0300, Andy Shevchenko wrote:
> > On Thu, 2016-05-19 at 02:18 +0100, Bryan O'Donoghue wrote:
> > > On Thu, 2016-05-12 at 18:06 +0300, Andy Shevchenko wrote:
> > > > On Fri, 2016-05-06 at 18:17 +0300, Andy Shevchenko wrote:
> > > > > This is combined series of two things:
> > > > > - split out the Intel LPSS specific driver from 8250_pci into
> > > > > 8250_lpss
> > > > > - enable DMA support on Intel Quark UART
> > > > > 
> > > > > The patch has been tested on few Intel SoCs / platforms. In
> > > > > any
> > > > > case I
> > > > > would
> > > > > like to ask Bryan to do independent test.
> > > 
> > > Andy.
> > > 
> > > It looks as though there's a performance drop when enabling the
> > > DMA
> > > here (v) stock PIO mode with the 8250 driver.
> 
> Wait, the time measurement you done is unrelated to DMA/non-DMA mode.
> It's significantly depend to the speed of the port.

Does it ? The size of the FIFO is what - 16 bytes ? Max burst size is 8
bytes - so for 37 bytes you'd expect to see five DMA transactions {8,
8, 8, 5}, for the second test 183 bytes you'd expect to see 23 eight
byte transactions followed by one 7 byte transaction. The flip side to
add data to the FIFO in PIO mode is a pretty different pattern.

> I also tried on my Galileo board, I used longer data stream, i.e.
> output
> of dmesg (since your data pattern makes 0:s in statistics) and got
> something quite near to each other:

I'll find some time to look at both a short stream and a long stream,
based on the branch you've indicated and maybe against the latest
stable kernel.

---
bod
