From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/10] serial: mvebu-uart: initial support for Armada-3700 serial port
Date: Tue, 02 Feb 2016 22:07:17 +0100
Message-ID: <5687888.WDl8xbENFR@wuerfel>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com> <1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Wilson Ding <dingwei@marvell.com>, Nadav Haklai <nadavh@marvell.com>
List-Id: linux-serial@vger.kernel.org

On Tuesday 02 February 2016 19:07:39 Gregory CLEMENT wrote:

> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 39721ec4f415..b291f934d51b 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1606,6 +1606,28 @@ config SERIAL_STM32_CONSOLE
>  	depends on SERIAL_STM32=y
>  	select SERIAL_CORE_CONSOLE
>  
> +config SERIAL_MVEBU_UART
> +	bool "Marvell EBU serial port support"

Could this be a loadable module?

> +config SERIAL_MVEBU_CONSOLE
> +	bool "Console on Marvell EBU serial port"
> +	depends on SERIAL_MVEBU_UART

If yes, this would become 

	depends on SERIAL_MVEBU_UART=y

	Arnd

