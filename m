From: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH] tty: ar933x_uart: use the clk API to get the uart clock
Date: Wed, 28 Aug 2013 10:02:22 +0200
Message-ID: <521DAE8E.3030007@openwrt.org>
References: <1377634465-8353-1-git-send-email-juhosg@openwrt.org> <20130827232707.GA10719@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:39050 "EHLO
	mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab3H1IIE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Aug 2013 04:08:04 -0400
In-Reply-To: <20130827232707.GA10719@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

2013.08.28. 1:27 keltez=E9ssel, Greg Kroah-Hartman =EDrta:
> On Tue, Aug 27, 2013 at 10:14:25PM +0200, Gabor Juhos wrote:
>> The AR933x UARTs are only used on the Atheros AR933x
>> SoCs. The base clock frequency of the UART is passed
>> to the driver via platform data. The SoC support code
>> implements the generic clock API, and the clock rate
>> can be retrieved via that.
>>
>> Update the code to get the clock rate via the generic
>> clock API instead of using the platform data.
>>
>> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
>> ---
>> Note:
>>
>> Because the driver specific platform data only contains
>> the clock frequency it can be removed. In order to avoid
>> merge conflicts between different trees, it will be removed
>> by a later patch once this one is merged upstream.
>=20
> I don't understand what you mean by this.

Currently the clock frequency is passed to the driver through platform =
data and
the platform data is initialized via platform specific setup code in
'arch/mips/ath79/dev-common.c'.

After this patch, the platform data is not used by the driver, so the
initialization will be superfluous and it can be removed along with the
'arch/mips/include/asm/mach-ath79/ar933x_uart_platform.h' header file.

However those changes would cause merge conflicts with my other patches=
 which
are going through the MIPS tree so I kept out that part from the patch.

> Also, this patch doesn't even apply to my tty-next tree, so I can't
> accept it as-is, so please fix it up,

Sorry, it was based on 3.11-rc7. Will rebase it against the tty-next tr=
ee.

> work with the people whose patches yours is conflicting with, and fig=
ure out
> how to do this with the least amount of merge issues.

Ok.

Thanks,
Gabor
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
