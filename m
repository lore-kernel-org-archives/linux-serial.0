Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7F32116F2
	for <linux-serial@vger.kernel.org>; Mon, 21 Apr 2025 03:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745206938; cv=none; b=QZYoNwedq7O5ZdihEik0YdiSNm1PI+stpCJBjE/Ip6JsZ/g4icN5+ndmT6OhlSWzKXCd8coXxqw6MyVXmpPkmgq1+Q3mz2rb+Dj1rC0cmSPUWhRdpj9j9RJtCfK6SoDcs+/6FTBLqedKnlOyS+YsKqdmpht5FYlyUPMAT/r9qug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745206938; c=relaxed/simple;
	bh=G8Bg5vDhlu1WZt8IOg4CwT6H7vLC5MM8+/1avfgnKXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABjwmdSq9ppU/VUKhGJBqpNd/Fd79ukLJL28L+jmLS1cNbeMCSVV3pernheX5gZohgIGwtF7Q94bwvLbkhiEOCf6rPfm1TnoJZBjJBWUMrxNlctVXD1D8ceHWdcRXOHrB91Ku6hrLRi+nW5WIuoqOFBO9fM3PedfRr1EsPZnZ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxogDbzw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxogDbzw"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227c7e57da2so31399955ad.0
        for <linux-serial@vger.kernel.org>; Sun, 20 Apr 2025 20:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745206935; x=1745811735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L80e+YbTDP0Dk/V47p8po3Ajk3c7xaROH1CjO9UT7GA=;
        b=ZxogDbzwUm8GqZe4EV7zwHkF3gsl5dc8/LiIAS4DBBulkeSKM/uXaVgxWHvv/EqRE9
         NPEnZCsiLspwpukSrSXVIeijzAFSmZt+YPtAaNM0vzcsk5QMg+x87oelmlrvHM/GqDRe
         x81ulKeghNxySo+XWf1zXbUL/CfU2dfVU4FGWtm3QqnOBFvBJvsCKWqQH8JkijkCawId
         +2jWjc30ZsZJMUAvjVTfS3MjSWfa6qbxCnRK/s24TF4gNp/ShVpyZlPr55JG5vAWZfcC
         e1YKH3EZbKk9DQJlW8QRHKEyPLXoJDv+pSABgvOgdUCXZgB7d8xoGuQ+zHptZODnJW9Q
         lYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745206935; x=1745811735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L80e+YbTDP0Dk/V47p8po3Ajk3c7xaROH1CjO9UT7GA=;
        b=Cpx9AJUJqP5xxrxzj4qpMJ/q/bupV1DHOZmsXEDhz26KxouEjvCkXjZV6bJcUbkpAP
         E7JxaDNoXEbryU2XcVxJUvL4R5WpXU3csWiBPsCd7wkwrcPyEWz9BJfp8haEZQDXQIJu
         DQQ5prTsKB9oFv7966yRaG7AxRTwmX5dRqVoPLtyOjajDJ0KWyV16tUJFLvlJi6IESDO
         Ik6nKtommBGi3siyos5IRZntcMxmdXBVERC9425HXy/kS8HbDB+IRYYhWYYXl2Spusn4
         SKO+boYDj+YldmTssXmDsB+PuuQd582SMAAXv33CuWIsqE1Yn7FnJJbPvKV87MIjY+Sa
         EVfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJQAdglaFvKsigiaptoHKHrQhQ0uXYPbSH+775zJ/NA8jJ55UxXpb0+T5KR5KJrn4KtnO/+NUqnxePEQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1+T7DKR7dWLj+FR/rlm8eLLid0WuIJ3Vy+Cg1OP8Ys3BW/Uv9
	RQUjXeQLH8SnpkUMWYOQH9a5T908lNir1YsmDUzwXiyo7I39Qa6j
X-Gm-Gg: ASbGncuKXtE36YUonl6T7m6viTmv7Fr4pk0xXDQ8FFtWks5npfhgQnSIi1WdfwxGJKe
	WtD+a+zMsGMJbiLaUw+mTcsqelauGxX8o5iMt5ELsX+/Rm9rOuzt8upfSyxHIhhufDbxpl3iqxN
	KLqKlr5g5vGykmdoGrx1YHPWe01yhNQ/e6D0jb9VXkqlBipahoDz7ZPqMRkmKY30IjS93l+W6z4
	+AgchYts1m4saevNjQPtuA+b8pbjHGNG6k66wqEzAZlIIxD3IAPF0qek4M9BiLmwXAaXlCJ8sEG
	HvNb/9P/7inqdGxi/woD4gelRr3doAzDREwcFsC257Or0qH5INnM73LT4DJ+w6D4u1rgEDdKhLH
	E48cFQxfZr80DXQARq3Bu4mFh2i8=
X-Google-Smtp-Source: AGHT+IE/L7WSqaRCif2ChIQGTqynuXwEilH3CzeEQise5/QfwpTyd9kH7j5ocvM58R6Uje7ru2bV5g==
X-Received: by 2002:a17:903:32d1:b0:215:8809:b3b7 with SMTP id d9443c01a7336-22c5337a009mr126242865ad.7.1745206934481;
        Sun, 20 Apr 2025 20:42:14 -0700 (PDT)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf5425sm55621415ad.98.2025.04.20.20.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 20:42:14 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: john.ogness@linutronix.de,
	pmladek@suse.com
Cc: Jason@zx2c4.com,
	gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com
Subject: Re: [linux-next:master] [serial]  b63e6f60ea: BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]
Date: Mon, 21 Apr 2025 12:41:50 +0900
Message-Id: <20250421034150.107997-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317144221.8231-1-ryotkkr98@gmail.com>
References: <20250317144221.8231-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

I would like to follow up the last email that I sent.

First, I'm sorry that I later realized that I should have tested
the rslib test as an inserted module, as how the robot does, by
choosing CONFIG_REED_SOLOMON_TEST=m.
Not as a boottime test by enabling CONFIG_REED_SOLOMON_TEST=y.

Running the rslib test as an inserted module without the John's series
was less prone to softlockup. Without the John's series, softlockup shows
up once in a test or not at all. With the John's series, softlockup can
be observed constanly over the test.

On Mon, 17 Mar 2025 23:42:21 +0900, Ryo Takakura wrote:
>On Mon, 17 Mar 2025 09:51:46 +0106, John Ogness wrote:
>>On 2025-03-15, Ryo Takakura <ryotkkr98@gmail.com> wrote:
>>> I got the same softlockup during the test regardless of the presence
>>> of the commits.
>>>
>>> [   60.222013] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [swapper/0:1]
>>> [   60.222023] Modules linked in:
>>> [   60.222032] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G             L     6.14.0-rc6-v14-rc6-voluntary+ #4
>>> [   60.222047] Tainted: [L]=SOFTLOCKUP
>>> [   60.222051] Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
>>> [   60.222055] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [   60.222066] pc : get_random_u32+0xac/0x118
>>> [   60.222081] lr : __get_random_u32_below+0x20/0x78
>>> [   60.222094] sp : ffffffc08002bb80
>>> [   60.222098] x29: ffffffc08002bb80 x28: 0000000000000003 x27: 0000000000000001
>>> [   60.222114] x26: ffffff804112e6a4 x25: ffffffd33ed21820 x24: ffffff804112e69c
>>> [   60.222128] x23: 0000000000000000 x22: ffffff804112e64e x21: 0000000000000000
>>> [   60.222142] x20: 000000000000000d x19: ffffff80fb7aebb8 x18: 0000000000000002
>>> [   60.222156] x17: 0000000000000004 x16: ffffff804112e584 x15: ffffff8041126796
>>> [   60.222169] x14: ffffff80411267c0 x13: 0000000000000006 x12: ffffff804112e5c0
>>> [   60.222183] x11: ffffff804112e64c x10: 0000000000000007 x9 : ffffffd33dccdd10
>>> [   60.222196] x8 : ffffff804112e6a8 x7 : 0000000000000000 x6 : 0005000400060005
>>> [   60.222210] x5 : ffffff804112e65a x4 : 0000000000000000 x3 : 0000000000000010
>>> [   60.222223] x2 : 0000000000000014 x1 : 000000002c7d0b7a x0 : 0000000000000013
>>> [   60.222237] Call trace:
>>> [   60.222241]  get_random_u32+0xac/0x118 (P)
>>> [   60.222256]  __get_random_u32_below+0x20/0x78
>>> [   60.222268]  get_rcw_we+0x180/0x208
>>> [   60.222278]  test_rslib_init+0x2c8/0xba0
>>> [   60.222292]  do_one_initcall+0x4c/0x210
>>> [   60.222303]  kernel_init_freeable+0x1fc/0x3a0
>>> [   60.222317]  kernel_init+0x28/0x1f8
>>> [   60.222327]  ret_from_fork+0x10/0x20
>>>
>>>> I wonder if a cond_resched() in some loop would help. Or using a
>>>
>>> I wasn't sure which loop would be the appropriate one but adding
>>> cond_resched() as below worked as suggested.
>>>
>>> ----- BEGIN -----
>>> diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
>>> index 75cb1adac..322d7b0a8 100644
>>> --- a/lib/reed_solomon/test_rslib.c
>>> +++ b/lib/reed_solomon/test_rslib.c
>>> @@ -306,6 +306,8 @@ static void test_uc(struct rs_control *rs, int len, int errs,
>>>
>>>                 if (memcmp(r, c, len * sizeof(*r)))
>>>                         stat->dwrong++;
>>> +
>>> +               cond_resched();
>>>         }
>>>         stat->nwords += trials;
>>>  }
>>> @@ -400,6 +402,8 @@ static void test_bc(struct rs_control *rs, int len, int errs,
>>>                 } else {
>>>                         stat->rfail++;
>>>                 }
>>> +
>>> +               cond_resched();
>>>         }
>>>         stat->nwords += trials;
>>>  }
>>> ----- END -----
>>>
>>>> pseudorandom generator. I remember the problems related to much
>>>> slower random generator, for example, see the commit
>>>> f900fde28883602b6 ("crypto: testmgr - fix RNG performance in fuzz
>>>> tests").
>>>
>>> I haven't tested this but I'll look into it!

For the same reason pointed out by the commit f900fde28883 ("crypto: 
testmgr - fix RNG performance in fuzz tests"), the commit d4150779e60f
("random32: use real rng for non-deterministic randomness") does seem
to have slowed down the rslib test.

On Raspberry pi 4(4G Mem, 4 CPUs), running the rslib test on v5.19 with
the commit d4150779e60f ("random32: use real rng for non-deterministic
randomness") takes about 450sec compared to v5.18(without the commit)
which only takes about 350sec.

However, random number generation does not seem to be the only reason
for the rslib test being slow.
Below is the function stats for v5.18 vs v5.19 for the test.

v5.18
+  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] load_module
+  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_init_module
+  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_one_initcall
+   59.90%    59.90%  insmod   [kernel.kallsyms]      [k] decode_rs16
+   30.28%     0.00%  insmod   [unknown]              [k] 0xffffffd60413a748
+   21.39%    21.39%  insmod   [kernel.kallsyms]      [k] encode_rs16
+   20.94%     0.00%  insmod   [unknown]              [k] 0xffffffd60441b0d4
+   14.17%     0.01%  insmod   [unknown]              [k] 0xffffffd60413a324
+   12.92%     0.00%  insmod   [unknown]              [k] 0xffffffd60413a720
+   11.74%     0.00%  insmod   [unknown]              [k] 0xffffffd60413a368
+   11.63%     0.01%  insmod   [unknown]              [k] 0xffffffd60413a4b4
+    6.60%     0.01%  insmod   [unknown]              [k] 0xffffffd60413a46c
+    3.26%     3.26%  insmod   [unknown]              [k] 0xffffffd60413a3c4
+    3.11%     3.11%  insmod   [kernel.kallsyms]      [k] prandom_u32

v5.19
+  100.00%     0.00%  insmod   [kernel.kallsyms]  [k] load_module
+  100.00%     0.00%  insmod   [kernel.kallsyms]  [k] do_init_module
+  100.00%     0.00%  insmod   [kernel.kallsyms]  [k] do_one_initcall
+   45.13%    45.13%  insmod   [kernel.kallsyms]  [k] decode_rs16
+   27.84%    27.83%  insmod   [kernel.kallsyms]  [k] get_random_u32
+   22.83%     0.01%  insmod   [unknown]          [k] 0xffffffd62b379324
+   22.76%     0.00%  insmod   [unknown]          [k] 0xffffffd62b379748
+   22.35%     0.00%  insmod   [unknown]          [k] 0xffffffd62b379720
+   16.17%    16.17%  insmod   [kernel.kallsyms]  [k] encode_rs16

As the v5.19 stats shows, the commit d4150779e60f ("random32: use real
rng for non-deterministic randomness") did slowed down the rslib test
by using real random number generator(prandom_u32->get_random_u32).
But it also shows that the decode/encoding takes quite a lot of time.

For the above reason, if we want make the softlockup go away, maybe
just converting from real to pseudo random generator won't be enough?
I tested with below changes applied to v6.14 which uses pseudo random
numbers instead of real ones similar to what the commit f900fde28883
("crypto: testmgr - fix RNG performance in fuzz tests") did.

The result is that while it did help to fast up the test from 450 sec
to 350 sec, it still triggers the softlockup.

--- BEGIN ---
diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
index 75cb1adac..5785e3c0c 100644
--- a/lib/reed_solomon/test_rslib.c
+++ b/lib/reed_solomon/test_rslib.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/prandom.h>
 #include <linux/random.h>
 #include <linux/slab.h>

@@ -95,6 +96,16 @@ static struct pad pad_coef[] = {
        { 1, 0 },
 };

+static inline void init_rnd_state(struct rnd_state *rng)
+{
+       prandom_seed_state(rng, get_random_u64());
+}
+
+static inline u32 prandom_u32_below(struct rnd_state *rng, u32 ceil)
+{
+       return prandom_u32_state(rng) % ceil;
+}
+
 static void free_ws(struct wspace *ws)
 {
        if (!ws)
@@ -151,6 +162,7 @@ static struct wspace *alloc_ws(struct rs_codec *rs)
 static int get_rcw_we(struct rs_control *rs, struct wspace *ws,
                        int len, int errs, int eras)
 {
+       struct rnd_state rng;
        int nroots = rs->codec->nroots;
        int *derrlocs = ws->derrlocs;
        int *errlocs = ws->errlocs;
@@ -162,9 +174,11 @@ static int get_rcw_we(struct rs_control *rs, struct wspace *ws,
        int errloc;
        int i;

+       init_rnd_state(&rng);
+
        /* Load c with random data and encode */
        for (i = 0; i < dlen; i++)
-               c[i] = get_random_u32() & nn;
+               c[i] = prandom_u32_state(&rng) & nn;

        memset(c + dlen, 0, nroots * sizeof(*c));
        encode_rs16(rs, c, dlen, c + dlen, 0);
@@ -178,12 +192,12 @@ static int get_rcw_we(struct rs_control *rs, struct wspace *ws,
        for (i = 0; i < errs; i++) {
                do {
                        /* Error value must be nonzero */
-                       errval = get_random_u32() & nn;
+                       errval = prandom_u32_state(&rng) & nn;
                } while (errval == 0);

                do {
                        /* Must not choose the same location twice */
-                       errloc = get_random_u32_below(len);
+                       errloc = prandom_u32_below(&rng, len);
                } while (errlocs[errloc] != 0);

                errlocs[errloc] = 1;
@@ -194,19 +208,19 @@ static int get_rcw_we(struct rs_control *rs, struct wspace *ws,
        for (i = 0; i < eras; i++) {
                do {
                        /* Must not choose the same location twice */
-                       errloc = get_random_u32_below(len);
+                       errloc = prandom_u32_below(&rng, len);
                } while (errlocs[errloc] != 0);

                derrlocs[i] = errloc;

-               if (ewsc && get_random_u32_below(2)) {
+               if (ewsc && prandom_u32_below(&rng, 2)) {
                        /* Erasure with the symbol intact */
                        errlocs[errloc] = 2;
                } else {
                        /* Erasure with corrupted symbol */
                        do {
                                /* Error value must be nonzero */
-                               errval = get_random_u32() & nn;
+                               errval = prandom_u32_state(&rng) & nn;
                        } while (errval == 0);

                        errlocs[errloc] = 1;
--- END ---

Below is the function stats for with vs without the above change.

v6.14 without the above change
+  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] load_module
+  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_init_module
+  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_one_initcall
+   46.94%    46.94%  insmod   [kernel.kallsyms]      [k] decode_rs16
+   24.92%    24.92%  insmod   [kernel.kallsyms]      [k] get_random_u32
+   23.59%     0.01%  insmod   [unknown]              [k] 0xffffffde423d88cc
+   22.66%     0.00%  insmod   [unknown]              [k] 0xffffffde423d82c0
+   22.39%     0.00%  insmod   [unknown]              [k] 0xffffffde423d88a4
+   16.67%    16.67%  insmod   [kernel.kallsyms]      [k] encode_rs16

v6.14 with the above change
+  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] load_module
+  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_init_module
+  100.00%     0.00%  insmod   [kernel.kallsyms]      [k] do_one_initcall
+   61.51%    61.50%  insmod   [kernel.kallsyms]      [k] decode_rs16
+   31.15%     0.00%  insmod   [unknown]              [k] 0xffffffe7013858cc
+   21.75%    21.75%  insmod   [kernel.kallsyms]      [k] encode_rs16
+   21.36%     0.01%  insmod   [unknown]              [k] 0xffffffe70137f120
+   15.20%     0.00%  insmod   [unknown]              [k] 0xffffffe7013852c0
+   12.79%     0.00%  insmod   [unknown]              [k] 0xffffffe7013858a4
+   12.00%     0.00%  insmod   [unknown]              [k] 0xffffffe7013854c0
+   12.00%     0.00%  insmod   [unknown]              [k] 0xffffffe701385304
+    6.74%     0.01%  insmod   [unknown]              [k] 0xffffffe701385600
+    3.43%     3.43%  insmod   [unknown]              [k] 0xffffffe701385598
+    2.50%     2.50%  insmod   [unknown]              [k] 0xffffffe701385564
+    1.96%     1.96%  insmod   [kernel.kallsyms]      [k] prandom_u32_state
+    1.85%     1.85%  insmod   [kernel.kallsyms]      [k] get_random_u64

So maybe we still need cond_resched() in addition to converting the
test from using psuedo random numbers to real ones in order to make
the softlockup go away?

>>>> That said, I did not dig deep into the code. And I did not try to
>>>> reproduce the softlockup. I am pretty busy at the moment with some
>>>> other stuff. I just wanted to give it a look and share my opinion.
>>>
>>> I think the softlockup is rather a problem of test itself,
>>> not the two commits.
>>
>>Thanks Ryo for looking into this! I think we need to have a technical
>>explanation/understanding of the problem so that it is clear how my
>>series triggers or exaggerates the issue.

As mentioned earlier, I'm sorry that I should have run the test as
inserted module... It seems the series does make the test more prone
to softlockups.

I am still looking into the issue but I noticed that if the printing
during the test were done in a caller context, not by printk thread,
the softlock goes away.

I tested with a change something like below so that the printing during
the test were not delegated to printk thread ("pr/ttyS0"). With the below
change, the softlock no longer shows up.

--- BEGIN ---
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

I tried to figure out how softlockup disappears over the weekend but
couldn't... Seems the John's series somehow prevents the softlockup
thread from touching its timestamp.

I would like to continue looking into the issue and appreaciate any
comment! Hope this provides some insight for now.

Sincerely,
Ryo Takakura

>I see. I can't yet say anything but still not sure if your series has
>anything to do with the softlockup... I found that there was similar
>report in the past [0].
>
>Anyways, I will look into the rslib test itself more carefully to see
>if I can give the needed technical explanation for the problem!
>[0] https://lore.kernel.org/linux-kernel//a309f09e07374e62a77bb84c70e6715efd288448.1583122776.git.planteen@gmail.com/
