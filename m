From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 06/11] tty: serial: Add Actions Semi Owl UART earlycon
Date: Mon, 20 Feb 2017 14:40:20 +0100
Message-ID: <072e4c03-74b7-c7d8-0e40-8944f8319159@suse.de>
References: <20170215165528.10052-1-afaerber@suse.de>
 <20170215165528.10052-7-afaerber@suse.de> <3685307.zVcugmQnxp@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3685307.zVcugmQnxp@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: support@lemaker.org, info@ucrobotics.com, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, mp-cs@actions-semi.com, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Am 16.02.2017 um 14:41 schrieb Arnd Bergmann:
> On Wednesday, February 15, 2017 5:55:23 PM CET Andreas Färber wrote:
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index 6117ac8..9d4213c 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -1677,6 +1677,25 @@ config SERIAL_MVEBU_CONSOLE
>>           and warnings and which allows logins in single user mode)
>>           Otherwise, say 'N'.
>>  
>> +config SERIAL_OWL
>> +       bool "Actions Semi Owl serial port support"
>> +       depends on ARCH_OWL || COMPILE_TEST
>> +       select SERIAL_CORE
>> +       help
>> +         This driver is for Actions Semi S500/S900 SoC's UART.
>> +         Say 'Y' here if you wish to use the on-board serial port.
>> +         Otherwise, say 'N'.
>> +
>>
> 
> This could maybe use a word of information about how there isn't
> actually a uart driver in this series, only an earlycon driver.

Yeah, I have added a sentence to the other one. Maybe also add a select?

> Do you plan to add the actual tty driver soon? If not, maybe
> only add one Kconfig symbol for the earlycon support.

So, I completed the driver the weekend and can see the full console
output, but there are still output glitches, possible locking issues up
to RCU stalls and soft lockups, and only stubbed out baudrate support.

Therefore I would rather keep the full driver as follow-up RFC in v2,
unless I get it fixed during Hackweek. In the earlycon I am confident,
and the only Kconfig change then is to switch from bool to tristate and
to drop the newly added sentence again.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
