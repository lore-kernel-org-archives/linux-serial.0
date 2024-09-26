Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED52F9DA
	for <linux-serial@vger.kernel.org>; Thu, 26 Sep 2024 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727357529; cv=none; b=DRknsLHscow/HHSTwOdV5RuFCteXWp/9aV7Oq3fG0tGuTuJYOWBSp9Nci1KhJZDsnaDU+rS+JUnjtD3UPaqCEXTFkmSI1Exc+gS9DWb/iQwMizSvG8I9K5nYlsjHtAMxauigb2t/IG4Ta3B/N50pe/g7SMbJFHVNjgQXpVsiyiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727357529; c=relaxed/simple;
	bh=LJcl/qBbQr5c5xL/kcM8bQSP0urCItkfmZWapAIECEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nsa1l0B85ON6LzaF6pwJd9XRCHejlNAdan3VkgjGWctUpWiJ157jTT2plB2doej+FFUistSDJe9erTabmuugxTuUilBfg24SN2KtJF0+7BPd4/ZEYfJLM28T0mpxDBXH3bzvAMiUTaA/LKTb6Y6erem1Z+b9GPQ7aMGFJC7q5y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bI/P9NlI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bI/P9NlI"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aa086b077so134384866b.0
        for <linux-serial@vger.kernel.org>; Thu, 26 Sep 2024 06:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727357526; x=1727962326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V6B4L9PguQXpZvu7wod8xXLrp4XbiyR0NJvOfDo+9EQ=;
        b=bI/P9NlId4Tw5bF/v7trlRCKXRceLn7qhBqZyHVPRVtGqLNvXoqmemRImQb1P6Ec7a
         qkb3Es2Cybbrdtt/42tKPs3mulEsVziEn1JybJzMk2QcEqaUlUtWIghWMIf5Is1pQCJy
         BP3lY6QRsWk4u8j3tBjQ0U47kseezuJkDiRM2gt7xZGmZ36SsNA7vOAdQ9vsxvpqIofK
         moXbqFocjDIhDoNi5YPCCb5t8ONUiRk8tRM2vP+X7H8i5tsum69+VO7lOL//PV8rH2tm
         LFf34bFY8h+PBkqquJnMA2W0addPptfU3wrM5+hSRI36aV/NdujoCxKyRyzYpM3JHQ7J
         VZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727357526; x=1727962326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6B4L9PguQXpZvu7wod8xXLrp4XbiyR0NJvOfDo+9EQ=;
        b=Sjuz9TfDA9xF4oPnm3onQAOG0GM08Zc+ADDCurOhYNbBRhpwEuNwdDtrHfFdV4o6ht
         8ybwJh90+LGkRYK7PIsMQp2dFaRaFmn06ZjinxQYJPAsw0SZMD7s4zqxcKs4ZQqnEHlQ
         imwdgVgjOP9aK/ZyM7+wqc2BsnBuArFaKReLz6QcqJ87r4CyP9N4aOL9gEqp371Bftz/
         1Fc1da/tKLDt56hMWjTD5gCDhktkGKNHYJINBl9/7LXHpi6MTpkAbKQvdn0q6q/Om8Ar
         gXQEq0syvoG8tIJXUWqAJ5L5skVSJOT8X11kAzcS5zYLjqvfpmYF7Y5MgtM0TKgp2stl
         894Q==
X-Forwarded-Encrypted: i=1; AJvYcCVugWSPL01NK6Ez3ucWEKqFhiyRKbdDTscJlW8iAH+3aiAMJxmTbA0HXyarX8X9ItVEzF4mAGF8ioaoIys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4EynYvDNJe/v3XC5UhS7Q9O4RNlJiNmtgAOk2uyFdLjhNvbaL
	wwYANLJS3Ctx1HIm9AfXMs8YRD28/41iAS+kwCU4yxtuXbjXIcLRTMsWQRSPqTc=
X-Google-Smtp-Source: AGHT+IG4oNQmzrTlb2jF8ndi4FRoYPKIyxkpvaaZ1r8v34GV2vOajwHLhGhi5V/QZz74Pv2R/KsRLQ==
X-Received: by 2002:a17:907:7fa0:b0:a91:158c:8057 with SMTP id a640c23a62f3a-a93a0682353mr725893266b.54.1727357525616;
        Thu, 26 Sep 2024 06:32:05 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f346e0sm358252266b.11.2024.09.26.06.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 06:32:05 -0700 (PDT)
Date: Thu, 26 Sep 2024 15:32:03 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [next-20240925] possible circular locking: uart vs kmemleak
Message-ID: <ZvViU8vmNiXhCjKX@pathway.suse.cz>
References: <20240926040715.GC11458@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926040715.GC11458@google.com>

On Thu 2024-09-26 13:07:15, Sergey Senozhatsky wrote:
> Greetings,
> 
> Ran into the following issue today.  It's sort of interesting, not sure
> what even to do about it.  The
> 
> 	uart -> tty -> mm /* kmalloc -> kmemleak */
> 
> chain looks problematic, it certainly overlaps with
> 
> 	mm -> printk -> uart  /* which can kmalloc and re-enter mm -> kmemleak? */

I believe that it will get solved by the uart console driver
conversion to nbcon. I should remove the path:

	printk -> uart

or more precisely, it should remove the path:

	console_owner --> &port_lock_key

The patchset with the uart 8250 console driver conversion is still
pending a review, see the last version at
https://lore.kernel.org/r/20240913140538.221708-1-john.ogness@linutronix.de

Best Regards,
Petr

> chain.
> 
> [   40.056844] ======================================================
> [   40.056845] WARNING: possible circular locking dependency detected
> [   40.056847] 6.11.0-next-20240925+ #729 Tainted: G        W        N
> [   40.056849] ------------------------------------------------------
> [   40.056850] modprobe/431 is trying to acquire lock:
> [   40.056851] ffffffff83cef3e0 (console_owner){-...}-{0:0}, at: console_flush_all+0xd9/0x9d0
> [   40.056859]
> [   40.056859] but task is already holding lock:
> [   40.056859] ffffffff83ed97d8 (kmemleak_lock){-.-.}-{2:2}, at: kmemleak_free+0x2e/0x70
> [   40.056866]
> [   40.056866] which lock already depends on the new lock.
> [   40.056866]
> [   40.056867]
> [   40.056867] the existing dependency chain (in reverse order) is:
> [   40.056868]
> [   40.056868] -> #2 (kmemleak_lock){-.-.}-{2:2}:
> [   40.056872]        _raw_spin_lock_irqsave+0x76/0xb0
> [   40.056876]        __create_object+0x3a/0x110
> [   40.056878]        __kmalloc_noprof+0x1ff/0x390
> [   40.056882]        __tty_buffer_request_room+0x18b/0x4e0
> [   40.056887]        __tty_insert_flip_string_flags+0x8b/0x3c0
> [   40.056889]        uart_insert_char+0x211/0x7f0
> [   40.056893]        serial8250_handle_irq+0x34a/0xb10
> [   40.056897]        serial8250_default_handle_irq+0xaa/0x170
> [   40.056900]        serial8250_interrupt+0xa7/0x130
> [   40.056902]        __handle_irq_event_percpu+0x1e1/0x680
> [   40.056904]        handle_irq_event+0x87/0x1c0
> [   40.056906]        handle_edge_irq+0x201/0x9b0
> [   40.056910]        __common_interrupt+0xb4/0x120
> [   40.056914]        common_interrupt+0x78/0x90
> [   40.056917]        asm_common_interrupt+0x22/0x40
> [   40.056921]        default_idle+0xb/0x10
> [   40.056924]        default_idle_call+0x6e/0xa0
> [   40.056927]        do_idle+0x172/0x3c0
> [   40.056930]        cpu_startup_entry+0x45/0x60
> [   40.056932]        start_secondary+0x12b/0x130
> [   40.056935]        common_startup_64+0x12c/0x137
> [   40.056938]
> [   40.056938] -> #1 (&port_lock_key){-.-.}-{2:2}:
> [   40.056942]        _raw_spin_lock_irqsave+0x76/0xb0
> [   40.056945]        serial8250_console_write+0xf5/0x1b10
> [   40.056947]        console_flush_all+0x4fd/0x9d0
> [   40.056949]        console_unlock+0x99/0x230
> [   40.056952]        vprintk_emit+0x3b6/0x650
> [   40.056955]        _printk+0x59/0x7b
> [   40.056958]        register_console+0x7fb/0xb40
> [   40.056960]        univ8250_console_init+0x3b/0x6b
> [   40.056965]        console_init+0x11a/0x3bb
> [   40.056970]        start_kernel+0x22a/0x39b
> [   40.056975]        x86_64_start_reservations+0x26/0x2b
> [   40.056979]        copy_bootdata+0x0/0xb0
> [   40.056981]        common_startup_64+0x12c/0x137
> [   40.056983]
> [   40.056983] -> #0 (console_owner){-...}-{0:0}:
> [   40.056986]        __lock_acquire+0x3790/0x7830
> [   40.056992]        lock_acquire+0x140/0x3b0
> [   40.056994]        console_flush_all+0x482/0x9d0
> [   40.056996]        console_unlock+0x99/0x230
> [   40.056999]        vprintk_emit+0x3b6/0x650
> [   40.057001]        _printk+0x59/0x7b
> [   40.057003]        __find_and_remove_object+0x106/0x120
> [   40.057005]        kmemleak_free+0x3d/0x70
> [   40.057007]        free_large_kmalloc+0x4d/0xb0
> [   40.057009]        init_module+0x12/0xffb [zram]
> [   40.057016]        do_one_initcall+0x130/0x450
> [   40.057018]        do_init_module+0x36a/0x890
> [   40.057021]        __se_sys_finit_module+0x513/0x7e0
> [   40.057022]        do_syscall_64+0x71/0x110
> [   40.057024]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   40.057027]
> [   40.057027] other info that might help us debug this:
> [   40.057027]
> [   40.057028] Chain exists of:
> [   40.057028]   console_owner --> &port_lock_key --> kmemleak_lock
> [   40.057028]
> [   40.057032]  Possible unsafe locking scenario:
> [   40.057032]
> [   40.057033]        CPU0                    CPU1
> [   40.057033]        ----                    ----
> [   40.057034]   lock(kmemleak_lock);
> [   40.057035]                                lock(&port_lock_key);
> [   40.057037]                                lock(kmemleak_lock);
> [   40.057039]   lock(console_owner);
> [   40.057040]
> [   40.057040]  *** DEADLOCK ***
> [   40.057040]
> [   40.057041] 3 locks held by modprobe/431:
> [   40.057043]  #0: ffffffff83ed97d8 (kmemleak_lock){-.-.}-{2:2}, at: kmemleak_free+0x2e/0x70
> [   40.057048]  #1: ffffffff83cef440 (console_lock){+.+.}-{0:0}, at: _printk+0x59/0x7b
> [   40.057053]  #2: ffffffff83cef050 (console_srcu){....}-{0:0}, at: console_flush_all+0xd9/0x9d0
> [   40.057057]
> [   40.057057] stack backtrace:
> [   40.057059] CPU: 11 UID: 0 PID: 431 Comm: modprobe Tainted: G        W        N 6.11.0-next-20240925+ #729
> [   40.057063] Tainted: [W]=WARN, [N]=TEST
> [   40.057065] Call Trace:
> [   40.057066]  <TASK>
> [   40.057067]  dump_stack_lvl+0xa3/0xeb
> [   40.057071]  print_circular_bug+0x136/0x1b0
> [   40.057074]  check_noncircular+0x26a/0x370
> [   40.057078]  __lock_acquire+0x3790/0x7830
> [   40.057085]  lock_acquire+0x140/0x3b0
> [   40.057087]  ? console_flush_all+0xd9/0x9d0
> [   40.057090]  ? console_flush_all+0xd9/0x9d0
> [   40.057092]  console_flush_all+0x482/0x9d0
> [   40.057094]  ? console_flush_all+0xd9/0x9d0
> [   40.057096]  ? console_flush_all+0xd9/0x9d0
> [   40.057100]  console_unlock+0x99/0x230
> [   40.057103]  vprintk_emit+0x3b6/0x650
> [   40.057107]  _printk+0x59/0x7b
> [   40.057110]  __find_and_remove_object+0x106/0x120
> [   40.057113]  kmemleak_free+0x3d/0x70
> [   40.057115]  free_large_kmalloc+0x4d/0xb0
> [   40.057118]  init_module+0x12/0xffb [zram]
> [   40.057125]  do_one_initcall+0x130/0x450
> [   40.057127]  ? __cfi_init_module+0x5/0x5 [zram]
> [   40.057133]  ? stack_depot_save_flags+0x25/0x700
> [   40.057136]  ? stack_trace_save+0xb3/0x150
> [   40.057140]  ? kasan_save_track+0x3c/0x60
> [   40.057143]  ? kasan_save_track+0x2b/0x60
> [   40.057145]  ? __kasan_kmalloc+0x6e/0x80
> [   40.057147]  ? do_init_module+0x16e/0x890
> [   40.057149]  ? __se_sys_finit_module+0x513/0x7e0
> [   40.057151]  ? do_syscall_64+0x71/0x110
> [   40.057156]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   40.057160]  ? stack_depot_save_flags+0x25/0x700
> [   40.057162]  ? stack_trace_save+0xb3/0x150
> [   40.057165]  ? __create_object+0x62/0x110
> [   40.057168]  ? do_raw_spin_unlock+0x5a/0x950
> [   40.057170]  ? __create_object+0x62/0x110
> [   40.057173]  ? _raw_spin_unlock_irqrestore+0x31/0x40
> [   40.057176]  ? __create_object+0x62/0x110
> [   40.057179]  ? kasan_unpoison+0x49/0x70
> [   40.057182]  ? __asan_register_globals+0x54/0x70
> [   40.057184]  do_init_module+0x36a/0x890
> [   40.057189]  __se_sys_finit_module+0x513/0x7e0
> [   40.057195]  do_syscall_64+0x71/0x110
> [   40.057197]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
