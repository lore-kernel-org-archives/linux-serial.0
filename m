From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [REPOST] RFC: sched: Prevent wakeup to enter critical section
	needlessly
Date: Tue, 9 Oct 2012 17:17:29 +0200
Message-ID: <20121009151729.GA3521@redhat.com>
References: <1348491997-30898-1-git-send-email-meltedpianoman@gmail.com> <1349782235-8896-1-git-send-email-meltedpianoman@gmail.com> <m2r4p7u5pk.fsf@firstfloor.org> <1349792104.7880.41.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42178 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756091Ab2JIPQD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Oct 2012 11:16:03 -0400
Content-Disposition: inline
In-Reply-To: <1349792104.7880.41.camel@twins>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <andi@firstfloor.org>, Ivo Sieben <meltedpianoman@gmail.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>

On 10/09, Peter Zijlstra wrote:
>
> One thing you might need to consider is the memory ordering, will the
> list_empty -- either careful or not -- observe the right list pointer,
> or could it -- when racing with wait_event()/prepare_to_wait() --
> observe a stale value. Or.. is that all already covered in on the use
> site.

I agree.

Without spin_lock(q->lock) (or some other barriers) wait_event-like
code can miss an event.

wait_event:

	prepare_to_wait(wq)	// takes wq->lock

	if (!CONDITION)
		schedule();

Now,

	CONDITION = 1;
	wake_up(wq);

at least need the full mb() before lits_empty().

Oleg.

