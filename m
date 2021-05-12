Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCCAC433ED
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 10:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D894D61059
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 10:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhELKcz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 May 2021 06:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhELKco (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 May 2021 06:32:44 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C13C061760;
        Wed, 12 May 2021 03:31:36 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 935742224E;
        Wed, 12 May 2021 12:31:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620815493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cNxJ+o6KmhNAUjsRoTAR9Xb8gkLZ9xbaAudO4uwx5Yc=;
        b=v3wE+d0m0bBaKpZWy3WF9bimBq4fJyfZwxjrtJPYLLxTX5FhOgt+F4PnszSF9Te6stORaO
        6fAEOELI44KLTCCS2cNmuVLPrx/piTEa/11Gc5xizZOr13NoTW/diG/iMKAPOlMspRQ4pd
        v3VUdSnfTq9JVCkYVEBLFfFg+1IYPWk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 12 May 2021 12:31:33 +0200
From:   Michael Walle <michael@walle.cc>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: Re: [PATCH 4/8] serial: fsl_lpuart: handle break and make sysrq work
In-Reply-To: <YJuozDa5ISIAHw7D@hovoldconsulting.com>
References: <20210511200148.11934-1-michael@walle.cc>
 <20210511200148.11934-5-michael@walle.cc>
 <YJugS4fiUBgPvIS6@hovoldconsulting.com>
 <e3e5ad179483508d02305f26fd20800a@walle.cc>
 <YJuozDa5ISIAHw7D@hovoldconsulting.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <7698180da355d6626a72794cf8a172f9@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

[dropped fugang.duan@nxp.com, mail bounces with 550 5.4.1 Recipient
address rejected: Access denied]

Am 2021-05-12 12:07, schrieb Johan Hovold:
> On Wed, May 12, 2021 at 11:46:28AM +0200, Michael Walle wrote:
>> Am 2021-05-12 11:30, schrieb Johan Hovold:
>> > On Tue, May 11, 2021 at 10:01:44PM +0200, Michael Walle wrote:
>> >> Although there is already (broken) sysrq characters handling, a break
>> >> condition was never detected. There is also a possible deadlock
>> >> because
>> >> we might call handle_sysrq() while still holding the port lock.
>> >
>> > Where's the possible deadlock?
>> 
>> [   17.866874] ======================================================
>> [   17.866876] WARNING: possible circular locking dependency detected
>> [   17.866878] 5.13.0-rc1-next-20210511+ #555 Not tainted
>> [   17.866880] ------------------------------------------------------
>> [   17.866882] sl28-variant.sh/1934 is trying to acquire lock:
>> [   17.866884] ffff800011d16a00 (console_owner){-.-.}-{0:0}, at:
>> console_unlock+0x1c0/0x660
>> [   17.866892]
>> [   17.866893] but task is already holding lock:
>> [   17.866895] ffff0020026ea098 (&port_lock_key){-.-.}-{2:2}, at:
>> lpuart32_int+0x1b0/0x7c8
>> [   17.866902]
>> [   17.866904] which lock already depends on the new lock.
>> [   17.866906]
>> [   17.866907]
>> [   17.866909] the existing dependency chain (in reverse order) is:
>> [   17.866910]
>> [   17.866912] -> #1 (&port_lock_key){-.-.}-{2:2}:
>> [   17.866918]        _raw_spin_lock_irqsave+0x80/0xd0
>> [   17.866920]        lpuart32_console_write+0x214/0x2b8
>> [   17.866922]        console_unlock+0x404/0x660
>> [   17.866924]        register_console+0x170/0x2a8
>> [   17.866925]        uart_add_one_port+0x464/0x478
>> [   17.866927]        lpuart_probe+0x218/0x3a8
>> [   17.866928]        platform_probe+0x70/0xe0
>> [   17.866930]        really_probe+0xec/0x3c0
>> [   17.866931]        driver_probe_device+0x6c/0xd0
>> [   17.866933]        device_driver_attach+0x7c/0x88
>> [   17.866935]        __driver_attach+0x6c/0xf8
>> [   17.866936]        bus_for_each_dev+0x7c/0xd0
>> [   17.866938]        driver_attach+0x2c/0x38
>> [   17.866939]        bus_add_driver+0x194/0x1f8
>> [   17.866941]        driver_register+0x6c/0x128
>> [   17.866943]        __platform_driver_register+0x30/0x40
>> [   17.866944]        lpuart_serial_init+0x44/0x6c
>> [   17.866946]        do_one_initcall+0x90/0x470
>> [   17.866948]        kernel_init_freeable+0x2d4/0x344
>> [   17.866949]        kernel_init+0x1c/0x120
>> [   17.866951]        ret_from_fork+0x10/0x30
>> [   17.866952]
>> [   17.866953] -> #0 (console_owner){-.-.}-{0:0}:
>> [   17.866959]        __lock_acquire+0xf60/0x17e8
>> [   17.866961]        lock_acquire+0x138/0x4c0
>> [   17.866963]        console_unlock+0x224/0x660
>> [   17.866964]        vprintk_emit+0x11c/0x338
>> [   17.866966]        vprintk_default+0x40/0x50
>> [   17.866967]        vprintk+0xfc/0x320
>> [   17.866969]        printk+0x6c/0x90
>> [   17.866970]        __handle_sysrq+0x16c/0x1d8
>> [   17.866972]        handle_sysrq+0x2c/0x48
>> [   17.866973]        lpuart32_int+0x70c/0x7c8
>> [   17.866975]        __handle_irq_event_percpu+0xcc/0x430
>> [   17.866977]        handle_irq_event_percpu+0x40/0x98
>> [   17.866978]        handle_irq_event+0x50/0x100
>> [   17.866980]        handle_fasteoi_irq+0xc0/0x178
>> [   17.866981]        generic_handle_irq+0x38/0x50
>> [   17.866983]        __handle_domain_irq+0x6c/0xc8
>> [   17.866985]        gic_handle_irq+0xdc/0x340
>> [   17.866986]        el1_irq+0xb8/0x150
>> [   17.866988]        arch_local_irq_restore+0x8/0x20
>> [   17.866989]        page_add_file_rmap+0x24/0x1f8
>> [   17.866991]        do_set_pte+0xd4/0x1a0
>> [   17.866992]        filemap_map_pages+0x358/0x590
>> [   17.866994]        __handle_mm_fault+0xbc0/0xdd0
>> [   17.866995]        handle_mm_fault+0x170/0x3e0
>> [   17.866997]        do_page_fault+0x1e8/0x448
>> [   17.866998]        do_translation_fault+0x60/0x70
>> [   17.867000]        do_mem_abort+0x48/0xb8
>> [   17.867001]        el0_da+0x44/0x80
>> [   17.867002]        el0_sync_handler+0x68/0xb8
>> [   17.867004]        el0_sync+0x178/0x180
>> [   17.867005]
>> [   17.867007] other info that might help us debug this:
>> [   17.867008]
>> [   17.867009]  Possible unsafe locking scenario:
>> [   17.867011]
>> [   17.867012]        CPU0                    CPU1
>> [   17.867013]        ----                    ----
>> [   17.867015]   lock(&port_lock_key);
>> [   17.867019]                                lock(console_owner);
>> [   17.867023]                                lock(&port_lock_key);
>> [   17.867027]   lock(console_owner);
>> [   17.867030]
>> [   17.867031]  *** DEADLOCK ***
>> [   17.867033]
>> [   17.867034] 7 locks held by sl28-variant.sh/1934:
>> [   17.867035]  #0: ffff002003a37b08 (&mm->mmap_lock){++++}-{3:3}, at:
>> do_page_fault+0x180/0x448
>> [   17.867043]  #1: ffff800011d87660 (rcu_read_lock){....}-{1:2}, at:
>> filemap_map_pages+0x8/0x590
>> [   17.867051]  #2: ffff0020048d8318 (ptlock_ptr(page)){+.+.}-{2:2}, 
>> at:
>> filemap_map_pages+0x27c/0x590
>> [   17.867059]  #3: ffff800011d87660 (rcu_read_lock){....}-{1:2}, at:
>> lock_page_memcg+0x8/0x1d8
>> [   17.867067]  #4: ffff0020026ea098 (&port_lock_key){-.-.}-{2:2}, at:
>> lpuart32_int+0x1b0/0x7c8
>> [   17.867074]  #5: ffff800011d87660 (rcu_read_lock){....}-{1:2}, at:
>> __handle_sysrq+0x8/0x1d8
>> [   17.867082]  #6: ffff800011d168a0 (console_lock){+.+.}-{0:0}, at:
>> vprintk_emit+0x114/0x338
> 
> Note that it says "possible" deadlock; the lockdep validator probably
> isn't smart enough to understand the trylock hack in the console write
> callback.
> 
>> > First, as you point out above the driver currently doesn't detect
>> > breaks
>> > so the sysrq handler is never called and there's no risk for deadlocks
>> > in the console code.
>> 
>> But this commit introduces it? Therefore, I don't get your point.
> 
> My point is that your commit message makes it sound like an actual
> deadlock in the current code. Something which, for example, can cause
> commits to get backported to stable when it is not needed.

I see. I'll rephrase the commit message. FWIW I intentionally didn't
put a Fixes: tag here, because of that.

>> > Second, the driver's console implementation explicitly handles being
>> > called recursively so would not deadlock after you start detecting
>> > breaks either.
>> 
>> See above. Or there is something wrong with the lock debugging.
> 
> Seems to work as intended.
> 
>> >> Add support for break detection and use the proper
>> >> uart_unlock_and_check_sysrq() to defer calling handle_sysrq().
> 
> But you should get rid of the sysrq trylock hack when switching to
> uart_unlock_and_check_sysrq().

Ok. But only for the sport->port.sysrq part right? We'll still
need it for oops_in_progress.

Thanks for reviewing,
-michael
