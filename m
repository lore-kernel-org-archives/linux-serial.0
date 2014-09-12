From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH v2 3/9] ARM: meson: serial: add MesonX SoC on-chip uart driver
Date: Fri, 12 Sep 2014 08:59:07 +0200
Message-ID: <CAOQ7t2a6ngA3CUWTAgwn=imJTQwfJK4_b=ig89tafky8fj7T_w@mail.gmail.com>
References: <1410466300-19168-1-git-send-email-carlo@caione.org>
	<1410466300-19168-4-git-send-email-carlo@caione.org>
	<20140911212534.GA17251@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:34591 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbaILG7H (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Sep 2014 02:59:07 -0400
In-Reply-To: <20140911212534.GA17251@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Carlo Caione <carlo@caione.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "jslaby@suse.cz" <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Beniamino Galvani <b.galvani@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, afaerber@suse.de, Matthias Brugger <matthias.bgg@gmail.com>

On Thu, Sep 11, 2014 at 11:25 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Sep 11, 2014 at 10:11:34PM +0200, Carlo Caione wrote:
>> The SoC has four fully functional UARTs which use the same programming
>> model. They are named UART_A, UART_B, UART_C and UART_AO (Always-On)
>> which cannot be powered off.
>>
>> Signed-off-by: Carlo Caione <carlo@caione.org>
>> ---
>>  drivers/tty/serial/Kconfig       |  18 ++
>>  drivers/tty/serial/Makefile      |   1 +
>>  drivers/tty/serial/meson_uart.c  | 634 +++++++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/serial_core.h |   3 +
>>  4 files changed, 656 insertions(+)
>>  create mode 100644 drivers/tty/serial/meson_uart.c
>
> I've already taken this patch, why resend it?

Just for completeness' sake since there is also the documentation in
the patchset.
In the cover I specified that it was already taken.

I'll leave it out in v3 (if any).

-- 
Carlo Caione
