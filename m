Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46745C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 08:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3001661029
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 08:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbhKHJAz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Nov 2021 04:00:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238257AbhKHJAz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Nov 2021 04:00:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C82B61029;
        Mon,  8 Nov 2021 08:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636361891;
        bh=TrHEQ4sI9oo53xDElCIDPWsGAF8FQCriNFj66mwhsjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSAqY7cigCuQtLlmVjRn7PrjXEOvCRkVFCuw1kcuvI3Eq9z4q+rwU9PFwmpuZnwBY
         lNh75+JZNrbWrpIy0LL9VjFVXhVn6J8BP36+yYGUonPyAcuVKWxomGu57RkKvyHc35
         3vbfcJ7ePO6PdImIAPS3xzkSKLFtm8QoWag7bva5O2588ACd2tTT61eSTFBBA5/9Qf
         Y2tGzDRc0feHDymJ/hEk7vY927Ca9mi4WdqBF+3ghd90cz7RwQeMEqLjfhgUnKXEjo
         kKAWt7EL4ju+wzPxwFUgDcJO18t6NXMOyd73EeHSQ/QswFprfONI1S3tjR9fXjEK60
         r1+IP3dZuHrPw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mk0Tg-0003JZ-PC; Mon, 08 Nov 2021 09:58:08 +0100
Date:   Mon, 8 Nov 2021 09:58:08 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH] tty: flush buffer on signal interrupted tty close
Message-ID: <YYjmoNkCGysVaCFr@hovoldconsulting.com>
References: <319321886d97c456203d5c6a576a5480d07c3478.1635781688.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <319321886d97c456203d5c6a576a5480d07c3478.1635781688.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 01, 2021 at 05:48:08PM +0200, Baruch Siach wrote:
> When a signal interrupts tty_wait_until_sent() on a UART device, there
> might be data left on the xmit buffer that the UART will never transmit.
> This causes set_termios() to wait forever in tty_wait_until_sent().
> 
> The hang reproduces easily on my system that is equipped with DesignWare
> 8250. Run
> 
>   while true; do echo -ne 0123456789abcdef01 > /dev/ttyS1; done
> 
> Hit Ctrl-C to interrupt the loop. When data is left in the struct
> uart_state xmit buffer, the following command hangs:
> 
>   stty -F /dev/ttyS1 raw -echo

Thanks for reporting this. It should not be possible for there to be
data left in the buffer and indeed we do have a long-standing regression
here since the serdev work five years ago. I'm a bit surprised no one
has noticed and reported this for that long.

> Call tty_driver_flush_buffer() on signal interrupted wait, to discard
> data from the xmit buffer.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/tty/tty_ioctl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> index 507a25d692bb..0bf6fad7ecb3 100644
> --- a/drivers/tty/tty_ioctl.c
> +++ b/drivers/tty/tty_ioctl.c
> @@ -203,6 +203,8 @@ void tty_wait_until_sent(struct tty_struct *tty, long timeout)
>  
>  	timeout = wait_event_interruptible_timeout(tty->write_wait,
>  			!tty_chars_in_buffer(tty), timeout);
> +	if (timeout == -ERESTARTSYS && tty->closing)
> +		tty_driver_flush_buffer(tty);
>  	if (timeout <= 0)
>  		return;

This is however not the right fix since the problem isn't limited to
interrupted waits and in any case should not be handled in
tty_wait_until_sent().

I can reproduce the problem and have posted a fix here:

	https://lore.kernel.org/r/20211108083856.5261-1-johan@kernel.org

Johan
