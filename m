From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Wed, 09 Nov 2016 22:34:38 +0100
Message-ID: <2825537.ADCNsGqGxn@wuerfel>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com> <1555494.4IFvGxvsfe@wuerfel> <EE11001F9E5DDD47B7634E2F8A612F2E1F8F1A7A@lhreml507-mbx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F8F1A7A@lhreml507-mbx>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>, Yuanzhichang <yuanzhichang@hisilicon.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "minyard@acm.org" <minyard@acm.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, John Garry <john.garry@huawei.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "xuwei (O)" <xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>, "olof@lixom.net" <olof@lixom.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "zourongrong@gmail.com" <zourongrong@gmail.com>"linux-serial@vger.kernel.org" <linux->
List-Id: linux-serial@vger.kernel.org

On Wednesday, November 9, 2016 12:10:43 PM CET Gabriele Paoloni wrote:
> > On Tuesday, November 8, 2016 11:47:09 AM CET zhichang.yuan wrote:
> > > +       /*
> > > +        * The first PCIBIOS_MIN_IO is reserved specifically for
> > indirectIO.
> > > +        * It will separate indirectIO range from pci host bridge to
> > > +        * avoid the possible PIO conflict.
> > > +        * Set the indirectIO range directly here.
> > > +        */
> > > +       lpcdev->io_ops.start = 0;
> > > +       lpcdev->io_ops.end = PCIBIOS_MIN_IO - 1;
> > > +       lpcdev->io_ops.devpara = lpcdev;
> > > +       lpcdev->io_ops.pfin = hisilpc_comm_in;
> > > +       lpcdev->io_ops.pfout = hisilpc_comm_out;
> > > +       lpcdev->io_ops.pfins = hisilpc_comm_ins;
> > > +       lpcdev->io_ops.pfouts = hisilpc_comm_outs;
> > 
> > I have to look at patch 2 in more detail again, after missing a few
> > review
> > rounds. I'm still a bit skeptical about hardcoding a logical I/O port
> > range here, and would hope that we can just go through the same
> > assignment of logical port ranges that we have for PCI buses,
> > decoupling
> > the bus addresses from the linux-internal ones.
> 
> The point here is that we want to avoid any conflict/overlap between
> the LPC I/O space and the PCI I/O space. With the assignment above
> we make sure that LPC never interfere with PCI I/O space.

But we already abstract the PCI I/O space using dynamic registration.
There is no need to hardcode the logical address for ISA, though
I think we can hardcode the bus address to start at zero here.

	Arnd
