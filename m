Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39BFC48BDF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 11:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C4D6102A
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 11:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhFRLLG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 07:11:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231695AbhFRLLF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 07:11:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BE2A6102A;
        Fri, 18 Jun 2021 11:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624014536;
        bh=L3q8tSpj6P1Zd9eDaJjlGk11ly6+I7AEhovXuKVgS7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8FXabh7SJlls/k46K6dyKx8B1y1whce+yOdAhq0TttnrHBY2ef71O/cJgEsisZd3
         H8G108jU2E+gtCDve5w8hznVyRxJ5RUwUAC0hqIJYJwurXr5Ji+Mz+IFlouSd5jgJ9
         fuem8+P2ApVjy8cbY7hgYGqq9HcipH3OzM3FqAW8=
Date:   Fri, 18 Jun 2021 13:08:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tty: serial: jsm: allocate queue buffer at probe time
Message-ID: <YMx+xjU9BVT5Q8WN@kroah.com>
References: <1623811191-13952-1-git-send-email-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623811191-13952-1-git-send-email-zheyuma97@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 16, 2021 at 02:39:51AM +0000, Zheyu Ma wrote:
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
> 
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
> [   12.786478]  __handle_irq_event_percpu+0x53/0x3e0
> [   12.786831]  handle_irq_event_percpu+0x35/0x90
> [   12.787157]  handle_irq_event+0x39/0x60
> [   12.787458]  handle_fasteoi_irq+0xc2/0x1d0
> [   12.787763]  __common_interrupt+0x7f/0x150
> [   12.788071]  common_interrupt+0xb4/0xd0
> [   12.788358]  </IRQ>
> [   12.788532]  asm_common_interrupt+0x1e/0x40
> [   12.788853] RIP: 0010:native_safe_halt+0x17/0x20
> [   12.789199] Code: 07 0f 00 2d 0b ab 50 00 f4 5d c3 0f 1f 84 00 00 00 00 00 8b 05 f2 11 f7 01 55 48 89 e5 85 c0 7e 07 0f 00 2d eb aa 50 00 fb f4 <5d> c3 cc cc cc cc cc cc cc 55 48 89 e5 e8 67 53 ff ff 8b 0d e9 dc
> [   12.790581] RSP: 0018:ffffc9000008fe90 EFLAGS: 00000246
> [   12.790975] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
> [   12.791502] RDX: 0000000000000000 RSI: ffffffff859d2c94 RDI: ffffffff8589953e
> [   12.792031] RBP: ffffc9000008fe90 R08: 0000000000000001 R09: 0000000000000001
> [   12.792573] R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff86434488
> [   12.793095] R13: 0000000000000000 R14: 0000000000000000 R15: ffff888100258000
> [   12.793625]  default_idle+0x9/0x10
> [   12.793898]  arch_cpu_idle+0xa/0x10
> [   12.794159]  default_idle_call+0x6e/0x250
> [   12.794462]  do_idle+0x1f0/0x2d0
> [   12.794708]  cpu_startup_entry+0x18/0x20
> [   12.795008]  start_secondary+0x11f/0x160
> [   12.795314]  secondary_startup_64_no_verify+0xb0/0xbb
> [   12.795701] Modules linked in:
> [   12.795931] Dumping ftrace buffer:
> [   12.796206]    (ftrace buffer empty)
> [   12.796481] CR2: 0000000000000000
> [   12.796741] ---[ end trace 5535b8755359e59f ]---
> [   12.797089] RIP: 0010:memcpy_fromio+0x75/0xa0
> [   12.797417] Code: e9 02 f3 a5 41 f6 c5 02 74 02 66 a5 41 f6 c5 01 74 01 a4 e8 5d 4e 6b ff 5b 41 5c 41 5d 5d c3 e8 51 4e 6b ff 4c 89 e7 48 89 de <a4> 49 89 fc 48 89 f3 49 83 ed 01 eb a4 e8 39 4e 6b ff 4c 89 e7 48
> [   12.798787] RSP: 0018:ffffc90000118db0 EFLAGS: 00010046
> [   12.799175] RAX: ffff888100258000 RBX: ffffc90007d0010f RCX: 0000000000000000
> [   12.799702] RDX: 0000000000000000 RSI: ffffc90007d0010f RDI: 0000000000000000
> [   12.800226] RBP: ffffc90000118dc8 R08: 0000000000000000 R09: 0000000000000000
> [   12.800753] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> [   12.801287] R13: 0000000000000001 R14: 0000000007d0009e R15: 0000000000000000
> [   12.801809] FS:  0000000000000000(0000) GS:ffff88817bc80000(0000) knlGS:0000000000000000
> [   12.802431] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   12.802862] CR2: 0000000000000000 CR3: 0000000005e2e000 CR4: 00000000000006e0
> [   12.803412] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   12.803932] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   12.804447] Kernel panic - not syncing: Fatal exception in interrupt
> [   12.805067] Dumping ftrace buffer:
> [   12.805315]    (ftrace buffer empty)
> [   12.805584] Kernel Offset: disabled
> [   12.805850] Rebooting in 1 seconds..
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
> Changes in v3:
>     - Remove useless comments
>     - Remove uncessary flag changes
>     - Keep flushing input quques in the open function
> 
> Changes in v2:
>     - Allocate the memory at probe time, instead of simply checking
>     whether it
>         is a null pointer.
> ---
>  drivers/tty/serial/jsm/jsm_tty.c | 43 ++++++++------------------------
>  1 file changed, 11 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
> index 8e42a7682c63..d42972b2d2c4 100644
> --- a/drivers/tty/serial/jsm/jsm_tty.c
> +++ b/drivers/tty/serial/jsm/jsm_tty.c
> @@ -195,38 +195,6 @@ static int jsm_tty_open(struct uart_port *port)
>  	/* Get board pointer from our array of majors we have allocated */
>  	brd = channel->ch_bd;
>  
> -	/*
> -	 * Allocate channel buffers for read/write/error.
> -	 * Set flag, so we don't get trounced on.
> -	 */
> -	channel->ch_flags |= (CH_OPENING);
> -
> -	/* Drop locks, as malloc with GFP_KERNEL can sleep */
> -
> -	if (!channel->ch_rqueue) {
> -		channel->ch_rqueue = kzalloc(RQUEUESIZE, GFP_KERNEL);
> -		if (!channel->ch_rqueue) {
> -			jsm_dbg(INIT, &channel->ch_bd->pci_dev,
> -				"unable to allocate read queue buf\n");
> -			return -ENOMEM;
> -		}
> -	}
> -	if (!channel->ch_equeue) {
> -		channel->ch_equeue = kzalloc(EQUEUESIZE, GFP_KERNEL);
> -		if (!channel->ch_equeue) {
> -			jsm_dbg(INIT, &channel->ch_bd->pci_dev,
> -				"unable to allocate error queue buf\n");
> -			return -ENOMEM;
> -		}
> -	}
> -
> -	channel->ch_flags &= ~(CH_OPENING);
> -	/*
> -	 * Initialize if neither terminal is open.
> -	 */
> -	jsm_dbg(OPEN, &channel->ch_bd->pci_dev,
> -		"jsm_open: initializing channel in open...\n");
> -
>  	/*
>  	 * Flush input queues.
>  	 */
> @@ -420,6 +388,17 @@ int jsm_tty_init(struct jsm_board *brd)
>  		ch->ch_close_delay = 250;
>  
>  		init_waitqueue_head(&ch->ch_flags_wait);
> +
> +		if (!ch->ch_rqueue) {
> +			ch->ch_rqueue = kzalloc(RQUEUESIZE, GFP_KERNEL);
> +			if (!ch->ch_rqueue)
> +				return -ENOMEM;
> +		}
> +		if (!ch->ch_equeue) {
> +			ch->ch_equeue = kzalloc(EQUEUESIZE, GFP_KERNEL);
> +			if (!ch->ch_equeue)
> +				return -ENOMEM;

You just leaked memory :(

