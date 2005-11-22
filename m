From: Dick Hollenbeck <dick@softplc.com>
Subject: Re: PROBLEM: serial port FIONREAD from realtime thread
Date: Tue, 22 Nov 2005 13:32:24 -0600
Message-ID: <43837248.5050601@softplc.com>
References: <43834F70.4010404@softplc.com> <43836D8C.3040307@microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ylpvm53-ext.prodigy.net ([207.115.57.84]:15024 "EHLO
	ylpvm53.prodigy.net") by vger.kernel.org with ESMTP id S965148AbVKVTaR
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Nov 2005 14:30:17 -0500
In-Reply-To: <43836D8C.3040307@microgate.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Fulghum <paulkf@microgate.com>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

Paul Fulghum wrote:

> Dick Hollenbeck wrote:
>
>> Problem Conditions:
>>
>> 1) linux 2.6.11.7, but possibly other kernels too
>> 1) realtime thread
>> 2) serial port open()ed *either* with NON_BLOCKING or not
>> 3) ioctl( FIONREAD ) always returns zero
>> ...
>> What causes this?   What is the usleep() enabling?
>
>
> The tty flip buffering uses a workqueue
> to push received data to the line discipline.
>
> Your polling loop at raised priority
> is probably preventing the workqueue
> from being processed by the events
> kernel thread.
>
> When you call usleep() your process yields
> so receive data can be processed.
>
> Have you tried (just for testing)
> lowering your process priority below that
> of the events kernel thread?
>
Thanks Paul.  This sounds right.  No, I have not dialed in at such a 
fine granularity.  Obviously at a non realtime priority things work OK, 
and obviously I need to run at a realtime priority.  There may be some 
room to fit in between.

1) Can you point me at the source file(s) where I can explore this 
further? (source file the workqueue written to).

2) How do I determine the priority of the events kernel thread (where is 
it created, and/or priority set).


Thanks much.

