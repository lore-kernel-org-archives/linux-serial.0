Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33214C433EF
	for <linux-serial@archiver.kernel.org>; Sun, 21 Nov 2021 09:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbhKUJED (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 21 Nov 2021 04:04:03 -0500
Received: from goliath.siemens.de ([192.35.17.28]:39719 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbhKUJEC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 21 Nov 2021 04:04:02 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AL90qSf029734
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Nov 2021 10:00:52 +0100
Received: from [167.87.72.70] ([167.87.72.70])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AL90p2C018468;
        Sun, 21 Nov 2021 10:00:51 +0100
Subject: Re: [PATCH] Revert "serial: 8250: Don't touch RTS modem control while
 in rs485 mode"
To:     Lukas Wunner <lukas@wunner.de>, Su Bao Cheng <baocheng_su@163.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Su Bao Cheng <baocheng.su@siemens.com>,
        linux-serial@vger.kernel.org, chao.zeng@siemens.com
References: <20211027111644.1996921-1-baocheng.su@siemens.com>
 <20211027113938.GA9373@wunner.de>
 <e1a9b9bf-45a4-6e71-09f4-1ae730284778@163.com>
 <20211120171810.GA26621@wunner.de>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <62d4b8ac-b9a4-3f3a-a5e3-7a3c21ed16f0@siemens.com>
Date:   Sun, 21 Nov 2021 10:00:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211120171810.GA26621@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 20.11.21 18:18, Lukas Wunner wrote:
> On Fri, Nov 12, 2021 at 02:14:11PM +0800, Su Bao Cheng wrote:
>> On 2021/10/27 7:39, Lukas Wunner wrote:
>>> On Wed, Oct 27, 2021 at 07:16:44PM +0800, Su Bao Cheng wrote:
>>>> During tty_open, the uart_port_startup sets the MCR to 0, and then use
>>>> set_mctrl to restore the MCR, so at this time, the MCR read does not
>>>> reflect the desired value.
> 
> So only the *initial* value of MCR[1] is wrong and prevents receiving.
> But once you've sent some data, RTS is deasserted correctly and you can
> receive again.  Did I understand that correctly?
> 
> 
>> The MCR is set to 0 at this line within uart_port_startup():
>> 	retval = uport->ops->startup(uport);
>>
>> On omap8250, the startup() points to omap_8250_startup(), within it:
>> 	up->mcr = 0;
>>
>> For software controlled RTS pin of RS485 half-duplex, when not in the
>> transmitting, the MCR[1] should be constant to indicate the current
>> direction is receiving. This is set in serial8250_em485_stop_tx().
> 
> I'm missing an important piece of information here:  Are you using
> inverse polarity for RTS?  Normally MCR[1] should be 1 to transmit
> and 0 to receive, per the figure on page 8734 of this document:
> 
> https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
> 
> Thus, setting up->mcr = 0 should be perfectly fine because it results
> in RTS being deasserted, so the transceiver is in receive mode.
> 
> I suspect that you're using inverse polarity for RTS, so the desired
> initial value of MCR[1] is 1 in your case.  Is that correct?
> 
> You write above that "the MCR[1] should be constant to indicate the
> current direction is receiving".  That sentence is missing the desired
> value, i.e. should MCR[1] be constant 1 or constant 0?
> 
> I suspect that the incorrect value in MCR[1] is evaluated by
> omap8250_set_mctrl() via this call stack:
>   omap_8250_set_termios()
>     omap8250_restore_regs()
>       up->port.ops->set_mctrl()
> 
> Could you confirm this please by inserting a dump_stack() in
> omap8250_set_mctrl()?
> 
> I would also like to know if you have set UPSTAT_AUTORTS on the port
> by enabling hardware flow-control (CRTSCTS) on the tty.  That would
> cause omap8250_set_mctrl to fiddle with UART_EFR_RTS bit and I think
> the user-visible result is that the transceiver is switched to
> transmit mode when the "RX FIFO HALT trigger level" is reached.
> We should probably stop it from doing that.
> 

Meanwhile reproduced myself, and now I believe your patch is broken in
ignoring the internal call path to serial8250_set_mctrl, coming from
uart_port_dtr_rts:

[  257.923335] uart_port_dtr_rts: rs485_on 1, RTS_after_send 1, raise 1
[   25.411508] mcr = 1 (was 0)
[  257.932631] CPU: 0 PID: 457 Comm: cat Not tainted 5.16.0-rc1+ #190
[  257.938803] Hardware name: SIMATIC IOT2050 Basic (DT)
[  257.943843] Call trace:
[  257.946280]  dump_backtrace+0x0/0x1ac
[  257.949948]  show_stack+0x18/0x70
[  257.953260]  dump_stack_lvl+0x68/0x84
[  257.956920]  dump_stack+0x18/0x34
[  257.960231]  serial8250_do_set_mctrl+0x184/0x190
[  257.964847]  omap8250_set_mctrl+0x24/0xd0
[  257.968855]  serial8250_set_mctrl+0x18/0x34
[  257.973033]  uart_port_dtr_rts+0xc0/0x160
[  257.977036]  uart_dtr_rts+0x64/0xdc
[  257.980519]  tty_port_block_til_ready+0x1fc/0x33c
[  257.985219]  tty_port_open+0xc4/0x250
[  257.988877]  uart_open+0x1c/0x30
[  257.992102]  tty_open+0x140/0x61c
[  257.995417]  chrdev_open+0xc0/0x230
[  257.998904]  do_dentry_open+0x12c/0x3a0
[  258.002737]  vfs_open+0x30/0x3c
[  258.005877]  path_openat+0x864/0xd30
[  258.009447]  do_filp_open+0x80/0x130
[  258.013018]  do_sys_openat2+0xb4/0x16c
[  258.016763]  __arm64_sys_openat+0x64/0xb0
[  258.020769]  invoke_syscall+0x48/0x114
[  258.024515]  el0_svc_common.constprop.0+0x44/0xec
[  258.029214]  do_el0_svc+0x24/0x90
[  258.032525]  el0_svc+0x20/0x60
[  258.035577]  el0t_64_sync_handler+0xe8/0xf0
[  258.039755]  el0t_64_sync+0x1a0/0x1a4

This case is not triggered by userspace setting a custom RTS value but
by the uart-internal machinery selecting it based on the rs485 mode,
among other things. That path must not be intercepted and made
conditional using the current MCR state but has to write the request
value *as is*. I think that is not even an omap-specific regression,
it's generic.

If you want to sanitize mctrl, you must do that at the entry point from
userspace, probably in uart_set_termios (but I didn't dig very deep into
that). So, reverting this commit still seems like the best option to me.

I see the point of filtering TIOCMSET, but that would have to be done
differently.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
