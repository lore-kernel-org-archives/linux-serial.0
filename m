From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v4 03/12] serial: mvebu-uart: initial support for
 Armada-3700 serial port
Date: Tue, 16 Feb 2016 22:27:06 +0100
Message-ID: <20160216222706.6b1d3375@free-electrons.com>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
	<1455646502-23834-4-git-send-email-gregory.clement@free-electrons.com>
	<3647094.zzYms58VAY@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3647094.zzYms58VAY@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>, Wilson Ding <dingwei@marvell.com>
List-Id: linux-serial@vger.kernel.org

Arnd,

On Tue, 16 Feb 2016 22:20:51 +0100, Arnd Bergmann wrote:

> > +config SERIAL_MVEBU_CONSOLE
> > +       bool "Console on Marvell EBU serial port"
> > +       depends on SERIAL_MVEBU_UART
> 
> then this one must become
> 
> 	depends on SERIAL_MVEBU_UART
> 
> so it does not get enabled if the driver is not builtin.

Hm, what's the different between "depends on SERIAL_MVEBU_UART" and
"depends on SERIAL_MVEBU_UART" ? Is it the late time that causes my
eyes to misunderstand what you mean, or some typo on your side ? :-)

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
