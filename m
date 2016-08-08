From: Dirk Eibach <dirk.eibach@gdsys.cc>
Subject: Re: [PATCH 1/2] sc16is7xx: Do not handle irqs in endless loop
Date: Mon, 8 Aug 2016 16:02:10 +0200
Message-ID: <CANVMifLptRS1_Qj9SB-a_cmADn+rgfat5FVtMhGXuYuyBJHh5g@mail.gmail.com>
References: <1470663136-26269-1-git-send-email-dirk.eibach@gdsys.cc> <20160808134315.GA11190@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160808134315.GA11190@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, jringle@gridpoint.com
List-Id: linux-serial@vger.kernel.org

2016-08-08 15:43 GMT+02:00 Greg KH <gregkh@linuxfoundation.org>:
> On Mon, Aug 08, 2016 at 03:32:15PM +0200, dirk.eibach@gdsys.cc wrote:
>> From: Dirk Eibach <dirk.eibach@gdsys.cc>
>>
>> sc16is7xx_port_irq() is laid out as an endless loop. It will exit only
>> when there is no more interrupt left to service. This not common
>> practice.
>> In our case it lead to some strange hangup situation when there was an
>> unexpected XOFF-interrupt that could not be handled.
>> So let's service interrupts only once and report XOFF-interrupts that
>> should never happen since they are never enabled.
>>
>> Signed-off-by: Dirk Eibach <dirk.eibach@gdsys.cc>
>>
>> Conflicts:
>>       drivers/tty/serial/sc16is7xx.c
>
> Why are these 2 lines in here?

Sorry, my bad. I have no idea how they slipped in. Will remove them in v2.

Cheers
Dirk
