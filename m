From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 01/12] irqchip: armada-370-xp: add Kconfig option for the driver
Date: Tue, 09 Feb 2016 16:14:32 +0100
Message-ID: <7747159.T9eeT0dC65@wuerfel>
References: <1454951660-13289-1-git-send-email-gregory.clement@free-electrons.com> <1454951660-13289-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454951660-13289-2-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>
List-Id: linux-serial@vger.kernel.org

On Monday 08 February 2016 18:14:09 Gregory CLEMENT wrote:
> 
> +config ARMADA_370_XP_IRQ
> +       bool
> +       default y if ARCH_MVEBU
> +       select GENERIC_IRQ_CHIP
> +
> 

Looks good. I wonder if we should also enable this for COMPILE_TEST, e.g.

config ARMADA_370_XP_IRQ
       bool "Marvell Armada 3xx/XP/3xxx interrupt controller" if COMPILE_TEST && !ARCH_MVEBU
       default ARCH_MVEBU
       select GENERIC_IRQ_CHIP

If we do this, it's probably something outside of your series that we should
do for all patches, so don't worry about it here. Any opinions on the general
question?

	Arnd
