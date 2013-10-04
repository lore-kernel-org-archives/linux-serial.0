From: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org
Subject: Re: [PATCH 3/6] sh: clkfwk: Select sh-/common- clkfwk alternatively
Date: Fri, 4 Oct 2013 14:25:17 +0900
Message-ID: <20131004142517.590a96bcb63330313ceb5298@ops.dti.ne.jp>
References: <52410F86.4040301@renesas.com>
	<20130924131206.d57d07f5faa5cb0773fc328c@ops.dti.ne.jp>
	<1663688.MHxO4ng5PY@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1663688.MHxO4ng5PY@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

> While I agree with this patch, I believe the use of the HAVE_MACH_CLKDEV 
> configuration option to select whether to compile core.o in is a bit of an 
> abuse. <snip>
Well, yes, indeed. It does not mean having include/mach/clkdev.h,
but means somewhat such like !COMMON_CLK.
# I think there is similar usage in arch/mips, though they define but not use.
# ... is an execution.

> However, as all ARCH_SHMOBILE platforms should be converted to the common 
> clock framework, this is only temporary and could be revisited later, so I'm 
> fine with keeping the patch as-is.
Sure.

Thank you for your review.
/yoshii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
