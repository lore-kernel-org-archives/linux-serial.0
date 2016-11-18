From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
Date: Fri, 18 Nov 2016 10:20:49 +0100
Message-ID: <2436881.9RqUVYxmDf@wuerfel>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com> <1478806353.7430.137.camel@kernel.crashing.org> <5825984B.3030303@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <5825984B.3030303@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "zhichang.yuan" <yuanzhichang@hisilicon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mark Rutland <mark.rutland@arm.com>, gabriele.paoloni@huawei.com, catalin.marinas@arm.com, will.deacon@arm.com, linuxarm@huawei.com, lorenzo.pieralisi@arm.com, xuwei5@hisilicon.com, linux-serial@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, minyard@acm.org, marc.zyngier@arm.com, liviu.dudau@arm.com, john.garry@huawei.com, zourongrong@gmail.com, robh+dt@kernel.org, bhelgaas@google.com, kantyzc@163.com, zhichang.yuan02@gmail.com, linux-kernel@vger.kernel.org, olof@lixom.net
List-Id: linux-serial@vger.kernel.org

On Friday, November 11, 2016 6:07:07 PM CET zhichang.yuan wrote:
> 
> I have similar idea as your PPC MMIO.
> 
> We notice the prototype of {in/out()} is something like that:
> 
> static inline u8 inb(unsigned long addr)
> static inline void outb(u8 value, unsigned long addr)
> 
> The type of parameter 'addr' is unsigned long. For I/O space, it is big enough.
> So, could you divide this 'addr' into several bit segments? The top 8 bits is
> defined as bus index. For normal direct IO, the bus index is 0. For those bus
> device which need indirectIO or some special I/O accessors, when these devices
> are initializing, can request to allocate an unique ID to them, and register
> their own accessors to the entry which is corresponding to the ID.

Ah, have you looked at the IA64 code? It does exactly this.
For ARM64 we decided to use the same basic approach as powerpc with
a single range of virtual memory for mapping it as that somewhat
simplified all cases we knew about at the time.

> In this way, we can support multiple domains, I think.
> But I am not sure whether it is feasible, for example, are there some
> architectures/platforms had populated the top 8 bits? Do we need to request IO
> region from ioport_resource for those devices?  etc...

On a 64-bit architecture, the top 32 bits of the port number are
definitely free to use for this, and 8 bits are probably sufficient.

Even on 32 bit architectures, I can't see why we'd ever need more than
16 bits worth of addressing within a domain, so using 8 bit domain
and 16 bit address leaves 8 or 40 unused bits.

	Arnd
