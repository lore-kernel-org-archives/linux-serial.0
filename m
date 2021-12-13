Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F007C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 13 Dec 2021 16:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240526AbhLMQM1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:12:27 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:56357 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbhLMQM1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Dec 2021 11:12:27 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 07AF32800A278;
        Mon, 13 Dec 2021 17:12:23 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id EF3A62B19B0; Mon, 13 Dec 2021 17:12:22 +0100 (CET)
Date:   Mon, 13 Dec 2021 17:12:22 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Su Bao Cheng <baocheng_su@163.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        linux-serial@vger.kernel.org, chao.zeng@siemens.com
Subject: Re: [PATCH] Revert "serial: 8250: Don't touch RTS modem control
 while in rs485 mode"
Message-ID: <20211213161222.GA15826@wunner.de>
References: <20211027111644.1996921-1-baocheng.su@siemens.com>
 <20211027113938.GA9373@wunner.de>
 <e1a9b9bf-45a4-6e71-09f4-1ae730284778@163.com>
 <20211120171810.GA26621@wunner.de>
 <62d4b8ac-b9a4-3f3a-a5e3-7a3c21ed16f0@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d4b8ac-b9a4-3f3a-a5e3-7a3c21ed16f0@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Nov 21, 2021 at 10:00:51AM +0100, Jan Kiszka wrote:
> Meanwhile reproduced myself, and now I believe your patch is broken in
> ignoring the internal call path to serial8250_set_mctrl, coming from
> uart_port_dtr_rts:
> 
> [  257.923335] uart_port_dtr_rts: rs485_on 1, RTS_after_send 1, raise 1
> [   25.411508] mcr = 1 (was 0)
> [  257.932631] CPU: 0 PID: 457 Comm: cat Not tainted 5.16.0-rc1+ #190
> [  257.938803] Hardware name: SIMATIC IOT2050 Basic (DT)
> [  257.943843] Call trace:
> [  257.946280]  dump_backtrace+0x0/0x1ac
> [  257.949948]  show_stack+0x18/0x70
> [  257.953260]  dump_stack_lvl+0x68/0x84
> [  257.956920]  dump_stack+0x18/0x34
> [  257.960231]  serial8250_do_set_mctrl+0x184/0x190
> [  257.964847]  omap8250_set_mctrl+0x24/0xd0
> [  257.968855]  serial8250_set_mctrl+0x18/0x34
> [  257.973033]  uart_port_dtr_rts+0xc0/0x160

Are you using a custom patch which is not in mainline to fix the behavior
of uart_port_dtr_rts() if rs485 is enabled?

In the dmesg output above, why does the timestamp jump from 257.923335
back to 25.411508?

After extensive debugging and staring at the code for a couple of days
I'm under the impression commit a6845e1e1b78 is broken and sets RTS
exactly the wrong way.  The commit failed to appreciate that with RS-485,
there's a single negation of RTS (MCR contains the complement of the
desired signal level) whereas with RS-232 there's a double negation
(the RS-232 transceiver negates the resulting signal level yet again).
So, "setting RTS" and "clearing RTS" is the inverse for RS-232 vis-a-vis
RS-485.

With the code in mainline broken, yet it apparently not being broken in
your tree (going by your debug output above), only explanation I can
think of is you've got a custom fix in your tree.  If you do, why haven't
you upstreamed it?

Thanks,

Lukas
