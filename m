Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00CE1E260A
	for <linux-serial@vger.kernel.org>; Wed, 30 Apr 2025 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746004528; cv=none; b=H9RKuQTbgvXxTMKY9SwmM4wNXGjiITfKJHlNlrsgvN48Pn9wSePQKqlRbBk4TMNyYhp9vTdAUICCGkGSnAJaREMM66xrnb1AUbC4WLutRv6UNUHVpzsShV6TB0OrWmb30a9D0pacLBg+wJehqq43jhSrkuZLEYPhXMxNVDWQM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746004528; c=relaxed/simple;
	bh=HV8RtL2fVcf2DOC/vw5yMFOtz4/W82IGoF85hfrU4PM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C+5KN5ayg4wETHGSFcQOmpMO5SnmTs5EA+ryGRn9beAgy9boT6QJiz2oc966Gkve/kK6EBRk0rI9j37HjwOsuT2f6BiJq+EkYC7HNemLUnw+NJA2id2uIkRH61ZJ/BGbeJwuT5Md4LmrjcYX/3RKuHD6ml82+LDZnN8II+JsgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXFFmRmg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXFFmRmg"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22da3b26532so60186115ad.0
        for <linux-serial@vger.kernel.org>; Wed, 30 Apr 2025 02:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746004526; x=1746609326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43+MXIBs3sBIsAsVJnhe7W+DVgEp9zhzQxeU6tiaBP4=;
        b=LXFFmRmgE2W9IHC+F7U/0SZXl1H6FCx/DufdyosVKfulYIAmIkhekKGdmfo1wU3FTC
         YM+wqmsB8axGw5p/RZumbXo00aHEfpOsI/URAt3IMSRCwJvEPXkFIgvqVfAxFihtnoqh
         tSavAOT6nqpjD8qjypjKj/vPPtLvdgoFOFCSlNrceouPVM9MgnXj8Zm4dbv38BJ10/bv
         yh1IfEzXppnx+xmt/vz7UaMvg1VQArKUdN//heVoJvLg9Dqut7NKsLiDA0yc6wOCECe8
         wputbiVITT2zYgkrIXH4hsWibpGh0EimVqDvlPq/A3ubepVOi5uBb/7agvo4Sn3qD3jD
         HcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746004526; x=1746609326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43+MXIBs3sBIsAsVJnhe7W+DVgEp9zhzQxeU6tiaBP4=;
        b=mqd6Q53IKLFIlIznzCro0IW5U/OOacHEbz99jucHOj4vKsH3pL51uK8ttwnuDx0Ics
         cTTA1xb4I2ksbcekEZEjSwCmsBIdofqDmtpS6TwR9+oSM25/kSz0w/ke12K04Map7fwx
         ECDfAD+BD6GnypuEM4WmvEnIId8y8WjZUSF7vCIKHZc2bYrqwt2eZ8uFF8mpN43IfWmW
         yeJp6dXekGlaMUT0rLQ2hEc7N7VtxhQUKg0nw4rGeTj9XzHm63Z65aw+x8XrLoog86y5
         gHd7IwyLP4a+MKHhtlLJ+BRpuKLiOUVdUVRPDcPM3mfDWFgmYUUEYlwhHkaGi/bWOOT7
         UcXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMeaohDnHsRdN0U3ElseB28YxKRBou3jr9I1s0pinLL/880giCFqvFLRvNX65frho9HPreienzUxctwAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsI6J0koiO7jJJXJ4pYanA6Xh0KAJpLnMUuJZAVnR8tN+6cqYJ
	AOS1ZseqPHpUBbkct1R8SDIouVag5ZWYlng05rMY2datBELr/Zgu
X-Gm-Gg: ASbGncsvfTY8iRE/c6J/s93IqVdB8Pa2pGGWHAMApJue8Vs4VotRA9/Fx9bFu8Q2Z99
	2+PJCgM+ltu+zyy3wLt70GqEajyuJMH4FKGe9efIFI6P3ic4wRX8cVfieC4+t3pFrBP5qNuytKR
	7k4c/qdWe29BI0tdJypCANLzWMkr2NsWTyJbLQRn/Ia+cemQ5ZZVm9aQfgSgj5M5bRQ0036kB5I
	eQBJypy6Pry9Oa5FQ2KyeDz40JSqj4Mi5C6rI+wTt/wXrOAUB2XYLTqV4N2CCo5EiAPaYqrKPHx
	F2lhwnZ20U0/CB8u1sl21UGQ0kKB9GdP1YmdL2yn8bAE8XHZ2yI8QFFJ53PNHiOIHWjv9WABk6K
	mR5zu207Leq0=
X-Google-Smtp-Source: AGHT+IFqX0JDA1uaRLQZpaNit0Fb73/WFRWVaZVRnbYAWRm2VaBGHtJy/7+mXxYxD4mHdTyAfSe9MQ==
X-Received: by 2002:a17:902:ceca:b0:220:fe50:5b44 with SMTP id d9443c01a7336-22df3529d50mr41448175ad.31.1746004525833;
        Wed, 30 Apr 2025 02:15:25 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7b5bsm117137795ad.141.2025.04.30.02.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:15:25 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: john.ogness@linutronix.de,
	pmladek@suse.com
Cc: ryotkkr98@gmail.com,
	Jason@zx2c4.com,
	gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com
Subject: Re: [linux-next:master] [serial]  b63e6f60ea: BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]
Date: Wed, 30 Apr 2025 18:15:20 +0900
Message-Id: <20250430091520.80111-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424081101.110914-1-ryotkkr98@gmail.com>
References: <20250424081101.110914-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, I tested what we have discussed!

On Thu, 24 Apr 2025 17:11:01 +0900, Ryo Takakura wrote:
>On Tue, 22 Apr 2025 14:15:01 +0200, Petr Mladek wrote:
>>On Mon 2025-04-21 12:41:50, Ryo Takakura wrote:
>>> First, I'm sorry that I later realized that I should have tested
>>> the rslib test as an inserted module, as how the robot does, by
>>> choosing CONFIG_REED_SOLOMON_TEST=m.
>>> Not as a boottime test by enabling CONFIG_REED_SOLOMON_TEST=y.
>>> 
>>> Running the rslib test as an inserted module without the John's series
>>> was less prone to softlockup. Without the John's series, softlockup shows
>>> up once in a test or not at all. With the John's series, softlockup can
>>> be observed constanly over the test.
>>
>>> On Mon, 17 Mar 2025 23:42:21 +0900, Ryo Takakura wrote:
>>> >On Mon, 17 Mar 2025 09:51:46 +0106, John Ogness wrote:
>>> >>On 2025-03-15, Ryo Takakura <ryotkkr98@gmail.com> wrote:
>>> >>> I got the same softlockup during the test regardless of the presence
>>> >>> of the commits.
>>> >>>
>>> >>> [   60.222013] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [swapper/0:1]
>>> >>> [   60.222023] Modules linked in:
>>> >>> [   60.222032] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G             L     6.14.>0-rc6-v14-rc6-voluntary+ #4
>>> >>> [   60.222047] Tainted: [L]=SOFTLOCKUP
>>> >>> [   60.222051] Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
>>> >>> [   60.222055] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> >>> [   60.222066] pc : get_random_u32+0xac/0x118
>>> >>> [   60.222081] lr : __get_random_u32_below+0x20/0x78
>>> >>> [   60.222094] sp : ffffffc08002bb80
>>> >>> [   60.222098] x29: ffffffc08002bb80 x28: 0000000000000003 x27: 0000000000000001
>>> >>> [   60.222114] x26: ffffff804112e6a4 x25: ffffffd33ed21820 x24: ffffff804112e69c
>>> >>> [   60.222128] x23: 0000000000000000 x22: ffffff804112e64e x21: 0000000000000000
>>> >>> [   60.222142] x20: 000000000000000d x19: ffffff80fb7aebb8 x18: 0000000000000002
>>> >>> [   60.222156] x17: 0000000000000004 x16: ffffff804112e584 x15: ffffff8041126796
>>> >>> [   60.222169] x14: ffffff80411267c0 x13: 0000000000000006 x12: ffffff804112e5c0
>>> >>> [   60.222183] x11: ffffff804112e64c x10: 0000000000000007 x9 : ffffffd33dccdd10
>>> >>> [   60.222196] x8 : ffffff804112e6a8 x7 : 0000000000000000 x6 : 0005000400060005
>>> >>> [   60.222210] x5 : ffffff804112e65a x4 : 0000000000000000 x3 : 0000000000000010
>>> >>> [   60.222223] x2 : 0000000000000014 x1 : 000000002c7d0b7a x0 : 0000000000000013
>>> >>> [   60.222237] Call trace:
>>> >>> [   60.222241]  get_random_u32+0xac/0x118 (P)
>>> >>> [   60.222256]  __get_random_u32_below+0x20/0x78
>>> >>> [   60.222268]  get_rcw_we+0x180/0x208
>>> >>> [   60.222278]  test_rslib_init+0x2c8/0xba0
>>> >>> [   60.222292]  do_one_initcall+0x4c/0x210
>>> >>> [   60.222303]  kernel_init_freeable+0x1fc/0x3a0
>>> >>> [   60.222317]  kernel_init+0x28/0x1f8
>>> >>> [   60.222327]  ret_from_fork+0x10/0x20
>>> >>>
>>> >>>> I wonder if a cond_resched() in some loop would help. Or using a
>>> >>>
>>> >>> I wasn't sure which loop would be the appropriate one but adding
>>> >>> cond_resched() as below worked as suggested.
>>> >>>
>>> >>> ----- BEGIN -----
>>> >>> diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
>>> >>> index 75cb1adac..322d7b0a8 100644
>>> >>> --- a/lib/reed_solomon/test_rslib.c
>>> >>> +++ b/lib/reed_solomon/test_rslib.c
>>> >>> @@ -306,6 +306,8 @@ static void test_uc(struct rs_control *rs, int len, int errs,
>>> >>>
>>> >>>                 if (memcmp(r, c, len * sizeof(*r)))
>>> >>>                         stat->dwrong++;
>>> >>> +
>>> >>> +               cond_resched();
>>> >>>         }
>>> >>>         stat->nwords += trials;
>>> >>>  }
>>> >>> @@ -400,6 +402,8 @@ static void test_bc(struct rs_control *rs, int len, int errs,
>>> >>>                 } else {
>>> >>>                         stat->rfail++;
>>> >>>                 }
>>> >>> +
>>> >>> +               cond_resched();
>>> >>>         }
>>> >>>         stat->nwords += trials;
>>> >>>  }
>>> >>> ----- END -----
>>> >>>
>>> >>>> pseudorandom generator. I remember the problems related to much
>>> >>>> slower random generator, for example, see the commit
>>> >>>> f900fde28883602b6 ("crypto: testmgr - fix RNG performance in fuzz
>>> >>>> tests").
>>> >>>
>>> >>> I haven't tested this but I'll look into it!
>>> 
>>> For the same reason pointed out by the commit f900fde28883 ("crypto: 
>>> testmgr - fix RNG performance in fuzz tests"), the commit d4150779e60f
>>> ("random32: use real rng for non-deterministic randomness") does seem
>>> to have slowed down the rslib test.
>>> 
>>> On Raspberry pi 4(4G Mem, 4 CPUs), running the rslib test on v5.19 with
>>> the commit d4150779e60f ("random32: use real rng for non-deterministic
>>> randomness") takes about 450sec compared to v5.18(without the commit)
>>> which only takes about 350sec.
>>> 
>>> However, random number generation does not seem to be the only reason
>>> for the rslib test being slow.
>>> Below is the function stats for v5.18 vs v5.19 for the test.
>>> 
>>> v5.18
>>> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] load_module
>>> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_init_module
>>> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_one_initcall
>>> +   59.90%    59.90%  insmod   [kernel.kallsyms]      [k] decode_rs16
>>> +   30.28%     0.00%  insmod   [unknown]              [k] 0xffffffd60413a748
>>> +   21.39%    21.39%  insmod   [kernel.kallsyms]      [k] encode_rs16
>>> +   20.94%     0.00%  insmod   [unknown]              [k] 0xffffffd60441b0d4
>>> +   14.17%     0.01%  insmod   [unknown]              [k] 0xffffffd60413a324
>>> +   12.92%     0.00%  insmod   [unknown]              [k] 0xffffffd60413a720
>>> +   11.74%     0.00%  insmod   [unknown]              [k] 0xffffffd60413a368
>>> +   11.63%     0.01%  insmod   [unknown]              [k] 0xffffffd60413a4b4
>>> +    6.60%     0.01%  insmod   [unknown]              [k] 0xffffffd60413a46c
>>> +    3.26%     3.26%  insmod   [unknown]              [k] 0xffffffd60413a3c4
>>> +    3.11%     3.11%  insmod   [kernel.kallsyms]      [k] prandom_u32
>>> 
>>> v5.19
>>> +  100.00%     0.00%  insmod   [kernel.kallsyms]  [k] load_module
>>> +  100.00%     0.00%  insmod   [kernel.kallsyms]  [k] do_init_module
>>> +  100.00%     0.00%  insmod   [kernel.kallsyms]  [k] do_one_initcall
>>> +   45.13%    45.13%  insmod   [kernel.kallsyms]  [k] decode_rs16
>>> +   27.84%    27.83%  insmod   [kernel.kallsyms]  [k] get_random_u32
>>> +   22.83%     0.01%  insmod   [unknown]          [k] 0xffffffd62b379324
>>> +   22.76%     0.00%  insmod   [unknown]          [k] 0xffffffd62b379748
>>> +   22.35%     0.00%  insmod   [unknown]          [k] 0xffffffd62b379720
>>> +   16.17%    16.17%  insmod   [kernel.kallsyms]  [k] encode_rs16
>>> 
>>> As the v5.19 stats shows, the commit d4150779e60f ("random32: use real
>>> rng for non-deterministic randomness") did slowed down the rslib test
>>> by using real random number generator(prandom_u32->get_random_u32).
>>> But it also shows that the decode/encoding takes quite a lot of time.
>>> 
>>> For the above reason, if we want make the softlockup go away, maybe
>>> just converting from real to pseudo random generator won't be enough?
>>> I tested with below changes applied to v6.14 which uses pseudo random
>>> numbers instead of real ones similar to what the commit f900fde28883
>>> ("crypto: testmgr - fix RNG performance in fuzz tests") did.
>>> 
>>> The result is that while it did help to fast up the test from 450 sec
>>> to 350 sec, it still triggers the softlockup.
>>
>>It is not that big speedup. 350 sec still provides a lot of
>>opportunities for a softlockup.
>>
>>> --- BEGIN ---
>>> diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
>>> index 75cb1adac..5785e3c0c 100644
>>> --- a/lib/reed_solomon/test_rslib.c
>>> +++ b/lib/reed_solomon/test_rslib.c
>>[...]
>>> @@ -162,9 +174,11 @@ static int get_rcw_we(struct rs_control *rs, struct wspace *ws,
>>>         int errloc;
>>>         int i;
>>> 
>>> +       init_rnd_state(&rng);
>>> +
>>>         /* Load c with random data and encode */
>>>         for (i = 0; i < dlen; i++)
>>> -               c[i] = get_random_u32() & nn;
>>> +               c[i] = prandom_u32_state(&rng) & nn;
>>> 
>>>         memset(c + dlen, 0, nroots * sizeof(*c));
>>>         encode_rs16(rs, c, dlen, c + dlen, 0);
>>[...]
>>> --- END ---
>>> 
>>> Below is the function stats for with vs without the above change.
>>> 
>>> v6.14 without the above change
>>> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] load_module
>>> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_init_module
>>> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_one_initcall
>>> +   46.94%    46.94%  insmod   [kernel.kallsyms]      [k] decode_rs16
>>> +   24.92%    24.92%  insmod   [kernel.kallsyms]      [k] get_random_u32
>>> +   23.59%     0.01%  insmod   [unknown]              [k] 0xffffffde423d88cc
>>> +   22.66%     0.00%  insmod   [unknown]              [k] 0xffffffde423d82c0
>>> +   22.39%     0.00%  insmod   [unknown]              [k] 0xffffffde423d88a4
>>> +   16.67%    16.67%  insmod   [kernel.kallsyms]      [k] encode_rs16
>>> 
>>> v6.14 with the above change
>>> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] load_module
>>> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_init_module
>>> +  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_one_initcall
>>> +   61.51%    61.50%  insmod   [kernel.kallsyms]      [k] decode_rs16
>>> +   31.15%     0.00%  insmod   [unknown]              [k] 0xffffffe7013858cc
>>> +   21.75%    21.75%  insmod   [kernel.kallsyms]      [k] encode_rs16
>>> +   21.36%     0.01%  insmod   [unknown]              [k] 0xffffffe70137f120
>>> +   15.20%     0.00%  insmod   [unknown]              [k] 0xffffffe7013852c0
>>> +   12.79%     0.00%  insmod   [unknown]              [k] 0xffffffe7013858a4
>>> +   12.00%     0.00%  insmod   [unknown]              [k] 0xffffffe7013854c0
>>> +   12.00%     0.00%  insmod   [unknown]              [k] 0xffffffe701385304
>>> +    6.74%     0.01%  insmod   [unknown]              [k] 0xffffffe701385600
>>> +    3.43%     3.43%  insmod   [unknown]              [k] 0xffffffe701385598
>>> +    2.50%     2.50%  insmod   [unknown]              [k] 0xffffffe701385564
>>> +    1.96%     1.96%  insmod   [kernel.kallsyms]      [k] prandom_u32_state
>>> +    1.85%     1.85%  insmod   [kernel.kallsyms]      [k] get_random_u64
>>> 
>>> So maybe we still need cond_resched() in addition to converting the
>>> test from using psuedo random numbers to real ones in order to make
>>> the softlockup go away?
>>
>>IMHO, cond_resched() should be added, definitely. The code clearly
>>prevents scheduling for tens of seconds.
>
>Thank you for checking, and I agree.
>If needed, I can prepare the fix for the test.
>
>>> >>>> That said, I did not dig deep into the code. And I did not try to
>>> >>>> reproduce the softlockup. I am pretty busy at the moment with some
>>> >>>> other stuff. I just wanted to give it a look and share my opinion.
>>> >>>
>>> >>> I think the softlockup is rather a problem of test itself,
>>> >>> not the two commits.
>>> >>
>>> >>Thanks Ryo for looking into this! I think we need to have a technical
>>> >>explanation/understanding of the problem so that it is clear how my
>>> >>series triggers or exaggerates the issue.
>>> 
>>> As mentioned earlier, I'm sorry that I should have run the test as
>>> inserted module... It seems the series does make the test more prone
>>> to softlockups.
>>
>>IMHO, the main difference is that the patch "serial: 8250: Switch to
>>nbcon console" removes touch_nmi_watchdog() from
>>serial8250_console_write().
>>
>>The touch_nmi_watchdog() resets the softlockup watchdog. It might
>>hide that the CPU did not schedule for a long time.
>>
>>The touch_nmi_watchdog() was there because the console_lock() owner,
>>used by the legacy loop, was responsible for flushing all pending
>>messages. And there might be many pending messages when new ones
>>were added by other CPUs in parallel. And the legacy loop
>>could not call cond_resched() when called from printk() because
>>printk() might be called in atomic context.
>
>I see. Without the John's series, the cond_resched() in the mention
>code path should be called during the rslib test as it's not in atomic
>context in addition to the touch_nmi_watchdog()s.

To test the above, I run the rslib test using legacy console(without the
John's series) with the touch_nmi_watchdog()s removed as following.

The result is that it triggered the softlockup as expected. So I guess we
can say that the legacy console was indeed hiding the softlockup scenario
as suggested by Petr.

--- BEGIN ---
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c8704eb9e..50b64a6a2 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2113,7 +2113,6 @@ static bool wait_for_lsr(struct uart_8250_port *up, int bits)
                if (--tmout == 0)
                        break;
                udelay(1);
-               touch_nmi_watchdog();
        }

        return (tmout != 0);
@@ -3425,8 +3424,6 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
        unsigned int ier, use_fifo;
        int locked = 1;

-       touch_nmi_watchdog();
-
        if (oops_in_progress)
                locked = uart_port_trylock_irqsave(port, &flags);
        else
--- END ---

>>The series removed the touch_nmi_watchdog() because the kthread
>>called cond_resched. And the amount of messages flushed in
>>the emergency or panic context was limited.
>
>With the John's series appied, I guess the kthread were running on a
>cpu other than the one running the rslib test as John said[0], and neither
>of touch_nmi_watchdog() nor cond_resched() were called that could prevent
>the softlockup.

To test the above, I removed the touch_nmi_watchdog() mentioned by John[0]
on top of the John's series with the printing forced to be done on the same
cpu running the rslib test by marking emergency section(below change applied).

The result is that it triggered the softlockup as expected. Similar to
the first test, the touch_nmi_watchdog() was preventing the softlockup
when its marked with emergency section.
And I believe this implies that the kthread was running on some other cpu
as stated above as it should also be calling the touch_nmi_watchdog()
when it does printing.

--- BEGIN ---
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 21bc9e79c..2f97a603d 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2133,7 +2133,6 @@ static bool wait_for_lsr(struct uart_8250_port *up, int bits)
                if (--tmout == 0)
                        break;
                udelay(1);
-               touch_nmi_watchdog();
        }

        return (tmout != 0);
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index fd12efcc4..07c879a64 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1639,6 +1639,7 @@ void nbcon_cpu_emergency_enter(void)
        cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
        (*cpu_emergency_nesting)++;
 }
+EXPORT_SYMBOL_GPL(nbcon_cpu_emergency_enter);

 /**
  * nbcon_cpu_emergency_exit - Exit an emergency section
@@ -1656,6 +1657,7 @@ void nbcon_cpu_emergency_exit(void)

        preempt_enable();
 }
+EXPORT_SYMBOL_GPL(nbcon_cpu_emergency_exit);

 /**
  * nbcon_alloc - Allocate and init the nbcon console specific data
diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
index 75cb1adac..8208f8317 100644
--- a/lib/reed_solomon/test_rslib.c
+++ b/lib/reed_solomon/test_rslib.c
@@ -11,6 +11,7 @@
 #include <linux/moduleparam.h>
 #include <linux/random.h>
 #include <linux/slab.h>
+#include <linux/console.h>

 enum verbosity {
        V_SILENT,
@@ -323,8 +324,11 @@ static int ex_rs_helper(struct rs_control *rs, struct wspace *ws,
        int nroots = rs->codec->nroots;
        int errs, eras, retval;

-       if (v >= V_PROGRESS)
+       if (v >= V_PROGRESS) {
+               nbcon_cpu_emergency_enter();
                pr_info("  %s\n", desc[method]);
+               nbcon_cpu_emergency_exit();
+       }

        for (errs = 0; errs <= nroots / 2; errs++)
                for (eras = 0; eras <= nroots - 2 * errs; eras++)
@@ -353,8 +357,11 @@ static int exercise_rs(struct rs_control *rs, struct wspace *ws,
        int retval = 0;
        int i;

-       if (v >= V_PROGRESS)
+       if (v >= V_PROGRESS) {
+               nbcon_cpu_emergency_enter();
                pr_info("Testing up to error correction capacity...\n");
+               nbcon_cpu_emergency_exit();
+       }

        for (i = 0; i <= IN_PLACE; i++)
                retval |= ex_rs_helper(rs, ws, len, trials, i);
@@ -411,8 +418,11 @@ static int exercise_rs_bc(struct rs_control *rs, struct wspace *ws,
        int nroots = rs->codec->nroots;
        int errs, eras, cutoff;

-       if (v >= V_PROGRESS)
+       if (v >= V_PROGRESS) {
+               nbcon_cpu_emergency_enter();
                pr_info("Testing beyond error correction capacity...\n");
+               nbcon_cpu_emergency_exit();
+       }

        for (errs = 1; errs <= nroots; errs++) {
                eras = nroots - 2 * errs + 1;
@@ -468,8 +478,10 @@ static int run_exercise(struct etab *e)

                prev_pad = pad;
                if (v >= V_PROGRESS) {
+                       nbcon_cpu_emergency_enter();
                        pr_info("Testing (%d,%d)_%d code...\n",
                                        len, kk - pad, nn + 1);
+                       nbcon_cpu_emergency_exit();
                }

                retval |= exercise_rs(rsc, ws, len, e->ntrials);
--- END ---

>>My view:
>>
>>The touch_nmi_watchdog() did hide the softlockup scenario in the rslib
>>test. The printk series allowed to see the problem reliably.
>>
>>By other words, the rslib test should get fixed by adding
>>cond_resched(). And the conversion of the 8250 serial console
>>driver to nbcon is correct.
>
>I see, and agree! I'll test what's discussed here so that we can say
>the above statement is true and the John's series can be brought back.

I would appreciate any comment on the above tests!
If sounds good, I will prepare a fix adding cond_resched() to the
rslib test later on.

>>That said, see below.
>>
>>> I am still looking into the issue but I noticed that if the printing
>>> during the test were done in a caller context, not by printk thread,
>>> the softlock goes away.
>>> 
>>> I tested with a change something like below so that the printing during
>>> the test were not delegated to printk thread ("pr/ttyS0"). With the below
>>> change, the softlock no longer shows up.
>>> 
>>> --- BEGIN ---
>>> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
>>> index fd12efcc4..07c879a64 100644
>>> --- a/kernel/printk/nbcon.c
>>> +++ b/kernel/printk/nbcon.c
>>> @@ -1639,6 +1639,7 @@ void nbcon_cpu_emergency_enter(void)
>>>         cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
>>>         (*cpu_emergency_nesting)++;
>>>  }
>>> +EXPORT_SYMBOL_GPL(nbcon_cpu_emergency_enter);
>>> 
>>>  /**
>>>   * nbcon_cpu_emergency_exit - Exit an emergency section
>>> @@ -1656,6 +1657,7 @@ void nbcon_cpu_emergency_exit(void)
>>> 
>>>         preempt_enable();
>>>  }
>>> +EXPORT_SYMBOL_GPL(nbcon_cpu_emergency_exit);
>>> 
>>>  /**
>>>   * nbcon_alloc - Allocate and init the nbcon console specific data
>>> diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
>>> index 75cb1adac..8208f8317 100644
>>> --- a/lib/reed_solomon/test_rslib.c
>>> +++ b/lib/reed_solomon/test_rslib.c
>>> @@ -11,6 +11,7 @@
>>>  #include <linux/moduleparam.h>
>>>  #include <linux/random.h>
>>>  #include <linux/slab.h>
>>> +#include <linux/console.h>
>>> 
>>>  enum verbosity {
>>>         V_SILENT,
>>> @@ -323,8 +324,11 @@ static int ex_rs_helper(struct rs_control *rs, struct wspace *ws,
>>>         int nroots = rs->codec->nroots;
>>>         int errs, eras, retval;
>>> 
>>> -       if (v >= V_PROGRESS)
>>> +       if (v >= V_PROGRESS) {
>>> +               nbcon_cpu_emergency_enter();
>>>                 pr_info("  %s\n", desc[method]);
>>> +               nbcon_cpu_emergency_exit();
>>> +       }
>>
>>I do not understand how this prevented the softlockup.
>>
>>The emergency context causes that the messages is flushed directly
>>from printk(), see nbcon_atomic_flush_pending() in vprintk_emit().
>>But see neither cond_resched() nor touch_nmi_watchdog() in this
>>code path.
>>
>>By other words, I do _not_ see how the emergency context either
>>triggered scheduling or did reset the watchdog.
>>
>>But I might be looking at a different code base. I looked at
>>Linus' master and linux-next.
>
>I used this kernel[1] which is for raspberry pi. Let me recheck
>with some other machine with Linus' master and linux-next to see
>if the behavior is raspberry pi specific.

I tested with Linus' master on x86 qemu. I was able to see the rslib
tests prone to softlockup and the John's series exaggerating it, same
as raspberry pi.

But I couldn't see the softlockup go away by marking the emergency
section around the printk call within the rslib test. Looks like it
never calls the touch_nmi_watchdog() in wait_for_lsr(). Maybe because
trasmission gets immediatly completed on qemu board?
I'm afraid that I currently don't have a convenient machine that I can
test this futher at the moment...

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/all/84ikmwqonm.fsf@jogness.linutronix.de/
