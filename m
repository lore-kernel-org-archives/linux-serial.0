From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH wq/for-3.19 3/3] workqueue: dump workqueues on sysrq-t
Date: Wed, 10 Dec 2014 13:34:50 -0500
Message-ID: <20141210183450.GG6294@htj.dyndns.org>
References: <20141208174326.GB12274@htj.dyndns.org>
 <20141208174406.GC12274@htj.dyndns.org>
 <20141208174733.GD12274@htj.dyndns.org>
 <20141208100613.ecc66d89.akpm@linux-foundation.org>
 <20141208184035.GE12274@htj.dyndns.org>
 <20141208110515.7860d68baca2b3bd46c9dab7@linux-foundation.org>
 <20141208192229.GF12274@htj.dyndns.org>
 <20141210045057.GA11973@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141210045057.GA11973@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Lai Jiangshan <laijs@cn.fujitsu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-serial@vger.kernel.org

Hello, Greg.

On Tue, Dec 09, 2014 at 11:50:57PM -0500, Greg Kroah-Hartman wrote:
> Oh wait, I think that might be it, shift is needed for the sysrq key on
> the keyboard to start with, right?  So there probably isn't a way to

On x86, the combo is alt-sysrq, so shift can theoretically be added.

> test the difference of a lower/upper case key here.
> 
> I'm traveling this week, and don't have access to a "real" keyboard at
> the moment, but this should be pretty easy for someone to test who has
> one and cares about this type of thing {hint}.

Just tested on a PS/2 port attached keyboard and it doesn't go
through.  I'm not sure where this is getting lost but given that
people sometimes have to use ctrl too to invoke sysrq, throwing in
shift makes it a four key combo which is likely to be over the
rollover capabilities of most keyboards.  It doesn't seem like a good
path to follow to me.  :(

Thanks.

-- 
tejun
