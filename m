Return-Path: <SRS0=vWxX=DA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FD3C4363D
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 07:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623892223E
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 07:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyQNa4j+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIWH0F (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Sep 2020 03:26:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37199 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726557AbgIWH0E (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Sep 2020 03:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600845961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aWwfdXE9GhI10cp0GYHU55bmfkW399HUTa6GTUJtf5s=;
        b=DyQNa4j+M/kKTRwFWG2AwhO23ORBkbEeII3PgvQ72Mk49S3AjGZ/mDz3ga+qp/PNN1m3qP
        HCi1fUH9HabOKtDaAOXcHMY3QHvzgqvFsPR9gmRXlijioLndXSnmij8V4LCg7XFBqNSsJC
        znA0Hgu/iP0hL+d/1IO/4UYY+6aexms=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-1UN_kFYzOzW38qJBfnpG7w-1; Wed, 23 Sep 2020 03:26:00 -0400
X-MC-Unique: 1UN_kFYzOzW38qJBfnpG7w-1
Received: by mail-ed1-f70.google.com with SMTP id r8so6797972edy.17
        for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2020 00:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aWwfdXE9GhI10cp0GYHU55bmfkW399HUTa6GTUJtf5s=;
        b=VI3nJ7bxG/7FBewYMrPLZ/jQBHvCJ1/IxrcwfVkRkJCdNe3Xq/RT2n865nHKmhwZf5
         Zq2V5NX4I3uagzl3PAsgrGXjkyShxE19Y31GkpMjneZSckL/COQgQPQNnUwVOXYMsnJj
         bz1aYPGHQg42a5g5W9x+ptA/z3IyARFpTcLsVcXVx1keLQP69PEaQCvEcBGXSj3OEXLw
         rCEIsENQGu+7VvvfkCFfPSi5X+2AcnyvaaB49vW8V1MWKO/k0pRxYbhxOKs+uMskH7nO
         XKhLyX9X1gGLN29m7grtttbhGzjmm2rm9ABUeXR4uMEOfPtpWr/9+8FuEjkG/0itigAL
         y19Q==
X-Gm-Message-State: AOAM533kPrlzIbWSARYoid6YIJHBfID1744UTYLYq435IXt+CM8oqTNE
        ENUmz+w98cW8uIJnO0xsZ9cSbQH0uN+j1OWoBa6wBiY5B9AB7h/OZ5W/BV+1KNl5YblAT11E3UG
        B4SIO+g4uJGCffy5F/MlF5da/
X-Received: by 2002:a17:906:375a:: with SMTP id e26mr8641226ejc.552.1600845958386;
        Wed, 23 Sep 2020 00:25:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0F17uM1zK9TDIBEGoF2D6HkS9yhsD62oDqqEyynZNXdlsRfhVv1aRYpXZ847SVA5UcjnJ7w==
X-Received: by 2002:a17:906:375a:: with SMTP id e26mr8641206ejc.552.1600845958042;
        Wed, 23 Sep 2020 00:25:58 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v18sm13451371edb.26.2020.09.23.00.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 00:25:57 -0700 (PDT)
Subject: Re: lockdep warning in 5.9 caused by "serial: 8250_dw: Fix common
 clocks usage race condition"
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
References: <f1cd5c75-9cda-6896-a4e2-42c5bfc3f5c3@redhat.com>
 <20200922163259.xlmylx5dac7j6xll@mobilestation>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d681d8e7-d963-ed14-e359-fcb60059b5ba@redhat.com>
Date:   Wed, 23 Sep 2020 09:25:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922163259.xlmylx5dac7j6xll@mobilestation>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 9/22/20 6:32 PM, Serge Semin wrote:
> Hans,
> 
> On Fri, Sep 11, 2020 at 11:03:41PM +0200, Hans de Goede wrote:
>> Hi Serge,
>>
>> I noticed that on various Cherry Trail (x86) based
>> devices, which use a 8250_dw UART for their blue-tooth,
>> I'm now (with 5.9) seeing a lockdep warning on suspend/resume",
>> see below.
>>
>> This is caused by commit cc816969d7b5 ("serial: 8250_dw: Fix common
>> clocks usage race condition"). If I revert that commit the lockdep
>> warning goes away.
> 
> Yes, suspending the port will definitely cause the deadlock. I can see that now
> even without the lockdep warning.( Alas I haven't tested the system suspend
> before releasing the patchset. The difficulty is to figure out how to fix it
> better. Moving the clock-change callback registration/de-registration to the
> probe/remove method causes another problem. I'll need to give it some time to
> find a proper solution.

I understand, thank you for looking into this.

Regards,

Hans



>> Here is the promised lockdep output:
>>
>> [  843.852886] ======================================================
>> [  843.852888] WARNING: possible circular locking dependency detected
>> [  843.852894] 5.9.0-rc3+ #38 Tainted: G        W   E
>> [  843.852896] ------------------------------------------------------
>> [  843.852900] systemd-sleep/1628 is trying to acquire lock:
>> [  843.852905] ffff935e30344d80 ((work_completion)(&data->clk_work)){+.+.}-{0:0}, at: __flush_work+0x2e6/0x460
>> [  843.852922]
>>                 but task is already holding lock:
>> [  843.852924] ffff935e302f1420 (&port->mutex){+.+.}-{3:3}, at: uart_suspend_port+0x3f/0x1f0
>> [  843.852938]
>>                 which lock already depends on the new lock.
>>
>> [  843.852940]
>>                 the existing dependency chain (in reverse order) is:
>> [  843.852943]
>>                 -> #1 (&port->mutex){+.+.}-{3:3}:
>> [  843.852954]        __mutex_lock+0x7b/0x820
>> [  843.852959]        serial8250_update_uartclk+0x34/0x1b0
>> [  843.852965]        process_one_work+0x23f/0x570
>> [  843.852969]        worker_thread+0x55/0x3c0
>> [  843.852974]        kthread+0x138/0x160
>> [  843.852981]        ret_from_fork+0x22/0x30
>> [  843.852984]
>>                 -> #0 ((work_completion)(&data->clk_work)){+.+.}-{0:0}:
>> [  843.852995]        __lock_acquire+0x1238/0x2080
>> [  843.852999]        lock_acquire+0xa7/0x3d0
>> [  843.853003]        __flush_work+0x30d/0x460
>> [  843.853008]        uart_suspend_port+0x1b9/0x1f0
>> [  843.853014]        dw8250_suspend+0x10/0x20
>> [  843.853020]        dpm_run_callback+0x51/0xc0
>> [  843.853025]        __device_suspend+0x1f9/0x450
>> [  843.853029]        dpm_suspend+0x13d/0x1e0
>> [  843.853033]        dpm_suspend_start+0x77/0x80
>> [  843.853040]        suspend_devices_and_enter+0xe6/0x620
>> [  843.853044]        pm_suspend.cold+0x333/0x389
>> [  843.853048]        state_store+0x71/0xd0
>> [  843.853056]        kernfs_fop_write+0xdc/0x1c0
>> [  843.853063]        vfs_write+0xec/0x230
>> [  843.853068]        ksys_write+0x58/0xd0
>> [  843.853075]        do_syscall_64+0x33/0x40
>> [  843.853079]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [  843.853081]
>>                 other info that might help us debug this:
>>
>> [  843.853083]  Possible unsafe locking scenario:
>>
>> [  843.853087]        CPU0                    CPU1
>> [  843.853090]        ----                    ----
>> [  843.853091]   lock(&port->mutex);
>> [  843.853095]                                lock((work_completion)(&data->clk_work));
>> [  843.853098]                                lock(&port->mutex);
>> [  843.853101]   lock((work_completion)(&data->clk_work));
>> [  843.853105]
>>                  *** DEADLOCK ***
>>
>> [  843.853109] 7 locks held by systemd-sleep/1628:
>> [  843.853111]  #0: ffff935e302a9488 (sb_writers#4){.+.+}-{0:0}, at: vfs_write+0x1a0/0x230
>> [  843.853123]  #1: ffff935e0e56a290 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write+0xa5/0x1c0
>> [  843.853134]  #2: ffff935e392a7848 (kn->active#206){.+.+}-{0:0}, at: kernfs_fop_write+0xad/0x1c0
>> [  843.853144]  #3: ffffffffb487b0b0 (system_transition_mutex){+.+.}-{3:3}, at: pm_suspend.cold+0xee/0x389
>> [  843.853155]  #4: ffffffffb4a42370 (acpi_scan_lock){+.+.}-{3:3}, at: acpi_s2idle_begin+0xa/0x10
>> [  843.853167]  #5: ffff935e39ee29a0 (&dev->mutex){....}-{3:3}, at: __device_suspend+0xe8/0x450
>> [  843.853178]  #6: ffff935e302f1420 (&port->mutex){+.+.}-{3:3}, at: uart_suspend_port+0x3f/0x1f0
>> [  843.853187]
>>                 stack backtrace:
>> [  843.853195] CPU: 3 PID: 1628 Comm: systemd-sleep Tainted: G        W   E     5.9.0-rc3+ #38
>> [  843.853199] Hardware name: Acer One S1003/One S1003, BIOS V1.19 03/20/2018
>> [  843.853203] Call Trace:
>> [  843.853213]  dump_stack+0x8b/0xb8
>> [  843.853222]  check_noncircular+0x134/0x150
>> [  843.853234]  __lock_acquire+0x1238/0x2080
>> [  843.853244]  ? lock_acquire+0xa7/0x3d0
>> [  843.853252]  lock_acquire+0xa7/0x3d0
>> [  843.853257]  ? __flush_work+0x2e6/0x460
>> [  843.853265]  ? lockdep_hardirqs_on_prepare+0x116/0x190
>> [  843.853270]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
>> [  843.853276]  ? trace_hardirqs_on+0x1c/0xe0
>> [  843.853284]  __flush_work+0x30d/0x460
>> [  843.853289]  ? __flush_work+0x2e6/0x460
>> [  843.853295]  ? sched_clock+0x5/0x10
>> [  843.853300]  ? sched_clock_cpu+0xc/0xb0
>> [  843.853311]  ? __mutex_unlock_slowpath+0x35/0x270
>> [  843.853321]  ? clk_notifier_unregister+0xf8/0x120
>> [  843.853328]  uart_suspend_port+0x1b9/0x1f0
>> [  843.853337]  ? acpi_pm_notify_work_func+0x30/0x30
>> [  843.853342]  dw8250_suspend+0x10/0x20
>> [  843.853346]  dpm_run_callback+0x51/0xc0
>> [  843.853353]  __device_suspend+0x1f9/0x450
>> [  843.853360]  dpm_suspend+0x13d/0x1e0
>> [  843.853367]  dpm_suspend_start+0x77/0x80
>> [  843.853373]  suspend_devices_and_enter+0xe6/0x620
>> [  843.853381]  ? rcu_read_lock_sched_held+0x3f/0x80
>> [  843.853388]  pm_suspend.cold+0x333/0x389
>> [  843.853394]  state_store+0x71/0xd0
>> [  843.853405]  kernfs_fop_write+0xdc/0x1c0
>> [  843.853413]  vfs_write+0xec/0x230
>> [  843.853420]  ksys_write+0x58/0xd0
>> [  843.853427]  do_syscall_64+0x33/0x40
>> [  843.853432]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [  843.853441] RIP: 0033:0x7f2a99d184b7
>> [  843.853450] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
>> [  843.853453] RSP: 002b:00007ffedaca0ef8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> [  843.853459] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f2a99d184b7
>> [  843.853462] RDX: 0000000000000004 RSI: 00007ffedaca0fe0 RDI: 0000000000000004
>> [  843.853465] RBP: 00007ffedaca0fe0 R08: 000000000000c0d0 R09: 00007f2a99daf0c0
>> [  843.853468] R10: 00007f2a99daefc0 R11: 0000000000000246 R12: 0000000000000004
>> [  843.853471] R13: 000055f1a8c67330 R14: 0000000000000004 R15: 00007f2a99dec720
>>
> 

