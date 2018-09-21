From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: add serial.h and set BASE_BAUD to 0
Date: Fri, 21 Sep 2018 14:59:14 +0100
Message-ID: <20180921135913.GM30658@n2100.armlinux.org.uk>
References: <20180920201357.16426-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180920201357.16426-1-zajec5@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 20, 2018 at 10:13:57PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> For years arm has been using serial.h from asm-generic which sets
> BASE_BAUD value to the (1843200 / 16). This is incorrect as:
> 1) This value obviously isn't correct for all devices
> 2) There are no device specific serial.h with CONFIG_ARCH_MULTIPLATFORM

This goes back a long way.  The BASE_BAUD definition is the base baud
for 8250 compatible UARTs _only_, no others.

However, as of 182ead3e418a ("earlycon: Remove hardcoded port->uartclk
initialization in of_setup_earlycon"), port->uartclk is no longer
initialised using BASE_BAUD.  As acknowledged in 814453adea7d
("earlycon: Initialize port->uartclk based on clock-frequency property")
the initialisation using BASE_BAUD was bogus, and there is now the
clock-frequency DT property which should be present to set this up.

Now, setting BASE_BAUD to zero as per your patch will break the
8250 serial driver - this relies on BASE_BAUD being set to the
current value, and yes, ARM hardware that uses this will break.  So
this is not a solution.

The only solution is that BASE_BAUD must not be abused - it must not
be used by non-8250 hardware, and thankfully there are already
solutions in the kernel (such as clock-frequency) to allow the clock
rate to be specified.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
