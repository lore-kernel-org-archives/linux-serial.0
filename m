From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for special ISA
Date: Wed, 09 Nov 2016 22:38:32 +0100
Message-ID: <5900275.i4NZvtxTcC@wuerfel>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com> <2368890.jTbyGqYR0M@wuerfel> <20161109135453.2e5402bd@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20161109135453.2e5402bd@lxorguk.ukuu.org.uk>
Sender: linux-pci-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, "zhichang.yuan" <yuanzhichang@hisilicon.com>, catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, bhelgaas@google.com, olof@lixom.net, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, minyard@acm.org, benh@kernel.crashing.org, liviu.dudau@arm.com, zourongrong@gmail.com, john.garry@huawei.com, gabriele.paoloni@huawei.com, zhichang.yuan02@gmail.com, kantyzc@163.com, xuwei5@hisilicon.com, marc.zyngier@arm.com
List-Id: linux-serial@vger.kernel.org

On Wednesday, November 9, 2016 1:54:53 PM CET One Thousand Gnomes wrote:
> > I think it is a relatively safe assumption that there is only one
> > ISA bridge. A lot of old drivers hardcode PIO or memory addresses
> 
> It's not a safe assumption for x86 at least. There are a few systems with
> multiple ISA busses particularly older laptops with a docking station.

But do they have multiple ISA domains? There is no real harm in supporting
it, the (small) downsides I can think of are:

- a few extra cycles for the lookup, from possibly walking a linked list
  to find the correct set of helpers and MMIO addresses
- making it too general could invite more people to design hardware
  around the infrastructure when we really want them to stop adding
  stuff like this.

	Arnd
