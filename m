Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816F2243364
	for <linux-serial@vger.kernel.org>; Mon, 17 Mar 2025 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222551; cv=none; b=gfchizpuRt0dVt3NO+oR6pciv9qubwBSRqqi6BpGKLC9XCjpcxYv2o9VX0AWVuZxUN/+0Ly+VXVzEpEQkFCxIYN1fDyHW8GkOzW1T9mVaBrxHNaDdkXiqasPA2eRYB289QBVZEMpVhfoTStgXQKe0D/dJcDig8av1XS+I9QOFMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222551; c=relaxed/simple;
	bh=Q1a6ifPK0PRS3rvFIO8fvE8J6Ojm9mTh/EDT/GpZlYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T28wzdspNpf3rQzXXAHG1CUcF9uVGgJhcAuBrbgipewhB4C5uce0scTDaJBombpypLMpSKyk/PCgOHm3icjnuLiM1FGjfYZPzK1PRDVO9gsr2vCzB7UwgLHVYC9Xz8un9ZSOg+wHVm7EV/jzdDjBGXg9zARHVZqUC7OvhVWBCgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVM86U+Y; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVM86U+Y"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2239c066347so90530585ad.2
        for <linux-serial@vger.kernel.org>; Mon, 17 Mar 2025 07:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742222549; x=1742827349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mo34dNzTDqY+kho3xTyDIEKizwiLIjHQzb4U8w2qOx8=;
        b=jVM86U+YznG6TW85bryKD2KdWh/aTVrAiNj9tyIS12ycH9iPE8xHOsiHLwgBEGjEf6
         XWZpT9rtLX3Xhp31z6dLBjUMmtINJN6yIf53t1No3CTU8dfv6Bmbc8etDPRJCll3oiT7
         tXrUpVsU+2PEo+wOel4hdRu9IVKfPyK77v9EI5zAPXckSS3Roz65R9dvulSGLtHUHvXP
         7RXd4vJAbYare0yXktw+B20xDSMYykQ8XhRGbNC8p+03kwppeHECNNhKFtlk1/4mB249
         Vb759fi9RgCqQU6DlKEazjlb9Ma28up9gLCNm24pwbmRATSW1aQQV7IDIyqyagQiYkHu
         sL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742222549; x=1742827349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mo34dNzTDqY+kho3xTyDIEKizwiLIjHQzb4U8w2qOx8=;
        b=lRVPkMY+xY2VzMIUElGzMXQyQbZbAuSb4EtzmqiN7jZqZUPDKgljA/gOa1niSJpsXt
         XgpFDyjjinv1KyjUNnlFShbIR0Xkr0RqOIZ1EhKJBwIdx8QZ9xHb5sksq2Aeulo63USg
         mWOn4Q/GcJIRQmJcCdyQ9qD05/FCz4n7YIpqMuHz5Qa8mkgSrcsu2wkpG/DCoNDmpkzy
         twvuIVnY6NOXPVDPBvy8vvZTvhJCPAFbcSt55ayrNnXnglzXBGTGX+8GnAkZ2jFyu1Pc
         VHkpXaIThSB4w59VIQNxs6CvfKJ3NP2EK/8QlzOwLm5jRO4hlNKxefXOnWHn8oEUc60k
         3nmQ==
X-Forwarded-Encrypted: i=1; AJvYcCULwkZPJtXikxed0Ni9BtQlPwGyexiwRNn0gf2A8nAIYtO/VUA8C4CuvRz+AJgdRjgnD5rz2A03QaSeKjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyA4mZXLDcP3NpRUud686tLkYEB+7fbfnx0NXYHP5cCPHOVEA7
	ANgKsYiMDSz+wDVEpYbjEApwh8miCuRKFv5DjPawYynIKWmdMApdXrpxGg==
X-Gm-Gg: ASbGnctlW1iIUs7/nrHlXrvY10K5gVOB6T8ztq6LuWT8K2NTLz/9rzabb8TwQPYP1UW
	7wEO3XF54Ffen7Isy+qigYPP9GVIwvALjjLa7LoRIxdJzkCrGWO2086XTV+V1qqJAqQokt1gK8j
	URE9uckh2YR/wGXZu/MSzCQD7DmZQE+d5lksgigTD1JNW8U47mtEnshbc7VFMdcQoxX8FG3xKT3
	IC8MYnXKJXGIGDrMEwlrluNM+xMCA2Y1ZrYADFHnq59MzwhcLyyR6Dz7ueyGI34E/x1SdXREo2J
	8Nn3TkP1Sj+wmXX/I56oZF8IpJqKDMt4Nd2XXyYBijobVcW8oIXWcVj56xoGey1lEWKhpRKjDA0
	0k41h3lSd6Xuiw7cKbTrCOiAxKuZCKzw50KU2ZYCyOQ==
X-Google-Smtp-Source: AGHT+IFJuuaswRcjPjh2sxYceH6LcyJNRZt9OgTh9fUEx+QGKF9VIDgzba6msfZ4UrRc/xoUXNrPIw==
X-Received: by 2002:a05:6a00:1397:b0:736:a682:deb8 with SMTP id d2e1a72fcca58-737223951d2mr17365260b3a.8.1742222548622;
        Mon, 17 Mar 2025 07:42:28 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711695493sm7870028b3a.137.2025.03.17.07.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:42:28 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: john.ogness@linutronix.de
Cc: Jason@zx2c4.com,
	gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	pmladek@suse.com,
	ryotkkr98@gmail.com
Subject: Re: [linux-next:master] [serial]  b63e6f60ea: BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]
Date: Mon, 17 Mar 2025 23:42:21 +0900
Message-Id: <20250317144221.8231-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <84a59krqo5.fsf@jogness.linutronix.de>
References: <84a59krqo5.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi John!

On Mon, 17 Mar 2025 09:51:46 +0106, John Ogness wrote:
>On 2025-03-15, Ryo Takakura <ryotkkr98@gmail.com> wrote:
>> I got the same softlockup during the test regardless of the presence
>> of the commits.
>>
>> [   60.222013] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [swapper/0:1]
>> [   60.222023] Modules linked in:
>> [   60.222032] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G             L     6.14.0-rc6-v14-rc6-voluntary+ #4
>> [   60.222047] Tainted: [L]=SOFTLOCKUP
>> [   60.222051] Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
>> [   60.222055] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [   60.222066] pc : get_random_u32+0xac/0x118
>> [   60.222081] lr : __get_random_u32_below+0x20/0x78
>> [   60.222094] sp : ffffffc08002bb80
>> [   60.222098] x29: ffffffc08002bb80 x28: 0000000000000003 x27: 0000000000000001
>> [   60.222114] x26: ffffff804112e6a4 x25: ffffffd33ed21820 x24: ffffff804112e69c
>> [   60.222128] x23: 0000000000000000 x22: ffffff804112e64e x21: 0000000000000000
>> [   60.222142] x20: 000000000000000d x19: ffffff80fb7aebb8 x18: 0000000000000002
>> [   60.222156] x17: 0000000000000004 x16: ffffff804112e584 x15: ffffff8041126796
>> [   60.222169] x14: ffffff80411267c0 x13: 0000000000000006 x12: ffffff804112e5c0
>> [   60.222183] x11: ffffff804112e64c x10: 0000000000000007 x9 : ffffffd33dccdd10
>> [   60.222196] x8 : ffffff804112e6a8 x7 : 0000000000000000 x6 : 0005000400060005
>> [   60.222210] x5 : ffffff804112e65a x4 : 0000000000000000 x3 : 0000000000000010
>> [   60.222223] x2 : 0000000000000014 x1 : 000000002c7d0b7a x0 : 0000000000000013
>> [   60.222237] Call trace:
>> [   60.222241]  get_random_u32+0xac/0x118 (P)
>> [   60.222256]  __get_random_u32_below+0x20/0x78
>> [   60.222268]  get_rcw_we+0x180/0x208
>> [   60.222278]  test_rslib_init+0x2c8/0xba0
>> [   60.222292]  do_one_initcall+0x4c/0x210
>> [   60.222303]  kernel_init_freeable+0x1fc/0x3a0
>> [   60.222317]  kernel_init+0x28/0x1f8
>> [   60.222327]  ret_from_fork+0x10/0x20
>>
>>> I wonder if a cond_resched() in some loop would help. Or using a
>>
>> I wasn't sure which loop would be the appropriate one but adding
>> cond_resched() as below worked as suggested.
>>
>> ----- BEGIN -----
>> diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
>> index 75cb1adac..322d7b0a8 100644
>> --- a/lib/reed_solomon/test_rslib.c
>> +++ b/lib/reed_solomon/test_rslib.c
>> @@ -306,6 +306,8 @@ static void test_uc(struct rs_control *rs, int len, int errs,
>>
>>                 if (memcmp(r, c, len * sizeof(*r)))
>>                         stat->dwrong++;
>> +
>> +               cond_resched();
>>         }
>>         stat->nwords += trials;
>>  }
>> @@ -400,6 +402,8 @@ static void test_bc(struct rs_control *rs, int len, int errs,
>>                 } else {
>>                         stat->rfail++;
>>                 }
>> +
>> +               cond_resched();
>>         }
>>         stat->nwords += trials;
>>  }
>> ----- END -----
>>
>>> pseudorandom generator. I remember the problems related to much
>>> slower random generator, for example, see the commit
>>> f900fde28883602b6 ("crypto: testmgr - fix RNG performance in fuzz
>>> tests").
>>
>> I haven't tested this but I'll look into it!
>>
>>> That said, I did not dig deep into the code. And I did not try to
>>> reproduce the softlockup. I am pretty busy at the moment with some
>>> other stuff. I just wanted to give it a look and share my opinion.
>>
>> I think the softlockup is rather a problem of test itself, 
>> not the two commits.
>
>Thanks Ryo for looking into this! I think we need to have a technical
>explanation/understanding of the problem so that it is clear how my
>series triggers or exaggerates the issue.

I see. I can't yet say anything but still not sure if your series has
anything to do with the softlockup... I found that there was similar 
report in the past [0].

Anyways, I will look into the rslib test itself more carefully to see 
if I can give the needed technical explanation for the problem!

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/linux-kernel//a309f09e07374e62a77bb84c70e6715efd288448.1583122776.git.planteen@gmail.com/

>John
