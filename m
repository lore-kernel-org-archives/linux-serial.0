Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C71CAA68
	for <linux-serial@vger.kernel.org>; Tue, 27 Jan 2026 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769515390; cv=none; b=VlvdZyd79Ee/lWusiEgRmWUbXYxriGhfMXqSrgtMgv5hqiLAq+dDQcxKnL+9MS4gYiEat/gsuVSQ8ohAGzP23ABHp8HhRh7xTdJoXgPMLAzdXQlyEwenK5ZQcz7iklM/jZa3Z13cbeFGAsOfApVXS9ndXwBg+OuFiF7syOuLaG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769515390; c=relaxed/simple;
	bh=VSDhsz7hhQgS/GjFO9HWbBRYdCO4lfz6dTEe5eSZ5Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lc6u6yqmYORW8f+2SzPq734h0833KlwwNv+LEg46DaSNuPZDnl/e/XJYtJYRqnzvR6LiiJBKHyA9X56RiyS7qJFje8RZrJZfPLbfiPJsOi7NTSMNdpWDmeq6J0+L+GCIVNOrxR5KQg8fpLNbqBCZxULKRKsm/PqKWBC7mUbta1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56379cb870bso1642476e0c.2
        for <linux-serial@vger.kernel.org>; Tue, 27 Jan 2026 04:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769515388; x=1770120188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1MjAM7V7GKMwIfo0dCUePGAiWLlyClrktdqGiTAq1E=;
        b=i57LRYWrhPdC6zbMfVd9nzxX8skbDokB0J3a7Sghcpx/CdtHpxNiHLKur5yiCeNQgX
         IVQCBfUglVrVX5NkbQUTvrBft6Dp5UE2Mxi9O7nNnsWaRFYTMbGAOm/Y7DUJXSqiFxHw
         907lbgq8M1QouSuuqG+Xs8WeyHCQjm9H5pS5SEjDuUeB8m1/iZBJQYuaPHrxkr2uwMYI
         cHE86EAPzBrKplgHMmkFn9l/YL6bJnhHLPw73Wl+I/ZNYPu51e/ejhKwknc3kMusgxuP
         d/w6iw3guIe68yIjglkmNleqhulbOI7Umkn1rj8YEitoXisAtunA008NCWZVctIuLkAV
         hU0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIA/L5kkXqF3NMHCn7NET5DfRgfM8k5OEj2oBomlEIiJPqDhNgUCweVcQNxQfJ2WEqVpNEQOMBhYSaWis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRmVJKhGG87g+Wi8tjQ6kSezlbQUhWTQC5COUkCxfvnWXbN4z
	ynV0i9SC8Fvk7ht7VheOuMjmkkgu2nfFvGnYm9YkK/Khiy0B1ZPs2kGwVH5+tqo1
X-Gm-Gg: AZuq6aJixtAdXx+C8oY3BorUztAwINmMFvjWY16jQCn8tSqS+8ZE2yv/0+rXsxGFE4r
	E/Ax5BFI6o8cOeTm11Qq13yGjAXOGqRxMIb2grVv6pNuVRpJ42XLUK5PH6sE2vz966bPdkdVxfu
	OESRmByByLrOuA38ECCKcr6zkxq0HLebOLv/BHshb/55jYJ8qft3VQG+S0Ongvc5llJXeEW3z0c
	ULBYm8bpaAYe0q8//UpaSnzWN5o/FPudF1tqCp1ITmHZy20I1MVousQJ1tfZKYdk4og5BKvwHaD
	I/WVc06UoDKeJ4aCIW/Y9ghdVlu6VvR7FrqQ0kFMdre24Aiyxh+wpj46tFMhdRj26prJaYZ7PuZ
	gzW9O8cXY2ryWsUghOnaq4aEIFZqvSgOO25a3XrBeuM3WKKMGDTZFWm9LOeEk6dWrV31YVaHMhd
	mE5lsKiJFs5CGqKFPsUKP6dxkzgjgVVisvmrgSy8uxEaWynCuDM04mP+YNwqk=
X-Received: by 2002:a05:6122:1799:b0:566:221e:a98e with SMTP id 71dfb90a1353d-566795ce2a8mr349622e0c.18.1769515388101;
        Tue, 27 Jan 2026 04:03:08 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5663f742b27sm2614658e0c.0.2026.01.27.04.02.56
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 04:02:57 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-93f5b804d4aso1851983241.3
        for <linux-serial@vger.kernel.org>; Tue, 27 Jan 2026 04:02:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+d3bMQc3rkNlJNgJzl2bRBfbEIQKhIiuRN9cS6FcYIKCIAaMFrsczP9YYQ2I8eir5KExii7gQ0CaPDOI=@vger.kernel.org
X-Received: by 2002:a05:6102:a50:b0:5ed:675:e355 with SMTP id
 ada2fe7eead31-5f72378e301mr620065137.27.1769515376244; Tue, 27 Jan 2026
 04:02:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223034836.2625547-1-jackzxcui1989@163.com>
 <CGME20260127103433eucas1p1ce8d8c194d4fd16d2f1dbbc0e9df28de@eucas1p1.samsung.com>
 <d1942304-ee30-478d-90fb-279519f3ae81@samsung.com> <aXic3pyl0xfTSYB-@tom-desktop>
In-Reply-To: <aXic3pyl0xfTSYB-@tom-desktop>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Jan 2026 13:02:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV2SLyrTs5MJKwAL2-jVLpd=TP+bMMnuEj-Ump0oyLjJA@mail.gmail.com>
X-Gm-Features: AZwV_QitHOaDYnXLTjC-AAT75rs03dxH0UgF1aly7BgaAEU8qPMzcTWF4eGkACQ
Message-ID: <CAMuHMdV2SLyrTs5MJKwAL2-jVLpd=TP+bMMnuEj-Ump0oyLjJA@mail.gmail.com>
Subject: Re: [PATCH v8] tty: tty_port: add workqueue to flip TTY buffer
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Xin Zhao <jackzxcui1989@163.com>, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, tj@kernel.org, 
	hch@infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jan 2026 at 12:10, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> On Tue, Jan 27, 2026 at 11:34:32AM +0100, Marek Szyprowski wrote:
> > On 23.12.2025 04:48, Xin Zhao wrote:
> > > On the embedded platform, certain critical data, such as IMU data, is
> > > transmitted through UART. The tty_flip_buffer_push() interface in the TTY
> > > layer uses system_dfl_wq to handle the flipping of the TTY buffer.
> > > Although the unbound workqueue can create new threads on demand and wake
> > > up the kworker thread on an idle CPU, it may be preempted by real-time
> > > tasks or other high-prio tasks.
> > >
> > > flush_to_ldisc() needs to wake up the relevant data handle thread. When
> > > executing __wake_up_common_lock(), it calls spin_lock_irqsave(), which
> > > does not disable preemption but disables migration in RT-Linux. This
> > > prevents the kworker thread from being migrated to other cores by CPU's
> > > balancing logic, resulting in long delays. The call trace is as follows:
> > >      __wake_up_common_lock
> > >      __wake_up
> > >      ep_poll_callback
> > >      __wake_up_common
> > >      __wake_up_common_lock
> > >      __wake_up
> > >      n_tty_receive_buf_common
> > >      n_tty_receive_buf2
> > >      tty_ldisc_receive_buf
> > >      tty_port_default_receive_buf
> > >      flush_to_ldisc
> > >
> > > In our system, the processing interval for each frame of IMU data
> > > transmitted via UART can experience significant jitter due to this issue.
> > > Instead of the expected 10 to 15 ms frame processing interval, we see
> > > spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
> > > be 2 to 3 occurrences of such high jitter, which is quite frequent. This
> > > jitter exceeds the software's tolerable limit of 20 ms.
> > >
> > > Introduce flip_wq in tty_port which can be set by tty_port_link_wq() or as
> > > default linked to default workqueue allocated when tty_register_driver().
> > > The default workqueue is allocated with flag WQ_SYSFS, so that cpumask and
> > > nice can be set dynamically. The execution timing of tty_port_link_wq() is
> > > not clearly restricted. The newly added function tty_port_link_driver_wq()
> > > checks whether the flip_wq of the tty_port has already been assigned when
> > > linking the default tty_driver's workqueue to the port. After the user has
> > > set a custom workqueue for a certain tty_port using tty_port_link_wq(), the
> > > system will only use this custom workqueue, even if tty_driver does not
> > > have %TTY_DRIVER_CUSTOM_WORKQUEUE flag.
> > >
> > > Introduce %TTY_DRIVER_CUSTOM_WORKQUEUE flag meaning not to create the
> > > default single tty_driver workqueue. Two reasons why need to introduce the
> > > %TTY_DRIVER_CUSTOM_WORKQUEUE flag:
> > > 1. If the WQ_SYSFS parameter is enabled, workqueue_sysfs_register() will
> > > fail when trying to create a workqueue with the same name. The pty is an
> > > example of this; if both CONFIG_LEGACY_PTYS and CONFIG_UNIX98_PTYS are
> > > enabled, the call to tty_register_driver() in unix98_pty_init() will fail.
> > > 2. Different tty ports may be used for different tasks, which may require
> > > separate core binding control via workqueues. In this case, the workqueue
> > > created by default in the tty driver is unnecessary. Enabling this flag
> > > prevents the creation of this redundant workqueue.
> > >
> > > After applying this patch, we can set the related UART TTY flip buffer
> > > workqueue by sysfs. We set the cpumask to CPU cores associated with the
> > > IMU tasks, and set the nice to -20. Testing has shown significant
> > > improvement in the previously described issue, with almost no stuttering
> > > occurring anymore.
> > >
> > > Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> >
> > This patch landed in linux-next as commit d000422a46aa ("tty: tty_port:
> > add workqueue to flip TTY buffer"). In my tests I found that it causes
> > some regressions, see the comments in the code below.
>
> Same here, testing on RZ/G3E looks like s2idle is broken:

> [  185.237717] Call trace:
> [  185.240176]  __queue_work+0x20/0x474 (P)
> [  185.244141]  queue_work_on+0x8c/0xa8
> [  185.247753]  tty_flip_buffer_push+0x2c/0x38

Lucky you, there is a hint to tty in your trace ;-)

I see a similar crash during boot on koelsch (R-Car M2-W), and a
lock-up during boot on salvator-xs (R-Car H3 ES2.0), with either no
output or an rcu stall:

    rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
    rcu:     1-...!: (0 ticks this GP) idle=1fe8/0/0x0 softirq=85/85
fqs=1 (false positive?)
    rcu:     2-...!: (1 ticks this GP) idle=1c78/0/0x0 softirq=77/77
fqs=1 (false positive?)
    rcu:     6-...!: (0 ticks this GP) idle=07b8/0/0x0 softirq=9/9
fqs=1 (false positive?)
    rcu:     (detected by 3, t=5260 jiffies, g=-1015, q=274 ncpus=8)
    Sending NMI from CPU 3 to CPUs 1:
    Sending NMI from CPU 3 to CPUs 2:
    Sending NMI from CPU 3 to CPUs 6:
    rcu: rcu_preempt kthread timer wakeup didn't happen for 12771
jiffies! g-1015 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x200
    rcu:     Possible timer handling issue on cpu=6 timer-softirq=1
    rcu: rcu_preempt kthread starved for 12780 jiffies! g-1015 f0x0
RCU_GP_WAIT_FQS(5) ->state=0x200 ->cpu=6
    rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM
is now expected behavior.
    rcu: RCU grace-period kthread stack dump:
    task:rcu_preempt     state:R stack:0     pid:15    tgid:15
ppid:2      task_flags:0x208040 flags:0x00000010
    Call trace:
     __switch_to+0xcc/0x100 (T)
     __schedule+0x368/0xc00
     schedule+0x30/0x100
     schedule_timeout+0x80/0xf8
     rcu_gp_fqs_loop+0xfc/0x418
     rcu_gp_kthread+0xe0/0xf4
     kthread+0x128/0x1e0
     ret_from_fork+0x10/0x20

Reverting commit d000422a46aad322 ("tty: tty_port: add workqueue to
flip TTY buffer") in tty-next fixes both.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
