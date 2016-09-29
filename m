From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update entry for atmel_serial driver
Date: Thu, 29 Sep 2016 08:17:31 +0200
Message-ID: <CACQ1gAiNNWqLmit-G4ch3eVJbBcB-QYa8eupRVqR8aVq6cjf7A@mail.gmail.com>
References: <20160928154735.25265-1-nicolas.ferre@atmel.com> <1475078653.2685.1.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475078653.2685.1.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
List-Id: linux-serial@vger.kernel.org

2016-09-28 18:04 GMT+02:00 Joe Perches <joe@perches.com>:
> On Wed, 2016-09-28 at 17:47 +0200, Nicolas Ferre wrote:
>> Change maintainer for the serial driver found on most of the
>> Microchip / Atmel MPUs and take advantage of the move to rename
>> and reorder the entry.
> []
>> diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> +MICROCHIP / ATMEL AT91 / AT32 SERIAL DRIVER
>> +M:   Richard Genoud <richard.genoud@gmail.com>
>> +S:   Maintained
>> +F:   drivers/tty/serial/atmel_serial.c
>> +F:   include/linux/atmel_serial.h
>
> Thanks Richard.
>
> include/linux is pretty cluttered with random files.
>
> atmel_serial.h is #include exactly once.
>
> Please move it out of include/linux and into
> drivers/tty/serial/ one day.
No problem, I'll add that to my TBD list !

Richard.
