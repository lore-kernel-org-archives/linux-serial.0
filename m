Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB681C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 27 Oct 2021 11:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF7560ED4
	for <linux-serial@archiver.kernel.org>; Wed, 27 Oct 2021 11:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239789AbhJ0Lsj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 27 Oct 2021 07:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhJ0Lsj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 Oct 2021 07:48:39 -0400
X-Greylist: delayed 391 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Oct 2021 04:46:13 PDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340DAC061570
        for <linux-serial@vger.kernel.org>; Wed, 27 Oct 2021 04:46:13 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id B7E9C105E9592;
        Wed, 27 Oct 2021 13:39:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 912152E9E7E; Wed, 27 Oct 2021 13:39:38 +0200 (CEST)
Date:   Wed, 27 Oct 2021 13:39:38 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Su Bao Cheng <baocheng.su@siemens.com>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jan.kiszka@siemens.com, chao.zeng@siemens.com
Subject: Re: [PATCH] Revert "serial: 8250: Don't touch RTS modem control
 while in rs485 mode"
Message-ID: <20211027113938.GA9373@wunner.de>
References: <20211027111644.1996921-1-baocheng.su@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027111644.1996921-1-baocheng.su@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 27, 2021 at 07:16:44PM +0800, Su Bao Cheng wrote:
> This reverts commit f45709df7731ad36306a28a3e1af7309d55c35f5.
> 
> The `serial8250_do_set_mctrl` not only used by userspace ioctl but
> also the kernel itself.
> 
> During tty_open, the uart_port_startup sets the MCR to 0, and then use
> set_mctrl to restore the MCR, so at this time, the MCR read does not
> reflect the desired value.

I don't quite follow.  Where is uart_port_startup() setting the MCR to 0?
Are you referring to the call to uart_port_dtr_rts()?  That function should
set RTS correctly according to RS485 state, so I don't see where any
breakage may occur.

What is the user-visible issue that you seek to fix with the revert?

Thanks,

Lukas

> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 66374704747e..40736e460956 100644
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
> -- 
> 2.25.1
