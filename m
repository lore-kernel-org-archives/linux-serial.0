From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [RFC 0/3] Move some ARM header files to more appropriate locations
Date: Fri, 21 Sep 2012 10:35:30 +0100
Message-ID: <20120921093530.GB31374@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37269 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932609Ab2IUJfl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2012 05:35:41 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Eric Miao <eric.y.miao@gmail.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Imre Kaloz <kaloz@openwrt.org>, Kristoffer Ericson <kristoffer.ericson@gmail.com>, Krzysztof Halasa <khc@pm.waw.pl>, Nicolas Ferre <nicolas.ferre@atmel.com>

This series moves some of the misplaced ARM header files, which
contain driver platform data, out of arch/arm/include/asm/mach
and into include/linux/platform_data.

arch/arm/include/asm/mach is supposed to be for include files
exporting generic ARM code structures and functions to ARM platforms,
not for platforms to export platform data definitions to the rest
of the kernel.

This patch series addresses three of the files: the SA11x0 serial
driver platform data, the PXA2xx UDC driver, and the Atmel serial
driver.  Out of those three, I ended up deleting the Atmel serial
driver header as I could not find any user of the exported function
and its data structure anywhere in the kernel.

 arch/arm/include/asm/mach/serial_at91.h            |   33 --------------------
 arch/arm/mach-ixp4xx/include/mach/udc.h            |    2 +-
 arch/arm/mach-pxa/include/mach/udc.h               |    2 +-
 arch/arm/mach-sa1100/assabet.c                     |    2 +-
 arch/arm/mach-sa1100/badge4.c                      |    2 +-
 arch/arm/mach-sa1100/cerf.c                        |    2 +-
 arch/arm/mach-sa1100/collie.c                      |    2 +-
 arch/arm/mach-sa1100/h3xxx.c                       |    2 +-
 arch/arm/mach-sa1100/hackkit.c                     |    2 +-
 arch/arm/mach-sa1100/jornada720.c                  |    2 +-
 arch/arm/mach-sa1100/lart.c                        |    2 +-
 arch/arm/mach-sa1100/nanoengine.c                  |    2 +-
 arch/arm/mach-sa1100/neponset.c                    |    2 +-
 arch/arm/mach-sa1100/pleb.c                        |    2 +-
 arch/arm/mach-sa1100/shannon.c                     |    2 +-
 arch/arm/mach-sa1100/simpad.c                      |    2 +-
 arch/avr32/include/asm/mach/serial_at91.h          |   33 --------------------
 drivers/tty/serial/atmel_serial.c                  |   18 -----------
 drivers/tty/serial/sa1100.c                        |    2 +-
 drivers/usb/gadget/pxa25x_udc.c                    |    4 +--
 .../linux/platform_data/pxa2xx_udc.h               |    5 ++-
 .../linux/platform_data/sa11x0-serial.h            |    6 ++-
 22 files changed, 24 insertions(+), 107 deletions(-)
 delete mode 100644 arch/arm/include/asm/mach/serial_at91.h
 delete mode 100644 arch/avr32/include/asm/mach/serial_at91.h
 rename arch/arm/include/asm/mach/udc_pxa2xx.h => include/linux/platform_data/pxa2xx_udc.h (94%)
 rename arch/arm/include/asm/mach/serial_sa1100.h => include/linux/platform_data/sa11x0-serial.h (93%)
