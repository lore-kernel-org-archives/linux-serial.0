From: "Salomon, Frank" <frank.salomon@wincor-nixdorf.com>
Subject: Re: serial port read working but not write.
Date: Mon, 26 Jul 2004 09:24:27 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <4104B1AB.7090005@wincor-nixdorf.com>
References: <20040724233650.78426.qmail@web8201.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from muxi.wincor-nixdorf.com ([217.115.67.71]:51653 "HELO
	mail.wincor-nixdorf.com") by vger.kernel.org with SMTP
	id S264965AbUGZHjm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Jul 2004 03:39:42 -0400
Received: from label.wincor-nixdorf.com (label.wincor-nixdorf.com [172.18.160.24])
	by zipp.wincor-nixdorf.com (8.12.8/8.12.8) with ESMTP id i6Q7deAw008469
	for <linux-serial@vger.kernel.org>; Mon, 26 Jul 2004 09:39:40 +0200
In-Reply-To: <20040724233650.78426.qmail@web8201.mail.in.yahoo.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org



suresh shenoy wrote:
> Hi all,
> 
>   
>    Frank, 
>   
>      I tried that test. It told me that hexdump was
> not a option in dd. I dont know much about dd so i
> read the man pages but could not figure out. 
> 
> 
>    Secondly,
> 
>       I changed the interrupt to 0 but still the
> numbers are increasing. 
> 
>       One thing that i did recognize is the baud rate
> for send was wrong which i changed to 115200 and then
> tried again but it still dint work. I am sending the
> correct packets. There could be no errors there. Also
> there is no parity in this program.
> 
> Thanks & Regards,
> Suresh

Hi Suresh,

did you forget "|"  in the command ?

dd bs=1 count=1 if=/dev/ttySx | hexdump

You can try to run the command:

setserial /dev/ttySx autoconfig auto_irq

before you perform the test. That command will set the correct interrupt.

Best regards, Frank

