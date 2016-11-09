From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
Date: Wed, 9 Nov 2016 13:54:53 +0000
Message-ID: <20161109135453.2e5402bd@lxorguk.ukuu.org.uk>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
        <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
        <20161108114953.GB15297@leverpostej>
        <2368890.jTbyGqYR0M@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2368890.jTbyGqYR0M@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, "zhichang.yuan" <yuanzhichang@hisilicon.com>, catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, bhelgaas@google.com, olof@lixom.net, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, minyard@acm.org, benh@kernel.crashing.org, liviu.dudau@arm.com, zourongrong@gmail.com, john.garry@huawei.com, gabriele.paoloni@huawei.com, zhichang.yuan02@gmail.com, kantyzc@163.com, xuwei5@hisilicon.com, marc.zyngier@arm.com
List-Id: linux-serial@vger.kernel.org

> I think it is a relatively safe assumption that there is only one
> ISA bridge. A lot of old drivers hardcode PIO or memory addresses

It's not a safe assumption for x86 at least. There are a few systems with
multiple ISA busses particularly older laptops with a docking station.

> when talking to an ISA device, so having multiple instances is
> already problematic.

PCMCIA devices handle it themselves so are ok. I'm not clear how the dual
PIIX4 configuration used in the older IBM laptop docks actually worked so
I assume the transaction went out of both bridges and providing one of
them responded the other kept silent as you simply stuffed the card into
the dock and it worked.

Alan
