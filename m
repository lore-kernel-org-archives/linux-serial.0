From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: RFC: cleaning up the serial drivers and use struct resource
Date: Tue, 12 Mar 2019 15:57:32 +0100
Message-ID: <1552402660-31730-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello folks,

I'm currently working on some cleanups in drivers/tty/serial.

There're several cases where new helpers, like devm_platform_ioremap_resource
can be used, other places can use devm_ioremap_resource() for a bit
cleaner code.

Another topic here is using struct resource, instead of separate fields
(BTW: struct uart_port->mapsize doesn't seem to be used consequently):
in struct uart_port, I'm adding a struct resource field for holding the
port's iomem range, and helpers for it. Then, I'm step by step patching
the individual drivers to use that, instead of the old fields, directly.

For now, this all is early, untested and not yet meant for mainline.
I'd just like to have your oppions on my approach.

What do you think about it ?


thx
--mtx
