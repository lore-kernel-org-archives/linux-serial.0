From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 00/10] bcm63xx_uart and of-serial updates
Date: Thu, 6 Nov 2014 10:49:18 -0800
Message-ID: <20141106184918.GA2279@kroah.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:52290 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbaKFStT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Nov 2014 13:49:19 -0500
Content-Disposition: inline
In-Reply-To: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org, arnd@arndb.de, geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Oct 21, 2014 at 03:22:56PM -0700, Kevin Cernekee wrote:
> V2->V3:
> 
> Change DT clock node based on review feedback (thanks Arnd!)
> 
> Rebase on Linus' master branch
> 
> 
> Kevin Cernekee (10):
>   tty: serial: bcm63xx: Allow bcm63xx_uart to be built on other
>     platforms
>   tty: serial: bcm63xx: Add support for unnamed clock outputs from DT
>   tty: serial: bcm63xx: Update the Kconfig help text
>   tty: serial: bcm63xx: Fix typo in MODULE_DESCRIPTION
>   Documentation: DT: Add entries for bcm63xx UART
>   tty: serial: bcm63xx: Enable DT earlycon support
>   tty: serial: bcm63xx: Eliminate unnecessary request/release functions
>   tty: serial: of-serial: Suppress warnings if OF earlycon is invoked
>     twice
>   tty: serial: of-serial: Allow OF earlycon to default to "on"
>   MAINTAINERS: Add entry for rp2 (Rocketport Express/Infinity) driver
> 
>  .../devicetree/bindings/serial/bcm63xx-uart.txt    | 30 ++++++++++++
>  MAINTAINERS                                        |  6 +++
>  drivers/of/fdt.c                                   | 17 +++++--
>  drivers/tty/serial/Kconfig                         | 30 ++++++++----
>  drivers/tty/serial/bcm63xx_uart.c                  | 55 +++++++++++++---------
>  include/linux/serial_bcm63xx.h                     |  2 -
>  6 files changed, 104 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/bcm63xx-uart.txt

I've applied 8 of these patches, not patches 08 or 09 at this time.

thanks,

greg k-h
