From: Noam Camus <noamc@ezchip.com>
Subject: RE: 8250_early for big-endian
Date: Fri, 12 Oct 2012 20:41:56 +0200
Message-ID: <264C179F799EF24AB26D5319053335E80CC30499A4@ezexch.ezchip.com>
References: <264C179F799EF24AB26D5319053335E80CC30499A2@ezexch.ezchip.com>,<20121012175150.4b081343@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ezexch.ezchip.com ([212.179.42.101]:43632 "EHLO
	ezexch.ezchip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753973Ab2JLSmh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Oct 2012 14:42:37 -0400
In-Reply-To: <20121012175150.4b081343@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

________________________________________
>From: Alan Cox [alan@lxorguk.ukuu.org.uk]
>Sent: Friday, October 12, 2012 6:51 PM
>To: Noam Camus
>Cc: linux-serial@vger.kernel.org
>Subject: Re: 8250_early for big-endian
>
>> I am using 8250 console and wish to use the 8250_early as well.
>>
>> I encounter endianess problem while using this driver for mmio32.
.>>
>> The problem is since my serial peripheral like my cpu is in BIG endian.
>>
>> Driver through serial_in/serial_out uses readl/writel from asm-generic/io.h.
>>
>> These macros assume peripheral is always in LITTLE endian.
>>
>> Therefore all data needs a swab.
>>
>> In 8250 driver I can register replacement for default serial_in/serial_out and workaround the problem.
>> In 8250_early I had no choice but to change code with additional swab to workaround the problem.
>>
>> I am looking for proper solution so it can be added to upstream.
>> I got several ideas if interest arise.
>
>Given they are all byte registers so how can they need swapping ? They are
>merely 3 further bytes offset.
>
>Alan

Of course swapping is a waste of cpu cycles.
Workaround can be 3 further bytes offset.
Thanks

Back to my problem.
How can 8250_early be enhanced to support big endian registers.
Is it configuation?
Maybe command line flag?
both? other?

Noam