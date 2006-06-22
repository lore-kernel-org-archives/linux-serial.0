From: Sergei Organov <osv@javad.com>
Subject: Re: [Q] New tty flip interface doubt.
Date: Thu, 22 Jun 2006 19:17:50 +0400
Message-ID: <87d5d15ie9.fsf@javad.com>
References: <87hd2epuu6.fsf@javad.com>
	<20060621134208.GA12884@devserv.devel.redhat.com>
	<87irmt63wk.fsf@javad.com>
	<20060622125652.GA23090@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from javad.com ([216.122.176.236]:18704 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1751821AbWFVPSI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Jun 2006 11:18:08 -0400
In-Reply-To: <20060622125652.GA23090@devserv.devel.redhat.com> (Alan Cox's
	message of "Thu, 22 Jun 2006 08:56:52 -0400")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-serial@vger.kernel.org

Alan Cox <alan@redhat.com> writes:
> On Thu, Jun 22, 2006 at 11:33:15AM +0400, Sergei Organov wrote:
>> One more question, if I get memory for N bytes with
>> tty_prepare_flip_string() then store M (M <= N) bytes into the buffer,
>> how do I tell tty layer that only M bytes are in fact stored?
>
> You don't.
>
>> [I'm thinking about eliminating buffers allocation for urbs as well as
>> data copy when transferring data from USB subsystem to flip buffers of
>> the tty subsystem. Currently the flow is:
>
> The tty buffers may not be DMAable

I saw this warning, but didn't think that USB urbs must be given DMAable
memory. Does "transfer_buffer: This buffer has to be allocated as a
non-pageable contiguous physical memory block" imply the memory must be
DMAable? If it doesn't, then do tty buffers meet the above cited
requirement?

>
>> and it seems that using tty buffers directly is a better idea:
>> 
>> - allocate N-bytes data buffer from tty and use it for urb
>> - submit the urb to USB subsystem
>> - flip M-bytes of data (M <= N) in USB receive callback.
>
> Its doable in theory but is it worth it ?

Well, I don't actually know, -- does your experience suggest it is not? 

I thought that saving roughly 30% memory (ttys require x2 memory due to
flags, right?) plus eliminating memcpy(), could be a valuable
improvement, especially for embedded/low end systems and/or USB2 speeds.

If you don't see some hard to avoid obstacles making it difficult to
implement, I'll probably try to modify tty layer to be able to support
such a feature to see what it gives.

[My daily job is programming real-time applications for embedded
systems, and time to time I do consider Linux a platform for our future
embedded development.  Recent progress of the kernel towards
preemptibility and real-time performance is very promising, so I'm
somewhat interested party indeed.]

-- 
Sergei.
