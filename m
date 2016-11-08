From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for special
 ISA
Date: Tue, 08 Nov 2016 17:19:54 +0100
Message-ID: <2368890.jTbyGqYR0M@wuerfel>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
 <20161108114953.GB15297@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161108114953.GB15297@leverpostej>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: gabriele.paoloni@huawei.com, benh@kernel.crashing.org, will.deacon@arm.com, linuxarm@huawei.com, lorenzo.pieralisi@arm.com, xuwei5@hisilicon.com, linux-serial@vger.kernel.org, catalin.marinas@arm.com, devicetree@vger.kernel.org, minyard@acm.org, marc.zyngier@arm.com, liviu.dudau@arm.com, john.garry@huawei.com, zourongrong@gmail.com, robh+dt@kernel.org, bhelgaas@google.com, kantyzc@163.com, zhichang.yuan02@gmail.com, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, "zhichang.yuan" <yuanzhichang@hisilicon.com>, olof@lixom.net
List-Id: linux-serial@vger.kernel.org

On Tuesday, November 8, 2016 11:49:53 AM CET Mark Rutland wrote:
> On Tue, Nov 08, 2016 at 11:47:08AM +0800, zhichang.yuan wrote:
> > +Hisilicon Hip06 low-pin-count device
> > +  Usually LPC controller is part of PCI host bridge, so the legacy ISA ports
> > +  locate on LPC bus can be accessed direclty. But some SoCs have independent
> > +  LPC controller, and access the legacy ports by triggering LPC I/O cycles.
> > +  Hisilicon Hip06 implements this LPC device.
> 
> s/direclty/directly/
> 
> My understanding of ISA (which may be flawed) is that it's not part of
> the PCI host bridge, but rather on x86 it happens to share the IO space
> with PCI.

On normal systems, ISA or LPC are behind a PCI bridge device, which
passes down both low addresses of I/O space and memory space.

> So, how about this becomes:
> 
>   Hisilicon Hip06 SoCs implement a Low Pin Count (LPC) controller, which
>   provides access to some legacy ISA devices.
> 
> I believe that we could theoretically have multiple independent LPC/ISA
> busses, as is possible with PCI on !x86 systems. If the current ISA code
> assumes a singleton bus, I think that's something that needs to be fixed
> up more generically.
> 
> I don't see why we should need any architecture-specific code here. Why
> can we not fix up the ISA bus code in drivers/of/address.c such that it
> handles multiple ISA bus instances, and translates all sub-device
> addresses relative to the specific bus instance?

I think it is a relatively safe assumption that there is only one
ISA bridge. A lot of old drivers hardcode PIO or memory addresses
when talking to an ISA device, so having multiple instances is
already problematic.

What is odd about ARM64 here is that the PIO space is not shared among
all ISA and PCI buses in some cases.

	Arnd
