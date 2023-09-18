Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8055CD37B0
	for <linux-serial@archiver.kernel.org>; Mon, 18 Sep 2023 07:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239937AbjIRHeg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Sep 2023 03:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240523AbjIRHeX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Sep 2023 03:34:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396A7132
        for <linux-serial@vger.kernel.org>; Mon, 18 Sep 2023 00:33:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CD2C433C7;
        Mon, 18 Sep 2023 07:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695022427;
        bh=Mrxwx3L4zMdgZS7gjDzQZzzXkqWACA06IKIMpI0YZH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SqIWJ7npunLRMBQnpbXTG3xKX+tdQoBknObrHIzET26k5VR/i1hQLrQrAIZYIPqMz
         36Y1U0vAtETbyeI0xGMNTzgDqYxmmu2P0iPpiboPG2p8f+1144aC9i9znM/U0KUyAm
         IogEgnAPTGl8gZtGZexIo7JqVndH1IQbYbD3cBNQ=
Date:   Mon, 18 Sep 2023 09:33:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     jeff.baldwin@sealevel.com, james.olson@sealevel.com,
        ryan.wenglarz@sealevel.com, darren.beeson@sealevel.com,
        linux-serial@vger.kernel.org, andriy.shevchenko@intel.com,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V6 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
Message-ID: <2023091853-reattach-dealmaker-ebb8@gregkh>
References: <1cfeb276-788b-5d21-5af9-8948c9273183@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cfeb276-788b-5d21-5af9-8948c9273183@sealevel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 14, 2023 at 04:52:21PM -0400, Matthew Howell wrote:
> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> Sealevel XR17V35X based cards utilize DTR to control RS-485 Enable, but 
> the current implementation of 8250_exar uses RTS for the 
> auto-RS485-Enable mode of the XR17V35X UARTs. This patch implements DTR 
> Auto-RS485 on Sealevel cards.

You have trailing whitespace in your commit log :(

Please fix your editor to not do this.

> Link: https://lore.kernel.org/all/24b88a50-9c53-82ba-84d1-292c74c81981@sealevel.com/T/

This is not needed, don't link to older emails, that can be done on a
0/X message if you really want one.

> Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> ---
> V5->V6
> Split ret in sealevel_rs485_config
> V4->V5
> Fixed typo in commit message
> Split readb and writeb into multiple lines/variables
> Removed "store original LCR" since it was clear from code
> Various small fixes to tabs and whitespace
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 3886f78ecbbf..34f0e18c7ad8 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -78,6 +78,9 @@
> 
>  #define UART_EXAR_RS485_DLY(x)	((x) << 4)
> 
> +#define UART_EXAR_DLD				0x02 /* Divisor Fractional */
> +#define UART_EXAR_DLD_485_POLARITY	0x80 /* RS-485 Enable Signal Polarity */

Why are these values not lined up?

>  /*
>   * IOT2040 MPIO wiring semantics:
>   *
> @@ -439,6 +442,41 @@ static int generic_rs485_config(struct uart_port *port, struct ktermios *termios
>  	return 0;
>  }
> 
> +static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
> +				struct serial_rs485 *rs485)
> +{
> +	u8 __iomem *p = port->membase;
> +	u8 old_lcr;
> +	u8 efr;
> +	u8 dld;
> +
> +	generic_rs485_config(port, termios, rs485);

Shouldn't you check the return value of this function?

Yes, today it can't fail, but you don't know that will really be the
case, so please fix this.

thanks,

greg k-h
