From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 03/12] serial: mvebu-uart: initial support for Armada-3700 serial port
Date: Tue, 16 Feb 2016 22:20:51 +0100
Message-ID: <3647094.zzYms58VAY@wuerfel>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com> <1455646502-23834-4-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455646502-23834-4-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>, Wilson Ding <dingwei@marvell.com>
List-Id: linux-serial@vger.kernel.org

On Tuesday 16 February 2016 19:14:53 Gregory CLEMENT wrote:
> 
> +config SERIAL_MVEBU_UART
> +       bool "Marvell EBU serial port support"
> +       select SERIAL_CORE

It would be nice to make this a tristate option with

	depends on ARCH_MVEBU || COMPILE_TEST

so we can build it in an allmodconfig kernel as a standalone module
like the other drivers.

> +
> +config SERIAL_MVEBU_CONSOLE
> +       bool "Console on Marvell EBU serial port"
> +       depends on SERIAL_MVEBU_UART

then this one must become

	depends on SERIAL_MVEBU_UART

so it does not get enabled if the driver is not builtin.

	Arnd
