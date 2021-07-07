Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8961CC07E95
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jul 2021 07:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6180261CAC
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jul 2021 07:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhGGHwV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Jul 2021 03:52:21 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:43707 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhGGHwU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Jul 2021 03:52:20 -0400
Received: by mail-ej1-f54.google.com with SMTP id v20so1797270eji.10;
        Wed, 07 Jul 2021 00:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fTMaPUGa80A1kDhI5k94VCOtT8TgfL8mfdjr2W3zsLs=;
        b=ZMlzqMrL9UQyLTlLFva1rHXusX0jokP8k9PutlZPAyLkmL2uut0/TDHDixMbGoq678
         fuKtgupCzN3ZRwVOguH4Gcif0TDpfvncGUp3UPnmHZrDVIJw772eNcdUgTe0W7rRNDZq
         qA+KdRd9ndaSp2yCPPIfMlntygb+mHr3XhulTwnohdESggR5CLrDkJPPZ8mxevkg9Ckx
         HtBYv9E3/xBZ6KvSDn9aP0vQzs10a+aq0VPgPEYrOJ9wlwIzK/Hd7o4ucJcbL77hS6By
         fW/5Rc/EvojmJ9G4yuXtEjV23ap+fs5gecsKRWNE5imZ8Gzc75ehGB2EpXx5JVekRXMh
         NP7w==
X-Gm-Message-State: AOAM532s9/NHUz/3ZSO44rXhAK7Bf25ZjqdFo/+jHjVwh9GtOF6ascXN
        6QUdrayXhHAhm6rncu16e8qOM4DLV84jtg==
X-Google-Smtp-Source: ABdhPJy1FaFSom0CXOgmzpKY6I6cJOLYSZhHKclp5eb/WuGX7M2o84A0NUMiOORp19d8f5UUJEYxDw==
X-Received: by 2002:a17:906:1b16:: with SMTP id o22mr3175056ejg.293.1625644179855;
        Wed, 07 Jul 2021 00:49:39 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id u13sm1311106ejb.75.2021.07.07.00.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 00:49:39 -0700 (PDT)
Subject: Re: [PATCH v4] tty: serial: jsm: allocate queue buffer at probe time
To:     Zheyu Ma <zheyuma97@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1625489588-26079-1-git-send-email-zheyuma97@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <fde46fee-fad9-8f3b-79b0-ad426fd379dd@kernel.org>
Date:   Wed, 7 Jul 2021 09:49:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1625489588-26079-1-git-send-email-zheyuma97@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05. 07. 21, 14:53, Zheyu Ma wrote:
> In function 'neo_intr', the driver uses 'ch->ch_equeue' and
> 'ch->ch_reuque'. These two pointers are initialized in 'jsm_tty_open',
> but the interrupt handler 'neo_intr' has been registered in the probe
> progress. If 'jsm_tty_open' has not been called at this time, it will
> cause null pointer dereference.
> 
> Once the driver registers the interrupt handler, the driver should be
> ready to handle it.
> 
> Fix this by allocating the memory at probe time and not at open time.

You are allocating the buffer in jsm_tty_init now. But that is still 
called after request_irq() in probe. So care to explain how this helps 
exactly? As I understand it, you only made the window much smaller.

Anyway, I'm no expert on jsm, but AFAICS jsm_tty_open first allocates 
the buffers, brd->bd_ops->uart_init() / neo_uart_init() clears ier and 
only brd->bd_ops->param() / neo_param() enables interrupts on the device 
(by ier update and write). So how it comes an interrupt came before 
neo_param() in jsm_tty_open was called?

> This log reveals it:
> 
> [   12.771912] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   12.774932] #PF: supervisor write access in kernel mode
> [   12.775314] #PF: error_code(0x0002) - not-present page
> [   12.775689] PGD 0 P4D 0
> [   12.775881] Oops: 0002 [#1] PREEMPT SMP PTI
> [   12.776212] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.12.4-g70e7f0549188-dirty #106
> [   12.776803] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [   12.777627] RIP: 0010:memcpy_fromio+0x75/0xa0
> [   12.777983] Code: e9 02 f3 a5 41 f6 c5 02 74 02 66 a5 41 f6 c5 01 74 01 a4 e8 5d 4e 6b ff 5b 41 5c 41 5d 5d c3 e8 51 4e 6b ff 4c 89 e7 48 89 de <a4> 49 89 fc 48 89 f3 49 83 ed 01 eb a4 e8 39 4e 6b ff 4c 89 e7 48
> [   12.779377] RSP: 0018:ffffc90000118db0 EFLAGS: 00010046
> [   12.779771] RAX: ffff888100258000 RBX: ffffc90007d0010f RCX: 0000000000000000
> [   12.780298] RDX: 0000000000000000 RSI: ffffc90007d0010f RDI: 0000000000000000
> [   12.780820] RBP: ffffc90000118dc8 R08: 0000000000000000 R09: 0000000000000000
> [   12.781359] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> [   12.781928] R13: 0000000000000001 R14: 0000000007d0009e R15: 0000000000000000
> [   12.782453] FS:  0000000000000000(0000) GS:ffff88817bc80000(0000) knlGS:0000000000000000
> [   12.783067] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   12.783499] CR2: 0000000000000000 CR3: 0000000005e2e000 CR4: 00000000000006e0
> [   12.784051] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   12.784579] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   12.785105] Call Trace:
> [   12.785295]  <IRQ>
> [   12.785457]  neo_copy_data_from_uart_to_queue+0x2f7/0x4e0
> [   12.785871]  neo_parse_isr.part.4+0x175/0x4d0
> [   12.786217]  neo_intr+0x188/0x7a0
thanks,
-- 
-- 
js
suse labs
