From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH] CRISv10 fasttimer: Scrap INLINE and name timeval_cmp better
Date: Wed, 14 Nov 2007 18:29:17 -0800
Message-ID: <200711141829.17361.vda.linux@googlemail.com>
References: <20071114170850.GR6347@axis.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:50251 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbXKOD3a (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Nov 2007 22:29:30 -0500
Received: by rv-out-0910.google.com with SMTP id k20so370072rvb
        for <linux-serial@vger.kernel.org>; Wed, 14 Nov 2007 19:29:30 -0800 (PST)
In-Reply-To: <20071114170850.GR6347@axis.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mikael Starvik <mikael.starvik@axis.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Wednesday 14 November 2007 09:08, Jesper Nilsson wrote:
> Scrap the local __INLINE__ macro, and rename timeval_cmp to fasttime_cmp.
>
> Inline macro was completely unnecessary since the macro was defined
> locally to be inline.
> timeval_cmp was inaccurately named since it does comparison on
> struct fasttimer_t and not on struct timeval.
>
> Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>
> ---
>  fasttimer.c |   16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/arch/cris/arch-v10/kernel/fasttimer.c
> b/arch/cris/arch-v10/kernel/fasttimer.c index 645d705..c1a3a21 100644
> --- a/arch/cris/arch-v10/kernel/fasttimer.c
> +++ b/arch/cris/arch-v10/kernel/fasttimer.c
> @@ -46,8 +46,6 @@ static int sanity_failed;
>  #define D2(x)
>  #define DP(x)
>
> -#define __INLINE__ inline
> -
>  static unsigned int fast_timer_running;
>  static unsigned int fast_timers_added;
>  static unsigned int fast_timers_started;
> @@ -118,13 +116,13 @@ int timer_freq_settings[NUM_TIMER_STATS];
>  int timer_delay_settings[NUM_TIMER_STATS];
>
>  /* Not true gettimeofday, only checks the jiffies (uptime) + useconds */
> -void __INLINE__ do_gettimeofday_fast(struct fasttime_t *tv)
> +inline void do_gettimeofday_fast(struct fasttime_t *tv)

Why these functions are not "static inline"?
Wthout "static", gcc will actually create non-inlined version of them!

$ cat t.c
inline int f() { return 1; }
int g() { return f(); }
$ gcc -O2 -c t.c
$ nm --size-sort t.o
0000000a T f   <=================== !!!
0000000a T g

P.S. whitespace style in fasttimer.c doesn't match rest of the kernel
(kernel uses tab, not 2-spaces indentation). Curly braces don't match too:
  if (t0->tv_sec < t1->tv_sec)
  {
    return -1;
  }
should be
      if (t0->tv_sec < t1->tv_sec) {
              return -1;
      }

--
vda
