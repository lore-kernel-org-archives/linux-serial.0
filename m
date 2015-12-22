From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v4 1/2] serial: rewrite pxa2xx-uart to use 8250_core
Date: Tue, 22 Dec 2015 20:27:05 +0100
Message-ID: <87a8p2ffna.fsf@belgarion.home>
References: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
	<1449700088-28076-1-git-send-email-ynvich@gmail.com>
	<1449700088-28076-2-git-send-email-ynvich@gmail.com>
	<8737uyhaji.fsf@belgarion.home> <87y4cqfu2j.fsf@belgarion.home>
	<1450550792.15911.5.camel@gmail.com> <87twnefd67.fsf@belgarion.home>
	<1450555955.15911.14.camel@gmail.com> <87poy2f2xw.fsf@belgarion.home>
	<1450610665.15911.53.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450610665.15911.53.camel@gmail.com> (Sergei Ianovich's message
	of "Sun, 20 Dec 2015 14:24:25 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Ianovich <ynvich@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kevin Hilman <khilman@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Sergei Ianovich <ynvich@gmail.com> writes:

> On Sun, 2015-12-20 at 00:12 +0100, Robert Jarzmik wrote:
>> Sergei Ianovich <ynvich@gmail.com> writes:
>> 
>> > On Sat, 2015-12-19 at 20:31 +0100, Robert Jarzmik wrote:
>> > I understand that people are afraid of taking this patch. If it
>> > starts
>> > causing troubles at runtime, it will be difficult to diagnose. There
>> > will be no console for most people. So it is probably good idea to
>> > fail
>> > at boot time.
>> If it's about something already written in a mailing
>> list, please point me to it so that it can help me think about it.
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/2167
> 73.html
>
> I can explain why I think so. Greg acked the patch, but hasn't merged it
> since then. He has good reasons for this most probably. Russell's
> comment pointed by the link seems to be the reason.

> I think the problem raised by Russell could be addressed. My best guess
> is compile time error, despite your comment above.
I re-read carefully Russell's answer in [1].

What Russell asked is that for a period of time, the old pxa serial code and the
new will be in the kernel, so that maintainers have the option to switch over to
the old drivers/tty/serial/pxa.c if the new 8250 based version breaks their
userspace getty.

Then, once the transition is done, and that for a period (let's say 1 year) no
maintainer had complained while its defconfig was switched over to the new 8520
version, then and only then you will remove drivers/tty/serial/pxa.c.

> I have one more plan. For transition period, we can introduce a
> temporary Kconfig option SERIAL_8250_PXA_OFF, and fail at build time if
> neither SERIAL_8250_PXA nor SERIAL_8250_PXA_OFF is set. This way all
> interested parties will be notified of this driver update.
No, I'd like to stick with Russell's original plan :
 - phase 1: both SERIAL_8250_PXA and SERIAL_PXA exist in KConfig
            both are selectable
            This lasts one year or something like that
 - phase 2: remove SERIAL_PXA from KConfig and drivers/tty/serial/pxa.c

This means a different patch from the one acked by Greg, and a new serie of
acks. The diffstat will be way worse (as you won't have the -970 for pxa.c), but
in the end it will end up on that -970.

That sounds like a good transition plan to me.

Cheers.

-- 
Robert

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/216773.html
