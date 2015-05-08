From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: How to use CONFIG_SERIAL_8250_SHARE_IRQ with device tree ?
Date: Fri, 8 May 2015 17:27:26 +0900
Message-ID: <CAK7LNARQqTrzWCSvKMw32NYTQiC++yE3y0DPa_TxUsq3YeD3=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hello, experts.

I am porting my board support for the latest kernel.


The 16550 UART device on my board (ARM architecture)
shares an IRQ line with an ethernet device.


With both devices enabled, I got an error message like this:

genirq:  Flags mismatch irq 18.  00000080 (serial) vs. 00000084 (eth0)


I am working on Linux 4.0 with device tree configuration.

Is there any solution?


When I used an old kernel with a board file,
I could use CONFIG_SERIAL_8250_SHARE_IRQ.

I gave it a try on the latest kernel, but it looked like no effect for me.

As I use device tree configuration, the UART is initialized
via drivers/tty/serial/of_serial.c

If CONFIG_SERIAL_8250_SHARE_IRQ is on, IRQF_SHARED is set
in serial8250_probe(), but this function is only for
pre-device-tree old boards, I think.


Is CONFIG_SERIAL_8250_SHARE_IRQ no longer supported
for DTS-configured boards?

Any hint is appreciated.

-- 
Best Regards
Masahiro Yamada
