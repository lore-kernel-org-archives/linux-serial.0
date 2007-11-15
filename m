From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH] CRISv10 fasttimer: Scrap INLINE and name timeval_cmp better
Date: Thu, 15 Nov 2007 09:10:18 +0100
Message-ID: <20071115081017.GS6347@axis.com>
References: <20071114170850.GR6347@axis.com> <200711141829.17361.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from miranda.se.axis.com ([193.13.178.8]:56605 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbXKOIKb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Nov 2007 03:10:31 -0500
Content-Disposition: inline
In-Reply-To: <200711141829.17361.vda.linux@googlemail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mikael Starvik <mikael.starvik@axis.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Wed, Nov 14, 2007 at 06:29:17PM -0800, Denys Vlasenko wrote:
> On Wednesday 14 November 2007 09:08, Jesper Nilsson wrote:
> >  /* Not true gettimeofday, only checks the jiffies (uptime) + useconds */
> > -void __INLINE__ do_gettimeofday_fast(struct fasttime_t *tv)
> > +inline void do_gettimeofday_fast(struct fasttime_t *tv)
> 
> Why these functions are not "static inline"?
> Wthout "static", gcc will actually create non-inlined version of them!
> 
> $ cat t.c
> inline int f() { return 1; }
> int g() { return f(); }
> $ gcc -O2 -c t.c
> $ nm --size-sort t.o
> 0000000a T f   <=================== !!!
> 0000000a T g

Quite true, I'll put that on the "to check" pile.

> P.S. whitespace style in fasttimer.c doesn't match rest of the kernel
> (kernel uses tab, not 2-spaces indentation). Curly braces don't match too:
>   if (t0->tv_sec < t1->tv_sec)
>   {
>     return -1;
>   }
> should be
>       if (t0->tv_sec < t1->tv_sec) {
>               return -1;
>       }

Yup, that item is already on my "to fix" list.

> --
> vda

Thanks for your comments!

/^JN - Jesper Nilsson
--
               Jesper Nilsson -- jesper.nilsson@axis.com
