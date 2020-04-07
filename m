Return-Path: <SRS0=8eBw=5X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C83C2BABC
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 09:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0666A206F7
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 09:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDGJBX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:01:23 -0400
Received: from submit-3.e-mind.com ([188.94.192.49]:41464 "EHLO
        submit-3.e-mind.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgDGJBX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Apr 2020 05:01:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by submit-3.e-mind.com (Postfix) with ESMTP id 24E3C846A0F
        for <linux-serial@vger.kernel.org>; Tue,  7 Apr 2020 09:01:20 +0000 (UTC)
Received: from submit-3.e-mind.com ([127.0.0.1])
        by localhost (submit-3.e-mind.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FmEr22YcgNnm for <linux-serial@vger.kernel.org>;
        Tue,  7 Apr 2020 11:01:20 +0200 (CEST)
Received: from qmail.e-mind.com (qmail34.e-mind.com [188.94.192.34])
        by submit-3.e-mind.com (Postfix) with SMTP id BCB1D842153
        for <linux-serial@vger.kernel.org>; Tue,  7 Apr 2020 11:01:10 +0200 (CEST)
Received: (qmail 1175 invoked by uid 0); 7 Apr 2020 09:01:07 -0000
Received: from unknown (HELO ?192.168.143.6?) (185.53.252.165)
  by 0 with SMTP; 7 Apr 2020 09:01:07 -0000
Subject: Re: Serial data loss
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <960c5054-48b0-fedc-4f3a-7246d84da832@eurek.it>
 <20200407082454.GA299198@kroah.com>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gianluca Renzi <icjtqr@gmail.com>,
        dimka@embeddedalley.com, linux@rempel-privat.de
From:   gianluca <gianlucarenzi@eurek.it>
Message-ID: <19bbd87d-75d7-3d9f-d7c1-629d1cc961e8@eurek.it>
Date:   Tue, 7 Apr 2020 11:01:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200407082454.GA299198@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,
I am very pleased the Mr. Greg Kroah-Hartman is writing to me in person!

I appreciate a lot sir!

On 04/07/2020 10:24 AM, Greg Kroah-Hartman wrote:
> On Tue, Apr 07, 2020 at 09:30:21AM +0200, gianluca wrote:
>> I have a BIG trouble having dataloss when using two internal serial ports of
>> my boards based on NXP/FreeScale iMX28 SoC ARMv5Te ARM920ej-s architecture.
>>
>> It runs at 454Mhz.
>>
>> Kernel used 4.9.x
>
> That's a very old kernel, you are going to have to get support for that
> from the vendor you bought it from :(
>

We are the vendor. ;-)

Jokes apart, I can try to use the latest kernel 5.6, and see how is 
going on them, but at the first check the driver seems exactly the same 
as in kernel 4.9.

>> When using my test case unit software between two serial ports connect each
>> other by a null modem cable, it fails when the speed rate are different,
>
> Of course, how would that work?
>

I am not native english speaker so I am misleading to a 
misunderstanding: my test case is a software with two pthreads which the 
main thread is working with a differnet baud rate than the other 
pthread. Using the same software in two different machines, and using 
the same baudrate for each corrispondant port it should work.

i.e. /dev/ttyAPP1 is running at 9600 and /dev/ttyAPP2 is running at 38400

The same in the other machine. Both ports are null-modem connected:

	9600  /dev/ttyAPP1 <----> /dev/ttyAPP1 9600
	38400 /dev/ttyAPP2 <----> /dev/ttyAPP2 38400

I hope to be clear now. ;-)

>> and
>> dataloss is increasing higher the speed rate.
>
> What type of flow control are you using?
>

Unfortunately no flow control. Because the I cannot use it. When 
connected to the real-hardware those two ports are connected to a 
microcontroller unit which does not have flow control, only RX & TX 
connected (i.e. no RTS/CTS/DTE/DCE lines)

>> I suppose to have overruns (now I am modifying my software to check them
>> too), but I think it is due the way the ISR is called and all data are
>> passed to the uart circular buffer within the interrupt routine.
>
> Are you using flow control?
>

As above, no [ unfortunately ]


>> I am talking about the high latency from the IRQ up to the service routine
>> when flushing the FIFO and another IRQ is called by another uart in the same
>> time at different speed.
>>
>> The code I was looking is: drivers/tty/serial/mxs-auart.c __but__ all other
>> serial drivers are acting in the same way: they are reading one character at
>> time from the FIFO (if it exists) and put it into the circular buffer so
>> serial/tty driver can pass them to the user read routine.
>>
>> Each function call has some overhead and it is time-consuming, and if
>> another interrupt is invoked by the same UART Core but from another serial
>> port (different context) the continuos insertion done by hardware UART into
>> the FIFO cannot be served fast enough to have an overrun. I think this can
>> be applied __almost__ to every serial driver as they are written in the same
>> way.
>>
>> And it is __NOT__ an issue because of the CPU and its speed! Using two
>> serial converter (FTDI and Prolific PL2303 based) on each board, the problem
>> does not appear at all even after 24 hours running at more than 115200!!!
>
> usb-serial devices are totally different and send data to the host in a
> completly different way.
>
> Your hardware might just not be able to handle really high baud rates at
> a continous stream, what baud rate were you using?
>

I suppose that, but the same issue can be proven with all single core 
(NO FIFO UART) processors using two ports on the same uart core, running 
Linux kernel @ 450 Mhz or less.

The irq latency it is the same.

> And again, this is what flow control was designed for, please use it.
>

I know and usually I am using a sort of protocol which can check 
correctness of packet, and if not, the packet has to be reasked/resent.
In this case the microcontroller board I am connected to is not built by 
us, and the software is a custom protocol (and I do not know if an error 
on transfer can be accomplished by another request).

So the flow control __CANNOT_BE_USED_AT_ALL__...

>> It does work fine if I am using two different serial devices: one internal
>> uart (mxs-auart) and an external uart (ttyUSB).
>
> Again, different interrupt and protocols being used for the USB stuff.
>

...and in our case is working better than the internal uart driver on 
the same board. It is a real pity...

> thanks,
>

Thanks to you, mr. greg k-h!

> greg k-h


P.S.: I am a very close friend of Andrea Arcangeli, we grew up in the 
same place, and we went in the same school here in Italy (Imola - bologna).

We used to talked about you last Christmas Holidays when Andrea came to 
Italy from NY

Regards,
Gianluca Renzi
-- 
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
