Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BE41864C
	for <linux-serial@vger.kernel.org>; Mon, 25 Mar 2024 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385683; cv=none; b=tzl9DEiWTKdMF0zK0/xjA/4rxNi/aZQ6uACqWOwgouL5xoasVSDPFmI4XUVng/iWOOGQCcZZAB90ZM8VnDVX2X1YHdiDEh3b8aEp2jgWemvUd/IHTRyOIzDurTzzmmZ5rE64EPn+ZoOz4ggjwT/kvgRjdtSSGkqgAVGDDkjoMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385683; c=relaxed/simple;
	bh=aa/xAgoFTkZQ5akxv87DP3DR9trs5AVyysEqRbo7sDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iETW8TsnnWeO2Bt/tdVudesvuILPmSAW19iIpvZg8Zt7HVWp4LBhv4GfoqF3Bd3JyRPNzOYxy+F02pM3qj+fjPLqDITEzjzeZoJ3dwkjdCCYZ6/S5rRknmcSaNZ/UuBIEdmNRtqr6MdRIqEepvcIRD32GX55K16w8Vwvr3YPxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OX5li4QR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OX5li4QR"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4148c65ea45so2138895e9.2
        for <linux-serial@vger.kernel.org>; Mon, 25 Mar 2024 09:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711385680; x=1711990480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=thWnxSeVJWJoNwYSEy6KslujnniVC0YW7pv2seZdkrc=;
        b=OX5li4QRJJuvmM3dhtkbFxzK43k0yukDkz1GMuLICv7DcY75m4hZ2nOTf/8XScqG6D
         8gzBrNH4SpiuBQgOR5ll/TB7Ty7SBSXTnWyqk8WN4U3ihzZKymIKhA+UEuORU8vcDqYJ
         6OqGDcjfJcF1jOIMbdq4hAInJKoz8AxxkE6N/RRdeUMq26dUXu7WoSLx1QpGZpyl2Vuz
         AhNZq4aSxibiMvgQEuW89wOQ6UnboA6HcwH7wpvVBXN6mjCRmPGaCxuvctAvBFrLELjG
         9/6fGljcHk5bJoTeFvbViH1WYgbiuXwLrbm0bIzaq1qSkYXPb8vaVedlKq9WoP983wHl
         RrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711385680; x=1711990480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thWnxSeVJWJoNwYSEy6KslujnniVC0YW7pv2seZdkrc=;
        b=TnYMbxIaJcvq4ZWxsck871Gl6MwiFcTmtXwV95jkXk69vE/Pwgq/y89bYZPYGDV6A6
         m3GuuqTCyYnzB4B61WYahC/9PxdnuYtifrpVL6iMsNPPcPnAvEKRLD2voK8zuvxQGAc3
         UNvYOXX78ymSYh1NdR9SbHKBKyii/2VTsjrlRSt6FUCMH91Bry/4SvVsTu/ELN3S1LRV
         FrF1NpLiFpEPkKR4be1ScpzaMdmHELHUt4L3TBzWNwHOIcz3O/vuo0HKDUq7d5MJkHMv
         Pjg8jEd4U5o/FnLfnt6aV7ITY/HusqYb/0UY+TM3aSNyRmtbkQ9W7emL3wONk8LmB5MW
         8jUw==
X-Forwarded-Encrypted: i=1; AJvYcCVHibM40PoSOSAReAte3Z15wWTW647boe4fi/wTWS92i7Ry5GyYhtLx3n+Cm/38qoBjRQ1vqQxKV3dh/7w74xAiTHQG+7SDLiLBW32w
X-Gm-Message-State: AOJu0Yw7E524HO7FnVWgLBW6u0tV5bLNnyIpt9R0FqjjT5jPH/YH2qwP
	FwO6BS/B2P/63BcaUHMHfmtet7pPSbdW3xeOjcOQx4sPsLdu3nLS5QDbdeQIles=
X-Google-Smtp-Source: AGHT+IHteQ08KR4uBeC4mxrJOYPYdh8IfwZeys4Zf0ji1SkwDrS1kdczfpPUgcIsXuTKPaRgcaodUQ==
X-Received: by 2002:a05:600c:214:b0:414:924:8ff9 with SMTP id 20-20020a05600c021400b0041409248ff9mr6276879wmi.34.1711385680250;
        Mon, 25 Mar 2024 09:54:40 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d4d0f000000b003418016b04csm9938384wrt.76.2024.03.25.09.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 09:54:38 -0700 (PDT)
Date: Mon, 25 Mar 2024 16:54:36 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: liu.yec@h3c.com
Cc: jirislaby@kernel.org, dianders@chromium.org, gregkh@linuxfoundation.org,
	jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH V5] kdb: Fix the deadlock issue in KDB debugging.
Message-ID: <20240325165436.GA485978@aspen.lan>
References: <20240322155818.GD7342@aspen.lan>
 <20240323014141.3621738-1-liu.yec@h3c.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323014141.3621738-1-liu.yec@h3c.com>

On Sat, Mar 23, 2024 at 09:41:41AM +0800, liu.yec@h3c.com wrote:
> From: LiuYe <liu.yeC@h3c.com>
>
> Currently, if CONFIG_KDB_KEYBOARD is enabled, then kgdboc will
> attempt to use schedule_work() to provoke a keyboard reset when
> transitioning out of the debugger and back to normal operation.
> This can cause deadlock because schedule_work() is not NMI-safe.
>
> The stack trace below shows an example of the problem. In this
> case the master cpu is not running from NMI but it has parked
> the slave CPUs using an NMI and the parked CPUs is holding
> spinlocks needed by schedule_work().
>
> example:
>  BUG: spinlock lockup suspected on CPU#0, namex/10450
>  lock: 0xffff881ffe823980, .magic: dead4ead, .owner: namexx/21888, .owner_cpu: 1
>  ffff881741d00000 ffff881741c01000 0000000000000000 0000000000000000
>  ffff881740f58e78 ffff881741cffdd0 ffffffff8147a7fc ffff881740f58f20
> Call Trace:
>  [<ffffffff81479e6d>] ? __schedule+0x16d/0xac0
>  [<ffffffff8147a7fc>] ? schedule+0x3c/0x90
>  [<ffffffff8147e71a>] ? schedule_hrtimeout_range_clock+0x10a/0x120
>  [<ffffffff8147d22e>] ? mutex_unlock+0xe/0x10
>  [<ffffffff811c839b>] ? ep_scan_ready_list+0x1db/0x1e0
>  [<ffffffff8147e743>] ? schedule_hrtimeout_range+0x13/0x20
>  [<ffffffff811c864a>] ? ep_poll+0x27a/0x3b0
>  [<ffffffff8108c540>] ? wake_up_q+0x70/0x70
>  [<ffffffff811c99a8>] ? SyS_epoll_wait+0xb8/0xd0
>  [<ffffffff8147f296>] ? entry_SYSCALL_64_fastpath+0x12/0x75
>  CPU: 0 PID: 10450 Comm: namex Tainted: G           O    4.4.65 #1
>  Hardware name: Insyde Purley/Type2 - Board Product Name1, BIOS 05.21.51.0036 07/19/2019
>   0000000000000000 ffff881ffe813c10 ffffffff8124e883 ffff881741c01000
>   ffff881ffe823980 ffff881ffe813c38 ffffffff810a7f7f ffff881ffe823980
>   000000007d2b7cd0 0000000000000001 ffff881ffe813c68 ffffffff810a80e0
>   Call Trace:
>   <#DB>  [<ffffffff8124e883>] dump_stack+0x85/0xc2
>   [<ffffffff810a7f7f>] spin_dump+0x7f/0x100
>   [<ffffffff810a80e0>] do_raw_spin_lock+0xa0/0x150
>   [<ffffffff8147eb55>] _raw_spin_lock+0x15/0x20
>   [<ffffffff8108c256>] try_to_wake_up+0x176/0x3d0
>   [<ffffffff8108c4c5>] wake_up_process+0x15/0x20
>   [<ffffffff8107b371>] insert_work+0x81/0xc0
>   [<ffffffff8107b4e5>] __queue_work+0x135/0x390
>   [<ffffffff8107b786>] queue_work_on+0x46/0x90
>   [<ffffffff81313d28>] kgdboc_post_exp_handler+0x48/0x70
>   [<ffffffff810ed488>] kgdb_cpu_enter+0x598/0x610
>   [<ffffffff810ed6e2>] kgdb_handle_exception+0xf2/0x1f0
>   [<ffffffff81054e21>] __kgdb_notify+0x71/0xd0
>   [<ffffffff81054eb5>] kgdb_notify+0x35/0x70
>   [<ffffffff81082e6a>] notifier_call_chain+0x4a/0x70
>   [<ffffffff8108304d>] notify_die+0x3d/0x50
>   [<ffffffff81017219>] do_int3+0x89/0x120
>   [<ffffffff81480fb4>] int3+0x44/0x80
>
> Just need to postpone schedule_work to the slave CPU exiting the NMI context.
>
> irq_work will only respond to handle schedule_work after exiting the current interrupt context.
>
> When the master CPU exits the interrupt context, other CPUs will naturally exit the NMI context, so there will be no deadlock.
>
> It is the call to input_register_handler() that forces us not to do the work from irq_work's hardirq callback.
>
> Therefore schedule another work in the irq_work and not do the job directly.

This looks like it was copy and pasted from the e-mail thread without
any editing to make it make any sense. It not even formatted correctly
(where are the line breaks?).

How about:

We fix the problem by using irq_work to call schedule_work()
instead of calling it directly. irq_work is an NMI-safe deferred work
framework that performs the requested work from a hardirq context
(usually an IPI but it can be timer interrupt on some
architectures).

Note that we still need to  a workqueue since we cannot resync
the keyboard state from the hardirq context provided by irq_work.
That must be done from task context for the calls into the input
subystem. Hence we must defer the work twice. First to safely
switch from the debug trap (NMI-like context) to hardirq and
then, secondly, to get from hardirq to the system workqueue.


Daniel.
