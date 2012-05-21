From: "Donald" <donald@asix.com.tw>
Subject: RE: Questions regarding adding a patch in linux/drivers/char/8250.c
Date: Mon, 21 May 2012 20:54:58 +0800
Message-ID: <00b701cd3750$f09ced60$d1d6c820$@com.tw>
References: <00a301cd3719$b3faa370$1befea50$@com.tw> <20120521103009.7f4be5e0@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from asix.com.tw ([113.196.140.82]:57679 "EHLO asix.com.tw"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755592Ab2EUM4C (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 May 2012 08:56:02 -0400
In-Reply-To: <20120521103009.7f4be5e0@pyramind.ukuu.org.uk>
Content-Language: zh-tw
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Alan Cox' <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

Hi Alan,

Thank you for your quick reply and nice questions. We will have an internal discussion regarding your questions and then I will
reply to your questions as soon as possible. 

Regards,
Donald 

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Monday, May 21, 2012 5:30 PM
To: Donald
Cc: linux-serial@vger.kernel.org
Subject: Re: Questions regarding adding a patch in linux/drivers/char/8250.c

On Mon, 21 May 2012 14:19:34 +0800
"Donald" <donald@asix.com.tw> wrote:

> Hi,
> 
> This is Donald from ASIX Electronics Corp. My company has three PCI to Serial controllers, including MCS9845, MCS9835, and
MCS9820.
> Currently those serial devices using these three chips can directly 
> use the Linux kernel's serial driver in linux/drivers/char/8250.c. 
> Recently we find these three chips have a hardware bug relating to parity error count function. We have a software workaround for
this issue. Below for reference is a pseudo code for this workaround.

Actually I have a second question.

Would it not be better to set the device to 8N1 and do the parity in software rather than lose the FIFO, especially at higher speeds
? Can you clarify what the erratum is triggered by ?

Alan



