From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH] tty: Only wakeup the line discipline idle queue when
 queue is active
Date: Mon, 21 Jan 2013 08:26:03 +0530
Message-ID: <50FCAE43.7090206@linux.vnet.ibm.com>
References: <50E3FDFA.4070203@suse.cz> <20130102114311.66215bf5@pyramind.ukuu.org.uk> <CAMSQXEHmDb5rUQnT1JNcMCzdaN+gAr+1hR=PyPiDMu7vK5ykxA@mail.gmail.com> <50E4854E.8060801@suse.cz> <CAMSQXEGU2WmhmMqP7XMK2x39GN9iDDWpg-Wa7_cAauHWx5OWbQ@mail.gmail.com> <50F66120.50704@linux.vnet.ibm.com> <CAMSQXEE=Qp8kVcEp8nBhNDmOaDMUQUUou+5Z2f8-1znykqy6mQ@mail.gmail.com> <50F683D9.1080908@linux.vnet.ibm.com> <CAMSQXEHjP5mzs9u5DUmuYgoEceM2OO=E8844-XQ7LPCSECoGRw@mail.gmail.com> <50F7D8C2.1030506@linux.vnet.ibm.com> <20130118154504.GA28072@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:57750 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610Ab3AUC5I (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 20 Jan 2013 21:57:08 -0500
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-serial@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Mon, 21 Jan 2013 12:52:15 +1000
In-Reply-To: <20130118154504.GA28072@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ivo Sieben <meltedpianoman@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>

On 01/18/2013 09:15 PM, Oleg Nesterov wrote:
> On 01/17, Preeti U Murthy wrote:
>>
>> On 01/16/2013 05:32 PM, Ivo Sieben wrote:
>>>
>>> I don't have a problem that there is a context switch to the high
>>> priority process: it has a higher priority, so it probably is more
>>> important.
>>> My problem is that even when the waitqueue is empty, the high priority
>>> thread has a risk to block on the spinlock needlessly (causing context
>>> switches to low priority task and back to the high priority task)
>>>
>> Fair enough Ivo.I think you should go ahead with merging the
>> waitqueue_active()
>>   wake_up()
>> logic into the wake_up() variants.
> 
> This is not easy. We can't simply change wake_up*() helpers or modify
> __wake_up().

Hmm.I need to confess that I don't really know what goes into a change
such as this.Since there are a lot of waitqueue_active()+wake_up()
calls,I was wondering why at all have a separate logic as
waitqueue_active(),if we could do what it does in wake_up*(). But you
guys can decide this best.
> 
> I can't understand why do you dislike Ivo's simple patch. There are
> a lot of "if (waitqueue_active) wake_up" examples. Even if we add the
> new helpers (personally I don't think this makes sense) , we can do
> this later. Why should we delay this fix?

Personally i was concerned about how this could cause a scheduler
overhead.There does not seem to be much of a problem here.Ivo's patch
for adding a waitqueue_active() for his specific problem would also do
well,unless there is a dire requirement for a clean up,which I am unable
to evaluate.

> 
> Oleg.
> 

Thank you

Regards
Preeti U Murthy

