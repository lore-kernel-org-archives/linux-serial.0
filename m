Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFD727CCD5
	for <linux-serial@vger.kernel.org>; Tue, 22 Apr 2025 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324108; cv=none; b=T1e3C74g9aDCTIxH+UKEmAMyaIQtfH5P13hdDpuS3g+GRDA6xY8Pc0kkIYrPbLBJTe+2e9a827VBHqOaBezbjJNIBMBaN6i038kxKkbSKQHWwE7DkBdorsDym4JdeduMdhSBx/xOdBRcV+lqfbPAuPw6CDnaDUE1jrr7I32gW3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324108; c=relaxed/simple;
	bh=LDDj8CBs5iiI4xrg7P6aRWaXZi/37+jExsKr53FvCPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqRQLeZRX34v5d7Rzxc6G/onhP7htqn7wwWumk908APZ8kh2KaPhOkFPexwLNeN1Rxumw9AbcSrZKVmDMhFGZ2DqqZi3RqR4ICIg86HqLEA+aMpnFs6jWB3rjI5bz5E3gxdrZmdqqr9G8BgeYrvO0Xh76KcegVBbisEdoUpUNLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PV6jiBzQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PV6jiBzQ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39129fc51f8so4341464f8f.0
        for <linux-serial@vger.kernel.org>; Tue, 22 Apr 2025 05:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745324104; x=1745928904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fqMvRRUfYWFEQlJtKo0yq/XAH4EEn6pYmCsE7BYoW9c=;
        b=PV6jiBzQugSIAmliiBPRT/Ez6uOqNwAcWfguuYSkjdZMaekB528B8F0ftc26+eslPn
         G2QZeXcUIlXaLzcUjQt79vtQ5MJ3sfiPYVR3qqbkUQbxAe/ZSY31vTSNyEZel2YTHpIQ
         xgZyNS5j3p6Bj7oDm3F07ofI+rf3p5ehCiz7cSTDiIZj9rY7eFiaDr59Hrw8w5WgWwLZ
         AZzEeE44GIAHVfz7TO2bOYPU1bIt70sDNfg9Cr5d398MWxR/e7QWMYbnysdi1dExVr1d
         /66XdYhsoZO74IYnsRCCb7d264awrYzntR00eGd3z8fWXp3g3XnlSfOy4yM6gjND1Nzs
         OsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745324104; x=1745928904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqMvRRUfYWFEQlJtKo0yq/XAH4EEn6pYmCsE7BYoW9c=;
        b=qfdsGGTInylPRi1B9H7uSD2K26S+CXhhhxXBh0NFRsBActYapwapQPRXrzwS+HJiHe
         TbAwFkybXmYBB01gHKD7bAPrnMCFWZ5hw1tM0nMGI9J6FLe+kbjBorQC+xDHchkOjqPZ
         71rtns3mg08/so5q1afsmUPLglSSE6FPZZ60AChcb5XB4UWK7b1RiFjRMp++qGK3oI2e
         grca3IqZtBC4wshGaJoe3ZMuFrt8HWs7qptfPy6+gI0ABo0700duXmsUswJNAKkRwn7K
         C9ltVPUEq1QQhx5WAVU9y3PS0o79xv7pp2sdSehQmsWgKPSoXwHnHdgBtHhkyTAGArTm
         zuqA==
X-Forwarded-Encrypted: i=1; AJvYcCXiHChi2tmxE1oq8eOGJHYMUyiMWZ34THz7YUap28PZxWdXsoupH0f9+hzMT1gzY5Pck/2owcMw3GYmuAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLVidFJsZbH6GG6jdK7c7OkueVYgoNI75v5Z/ZJXbI2lfmn9jA
	GyKw6ppj+EGxdB3XMZc4ZXdKnm0gMSuSM0bLQDpFiaq8ZALqyiVl1q1ASAraYnvulampY15CfCM
	0
X-Gm-Gg: ASbGncsD+53ZD43ZoS0rXo2XEJCZXJUmfZquDDENoV3yqUWVyhTAcMwOfd3NYUamtTJ
	T/GF3x7OEmXGFefZK0N3ijcKOdiB+2EFtCXLG50kUtweZMqqZJD0dicG1UUWnDWPsaY5FbPq6LU
	H25+3sLTT3APgTOeN5wEICG/bI8TYET/+qdNkWJifGwAY/ht1fo/TIJk3q1V87tPFEAhCABYEG9
	o8yx4AdBYltj/FUsDMJRX/uv7EYuY4q8oz4W12M0oeV6Ctj22cpeyEQl3Af/mxw+bi1gCi5rIdn
	JLLKO5rHGNgCtfnhBfknz2eNAuXLR4MluKtkVcq4Wj4=
X-Google-Smtp-Source: AGHT+IHmLn5EVcnwyczfvKP8ed2LDHKhqAf7O6XREEpkYZJgbQjmvzkZpixkhlPFNDF8//ecGhf6Gw==
X-Received: by 2002:a05:6000:4308:b0:390:f6aa:4e7c with SMTP id ffacd0b85a97d-39efba5e837mr11823334f8f.28.1745324103656;
        Tue, 22 Apr 2025 05:15:03 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43d006sm15266686f8f.56.2025.04.22.05.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 05:15:03 -0700 (PDT)
Date: Tue, 22 Apr 2025 14:15:01 +0200
From: Petr Mladek <pmladek@suse.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: john.ogness@linutronix.de, Jason@zx2c4.com, gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org, lkp@intel.com, oe-lkp@lists.linux.dev,
	oliver.sang@intel.com
Subject: Re: [linux-next:master] [serial]  b63e6f60ea:
 BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]
Message-ID: <aAeIRZH_VD0mai0V@pathway.suse.cz>
References: <20250317144221.8231-1-ryotkkr98@gmail.com>
 <20250421034150.107997-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421034150.107997-1-ryotkkr98@gmail.com>

On Mon 2025-04-21 12:41:50, Ryo Takakura wrote:
> Hi!
> 
> I would like to follow up the last email that I sent.
> 
> First, I'm sorry that I later realized that I should have tested
> the rslib test as an inserted module, as how the robot does, by
> choosing CONFIG_REED_SOLOMON_TEST=m.
> Not as a boottime test by enabling CONFIG_REED_SOLOMON_TEST=y.
> 
> Running the rslib test as an inserted module without the John's series
> was less prone to softlockup. Without the John's series, softlockup shows
> up once in a test or not at all. With the John's series, softlockup can
> be observed constanly over the test.

> On Mon, 17 Mar 2025 23:42:21 +0900, Ryo Takakura wrote:
> >On Mon, 17 Mar 2025 09:51:46 +0106, John Ogness wrote:
> >>On 2025-03-15, Ryo Takakura <ryotkkr98@gmail.com> wrote:
> >>> I got the same softlockup during the test regardless of the presence
> >>> of the commits.
> >>>
> >>> [   60.222013] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [swapper/0:1]
> >>> [   60.222023] Modules linked in:
> >>> [   60.222032] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G             L     6.14.0-rc6-v14-rc6-voluntary+ #4
> >>> [   60.222047] Tainted: [L]=SOFTLOCKUP
> >>> [   60.222051] Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
> >>> [   60.222055] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >>> [   60.222066] pc : get_random_u32+0xac/0x118
> >>> [   60.222081] lr : __get_random_u32_below+0x20/0x78
> >>> [   60.222094] sp : ffffffc08002bb80
> >>> [   60.222098] x29: ffffffc08002bb80 x28: 0000000000000003 x27: 0000000000000001
> >>> [   60.222114] x26: ffffff804112e6a4 x25: ffffffd33ed21820 x24: ffffff804112e69c
> >>> [   60.222128] x23: 0000000000000000 x22: ffffff804112e64e x21: 0000000000000000
> >>> [   60.222142] x20: 000000000000000d x19: ffffff80fb7aebb8 x18: 0000000000000002
> >>> [   60.222156] x17: 0000000000000004 x16: ffffff804112e584 x15: ffffff8041126796
> >>> [   60.222169] x14: ffffff80411267c0 x13: 0000000000000006 x12: ffffff804112e5c0
> >>> [   60.222183] x11: ffffff804112e64c x10: 0000000000000007 x9 : ffffffd33dccdd10
> >>> [   60.222196] x8 : ffffff804112e6a8 x7 : 0000000000000000 x6 : 0005000400060005
> >>> [   60.222210] x5 : ffffff804112e65a x4 : 0000000000000000 x3 : 0000000000000010
> >>> [   60.222223] x2 : 0000000000000014 x1 : 000000002c7d0b7a x0 : 0000000000000013
> >>> [   60.222237] Call trace:
> >>> [   60.222241]  get_random_u32+0xac/0x118 (P)
> >>> [   60.222256]  __get_random_u32_below+0x20/0x78
> >>> [   60.222268]  get_rcw_we+0x180/0x208
> >>> [   60.222278]  test_rslib_init+0x2c8/0xba0
> >>> [   60.222292]  do_one_initcall+0x4c/0x210
> >>> [   60.222303]  kernel_init_freeable+0x1fc/0x3a0
> >>> [   60.222317]  kernel_init+0x28/0x1f8
> >>> [   60.222327]  ret_from_fork+0x10/0x20
> >>>
> >>>> I wonder if a cond_resched() in some loop would help. Or using a
> >>>
> >>> I wasn't sure which loop would be the appropriate one but adding
> >>> cond_resched() as below worked as suggested.
> >>>
> >>> ----- BEGIN -----
> >>> diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
> >>> index 75cb1adac..322d7b0a8 100644
> >>> --- a/lib/reed_solomon/test_rslib.c
> >>> +++ b/lib/reed_solomon/test_rslib.c
> >>> @@ -306,6 +306,8 @@ static void test_uc(struct rs_control *rs, int len, int errs,
> >>>
> >>>                 if (memcmp(r, c, len * sizeof(*r)))
> >>>                         stat->dwrong++;
> >>> +
> >>> +               cond_resched();
> >>>         }
> >>>         stat->nwords += trials;
> >>>  }
> >>> @@ -400,6 +402,8 @@ static void test_bc(struct rs_control *rs, int len, int errs,
> >>>                 } else {
> >>>                         stat->rfail++;
> >>>                 }
> >>> +
> >>> +               cond_resched();
> >>>         }
> >>>         stat->nwords += trials;
> >>>  }
> >>> ----- END -----
> >>>
> >>>> pseudorandom generator. I remember the problems related to much
> >>>> slower random generator, for example, see the commit
> >>>> f900fde28883602b6 ("crypto: testmgr - fix RNG performance in fuzz
> >>>> tests").
> >>>
> >>> I haven't tested this but I'll look into it!
> 
> For the same reason pointed out by the commit f900fde28883 ("crypto: 
> testmgr - fix RNG performance in fuzz tests"), the commit d4150779e60f
> ("random32: use real rng for non-deterministic randomness") does seem
> to have slowed down the rslib test.
> 
> On Raspberry pi 4(4G Mem, 4 CPUs), running the rslib test on v5.19 with
> the commit d4150779e60f ("random32: use real rng for non-deterministic
> randomness") takes about 450sec compared to v5.18(without the commit)
> which only takes about 350sec.
> 
> However, random number generation does not seem to be the only reason
> for the rslib test being slow.
> Below is the function stats for v5.18 vs v5.19 for the test.
> 
> v5.18
> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] load_module
> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_init_module
> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_one_initcall
> +   59.90%    59.90%  insmod   [kernel.kallsyms]      [k] decode_rs16
> +   30.28%     0.00%  insmod   [unknown]              [k] 0xffffffd60413a748
> +   21.39%    21.39%  insmod   [kernel.kallsyms]      [k] encode_rs16
> +   20.94%     0.00%  insmod   [unknown]              [k] 0xffffffd60441b0d4
> +   14.17%     0.01%  insmod   [unknown]              [k] 0xffffffd60413a324
> +   12.92%     0.00%  insmod   [unknown]              [k] 0xffffffd60413a720
> +   11.74%     0.00%  insmod   [unknown]              [k] 0xffffffd60413a368
> +   11.63%     0.01%  insmod   [unknown]              [k] 0xffffffd60413a4b4
> +    6.60%     0.01%  insmod   [unknown]              [k] 0xffffffd60413a46c
> +    3.26%     3.26%  insmod   [unknown]              [k] 0xffffffd60413a3c4
> +    3.11%     3.11%  insmod   [kernel.kallsyms]      [k] prandom_u32
> 
> v5.19
> +  100.00%     0.00%  insmod   [kernel.kallsyms]  [k] load_module
> +  100.00%     0.00%  insmod   [kernel.kallsyms]  [k] do_init_module
> +  100.00%     0.00%  insmod   [kernel.kallsyms]  [k] do_one_initcall
> +   45.13%    45.13%  insmod   [kernel.kallsyms]  [k] decode_rs16
> +   27.84%    27.83%  insmod   [kernel.kallsyms]  [k] get_random_u32
> +   22.83%     0.01%  insmod   [unknown]          [k] 0xffffffd62b379324
> +   22.76%     0.00%  insmod   [unknown]          [k] 0xffffffd62b379748
> +   22.35%     0.00%  insmod   [unknown]          [k] 0xffffffd62b379720
> +   16.17%    16.17%  insmod   [kernel.kallsyms]  [k] encode_rs16
> 
> As the v5.19 stats shows, the commit d4150779e60f ("random32: use real
> rng for non-deterministic randomness") did slowed down the rslib test
> by using real random number generator(prandom_u32->get_random_u32).
> But it also shows that the decode/encoding takes quite a lot of time.
> 
> For the above reason, if we want make the softlockup go away, maybe
> just converting from real to pseudo random generator won't be enough?
> I tested with below changes applied to v6.14 which uses pseudo random
> numbers instead of real ones similar to what the commit f900fde28883
> ("crypto: testmgr - fix RNG performance in fuzz tests") did.
> 
> The result is that while it did help to fast up the test from 450 sec
> to 350 sec, it still triggers the softlockup.

It is not that big speedup. 350 sec still provides a lot of
opportunities for a softlockup.

> --- BEGIN ---
> diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
> index 75cb1adac..5785e3c0c 100644
> --- a/lib/reed_solomon/test_rslib.c
> +++ b/lib/reed_solomon/test_rslib.c
[...]
> @@ -162,9 +174,11 @@ static int get_rcw_we(struct rs_control *rs, struct wspace *ws,
>         int errloc;
>         int i;
> 
> +       init_rnd_state(&rng);
> +
>         /* Load c with random data and encode */
>         for (i = 0; i < dlen; i++)
> -               c[i] = get_random_u32() & nn;
> +               c[i] = prandom_u32_state(&rng) & nn;
> 
>         memset(c + dlen, 0, nroots * sizeof(*c));
>         encode_rs16(rs, c, dlen, c + dlen, 0);
[...]
> --- END ---
> 
> Below is the function stats for with vs without the above change.
> 
> v6.14 without the above change
> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] load_module
> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_init_module
> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_one_initcall
> +   46.94%    46.94%  insmod   [kernel.kallsyms]      [k] decode_rs16
> +   24.92%    24.92%  insmod   [kernel.kallsyms]      [k] get_random_u32
> +   23.59%     0.01%  insmod   [unknown]              [k] 0xffffffde423d88cc
> +   22.66%     0.00%  insmod   [unknown]              [k] 0xffffffde423d82c0
> +   22.39%     0.00%  insmod   [unknown]              [k] 0xffffffde423d88a4
> +   16.67%    16.67%  insmod   [kernel.kallsyms]      [k] encode_rs16
> 
> v6.14 with the above change
> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] load_module
> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_init_module
> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_one_initcall
> +   61.51%    61.50%  insmod   [kernel.kallsyms]      [k] decode_rs16
> +   31.15%     0.00%  insmod   [unknown]              [k] 0xffffffe7013858cc
> +   21.75%    21.75%  insmod   [kernel.kallsyms]      [k] encode_rs16
> +   21.36%     0.01%  insmod   [unknown]              [k] 0xffffffe70137f120
> +   15.20%     0.00%  insmod   [unknown]              [k] 0xffffffe7013852c0
> +   12.79%     0.00%  insmod   [unknown]              [k] 0xffffffe7013858a4
> +   12.00%     0.00%  insmod   [unknown]              [k] 0xffffffe7013854c0
> +   12.00%     0.00%  insmod   [unknown]              [k] 0xffffffe701385304
> +    6.74%     0.01%  insmod   [unknown]              [k] 0xffffffe701385600
> +    3.43%     3.43%  insmod   [unknown]              [k] 0xffffffe701385598
> +    2.50%     2.50%  insmod   [unknown]              [k] 0xffffffe701385564
> +    1.96%     1.96%  insmod   [kernel.kallsyms]      [k] prandom_u32_state
> +    1.85%     1.85%  insmod   [kernel.kallsyms]      [k] get_random_u64
> 
> So maybe we still need cond_resched() in addition to converting the
> test from using psuedo random numbers to real ones in order to make
> the softlockup go away?

IMHO, cond_resched() should be added, definitely. The code clearly
prevents scheduling for tens of seconds.

> >>>> That said, I did not dig deep into the code. And I did not try to
> >>>> reproduce the softlockup. I am pretty busy at the moment with some
> >>>> other stuff. I just wanted to give it a look and share my opinion.
> >>>
> >>> I think the softlockup is rather a problem of test itself,
> >>> not the two commits.
> >>
> >>Thanks Ryo for looking into this! I think we need to have a technical
> >>explanation/understanding of the problem so that it is clear how my
> >>series triggers or exaggerates the issue.
> 
> As mentioned earlier, I'm sorry that I should have run the test as
> inserted module... It seems the series does make the test more prone
> to softlockups.

IMHO, the main difference is that the patch "serial: 8250: Switch to
nbcon console" removes touch_nmi_watchdog() from
serial8250_console_write().

The touch_nmi_watchdog() resets the softlockup watchdog. It might
hide that the CPU did not schedule for a long time.

The touch_nmi_watchdog() was there because the console_lock() owner,
used by the legacy loop, was responsible for flushing all pending
messages. And there might be many pending messages when new ones
were added by other CPUs in parallel. And the legacy loop
could not call cond_resched() when called from printk() because
printk() might be called in atomic context.

The series removed the touch_nmi_watchdog() because the kthread
called cond_resched. And the amount of messages flushed in
the emergency or panic context was limited.

My view:

The touch_nmi_watchdog() did hide the softlockup scenario in the rslib
test. The printk series allowed to see the problem reliably.

By other words, the rslib test should get fixed by adding
cond_resched(). And the conversion of the 8250 serial console
driver to nbcon is correct.

That said, see below.

> I am still looking into the issue but I noticed that if the printing
> during the test were done in a caller context, not by printk thread,
> the softlock goes away.
> 
> I tested with a change something like below so that the printing during
> the test were not delegated to printk thread ("pr/ttyS0"). With the below
> change, the softlock no longer shows up.
> 
> --- BEGIN ---
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index fd12efcc4..07c879a64 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1639,6 +1639,7 @@ void nbcon_cpu_emergency_enter(void)
>         cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
>         (*cpu_emergency_nesting)++;
>  }
> +EXPORT_SYMBOL_GPL(nbcon_cpu_emergency_enter);
> 
>  /**
>   * nbcon_cpu_emergency_exit - Exit an emergency section
> @@ -1656,6 +1657,7 @@ void nbcon_cpu_emergency_exit(void)
> 
>         preempt_enable();
>  }
> +EXPORT_SYMBOL_GPL(nbcon_cpu_emergency_exit);
> 
>  /**
>   * nbcon_alloc - Allocate and init the nbcon console specific data
> diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
> index 75cb1adac..8208f8317 100644
> --- a/lib/reed_solomon/test_rslib.c
> +++ b/lib/reed_solomon/test_rslib.c
> @@ -11,6 +11,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/random.h>
>  #include <linux/slab.h>
> +#include <linux/console.h>
> 
>  enum verbosity {
>         V_SILENT,
> @@ -323,8 +324,11 @@ static int ex_rs_helper(struct rs_control *rs, struct wspace *ws,
>         int nroots = rs->codec->nroots;
>         int errs, eras, retval;
> 
> -       if (v >= V_PROGRESS)
> +       if (v >= V_PROGRESS) {
> +               nbcon_cpu_emergency_enter();
>                 pr_info("  %s\n", desc[method]);
> +               nbcon_cpu_emergency_exit();
> +       }

I do not understand how this prevented the softlockup.

The emergency context causes that the messages is flushed directly
from printk(), see nbcon_atomic_flush_pending() in vprintk_emit().
But see neither cond_resched() nor touch_nmi_watchdog() in this
code path.

By other words, I do _not_ see how the emergency context either
triggered scheduling or did reset the watchdog.

But I might be looking at a different code base. I looked at
Linus' master and linux-next.

Best Regards,
Petr
