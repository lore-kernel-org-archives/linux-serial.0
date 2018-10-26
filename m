From: "sudheer.v" <open.sudheer@gmail.com>
Subject: Re: [[PATCH] 8/9] DMA-UART-Driver-for-AST2500
Date: Fri, 26 Oct 2018 12:37:28 +0530
Message-ID: <20181026070726.GA30088@Pilot130>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
 <1539749466-3912-9-git-send-email-open.sudheer@gmail.com>
 <20181017060531.GU2400@vkoul-mobl>
 <351eecd5b1b21893e94f76b34c058c6257b7f837.camel@kernel.crashing.org>
 <20181018095507.GC2400@vkoul-mobl>
 <a3fecf7913d6a85a6294afbc5a1a18b7714d6756.camel@kernel.crashing.org>
 <20181019071154.GE13642@Pilot130>
 <20181020162624.GC2894@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181020162624.GC2894@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod <vkoul@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Russell King <linux@armlinux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Moese <mmoese@suse.de>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, Oct 20, 2018 at 09:56:24PM +0530, Vinod wrote:
> On 19-10-18, 12:41, sudheer.v wrote:
> > On Fri, Oct 19, 2018 at 10:32:24AM +1100, Benjamin Herrenschmidt wrote:
> > > On Thu, 2018-10-18 at 15:25 +0530, Vinod wrote:
> > > > 
> > > > > It's not a dmaengine driver. It's a serial UART driver that happens to
> > > > > use a dedicated DMA engine.
> > > > 
> > > > Then I see no reason for it to use dmaengine APIs. The framework allows
> > > > people to share a controller for many clients, but if you have dedicated
> > > > one then you may use it directly
> > > 
> > > Well... the engine is shared by a few UARTs, they have dedicated rings
> > > but there's a common set of regs for interrupt handling etc.
> > > 
> > > That said, I still think it could be contained within a UART driver,
> > > there's little benefit in adding the framework overhead, esp since
> > > these are really weak cores, any overhead will be felt.
> > > 
> > > Ben.
> > > 
> > > > > It's unclear whether it should be split into two drivers, or just have
> > > > > the serial driver directly use the dma engine since that engine is
> > > > > dedicated in HW to only work on those UARTs and nothing else...
> > > > > 
> > > > > Cheers,
> > > > > Ben.
> > 
> > Initially we wanted to have  a single driver,
> > however we had an informal discussion with one of the maintainer 
> > and based on the feedback, followed the Linux DMA and UART architecture.
> > 
> > If this seperate DMA-engine driver adds more overhead than benifit,
> > we will merge them into a single UART driver and resubmitt the patches.
> > Vinod,
> >       can this dma-controller driver sit under dma subsystem?.
> >       or better to move it under UART framework.
> 
> 
> My advise would be to see what you can do with the DMA IP block. If this
> can/would be used in different places then it would make sense to do a
> dmaengine driver and solve the problem for everyone.
> 
> If this is always going to be hidden behind serial then maybe it makes
> sense to be inside serial driver and not use dmaengine APIs
> 
> If you decide to prefer the former case, please move it to dmaengine and
> resubmit :)
> 
> HTH
> -- 
> ~Vinod

Hi All,
 As the DMA engine is dedicated only to UART,we have decided 
 to rewrite the driver so that no code will come under 
 drivers/dma.
 
 I will resubmitt the patches after merging dma controller
 code and uart driver code.
Regards
-sudheer
