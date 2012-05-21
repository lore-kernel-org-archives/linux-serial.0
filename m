From: Jason Smith <jason.smith@ni.com>
Subject: Re: Questions regarding adding a patch in linux/drivers/char/8250.c
Date: Mon, 21 May 2012 10:07:24 -0500
Message-ID: <OF3B2C85A3.A3F15B1E-ON86257A05.005280F3-86257A05.00531366@ni.com>
References: <00a301cd3719$b3faa370$1befea50$@com.tw> <20120521103009.7f4be5e0@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailserver6.natinst.com ([130.164.80.6]:59028 "EHLO
	spamkiller06.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab2EUPHf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 May 2012 11:07:35 -0400
In-Reply-To: <20120521103009.7f4be5e0@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Donald <donald@asix.com.tw>, linux-serial@vger.kernel.org, linux-serial-owner@vger.kernel.org

On Mon, May 21, 2012 at 4:30 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> 
wrote:
> On Mon, 21 May 2012 14:19:34 +0800
> "Donald" <donald@asix.com.tw> wrote:
>
>> Hi,
>>
>> This is Donald from ASIX Electronics Corp. My company has three PCI to 
Serial controllers, including MCS9845, MCS9835, and MCS9820.
>> Currently those serial devices using these three chips can directly use 
the Linux kernel's serial driver in
>> linux/drivers/char/8250.c. Recently we find these three chips have a 
hardware bug relating to parity error count function. We have a
>> software workaround for this issue. Below for reference is a pseudo 
code for this workaround.
>
> Actually I have a second question.
>
> Would it not be better to set the device to 8N1 and do the parity in
> software rather than lose the FIFO, especially at higher speeds ? Can 
you
> clarify what the erratum is triggered by ?
>
> Alan


I saw your suggestion and thought it could work for a UART we are working 
with as well, which cannot identify which bytes have parity errors. 
However, It seems that doing parity in software would be a fine solution 
if you are using less than 8 data bits, but would not work with 8 bits + 
parity. Unless the UART supports 9 data bits, you would be unable to read 
the parity byte from the UART, and would still have the same problem.

-Jason




From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
To:     "Donald" <donald@asix.com.tw>
Cc:     <linux-serial@vger.kernel.org>
Date:   05/21/2012 04:29 AM
Subject:        Re: Questions regarding adding a patch in 
linux/drivers/char/8250.c
Sent by:        linux-serial-owner@vger.kernel.org



On Mon, 21 May 2012 14:19:34 +0800
"Donald" <donald@asix.com.tw> wrote:

> Hi,
> 
> This is Donald from ASIX Electronics Corp. My company has three PCI to 
Serial controllers, including MCS9845, MCS9835, and MCS9820.
> Currently those serial devices using these three chips can directly use 
the Linux kernel's serial driver in
> linux/drivers/char/8250.c. Recently we find these three chips have a 
hardware bug relating to parity error count function. We have a
> software workaround for this issue. Below for reference is a pseudo code 
for this workaround.

Actually I have a second question.

Would it not be better to set the device to 8N1 and do the parity in
software rather than lose the FIFO, especially at higher speeds ? Can you
clarify what the erratum is triggered by ?

Alan


--
To unsubscribe from this list: send the line "unsubscribe linux-serial" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


