From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [RFT PATCH 1/2] serial: Fix console setup section mismatch
Date: Tue, 31 May 2016 15:21:42 +0100
Message-ID: <20160531142142.GX19428@n2100.arm.linux.org.uk>
References: <1464704372-17668-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <sparclinux-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464704372-17668-1-git-send-email-k.kozlowski@samsung.com>
Sender: sparclinux-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Tobias Klauser <tklauser@distanz.ch>, Nicolas Ferre <nicolas.ferre@atmel.com>, Sonic Zhang <sonic.zhang@analog.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Barry Song <baohua@kernel.org>, "David S. Miller" <davem@davemloft.net>, Tony Prisk <linux@prisktech.co.nz>, Michal Simek <michal.simek@xilinx.com>, =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, nios2-dev@lists.rocketboards.org, adi-buildroot-devel@lists.sourceforge.net, linux-a
List-Id: linux-serial@vger.kernel.org

On Tue, May 31, 2016 at 04:19:31PM +0200, Krzysztof Kozlowski wrote:
> Remove __init annotation from all of console->setup implementations
> because:
> 1. The pointer to it is stored in a struct console which is not
>    marked with __initdata.
> 2. It is referenced by register_console() from kernel which is not
>    marked with __init.

However, many of these drivers, the console can only be used when the
driver is built-in, and register_console() is only called early in
initialisation.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
