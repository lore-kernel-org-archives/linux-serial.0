Return-Path: <SRS0=sEmL=27=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B01C282DD
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 16:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF8320721
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 16:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578674807;
	bh=Q/Krz5L+BywpaikQwEhNbMRsDEYYow+J/SrLX6ewYgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HRvmusH1MGHam4z0dahGjkF3yTUYONE2Z+8lnMOoDoa6k8BRzQQqjAwxfRK/0jaZl
	 lGAPXCIB0HU8XDaaF5hDnog78Lku7ATIQYMCfzMIJ5thECrMnLtCzMinR5vHh0GyL2
	 USL91GWN6VDA6GRWQW0ndV5+lmTNg7hYw8ZRS2w8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgAJQqq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:46:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:46950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728542AbgAJQqq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jan 2020 11:46:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2313E206ED;
        Fri, 10 Jan 2020 16:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578674805;
        bh=Q/Krz5L+BywpaikQwEhNbMRsDEYYow+J/SrLX6ewYgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C6qapw4FSUm8G59HZSFHuh7wITftQUYHbB9z1x0GHpLzHlao5WNjcBK3Iz0Vo1+Pq
         SMKJn8i2w9EUbERHVRA+ByX51UowC2/LKSZZgKh9Ey3KBtm6n5ZN9nO4Vs5V1763FX
         y3fRHs+j4rKAby/QG6P4yvnp163bsNFbsygjdQ5M=
Date:   Fri, 10 Jan 2020 17:46:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH-next 3/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
Message-ID: <20200110164643.GB1822445@kroah.com>
References: <20200109215444.95995-1-dima@arista.com>
 <20200109215444.95995-4-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109215444.95995-4-dima@arista.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 09, 2020 at 09:54:44PM +0000, Dmitry Safonov wrote:
> Many embedded boards have a disconnected TTL level serial which can
> generate some garbage that can lead to spurious false sysrq detects.
> 
> Currently, sysrq can be either completely disabled for serial console
> or always disabled (with CONFIG_MAGIC_SYSRQ_SERIAL), since
> commit 732dbf3a6104 ("serial: do not accept sysrq characters via serial port")
> 
> At Arista, we have such boards that can generate BREAK and random
> garbage. While disabling sysrq for serial console would solve
> the problem with spurious false sysrq triggers, it's also desirable
> to have a way to enable sysrq back.
> 
> As a measure of balance between on and off options, add
> MAGIC_SYSRQ_SERIAL_SEQUENCE which is a string sequence that can enable
> sysrq if it follows BREAK on a serial line. The longer the string - the
> less likely it may be in the garbage.
> 
> Having the way to enable sysrq was beneficial to debug lockups with
> a manual investigation in field and on the other side preventing false
> sysrq detections.
> 
> Based-on-patch-by: Vasiliy Khoruzhick <vasilykh@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  drivers/tty/serial/serial_core.c | 52 ++++++++++++++++++++++++++++----
>  include/linux/serial_core.h      |  2 +-
>  lib/Kconfig.debug                |  8 +++++
>  3 files changed, 55 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 6ac9dfed3423..f70eba032d0b 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3081,6 +3081,38 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
>  }
>  EXPORT_SYMBOL_GPL(uart_insert_char);
>  
> +const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
> +
> +static void uart_sysrq_on(struct work_struct *w)
> +{
> +	sysrq_toggle_support(1);
> +	pr_info("SysRq is enabled by magic sequience on serial\n");

Do we want to say what serial port it is enabled on?

And why is this done in a workqueue?

> +}
> +static DECLARE_WORK(sysrq_enable_work, uart_sysrq_on);
> +
> +static int uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
> +{
> +	if (sysrq_toggle_seq[0] == '\0')
> +		return 0;

Is constantly checking the data stream like this going to slow things
down overall?  Ah, we are just checking this after BREAK, right?  So
that hopefully will not be that bad...

> +
> +	BUILD_BUG_ON(ARRAY_SIZE(sysrq_toggle_seq) >= sizeof(port->sysrq_seq)*U8_MAX);
> +	if (sysrq_toggle_seq[port->sysrq_seq] != ch) {
> +		port->sysrq_seq = 0;
> +		return 0;
> +	}
> +
> +	/* Without the last \0 */
> +	if (++port->sysrq_seq < (ARRAY_SIZE(sysrq_toggle_seq) - 1)) {
> +		port->sysrq = jiffies + HZ*5;

5 second delay?  You should document what this value is for somewhere
here...

> +		return 1;
> +	}
> +
> +	schedule_work(&sysrq_enable_work);
> +
> +	port->sysrq = 0;
> +	return 1;
> +}
> +
>  int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
>  {
>  	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
> @@ -3090,9 +3122,13 @@ int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
>  		return 0;
>  
>  	if (ch && time_before(jiffies, port->sysrq)) {
> -		handle_sysrq(ch);
> -		port->sysrq = 0;
> -		return 1;
> +		if (sysrq_get_mask()) {
> +			handle_sysrq(ch);
> +			port->sysrq = 0;
> +			return 1;
> +		}

Isn't this change to test for sysrq_get_mask() a different change than
checking for the "magic" data stream?

> +		if (uart_try_toggle_sysrq(port, ch))
> +			return 1;
>  	}
>  	port->sysrq = 0;
>  
> @@ -3109,9 +3145,13 @@ int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
>  		return 0;
>  
>  	if (ch && time_before(jiffies, port->sysrq)) {
> -		port->sysrq_ch = ch;
> -		port->sysrq = 0;
> -		return 1;
> +		if (sysrq_get_mask()) {
> +			port->sysrq_ch = ch;
> +			port->sysrq = 0;
> +			return 1;
> +		}
> +		if (uart_try_toggle_sysrq(port, ch))
> +			return 1;
>  	}
>  	port->sysrq = 0;
>  
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 255e86a474e9..1f4443db5474 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -243,10 +243,10 @@ struct uart_port {
>  	unsigned long		sysrq;			/* sysrq timeout */
>  	unsigned int		sysrq_ch;		/* char for sysrq */
>  	unsigned char		has_sysrq;
> +	unsigned char		sysrq_seq;		/* index in sysrq_toggle_seq */
>  
>  	unsigned char		hub6;			/* this should be in the 8250 driver */
>  	unsigned char		suspended;
> -	unsigned char		unused;

This is an unrelated change, let's leave it for a different patch that
cleans up the layout of this structure, ok?

thanks,

greg k-h
