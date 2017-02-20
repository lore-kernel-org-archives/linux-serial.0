From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 06/11] tty: serial: Add Actions Semi Owl UART earlycon
Date: Mon, 20 Feb 2017 16:17:06 +0100
Message-ID: <CAK8P3a3v=c4hNVotywiU7QmyhD5sFcqTWg2A=No-nzi235C9Fw@mail.gmail.com>
References: <20170215165528.10052-1-afaerber@suse.de> <20170215165528.10052-7-afaerber@suse.de>
 <3685307.zVcugmQnxp@wuerfel> <072e4c03-74b7-c7d8-0e40-8944f8319159@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <072e4c03-74b7-c7d8-0e40-8944f8319159@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, support@lemaker.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, info@ucrobotics.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mp-cs@actions-semi.com, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Feb 20, 2017 at 2:40 PM, Andreas F=C3=A4rber <afaerber@suse.de> wro=
te:
> Am 16.02.2017 um 14:41 schrieb Arnd Bergmann:
>> On Wednesday, February 15, 2017 5:55:23 PM CET Andreas F=C3=A4rber wrote=
:
>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>>> index 6117ac8..9d4213c 100644
>>> --- a/drivers/tty/serial/Kconfig
>>> +++ b/drivers/tty/serial/Kconfig
>>> @@ -1677,6 +1677,25 @@ config SERIAL_MVEBU_CONSOLE
>>>           and warnings and which allows logins in single user mode)
>>>           Otherwise, say 'N'.
>>>
>>> +config SERIAL_OWL
>>> +       bool "Actions Semi Owl serial port support"
>>> +       depends on ARCH_OWL || COMPILE_TEST
>>> +       select SERIAL_CORE
>>> +       help
>>> +         This driver is for Actions Semi S500/S900 SoC's UART.
>>> +         Say 'Y' here if you wish to use the on-board serial port.
>>> +         Otherwise, say 'N'.
>>> +
>>>
>>
>> This could maybe use a word of information about how there isn't
>> actually a uart driver in this series, only an earlycon driver.
>
> Yeah, I have added a sentence to the other one. Maybe also add a select?

I generally only use 'select' to avoid build failures, not to save the user
the time to make a choice.

>> Do you plan to add the actual tty driver soon? If not, maybe
>> only add one Kconfig symbol for the earlycon support.
>
> So, I completed the driver the weekend and can see the full console
> output, but there are still output glitches, possible locking issues up
> to RCU stalls and soft lockups, and only stubbed out baudrate support.
>
> Therefore I would rather keep the full driver as follow-up RFC in v2,
> unless I get it fixed during Hackweek. In the earlycon I am confident,
> and the only Kconfig change then is to switch from bool to tristate and
> to drop the newly added sentence again.

Ok, sounds good.

     Arnd
