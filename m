Return-Path: <SRS0=20mg=6P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D22EC47253
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 11:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B4C208CA
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 11:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnpeYN4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgEALts (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 May 2020 07:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728575AbgEALtr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 May 2020 07:49:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DFDC061A0C
        for <linux-serial@vger.kernel.org>; Fri,  1 May 2020 04:49:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x18so11273444wrq.2
        for <linux-serial@vger.kernel.org>; Fri, 01 May 2020 04:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wZe2OaPSCDY2afaaPs7tXOLu/QH16szPzOl/6fyIoCI=;
        b=HnpeYN4+TYH+XayrvAH7rL5ulJldblF3Ng/1chwg39cdkkrQL4rmBVo1lNcCQe1ahE
         9KyLRPrC6rq3s+1sin2kOHGQnkFiCQ9gC5CZlu2DX5cI9LmWo2Bi3miDdWZ5TKSWmET5
         SRMRg6gqQqE+GiVQ2dzIBKRxknXFevRv3w7t057tmCY4b8/RA7CwMmmcB+Td7+fv+vAC
         T6J8UT6bu3/6ANuZZahYPFDO/P/G43HlDBVLg+NiDmORssGZKuKq1ee1TMvhuli+ndt0
         4Q4zLMmYK2y5Evkdloc6SaWjMe8wQFoWs7NOPa86ImWE9cAfy6Z+/Ep69b3oXMs4dP+J
         BPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wZe2OaPSCDY2afaaPs7tXOLu/QH16szPzOl/6fyIoCI=;
        b=kctNBREHVTkyD5R0BLVtUTfzF6uROOrejqFr8jNRnSxTl936ulhpquS7QR6DWVgDeM
         EecpeDO+gvh6HbMOgwwtz205VLyOFQNkH/09AtmUUhnN3EQmhXx3W3IhC49HpIXGgbUl
         R8CuK7iMVfkCINbYoCOv/cWqYvJRXSuXx9FCm29x4wETkU2PQ4IbW7jwybblHv1WshPh
         Wv0hz8O0NEl6Oun0/kVHKEDPGgeR5GzY0LVUAVkrHctxA+UapqG+vo2zUlF4j7D4IWHc
         17y4LdOG7boKZpdp8dg6IDsba2315Qf/XC5I+5vm2wsoLzRwNofMicliN1YQ9bJEQ1md
         yF0g==
X-Gm-Message-State: AGi0PuZwvp0uikERUg2nEhgFjqiNXRV7nQHCyBkOliYMlpf3v6vVLlW/
        LScKUmZPO5md7KAzN7QFL6TXFw==
X-Google-Smtp-Source: APiQypISgLF1uo9wNeadwVw7nKzKFWvl5TOTlq1H4Pk/72E9uiX1TgTiyZUcpV2jCxAiwy9I2F7tRQ==
X-Received: by 2002:a5d:634a:: with SMTP id b10mr3866323wrw.263.1588333785560;
        Fri, 01 May 2020 04:49:45 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b12sm4578913wro.18.2020.05.01.04.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 04:49:44 -0700 (PDT)
Date:   Fri, 1 May 2020 12:49:43 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>, sumit.garg@linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] kgdboc: Be a bit more robust about handling earlycon
 leaving
Message-ID: <20200501114943.ioetuxe24gi27bll@holly.lan>
References: <20200430095819.1.Id37f71c69eb21747b9d9e2c7c242be130814b362@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430095819.1.Id37f71c69eb21747b9d9e2c7c242be130814b362@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 30, 2020 at 09:59:09AM -0700, Douglas Anderson wrote:
> The original implementation of kgdboc_earlycon included a comment
> about how it was impossible to get notified about the boot console
> going away without making changes to the Linux core.  Since folks
> often don't want to change the Linux core for kgdb's purposes, the
> kgdboc_earlycon implementation did a bit of polling to figure out when
> the boot console went away.
> 
> It turns out, though, that it is possible to get notified about the
> boot console going away.  The solution is either clever or a hack
> depending on your viewpoint.  ...or, perhaps, a clever hack.  All we
> need to do is head-patch the "exit" routine of the boot console.  We
> know that "struct console" must be writable because it has a "next"
> pointer in it, so we can just put our own exit routine in, do our
> stuff, and then call back to the original.

I think I'm in the hack camp on this one!

 
> This works great to get notified about the boot console going away.
> The (slight) problem is that in the context of the boot console's exit
> routine we can't call tty_find_polling_driver().

I presume this is something to do with the tty_mutex?


> We solve this by
> kicking off some work on the system_wq when we get notified and this
> works pretty well.

There are some problems with the workqueue approach.

Firstly, its runs too early on many systems (esp. those that register
the console from a console initcall. kgdboc cannot find the tty, I think
because the console is registered a long time before the corresponding
tty comes up.

Secondly I am seeing warnings related to the tty_mutex where the
might_sleep() machinery ends up flushing the active workqueue.

[   39.298332] ------------[ cut here ]------------                             
[   39.298332] WARNING: CPU: 0 PID: 5 at kernel/workqueue.c:3033 __flush_work+00
[   39.298332] Modules linked in:                                               
[   39.298332] CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.7.0-rc3+ #47       
[   39.298332] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-204
[   39.298332] Workqueue: events kgdboc_earlycon_exit_work_fn           
[   39.298332] RIP: 0010:__flush_work+0x19c/0x1c0                               
[   39.298332] Code: 4c 8b 6d 20 e9 06 ff ff ff 41 c6 04 24 00 fb 45 31 f6 eb 8f
[   39.298332] RSP: 0018:ffff993500033dd0 EFLAGS: 00010246                      
[   39.298332] RAX: 0000000000000000 RBX: ffffffffadcd0720 RCX: 0000000000000001
[   39.298332] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffadcd0820
[   39.298332] RBP: ffff8a633ec299c0 R08: 0000000000000000 R09: 0000000000000001
[   39.298332] R10: 000000000000000a R11: f000000000000000 R12: 00000000ffffffed
[   39.298332] R13: ffff8a633e408840 R14: 0000000000000000 R15: ffff8a633e408840
[   39.298332] FS:  0000000000000000(0000) GS:ffff8a633ec00000(0000) knlGS:00000
[   39.298332] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033                
[   39.298332] CR2: ffff8a6333201000 CR3: 0000000032a0a000 CR4: 00000000000006f0
[   39.298332] Call Trace:                                                      
[   39.298332]  ? _cond_resched+0x10/0x20                                       
[   39.298332]  ? mutex_lock+0x9/0x30                                           
[   39.298332]  ? tty_find_polling_driver+0x134/0x1a0                      
[   39.298332]  configure_kgdboc+0x12d/0x1c0                                    
[   39.298332]  kgdboc_earlycon_exit_work_fn+0x1a/0x40                          
[   39.298332]  process_one_work+0x1d3/0x380                                    
[   39.298332]  worker_thread+0x45/0x3c0                                        
[   39.298332]  kthread+0xf6/0x130                                              
[   39.298332]  ? process_one_work+0x380/0x380                                  
[   39.298332]  ? kthread_park+0x80/0x80                                        
[   39.298332]  ret_from_fork+0x22/0x40                                         
[   39.298332] ---[ end trace 1190f578d6e11204 ]---                             
[   39.298338] KGDB: Unregistered I/O driver kgdboc_earlycon, debugger disabled 


Daniel.
