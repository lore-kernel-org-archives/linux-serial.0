Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EAF26FA6F
	for <linux-serial@vger.kernel.org>; Mon, 29 Sep 2025 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135151; cv=none; b=pg7AeMVYGRvlcl7JqAV4fBgRM/eEMYo+todbqPAiiDzUiOnuvNJ9zRj2mvP9d6O09csuU0wa2peeLFu7KGyToV2P0V3ISPhZu5wUiY9k7h1is9IehS8+48WIE0V65frXHLCf4x/8aQKaNzz7wCqqpFq30aG/nc1qEuiFKROXq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135151; c=relaxed/simple;
	bh=TmaQd4o0RTw+qJvwfYDsZEYphnDFl8O+aVZ7c+sBUdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6nkxf+Jl3EE/jaztTJGmpWb5lMS3TSo32wmkG9Pp/tV1z2ekSjkEaYjqFxYZiDlEQJT4zlvqCVBPmxEMmCJv3KbHgBhCQSYhd4OZsTywRT9sdfCuqqQau1ggi4GfzULUFEUH7thaDq8fqp2JSWwI66qbGTy3lJKviVH1h1O6VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=oj8MYSzE; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="oj8MYSzE"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8d593793af1so170670839f.0
        for <linux-serial@vger.kernel.org>; Mon, 29 Sep 2025 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1759135148; x=1759739948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pFRvaYMJ1vy51yLdimM3/5jbpqBBGlPL331N70STe0c=;
        b=oj8MYSzExuMnVsz8kYjdmvDOjEkG0u4Hk4Iq0d1H2yWvWtXkeiWQnLGUKURIaBFBCH
         fK1LnUFWBovn2ZVJ9HKh8Zgu/aHji8pIQcAZHv74rpFSK02yU+KDcobatKCyDKX7g50y
         ajDXSpBvYnRPb4o7tzwskNyaldiRPbqIAcqvDjlWgKEFcmb67zUb7pG51y8AsvRjXrnV
         Q8VEuEQQtC1hhZ9XjUIIWBwagwV/lDjseh7gqhCRsILyVyGZu4/cn1SWGh7zplZ0TM5w
         FiKuFX4r3QIMxkzpVQ635DfnyDP1XvKcv2M1Ka6UGdMgkR3E/dQMUv+dRUGDQnmt/sVY
         QqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759135148; x=1759739948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFRvaYMJ1vy51yLdimM3/5jbpqBBGlPL331N70STe0c=;
        b=JzuWNFxJUsMctqeBec6WW5Yr+zyJEI+esBGhl66fasaGL4tSb6E6QNCPysxwVl0v8M
         8EBRFXSbgyWSPDJC/nLF4EYcXLuBM4/3RZRBF6eiTp20NztCKZspov9TvjirsGAkO9w2
         1Zn/exrDzfRabcpR0+ifoVJ+zmSMqg7SagqY/lq4HATslg4s8u0tWWVO0XX2Xc8/VIlx
         8jQxwwhQZz4iM5GzyaytFH5H/JyEIV3kpwKZaAxOofhKhzEhkF8WACDYrUilSEXKx4MJ
         8n6CxqgW3ML6bxO/FCWhhb55kUni8ReBvki9q30Mg3Leb6GAHMOz4b4Hsx/l5qQ3kY7N
         5WRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhZApo93xZBq0h3QaFrmAVHQQufHsJqmphSGyek+UStikhnjptagH/XMsTS6Htw1LcoXceOZ8mhflZHUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKly4x4bn2ZF0lSYBolotzsNnc35t88MrgrmUa1Anb+9uPeF5+
	VBctfscWtqd0iiwpl0ao82WKoT0xq8shn/ijbkue6YPcIsUl/Xl659S1eDOYcByr5IUg4EUzm7r
	8JeZRZXRGd2sGJghHmV8t3rE6fe7aEtt4dK1KrNqUuQ==
X-Gm-Gg: ASbGncsVVsRiIHGVdzbDeJjL4x+emZvXD2DmTuDKJPMQhmrJOKyoaFsvGeebpj16vg0
	1d9WFPoiKgBsTxORTA3MiLyS1kxqiPwdPLgc5cJiiTmIqFAPMq3EfTmMi6PISSYu5EgD+JOr4qQ
	9J49IWUIMKylw6+tyIeiagg1VZ5V0Bjf4tcdUIJi4avvqQPV5SYogU9KS6o6upt7EoIhTXy9v0x
	8M/O1mUlry/elHOaKOmwc9zBjYiYfJNwD6ssn24mOheT5SiQXM=
X-Google-Smtp-Source: AGHT+IFxrKzPQAcrlzU7ZDuTd4iixFCb7z3l3mi1CDZ/S+VlSgc8ICsJKl2Oly84woPaCzcz1Abkt6vL+5MZwcT5y5g=
X-Received: by 2002:a05:6e02:1a82:b0:42b:7615:46a1 with SMTP id
 e9e14a558f8ab-42b76154ee9mr53607275ab.6.1759135148141; Mon, 29 Sep 2025
 01:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926124912.243464-1-pmladek@suse.com> <20250926124912.243464-4-pmladek@suse.com>
In-Reply-To: <20250926124912.243464-4-pmladek@suse.com>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Mon, 29 Sep 2025 09:38:57 +0100
X-Gm-Features: AS18NWCXdvU2ZbPVb8EAa62GjVbFMiWAQd1KeKjdEBSGcOtZptF6Dl6utgPxIoM
Message-ID: <CALqELGzfY2L0z231Zt94-iuy5jE-+Lzjm2TqMgHrE3jsx-DCBQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] printk/nbcon: Release nbcon consoles ownership in
 atomic flush after each emitted record
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Tony Lindgren <tony@atomide.com>, Niklas Schnelle <schnelle@linux.ibm.com>, 
	Serge Semin <fancer.lancer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 13:50, Petr Mladek <pmladek@suse.com> wrote:
>
> printk() tries to flush messages with NBCON_PRIO_EMERGENCY on
> nbcon consoles immediately. It might take seconds to flush all
> pending lines on slow serial consoles. Note that there might be
> hundreds of messages, for example:
>
> [    3.771531][    T1] pci 0000:3e:08.1: [8086:324
> ** replaying previous printk message **
> [    3.771531][    T1] pci 0000:3e:08.1: [8086:3246] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [ ... more than 2000 lines, about 200kB messages ... ]
> [    3.837752][    T1] pci 0000:20:01.0: Adding to iommu group 18
> [    3.837851][    T
> ** replaying previous printk message **
> [    3.837851][    T1] pci 0000:20:03.0: Adding to iommu group 19
> [    3.837946][    T1] pci 0000:20:05.0: Adding to iommu group 20
> [ ... more than 500 messages for iommu groups 21-590 ...]
> [    3.912932][    T1] pci 0000:f6:00.1: Adding to iommu group 591
> [    3.913070][    T1] pci 0000:f6:00.2: Adding to iommu group 592
> [    3.913243][    T1] DMAR: Intel(R) Virtualization Technology for Directed I/O
> [    3.913245][    T1] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    3.913245][    T1] software IO TLB: mapped [mem 0x000000004f000000-0x0000000053000000] (64MB)
> [    3.913324][    T1] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
> [    3.913325][    T1] RAPL PMU: hw unit of domain package 2^-14 Joules
> [    3.913326][    T1] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [    3.913327][    T1] RAPL PMU: hw unit of domain psys 2^-0 Joules
> [    3.933486][    T1] ------------[ cut here ]------------
> [    3.933488][    T1] WARNING: CPU: 2 PID: 1 at arch/x86/events/intel/uncore.c:1156 uncore_pci_pmu_register+0x15e/0x180
> [    3.930291][    C0] watchdog: Watchdog detected hard LOCKUP on cpu 0
> [    3.930291][    C0] Kernel panic - not syncing: Hard LOCKUP
> [...]
> [    3.930291][    C0] CPU: 0 UID: 0 PID: 18 Comm: pr/ttyS0 Not tainted...
> [...]
> [    3.930291][    C0] RIP: 0010:nbcon_reacquire_nobuf+0x11/0x50
> [    3.930291][    C0] Call Trace:
> [...]
> [    3.930291][    C0]  <TASK>
> [    3.930291][    C0]  serial8250_console_write+0x16d/0x5c0
> [    3.930291][    C0]  nbcon_emit_next_record+0x22c/0x250
> [    3.930291][    C0]  nbcon_emit_one+0x93/0xe0
> [    3.930291][    C0]  nbcon_kthread_func+0x13c/0x1c0
>
> The are visible two takeovers of the console ownership:
>
>   - The 1st one is triggered by the "WARNING: CPU: 2 PID: 1 at
>     arch/x86/..." line printed with NBCON_PRIO_EMERGENCY.
>
>   - The 2nd one is triggered by the "Kernel panic - not syncing:
>     Hard LOCKUP" line printed with NBCON_PRIO_PANIC.
>
> There are more than 2500 lines, at about 240kB, emitted between
> the takeover and the 1st "WARNING" line in the emergency context.
> This amount of pending messages had to be flushed by
> nbcon_atomic_flush_pending() when WARN() printed its first line.
>
> The atomic flush was holding the nbcon console context for too long so
> that it triggered hard lockup on the CPU running the printk kthread
> "pr/ttyS0". The kthread needed to reacquire the console ownership
> for restoring the original serial port state in serial8250_console_write().
>
> Prevent the hardlockup by releasing the nbcon console ownership after
> each emitted record.
>
> Note that __nbcon_atomic_flush_pending_con() used to hold the console
> ownership all the time because it blocked the printk kthread. Otherwise
> the kthread tried to flush the messages in parallel which caused repeated
> takeovers and more replayed messages.
>
> It is not longer a problem because the repeated takeovers are blocked
> by the counter of emergency contexts, see nbcon_cpu_emergency_cnt.
>
> Link: https://lore.kernel.org/all/aNQO-zl3k1l4ENfy@pathway.suse.cz
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/printk/nbcon.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 219ae0c8b5ed..e298346111b2 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1532,10 +1532,10 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
>         ctxt->prio                      = nbcon_get_default_prio();
>         ctxt->allow_unsafe_takeover     = allow_unsafe_takeover;
>
> -       if (!nbcon_context_try_acquire(ctxt, false))
> -               return -EPERM;
> -
>         while (nbcon_seq_read(con) < stop_seq) {
> +               if (!nbcon_context_try_acquire(ctxt, false))
> +                       return -EPERM;
> +
>                 /*
>                  * nbcon_emit_next_record() returns false when the console was
>                  * handed over or taken over. In both cases the context is no
> @@ -1544,6 +1544,8 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
>                 if (!nbcon_emit_next_record(&wctxt, true))
>                         return -EAGAIN;
>
> +               nbcon_context_release(ctxt);
> +
>                 if (!ctxt->backlog) {
>                         /* Are there reserved but not yet finalized records? */
>                         if (nbcon_seq_read(con) < stop_seq)
> @@ -1552,7 +1554,6 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
>                 }
>         }
>
> -       nbcon_context_release(ctxt);
>         return err;
>  }
>
> --
> 2.51.0
>

Reviewed-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

Thanks,

Andrew Murray
