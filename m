Return-Path: <SRS0=RzGw=D2=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F13C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 19 Oct 2020 07:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420B72177B
	for <linux-serial@archiver.kernel.org>; Mon, 19 Oct 2020 07:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603090803;
	bh=1wvKsTrzrrmCLzhGJvY04QpzsljzWzsMn3MQF8OZLdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dkWp/muht34KEmF/ZeZ/OC610/DvnJdovqSNNqqqOWMxM1DeOES5ISt1cJSPicH46
	 j5ZCHFW4vIiMUuO43cbS9Vximc4UUNhl1+IJ3jij3Fkllj1RXWXvLny9EmauFBT/Om
	 Ygr8Qif/ZmdV75plxHagYlz587vpNm4YSwMwyYYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgJSHAC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 19 Oct 2020 03:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbgJSHAB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 19 Oct 2020 03:00:01 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DB7320704;
        Mon, 19 Oct 2020 06:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603090800;
        bh=1wvKsTrzrrmCLzhGJvY04QpzsljzWzsMn3MQF8OZLdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wXR0CAnOcePawa+tJwuWLZoJLLnz5sb4vTzL6QIGvrY+FreCz/PI08OWZhkk1wSF8
         vK9P4MPEn1HBdnVUgh39DZHoCJj6nL97c8dcerjyTMqij8kGkhLmNHH/udPk9p6GEp
         IvL2DB3e+JAA+5lXQt2MMnz+goMNfuOg19N6UxX4=
Date:   Mon, 19 Oct 2020 09:00:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 21285: fix lockup on open
Message-ID: <20201019070046.GC3217420@kroah.com>
References: <E1kU4GS-0006lE-OO@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1kU4GS-0006lE-OO@rmk-PC.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Oct 18, 2020 at 09:42:04AM +0100, Russell King wrote:
> Commit 293f89959483 ("tty: serial: 21285: stop using the unused[]
> variable from struct uart_port") introduced a bug which stops the
> transmit interrupt being disabled when there are no characters to
> transmit - disabling the transmit interrupt at the interrupt controller
> is the only way to stop an interrupt storm. If this interrupt is not
> disabled when there are no transmit characters, we end up with an
> interrupt storm which prevents the machine making forward progress.
> 
> Fixes: 293f89959483 ("tty: serial: 21285: stop using the unused[] variable from struct uart_port")
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/tty/serial/21285.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
> index 718e010fcb04..09baef4ccc39 100644
> --- a/drivers/tty/serial/21285.c
> +++ b/drivers/tty/serial/21285.c
> @@ -50,25 +50,25 @@ static const char serial21285_name[] = "Footbridge UART";
>  
>  static bool is_enabled(struct uart_port *port, int bit)
>  {
> -	unsigned long private_data = (unsigned long)port->private_data;
> +	unsigned long *private_data = (unsigned long *)&port->private_data;
>  
> -	if (test_bit(bit, &private_data))
> +	if (test_bit(bit, private_data))
>  		return true;
>  	return false;
>  }
>  
>  static void enable(struct uart_port *port, int bit)
>  {
> -	unsigned long private_data = (unsigned long)port->private_data;
> +	unsigned long *private_data = (unsigned long *)&port->private_data;
>  
> -	set_bit(bit, &private_data);
> +	set_bit(bit, private_data);
>  }
>  
>  static void disable(struct uart_port *port, int bit)
>  {
> -	unsigned long private_data = (unsigned long)port->private_data;
> +	unsigned long *private_data = (unsigned long *)&port->private_data;
>  
> -	clear_bit(bit, &private_data);
> +	clear_bit(bit, private_data);
>  }
>  
>  #define is_tx_enabled(port)	is_enabled(port, tx_enabled_bit)
> -- 
> 2.20.1
> 

Sorry about this, my fault.  I'll merge this after 5.10-rc1 is out,
thanks for the fix.

greg k-h
