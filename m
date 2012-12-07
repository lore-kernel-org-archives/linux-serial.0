From: Woody Wu <narkewoody@gmail.com>
Subject: 16C554 (16550 compatiable) UART autoconf failed (8250 driver)
Date: Fri, 7 Dec 2012 07:02:08 +0000 (UTC)
Message-ID: <slrnkc351k.2ck.narkewoody@zuhnb712.local.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58306 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754269Ab2LHOT6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Dec 2012 09:19:58 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1ThLG8-0006ls-9U
	for linux-serial@vger.kernel.org; Sat, 08 Dec 2012 15:20:04 +0100
Received: from 59.37.26.98 ([59.37.26.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Sat, 08 Dec 2012 15:20:04 +0100
Received: from narkewoody by 59.37.26.98 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Sat, 08 Dec 2012 15:20:04 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi, list

Does anyone here familiar to the serial 8250 driver?

I enabled two uart ports in my board definition, but the ports doesn't
appear after I loaded the kernel (3.4.19).  I discovered, it failed at
the UART port auto configuration stage, the exact function is
autoconfig(...) in drivers/tty/serial/8250.c.

...
    if (!(port->flags & UPF_BUGGY_UART)) {
        scratch = serial_in(up, UART_IER);
        serial_out(up, UART_IER, 0);
#ifdef __i386__
        outb(0xff, 0x080);
#endif
        /*
         * Mask out IER[7:4] bits for test as some UARTs (e.g. TL
         * 16C754B) allow only to modify them if an EFR bit is set.
         */
        scratch2 = serial_in(up, UART_IER) & 0x0f;
        serial_out(up, UART_IER, 0x0F);
#ifdef __i386__
        outb(0, 0x080);
#endif
        scratch3 = serial_in(up, UART_IER) & 0x0f;
        serial_out(up, UART_IER, scratch);
        if (scratch2 != 0 || scratch3 != 0x0F) {
            /*
             * We failed; there's nothing here
             */
            DEBUG_AUTOCONF("IER test failed (%02x, %02x) ",
                       scratch2, scratch3);
            goto out;
        }
    }

By enabling the debug output, I found it failed because values in scratch2 and
scratch3 are all zeros.


In my board definition, what I configured are something like:

#define SERIAL_BASE  (0xe1400000)
#define SERIAL_FLAGS (UPF_BOOT_AUTOCONF | UPF_IOREMAP | UPF_SHARE_IRQ)
#define SERIAL_CLK   (14745600) 

static struct plat_serial8250_port lgf2410_urts_data[] = {
    [0] = {
        .mapbase    = SERIAL_BASE + 0x00,
        .irq        = 16,
        .flags      = SERIAL_FLAGS,
        .iotype     = UPIO_MEM,
        .regshift   = 0,
        .uartclk    = SERIAL_CLK,
    },
    [1] = {
        .mapbase    = SERIAL_BASE + 0x10,
        .irq        = 17,
        .flags      = SERIAL_FLAGS,
        .iotype     = UPIO_MEM,
        .regshift   = 0,
        .uartclk    = SERIAL_CLK,
    },
};

static struct platform_device lgf2410_urts = {
    .name           = "serial8250",
    .id         = PLAT8250_DEV_PLATFORM,
    .dev            = {
        .platform_data  = &lgf2410_urts_data,
    },
};

I think the mapbase addresses are corrected. Since I copied these addresse from
a old kernel log output from a 2.6.16 linux. For the old 2.6.16 kernel, which
run the exact same board, I have no information how it was configured.

Below is the 2.6.16 kernel output, it successfully detected the UART
ports:

serial8250: tts0 at MMIO 0xe1400000 (irq = 16) is a 16550A
serial8250: tts1 at MMIO 0xe1400008 (irq = 16) is a 16550A
serial8250: tts2 at MMIO 0xe1400010 (irq = 17) is a 16550A
serial8250: tts3 at MMIO 0xe1400018 (irq = 17) is a 16550A

Now I expect the same result from my self tailored 3.4.19 kernel.

Hope I can get your kind support! Thanks.




-- 
woody
I can't go back to yesterday - because I was a different person then.

