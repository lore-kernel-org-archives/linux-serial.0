From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v4 09/28] tty: serial: Add Actions Semi Owl UART earlycon
Date: Sun, 18 Jun 2017 23:45:28 +0200
Message-ID: <55059fdd-5c54-ee6c-3e63-b5a9035c1745@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-10-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606005426.26446-10-afaerber@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, support@lemaker.org, =?UTF-8?B?5byg5aSp55uK?= <tyzhang@actions-semi.com>, 96boards@ucrobotics.com, linux-kernel@vger.kernel.org, Thomas Liau <thomas.liau@actions-semi.com>, mp-cs@actions-semi.com, linux-serial@vger.kernel.org, =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, Jiri Slaby <jslaby@suse.com>, =?UTF-8?B?5byg5Lic6aOO?= <zhangdf@actions-semi.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

Greg,

Am 06.06.2017 um 02:54 schrieb Andreas Färber:
> This implements an earlycon for Actions Semi S500/S900 SoCs.
> 
> Based on LeMaker linux-actions tree.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  v3 -> v4: Unchanged
>  
>  v2 -> v3:
>  * Adopted BIT() macro
>  
>  v1 -> v2:
>  * Extended Kconfig help to mention earlycon (Arnd)
>  * Spelled out Actions Semiconductor in Kconfig help
>  * Adopted "actions" vendor prefix
>  
>  drivers/tty/serial/Kconfig    |  19 ++++++
>  drivers/tty/serial/Makefile   |   1 +
>  drivers/tty/serial/owl-uart.c | 135 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 155 insertions(+)
>  create mode 100644 drivers/tty/serial/owl-uart.c

The DT vendor prefix is applied to my linux-actions.git tree now, and
the serial binding has been ack'ed by Rob.

Is there anything keeping you from adding this patch, the preceding DT
binding (08/28) and the following documentation patch (10/28) to your
tree for 4.13?

The full serial driver (16/28) needs another spin and may miss 4.13, but
earlycon would prove the rest is working.

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
