From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [[PATCH] 8/9] DMA-UART-Driver-for-AST2500
Date: Fri, 19 Oct 2018 10:32:24 +1100
Message-ID: <a3fecf7913d6a85a6294afbc5a1a18b7714d6756.camel@kernel.crashing.org>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
 <1539749466-3912-9-git-send-email-open.sudheer@gmail.com>
 <20181017060531.GU2400@vkoul-mobl>
 <351eecd5b1b21893e94f76b34c058c6257b7f837.camel@kernel.crashing.org>
 <20181018095507.GC2400@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181018095507.GC2400@vkoul-mobl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vinod <vkoul@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, linux-aspeed@lists.ozlabs.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Michael Moese <mmoese@suse.de>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, Joel Stanley <joel@jms.id.au>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, ShivahShankar Shakarnarayan rao <shivahshankar.shankarnarayanrao@aspeedtech.com>, Rob Herring <robh+dt@kernel.org>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, Sudheer V <sudheer.veliseti@aspeedtech.com>, Andrew Jeffery <andrew@aj.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, "sudheer.v" <open.sudheer@gmail.com>, Philippe
List-Id: linux-serial@vger.kernel.org

On Thu, 2018-10-18 at 15:25 +0530, Vinod wrote:
> 
> > It's not a dmaengine driver. It's a serial UART driver that happens to
> > use a dedicated DMA engine.
> 
> Then I see no reason for it to use dmaengine APIs. The framework allows
> people to share a controller for many clients, but if you have dedicated
> one then you may use it directly

Well... the engine is shared by a few UARTs, they have dedicated rings
but there's a common set of regs for interrupt handling etc.

That said, I still think it could be contained within a UART driver,
there's little benefit in adding the framework overhead, esp since
these are really weak cores, any overhead will be felt.

Ben.

> > It's unclear whether it should be split into two drivers, or just have
> > the serial driver directly use the dma engine since that engine is
> > dedicated in HW to only work on those UARTs and nothing else...
> > 
> > Cheers,
> > Ben.
> > 
> > 
> > > While doing resubmission please take some time to understand subsystem
> > > tags to use. (hint git log <subsystem> will tell you)
> > > 
> > > Also series has [[PATCH] 8/9] whereas it should be [PATCH 8/9] please
> > > let git generate that for you (hint git format-patch start..end does a
> > > good job)
> > > 
> > > > @@ -0,0 +1,1594 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + *   drivers/tty/serial/8250/8250_aspeed_uart_dma.c
> > > > + *    1. 2018/07/01 Shivah Shankar created
> > > > + *    2. 2018/08/25 sudheer.veliseti<open.sudheer@gmail.com> modified
> > > 
> > > we dont use this log in kernel. I do not see s-o-b by Shivah, that
> > > should be added. I think he should be author and you need to list
> > > changes you did..
> > > 
> 
> 
