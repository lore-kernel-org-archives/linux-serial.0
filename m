Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9CCC433F5
	for <linux-serial@archiver.kernel.org>; Mon,  9 May 2022 12:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiEIMTU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 May 2022 08:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbiEIMTT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 May 2022 08:19:19 -0400
X-Greylist: delayed 2992 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 05:15:24 PDT
Received: from vps19.webwerkers.nl (vps19.webwerkers.nl [136.144.231.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A391F2645
        for <linux-serial@vger.kernel.org>; Mon,  9 May 2022 05:15:24 -0700 (PDT)
Received: from [89.255.59.226] (helo=server.mep)
        by vps19.webwerkers.nl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <indan.zupancic@mep-info.com>)
        id 1no1Vz-0002is-3G; Mon, 09 May 2022 13:25:23 +0200
Received: from _ (localhost [127.0.0.1])
        by server.mep (Postfix) with ESMTPA id 9FB0060026;
        Mon,  9 May 2022 13:24:54 +0200 (CEST)
MIME-Version: 1.0
Date:   Mon, 09 May 2022 13:24:53 +0200
From:   Indan Zupancic <indan.zupancic@mep-info.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sherry.sun@nxp.com, linux-imx@nxp.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH] fsl_lpuart: Don't enable interrupts too early
In-Reply-To: <26f51ae5-6530-2376-55ac-0cfd3884f1ef@kernel.org>
References: <20220505114750.45423-1-Indan.Zupancic@mep-info.com>
 <26f51ae5-6530-2376-55ac-0cfd3884f1ef@kernel.org>
Message-ID: <80f2b4a248999e503d77553aeee423b3@mep-info.com>
X-Sender: indan.zupancic@mep-info.com
User-Agent: Roundcube Webmail/1.3.16
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: meptelco
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Jiri,

On 2022-05-09 12:21, Jiri Slaby wrote:
> On 05. 05. 22, 13:47, Indan Zupancic wrote:
>> If an irq is pending when devm_request_irq() is called, the irq
>> handler will cause a NULL pointer access because initialisation
>> is not done yet.
> 
> Sounds about right. But could you be a bit more specific? Like
> appending the BUG and its stack trace?

Not sure how much use this is, considering this is not mainline
kernel, but a branch of the Freescale community fork. See dmesg
output at the bottom.

All functions called by lpuart32_int() are inlined by the compiler,
complicating matters a bit. Looking at the disassembler it was probably
the access to sport->port.state in lpuart32_rxint() that caused the
bug, as that gets initialised by uart_add_one_port(), which wasn't
called yet at the time of the devm_request_irq() call. But perhaps
the platform_set_drvdata() calls is also crucial or any other inits
that were done after the devm_request_irq() call.

We noticed this problem because of wrong IO pull-up settings in our
device tree, causing erroneous interrupts and hence the crash. It's
easily triggered manually by giving UART input during bootup though.

Greetings,

Indan


[    0.806288] Unable to handle kernel NULL pointer dereference at 
virtual address 0000000000000080
[    0.814740] Mem abort info:
[    0.817518]   ESR = 0x96000005
[    0.820561]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.825858]   SET = 0, FnV = 0
[    0.828899]   EA = 0, S1PTW = 0
[    0.832025] Data abort info:
[    0.834893]   ISV = 0, ISS = 0x00000005
[    0.838715]   CM = 0, WnR = 0
[    0.841670] [0000000000000080] user address but active_mm is swapper
[    0.848014] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[    0.853572] Modules linked in:
[    0.856618] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
5.10.109-113847-gc8bff44151fd-dirty #26
[    0.865126] Hardware name: MEP GTW995 Rev 1 +seL4 (DT)
[    0.870255] pstate: 40000085 (nZcv daIf -PAN -UAO -TCO BTYPE=--)
[    0.876256] pc : lpuart32_int+0x398/0x540
[    0.880244] lr : lpuart32_int+0x10c/0x540
[    0.884238] sp : ffffffc010c6be20
[    0.887540] x29: ffffffc010c6be20 x28: 0000000000002800
[    0.892839] x27: 0000000041e2c000 x26: 0000000000020000
[    0.898138] x25: 0000000041e2c000 x24: 00000000000b0000
[    0.903438] x23: 0000000000000000 x22: 0000000000000000
[    0.908737] x21: 0000000000800000 x20: 0000000000000000
[    0.914036] x19: ffffff80244a4880 x18: 0000000000000020
[    0.919336] x17: 0000000000000001 x16: 0000000000000048
[    0.924635] x15: ffffff8024050438 x14: ffffffffffffffff
[    0.929934] x13: 0000000000000000 x12: 0000000000000040
[    0.935234] x11: ffffff8026040248 x10: ffffff802604024a
[    0.940533] x9 : ffffffc010b9aad0 x8 : ffffff8026000270
[    0.945832] x7 : 0000000000000000 x6 : ffffff8026000338
[    0.951132] x5 : 0000000000000000 x4 : ffffff8026000340
[    0.956431] x3 : 0000000000000000 x2 : 0000000000000001
[    0.961731] x1 : 0000000000000000 x0 : 0000000000000002
[    0.967030] Call trace:
[    0.969466]  lpuart32_int+0x398/0x540
[    0.973119]  __handle_irq_event_percpu+0x4c/0x150
[    0.977806]  handle_irq_event+0x64/0xec
[    0.981629]  handle_fasteoi_irq+0x144/0x1fc
[    0.985798]  __handle_domain_irq+0xd4/0x11c
[    0.989970]  gic_handle_irq+0xb4/0x120
[    0.993704]  el1_irq+0xc8/0x180
[    0.996833]  _raw_spin_unlock_irqrestore+0x14/0x3c
[    1.001610]  __setup_irq+0x4a0/0x720
[    1.005171]  request_threaded_irq+0x110/0x184
[    1.009514]  devm_request_threaded_irq+0x84/0xd0
[    1.014119]  lpuart_probe+0x3d0/0x5d0
[    1.017770]  platform_drv_probe+0x50/0xa0
[    1.021766]  really_probe+0x21c/0x494
[    1.025412]  driver_probe_device+0x70/0xb0
[    1.029495]  device_driver_attach+0x64/0xa0
[    1.033665]  __driver_attach+0xf0/0x100
[    1.037489]  bus_for_each_dev+0x5c/0xc0
[    1.041311]  driver_attach+0x20/0x30
[    1.044873]  bus_add_driver+0xe4/0x1e0
[    1.048608]  driver_register+0xb8/0xfc
[    1.052344]  __platform_driver_register+0x44/0x50
[    1.057036]  lpuart_serial_init+0x38/0x5c
[    1.061031]  do_one_initcall+0x6c/0x1a0
[    1.064855]  kernel_init_freeable+0x214/0x280
[    1.069200]  kernel_init+0x10/0x108
[    1.072672]  ret_from_fork+0x10/0x20
[    1.076240] Code: 52800082 b9401801 37000341 14000005 (f94042c0)
[    1.082322] ---[ end trace 10fce621bf8cdd96 ]---
[    1.086920] Kernel panic - not syncing: Oops: Fatal exception in 
interrupt
[    1.093785] Kernel Offset: disabled
[    1.097257] CPU features: 0x0000002,00002008
[    1.101512] Memory Limit: none
[    1.104557] Rebooting in 1 seconds..

(Apologies for any formatting problems, Roundcube can't send plain text 
plainly...)
