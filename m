From: "Michael Langford" <mlangford@tieronedesign.com>
Subject: ttyS read/write errors after setting up memory mapped 16550A uart
Date: Wed, 22 Aug 2007 12:56:21 -0400
Message-ID: <3547473BFF99D74F875EEE3E38BCDDFF23A46F@tieroneserver.tier1design.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.tier1design.com ([68.16.98.218]:24788 "EHLO
	tieroneserver.tier1design.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751526AbXHVQ4i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Aug 2007 12:56:38 -0400
Content-class: urn:content-classes:message
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linux Serial Mailing List <linux-serial@vger.kernel.org>

Thank you in advance for those who are looking at this. 

I'm creating/configuring drivers for and otherwise bringing up a board
we have made. 

I believe my configuration of the driver for the 16550 external uart
chip on my board is off. I can see the 8250 driver get loaded in driver
init, as well as see the individual ports get added/configured in the
port registration routines in the 8250 driver, but when I attempt to
interact with the device file, I get the following two (somewhat
bizarre) errors:

echo foo > /dev/ttyS3
-sh: /dev/ttyS3: Is a directory

cat /dev/ttyS3
cat: read error: Input/output error


Using a simple userspace test program that calls getc and fprintf, I get
the following output from perror:

Can't write to the port: Bad file descriptor
Can't read from the port: Input/output error

(The FILE* is a non-zero entity before making these calls)


Here is how specify the memory IO regions and other settings for the
uart:

#define T1IXUART2 0xc000000
#define T1IXUART3 0xc000010
#define T1IXUART4 0xc000020
#define T1IXUART5 0xc000030

#define T1IXUART2_IRQ IRQ_GPIO(98)
#define T1IXUART3_IRQ IRQ_GPIO(99)
#define T1IXUART4_IRQ IRQ_GPIO(100)
#define T1IXUART5_IRQ IRQ_GPIO(101)

static struct plat_serial8250_port the_ports[] = {
     [0] = {
     .mapbase = (unsigned long) T1IXUART2,
     .irq  = T1IXUART2_IRQ,
     .flags  = UPF_BOOT_AUTOCONF | UPF_IOREMAP,
     .iotype  = UPIO_MEM,
     .regshift = 1,
     .iobase = 0,
     .uartclk = 3686400,
     },
     [1] = {
     .mapbase = (unsigned long) T1IXUART3,
     .irq  = T1IXUART3_IRQ,
     .iobase= 0,
     .flags  = UPF_BOOT_AUTOCONF | UPF_IOREMAP,
     .iotype  = UPIO_MEM,
     .regshift = 1,
     .uartclk = 3686400,
     },
     [2] = {
     .mapbase = (unsigned long) T1IXUART4,
     .irq  = T1IXUART4_IRQ,
     .flags  = UPF_BOOT_AUTOCONF | UPF_IOREMAP,
     .iotype  = UPIO_MEM,
     .regshift = 1,
     .uartclk = 3686400,
     },
     [3] = {
     .mapbase = (unsigned long) T1IXUART5,
     .irq  = T1IXUART5_IRQ,
     .flags  = UPF_BOOT_AUTOCONF | UPF_IOREMAP,
     .iotype  = UPIO_MEM,
     .regshift = 1,
     .uartclk = 3686400,
     },
     {},
    };

static struct platform_device serial_device = {
     .name   = "serial8250.%d",
     .id    = -1,
     .dev   = {
     .platform_data = the_ports,
     },
    };

static int __init ext_uart_init(void)
    {
     return platform_device_register(&serial_device);
    }


arch_initcall(ext_uart_init);


I am running kernel version 2.6.20.11 on a pxa270 arm chip. I've applied
the alternate serial port patch (which does not touch the 8250 driver or
config) to move the arm specific serial ports to major number 204 using
the ttySA* namespace. These ports are working fine (and are what I'm
using to debug the system). I'm displaying the console on these ports. 

In addition, the IO addresses, regshift and uartclk appear to be what
our chip/board layout requires. Additionally, I see the open call at
least propagating down to the serial driver.

Is there anything  obviously wrong with these settings?

References:
Google cache of the patch (main server isn't responding right now):
http://tinyurl.com/2gf8sh

     --Michael Langford


Ps: I apologize if this is a repost, I'd not properly beat outlook into
shape yet, and originally sent HTML mail.
--
Tier One Design
www.TierOneDesign.com

