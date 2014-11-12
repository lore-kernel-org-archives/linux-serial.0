From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH/RFC 5/8] serial: pxa: Make the driver buildable for
 BCM7xxx set-top platforms
Date: Wed, 12 Nov 2014 01:19:24 -0800
Message-ID: <CAJiQ=7AFr5vR+FEc8B3CAZLb5GYujNxtaz7TU2FU0D3oModZ7w@mail.gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
 <1415781993-7755-6-git-send-email-cernekee@gmail.com> <3356477.HitZEsNa4H@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:45880 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbaKLJTq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 04:19:46 -0500
In-Reply-To: <3356477.HitZEsNa4H@wuerfel>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, tushar.behera@linaro.org, daniel@zonque.org, Haojian Zhuang <haojian.zhuang@gmail.com>, robert.jarzmik@free.fr, Grant Likely <grant.likely@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Nov 12, 2014 at 1:04 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 12 November 2014 00:46:30 Kevin Cernekee wrote:
>> Remove the platform dependency in Kconfig and add an appropriate
>> compatible string.  Note that BCM7401 has one 16550A-compatible UART
>> in the UPG uart_clk domain, and two proprietary UARTs in the 27 MHz
>> clock domain.  This driver handles the former one.
>>
>> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>
> Can you explain why you are using the PXA serial driver instead of the
> 8250 driver, if this is 16550A compatible? I don't know the history
> why PXA is using a separate driver.

I wasn't able to get serial8250 to work in any situation where another
driver tried to claim "ttyS"/4/64.

serial8250 calls uart_add_one_port() in its module_init function, even
if the system doesn't have any ports.  Setting nr_uarts
(CONFIG_SERIAL_8250_RUNTIME_UARTS) to 0 doesn't help because
serial8250_find_match_or_unused() will just return NULL.

I guess I could try to rework that logic but several cases would need
to be retested, going back to PCs with ISA buses and PCI add-in cards.
And the differences may be visible to userspace.

The PXA driver seemed like a much cleaner starting point, even if it
was intended for a different SoC.
