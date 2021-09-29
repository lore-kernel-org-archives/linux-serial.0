Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AD6C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 16:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A883615E1
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 16:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344873AbhI2QMq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Sep 2021 12:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345867AbhI2QMl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Sep 2021 12:12:41 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF44C061764
        for <linux-serial@vger.kernel.org>; Wed, 29 Sep 2021 09:10:46 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id 188so3715390vsv.0
        for <linux-serial@vger.kernel.org>; Wed, 29 Sep 2021 09:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3cQ0Lx+qAjvlyUtN9nl5Z68+mrM2xk+c8esFtY4VvVs=;
        b=aWpLMee0pkGGa/bLORkoDgVipsAS3ZBmD3v2aKvmmq5yxTfCFRE0c/LSOIMGBEoQmx
         DOJKfcq9Cp1WdIPkHdZf/8WDC2qA8Bjt4G9HMji8Cd0KAZZH/SKwvM4nirVfXlSilCMN
         zfjZQcM6+vfVEik/JLiKoUurMUFL4+Nl4PXrNaGXWkoqysudRb+ks9zZYBf6EoX2HbtE
         NhCtfgg1gCHZUa08vaOOxaW444HFG0vY+e/S9T6UrvQggW+8PdNOulZXpQRoZgNlMI8R
         RskZ3xzr4yQOZqEqdIHY+HK1P50u6A6OMXuJxI9H8nwG67EsRTKsONzGaIINbH4E6dWF
         AYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3cQ0Lx+qAjvlyUtN9nl5Z68+mrM2xk+c8esFtY4VvVs=;
        b=c6uwOQGV7/DJtca7t+JITPXLwzG1c14jRNljUL91yECjHgSMOY8E9m6CBevzwvuiK+
         yrRqxbIKaTb5sNtFYM+xwko6IlVnO292E5XMs3mWjoGYOYPrHCMyp8rQBgcAL6KkdGwY
         ghSzPbgFaMLASjb1IqYMEXf2uUau/Ua9O767Lm871G+9StPaeJLvb18rykSfKdEuuBrS
         Q+uzN48er9IVrfFAf7EHc/itEll+0TBSckRCEuBXPG5mPhR6EjP5GfrIAUJgtIKhsc9n
         oLZ7PjGeq8NxoOoqB10ABFth0wRBtpunSnGh/DPZ/jJZv/2jwQ0iy3c1F6O5Ef1iJ2+L
         X5eQ==
X-Gm-Message-State: AOAM532mffBhRlZBJ3TkykmNzE2K64XHLHpYTnXqTSW4HgyGTzyGGcBz
        cxwn/ugS6msrlf8geiTO0d5kRdQU6pI+sQi46Bg=
X-Google-Smtp-Source: ABdhPJww/hPFXXH77Rde9W/ga3HhPBTilyE9G4hZk89yTN9ciZ2bMGUQBPeBUKc0QjVYAs4xN4Q4re6J8nSDfKQ+iyc=
X-Received: by 2002:a67:ee12:: with SMTP id f18mr1085397vsp.20.1632931845014;
 Wed, 29 Sep 2021 09:10:45 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 29 Sep 2021 13:10:34 -0300
Message-ID: <CAOMZO5Du1L4A6okC0GJaEiKQr_=n_AJ8SvA15PPU35=mxz8LZw@mail.gmail.com>
Subject: serial: imx: Possible circular locking dependency
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-serial@vger.kernel.org, rostedt@goodmis.org,
        Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Petr and Sergey,

I know this has been reported before [1] and [2], but I am still
observing the deadlock below
on an imx6q board since commit dbdda842fe96 ("printk: Add console
owner and waiter logic to load balance console writes").

To reproduce it:

# echo t > /proc/sysrq-trigger

[   20.325246] ======================================================
[   20.325252] WARNING: possible circular locking dependency detected
[   20.325260] 5.15.0-rc2-next-20210924-00004-gd2d6e664f29f-dirty #163
Not tainted
[   20.325273] ------------------------------------------------------
[   20.325279] sh/236 is trying to acquire lock:
[   20.325293] c1618614 (console_owner){-...}-{0:0}, at:
console_unlock+0x180/0x5bc
[   20.325361]
[   20.325361] but task is already holding lock:
[   20.325368] eefccc90 (&pool->lock){-.-.}-{2:2}, at:
show_workqueue_state+0x104/0x3c8
[   20.325432]
[   20.325432] which lock already depends on the new lock.
[   20.325432]
[   20.325439]
[   20.325439] the existing dependency chain (in reverse order) is:
[   20.325446]
[   20.325446] -> #3 (&pool->lock){-.-.}-{2:2}:
[   20.325475]        __queue_work+0x114/0x810
[   20.325497]        queue_work_on+0x54/0x94
[   20.325516]        put_pwq_unlocked.part.0+0x18/0x24
[   20.325535]        trace_eval_sync+0x18/0x2c
[   20.325560]        do_one_initcall+0x78/0x388
[   20.325582]        kernel_init_freeable+0x198/0x22c
[   20.325613]        kernel_init+0x10/0x128
[   20.325631]        ret_from_fork+0x14/0x38
[   20.325646]        0x0
[   20.325657]
[   20.325657] -> #2 (&pool->lock/1){-.-.}-{2:2}:
[   20.325690]        __queue_work+0x114/0x810
[   20.325710]        queue_work_on+0x54/0x94
[   20.325727]        __imx_uart_rxint.constprop.0+0x1b4/0x2e0
[   20.325760]        imx_uart_int+0x270/0x310
[   20.325778]        __handle_irq_event_percpu+0x48/0x34c
[   20.325796]        handle_irq_event_percpu+0x2c/0x84
[   20.325811]        handle_irq_event+0x38/0x5c
[   20.325824]        handle_fasteoi_irq+0xc8/0x180
[   20.325848]        handle_domain_irq+0x68/0xa4
[   20.325862]        gic_handle_irq+0x88/0xb0
[   20.325881]        __irq_svc+0x60/0x80
[   20.325896]        cpuidle_enter_state+0x138/0x5a4
[   20.325915]        cpuidle_enter_state+0x138/0x5a4
[   20.325928]        cpuidle_enter+0x28/0x38
[   20.325941]        do_idle+0x210/0x2bc
[   20.325966]        cpu_startup_entry+0x18/0x1c
[   20.325982]        start_kernel+0x5d4/0x6d8
[   20.326005]
[   20.326005] -> #1 (&port_lock_key){-...}-{2:2}:
[   20.326033]        imx_uart_console_write+0x168/0x1ac
[   20.326059]        console_unlock+0x2a4/0x5bc
[   20.326083]        register_console+0x18c/0x2ec
[   20.326102]        uart_add_one_port+0x4b4/0x50c
[   20.326121]        imx_uart_probe+0x4ac/0x728
[   20.326140]        platform_probe+0x58/0xb8
[   20.326162]        really_probe+0x14c/0x320
[   20.326192]        __driver_probe_device+0x80/0xe4
[   20.326214]        driver_probe_device+0x30/0xd4
[   20.326234]        __driver_attach+0x70/0xf4
[   20.326255]        bus_for_each_dev+0x74/0xc0
[   20.326277]        bus_add_driver+0x150/0x1dc
[   20.326298]        driver_register+0x74/0x108
[   20.326313]        imx_uart_init+0x20/0x40
[   20.326341]        do_one_initcall+0x78/0x388
[   20.326358]        kernel_init_freeable+0x198/0x22c
[   20.326380]        kernel_init+0x10/0x128
[   20.326396]        ret_from_fork+0x14/0x38
[   20.326410]        0x0
[   20.326419]
[   20.326419] -> #0 (console_owner){-...}-{0:0}:
[   20.326445]        lock_acquire+0x130/0x400
[   20.326462]        console_unlock+0x1d0/0x5bc
[   20.326481]        vprintk_emit+0x1f0/0x2e8
[   20.326503]        vprintk_default+0x20/0x28
[   20.326522]        _printk+0x2c/0x5c
[   20.326553]        show_pwq+0x58/0x2b0
[   20.326572]        show_workqueue_state+0x11c/0x3c8
[   20.326597]        __handle_sysrq+0xf4/0x210
[   20.326619]        write_sysrq_trigger+0x6c/0x84
[   20.326636]        proc_reg_write+0xa8/0xcc
[   20.326667]        vfs_write+0xb8/0x544
[   20.326697]        ksys_write+0x60/0xec
[   20.326717]        ret_fast_syscall+0x0/0x1c
[   20.326733]        0xbec5b950
[   20.326743]
[   20.326743] other info that might help us debug this:
[   20.326743]
[   20.326750] Chain exists of:
[   20.326750]   console_owner --> &pool->lock/1 --> &pool->lock
[   20.326750]
[   20.326788]  Possible unsafe locking scenario:
[   20.326788]
[   20.326792]        CPU0                    CPU1
[   20.326797]        ----                    ----
[   20.326803]   lock(&pool->lock);
[   20.326814]                                lock(&pool->lock/1);
[   20.326833]                                lock(&pool->lock);
[   20.326846]   lock(console_owner);
[   20.326858]
[   20.326858]  *** DEADLOCK ***
[   20.326858]
[   20.326862] 5 locks held by sh/236:
[   20.326876]  #0: c2abd284 (sb_writers#4){.+.+}-{0:0}, at:
ksys_write+0x60/0xec
[   20.326933]  #1: c16e0d2c (rcu_read_lock){....}-{1:2}, at:
__handle_sysrq+0x0/0x210
[   20.326984]  #2: c16e0d2c (rcu_read_lock){....}-{1:2}, at:
show_workqueue_state+0x0/0x3c8
[   20.327035]  #3: eefccc90 (&pool->lock){-.-.}-{2:2}, at:
show_workqueue_state+0x104/0x3c8
[   20.327081]  #4: c161858c (console_lock){+.+.}-{0:0}, at:
vprintk_emit+0xd8/0x2e8
[   20.327133]
[   20.327133] stack backtrace:
[   20.327141] CPU: 1 PID: 236 Comm: sh Not tainted
5.15.0-rc2-next-20210924-00004-gd2d6e664f29f-dirty #163
[   20.327163] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   20.327177] [<c0111918>] (unwind_backtrace) from [<c010be08>]
(show_stack+0x10/0x14)
[   20.327224] [<c010be08>] (show_stack) from [<c0e87838>]
(dump_stack_lvl+0x58/0x70)
[   20.327260] [<c0e87838>] (dump_stack_lvl) from [<c0189520>]
(check_noncircular+0xf4/0x168)
[   20.327290] [<c0189520>] (check_noncircular) from [<c018d3a8>]
(__lock_acquire+0x167c/0x31e8)
[   20.327320] [<c018d3a8>] (__lock_acquire) from [<c018f97c>]
(lock_acquire+0x130/0x400)
[   20.327347] [<c018f97c>] (lock_acquire) from [<c01984d0>]
(console_unlock+0x1d0/0x5bc)
[   20.327381] [<c01984d0>] (console_unlock) from [<c019a778>]
(vprintk_emit+0x1f0/0x2e8)
[   20.327416] [<c019a778>] (vprintk_emit) from [<c019a890>]
(vprintk_default+0x20/0x28)
[   20.327453] [<c019a890>] (vprintk_default) from [<c0e83744>]
(_printk+0x2c/0x5c)
[   20.327498] [<c0e83744>] (_printk) from [<c0e826c4>] (show_pwq+0x58/0x2b0)
[   20.327534] [<c0e826c4>] (show_pwq) from [<c014acfc>]
(show_workqueue_state+0x11c/0x3c8)
[   20.327576] [<c014acfc>] (show_workqueue_state) from [<c06cedd8>]
(__handle_sysrq+0xf4/0x210)
[   20.327617] [<c06cedd8>] (__handle_sysrq) from [<c06cf3dc>]
(write_sysrq_trigger+0x6c/0x84)
[   20.327648] [<c06cf3dc>] (write_sysrq_trigger) from [<c03707d0>]
(proc_reg_write+0xa8/0xcc)
[   20.327692] [<c03707d0>] (proc_reg_write) from [<c02cfa40>]
(vfs_write+0xb8/0x544)
[   20.327733] [<c02cfa40>] (vfs_write) from [<c02d001c>] (ksys_write+0x60/0xec)
[   20.327770] [<c02d001c>] (ksys_write) from [<c0100080>]
(ret_fast_syscall+0x0/0x1c)
[   20.327803] Exception stack(0xc2a55fa8 to 0xc2a55ff0)
[   20.327824] 5fa0:                   00000001 0128cf28 00000001
0128cf28 00000002 00000000
[   20.327846] 5fc0: 00000001 0128cf28 00000002 00000004 00585444
bec5b98c 00000020 0128b008
[   20.327861] 5fe0: 00584c60 bec5b950 004bd630 b6f66a3c

[1] https://lore.kernel.org/lkml/20190917141034.gvjg7bgylqbbxyv7@pengutronix.de/
[2] https://lore.kernel.org/linux-serial/1574416632-32321-1-git-send-email-fugang.duan@nxp.com/

Petr has suggested a way to fix it:
https://lore.kernel.org/lkml/20190926085855.debu7t46s7kgb26p@pathway.suse.cz/

but I am not familiar with the serial core code enough to give it a
try at implementing it.

Would it be possible for you to cook a patch to fix this issue so I
could try it?

Thanks a lot,

Fabio Estevam
