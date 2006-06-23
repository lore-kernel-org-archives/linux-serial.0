From: Alan Cox <alan@redhat.com>
Subject: Re: [Q] New tty flip interface doubt.
Date: Fri, 23 Jun 2006 09:16:13 -0400
Message-ID: <20060623131613.GA27504@devserv.devel.redhat.com>
References: <87hd2epuu6.fsf@javad.com> <20060621134208.GA12884@devserv.devel.redhat.com> <87irmt63wk.fsf@javad.com> <20060622125652.GA23090@devserv.devel.redhat.com> <87d5d15ie9.fsf@javad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:16002 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964818AbWFWNQP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Jun 2006 09:16:15 -0400
Content-Disposition: inline
In-Reply-To: <87d5d15ie9.fsf@javad.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sergei Organov <osv@javad.com>
Cc: Alan Cox <alan@redhat.com>, linux-serial@vger.kernel.org

On Thu, Jun 22, 2006 at 07:17:50PM +0400, Sergei Organov wrote:
> I saw this warning, but didn't think that USB urbs must be given DMAable
> memory. Does "transfer_buffer: This buffer has to be allocated as a
> non-pageable contiguous physical memory block" imply the memory must be
> DMAable? If it doesn't, then do tty buffers meet the above cited
> requirement?

At the moment the tty buffers are a chain of buffers meeting that requirement.

> >> - allocate N-bytes data buffer from tty and use it for urb
> >> - submit the urb to USB subsystem
> >> - flip M-bytes of data (M <= N) in USB receive callback.
> >
> > Its doable in theory but is it worth it ?
> 
> Well, I don't actually know, -- does your experience suggest it is not? 

On a PC almost certainly not because the cost of the accesses is almost nil
with the cache sizes on the CPU die and the performance of the CPU. Embedded
I don't know , you tell me 8)

> If you don't see some hard to avoid obstacles making it difficult to
> implement, I'll probably try to modify tty layer to be able to support
> such a feature to see what it gives.

I've no problem with that. At the moment the allocations all use kmalloc
which should be fine for remapping. At worst you could add an optional

tty->alloc_buf
tty->free_buf

function pointer pair

Alan

