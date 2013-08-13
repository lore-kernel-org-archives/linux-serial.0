From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v2] serial: OMAP: add RS485 support
Date: Tue, 13 Aug 2013 13:14:42 +0200
Message-ID: <CAAwP0s3ie8=spaV9TP7O5MMySXhjKo=-0_1NnSUNy4S7=ZJEFA@mail.gmail.com>
References: <52079822.9020103@newflow.co.uk> <20130812225638.GA30919@kroah.com>
 <520A08FE.5070804@newflow.co.uk> <CAAwP0s1QyNjQb+0zhK_UeHraTW+R6Mefq1E4HyV-XJ4fV42w+g@mail.gmail.com>
 <520A1355.1050301@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:34699 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757287Ab3HMLPE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Aug 2013 07:15:04 -0400
In-Reply-To: <520A1355.1050301@newflow.co.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Jackson <mpfj-list@newflow.co.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-serial@vger.kernel.org, jslaby@suse.cz

On Tue, Aug 13, 2013 at 1:07 PM, Mark Jackson <mpfj-list@newflow.co.uk> wrote:
> On 13/08/13 11:54, Javier Martinez Canillas wrote:
>
> <snip>
>
>>
>> Hi Mark,
>>
>> I've seen several attempts to add RS485 support to the omap serial
>> driver and it is always nack-ed. There seems to be concerns about
>> controlling the RTS by software when RS485 is not supported by the
>> UART hardware. Please refer to [1] and [2] for more information.
>
> Hmmmm ... okay, I guess I'll just have to maintain our own code (as
> did the OP in [1]).
>

Yes, back then we had to do the same using Ilya Yanok's OMAP RS485
patches [1] on a vendor tree :(

> Thanks for the info.

I just wanted to avoid you wasting more time on this, unless the
mindset has changed in which case it would be really great to have
RS485 support for OMAP serial.

Thanks a lot and best regards,
Javier

[1]: http://comments.gmane.org/gmane.linux.serial/6770
