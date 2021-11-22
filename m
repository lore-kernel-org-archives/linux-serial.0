Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8795C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 09:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbhKVJEi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 04:04:38 -0500
Received: from m12-18.163.com ([220.181.12.18]:51443 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhKVJEe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 04:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=H+3qu
        oeBk2kg7UH2uIl9AADTVyeUv0ygwL0EvisFerI=; b=hIrnd77GoyAR9cZpZYmhC
        k7ymyVrnjCyrlxyp6EtIWgRay+RO8vQljxo7dkjHTzJy/86Ln8m1FRkk/mUJKeJC
        WeSzwGUhxZAV7Ewy6RfuXVYtWcoBuS/SqpsH812pcDLN1NI+AhDynEXsAIo3rH5N
        tb6HmoQWugOF+fBjPTlzYs=
Received: from [192.168.100.154] (unknown [117.61.11.102])
        by smtp14 (Coremail) with SMTP id EsCowACnk8FUXJthFHXwMQ--.91S2;
        Mon, 22 Nov 2021 17:01:14 +0800 (CST)
Subject: Re: [PATCH] Revert "serial: 8250: Don't touch RTS modem control while
 in rs485 mode"
To:     Lukas Wunner <lukas@wunner.de>, Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        linux-serial@vger.kernel.org, chao.zeng@siemens.com
References: <20211027111644.1996921-1-baocheng.su@siemens.com>
 <20211027113938.GA9373@wunner.de>
 <e1a9b9bf-45a4-6e71-09f4-1ae730284778@163.com>
 <20211120171810.GA26621@wunner.de>
 <62d4b8ac-b9a4-3f3a-a5e3-7a3c21ed16f0@siemens.com>
 <20211121174324.GA17258@wunner.de>
From:   Su Bao Cheng <baocheng_su@163.com>
Message-ID: <10469f11-aefc-3b45-b7e1-516c918e4dc2@163.com>
Date:   Mon, 22 Nov 2021 17:01:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211121174324.GA17258@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: EsCowACnk8FUXJthFHXwMQ--.91S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr4DXF43GryxAw4UZr1rCrg_yoW7Jr15pF
        4qkrZ0yrWqgay8G3WkZFWjqFWFg3Zrtry2gF9rG3s0vrn09F1IvF1xKayYkrWUGryvkFy2
        yr1Yvr1j9a4DAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jZOzsUUUUU=
X-Originating-IP: [117.61.11.102]
X-CM-SenderInfo: pedrux5hqjs2rx6rljoofrz/1tbixhtTJ13bpaS6ogAAs2
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/22/21 1:43 AM, Lukas Wunner wrote:
> On Sun, Nov 21, 2021 at 10:00:51AM +0100, Jan Kiszka wrote:
>> Meanwhile reproduced myself, and now I believe your patch is broken in
>> ignoring the internal call path to serial8250_set_mctrl, coming from
>> uart_port_dtr_rts:
> [...]
>> This case is not triggered by userspace setting a custom RTS value but
>> by the uart-internal machinery selecting it based on the rs485 mode,
>> among other things. That path must not be intercepted and made
>> conditional using the current MCR state but has to write the request
>> value *as is*.
> 
> Thanks for the analysis and sorry for the breakage.  I'm proposing the
> fix below.  Let me know if that works for you.
> 
> However I believe that omap_8250_startup() should be amended to not set
> up->mcr = 0 unconditionally.  Rather, it should set the RTS bit if rs485
> is enabled and RTS polarity is inverted (as seems to be the case on your
> product).  Right now, even with the fix below you'll see a brief glitch
> wherein RTS is asserted (so the transceiver's driver is enabled) and
> immediately deasserted when opening the port.  This may disturb the
> communication of other devices on the bus.  Do you agree?  If so, I can
> prepare a separate fix for that.  Note that we may have never noticed
> that without f45709df7731, so... ;)
> 
> Thanks,
> 
> Lukas
> 

The new patch works on our setup.

Thanks,

Baocheng Su

> -- >8 --
> Subject: [PATCH] serial: 8250: Fix RTS modem control while in rs485 mode
> 
> Commit f45709df7731 ("serial: 8250: Don't touch RTS modem control while
> in rs485 mode") sought to prevent user space from interfering with rs485
> communication by ignoring a TIOCMSET ioctl() which changes RTS polarity.
> 
> It did so in serial8250_do_set_mctrl(), which turns out to be too deep
> in the call stack:  When a uart_port is opened, RTS polarity is set by
> the rs485-aware function uart_port_dtr_rts().  It calls down to
> serial8250_do_set_mctrl() and that particular RTS polarity change should
> *not* be ignored.
> 
> The user-visible result is that on 8250_omap ports which use rs485 with
> inverse polarity (RTS bit in MCR register is 1 to receive, 0 to send),
> a newly opened port initially sets up RTS for sending instead of
> receiving.  That's because omap_8250_startup() sets the cached value
> up->mcr to 0 and omap_8250_restore_regs() subsequently writes it to the
> MCR register.  Due to the commit, serial8250_do_set_mctrl() preserves
> that incorrect register value:
> 
> do_sys_openat2
>   do_filp_open
>     path_openat
>       vfs_open
>         do_dentry_open
> 	  chrdev_open
> 	    tty_open
> 	      uart_open
> 	        tty_port_open
> 		  uart_port_activate
> 		    uart_startup
> 		      uart_port_startup
> 		        serial8250_startup
> 			  omap_8250_startup # up->mcr = 0
> 			uart_change_speed
> 			  serial8250_set_termios
> 			    omap_8250_set_termios
> 			      omap_8250_restore_regs
> 			        serial8250_out_MCR # up->mcr written
> 		  tty_port_block_til_ready
> 		    uart_dtr_rts
> 		      uart_port_dtr_rts
> 		        serial8250_set_mctrl
> 			  omap8250_set_mctrl
> 			    serial8250_do_set_mctrl # mcr[1] = 1 ignored
> 
> Fix by intercepting RTS changes from user space in uart_tiocmset()
> instead.
> 
> Fixes: f45709df7731 ("serial: 8250: Don't touch RTS modem control while in rs485 mode")
> Reported-by: Su Bao Cheng <baocheng.su@siemens.com>
> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Chao Zeng <chao.zeng@siemens.com>
> Cc: stable@vger.kernel.org # v5.7+
> ---
>  drivers/tty/serial/8250/8250_port.c | 7 -------
>  drivers/tty/serial/serial_core.c    | 5 +++++
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 5775cbff8f6e..46e2079ad1aa 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2024,13 +2024,6 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  	unsigned char mcr;
>  
> -	if (port->rs485.flags & SER_RS485_ENABLED) {
> -		if (serial8250_in_MCR(up) & UART_MCR_RTS)
> -			mctrl |= TIOCM_RTS;
> -		else
> -			mctrl &= ~TIOCM_RTS;
> -	}
> -
>  	mcr = serial8250_TIOCM_to_MCR(mctrl);
>  
>  	mcr = (mcr & up->mcr_mask) | up->mcr_force | up->mcr;
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 1e738f265eea..6a38e9d7b87a 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1075,6 +1075,11 @@ uart_tiocmset(struct tty_struct *tty, unsigned int set, unsigned int clear)
>  		goto out;
>  
>  	if (!tty_io_error(tty)) {
> +		if (uport->rs485.flags & SER_RS485_ENABLED) {
> +			set &= ~TIOCM_RTS;
> +			clear &= ~TIOCM_RTS;
> +		}
> +
>  		uart_update_mctrl(uport, set, clear);
>  		ret = 0;
>  	}
> 

