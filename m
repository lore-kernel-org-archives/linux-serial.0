Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96D8C4361B
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 13:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A71229C5
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 13:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408109AbgLNNm2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Dec 2020 08:42:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404614AbgLNNmY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Dec 2020 08:42:24 -0500
Date:   Mon, 14 Dec 2020 14:42:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607953303;
        bh=4ExNYwY+fXTGIXYI6+NMrN06KhijSHTS38fdlEfcJrE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=NuAxBohdTBa8IwHmiovN1rcBJ+zL/eUUhDnE9Q/qANFR0TUqpkcRaTeDhMVcBV1iP
         oF4uvp6Pd6Y6FYVU9ER6ybEEfb9xQRcLgr4hVSNpZKkDEOkkYdUsN3y+TztKx5OGpG
         40dO4no1Ei7XTVOwPS+eL1/ZCAC0WWAkeswcIxfM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Ji-Ze Hong <hpeter@gmail.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] serial: 8250_fintek: Print Fintek chip name
Message-ID: <X9dr2IvOgPyhsalE@kroah.com>
References: <20201214131445.954822-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214131445.954822-1-f.suligoi@asem.it>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Dec 14, 2020 at 02:14:45PM +0100, Flavio Suligoi wrote:
> At the moment, if a Fintek UART is detected, there is no
> printed information about this.
> The ttyS port is declared as a simple 16550A port, but,
> especially when we want to use the RS485 mode, it's
> very important understand if the Fintek UART is correctly
> detected as expected.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  drivers/tty/serial/8250/8250_fintek.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
> index 31c9e83ea3cb..ef2303cb5176 100644
> --- a/drivers/tty/serial/8250/8250_fintek.c
> +++ b/drivers/tty/serial/8250/8250_fintek.c
> @@ -97,6 +97,7 @@ struct fintek_8250 {
>  	u16 base_port;
>  	u8 index;
>  	u8 key;
> +	const char *chip_name;
>  };
>  
>  static u8 sio_read_reg(struct fintek_8250 *pdata, u8 reg)
> @@ -140,9 +141,11 @@ static void fintek_8250_exit_key(u16 base_port)
>  	release_region(base_port + ADDR_PORT, 2);
>  }
>  
> -static int fintek_8250_check_id(struct fintek_8250 *pdata)
> +static int fintek_8250_check_id(struct fintek_8250 *pdata,
> +				struct uart_8250_port *uart)
>  {
>  	u16 chip;
> +	const char *chip_name;
>  
>  	if (sio_read_reg(pdata, VENDOR_ID1) != VENDOR_ID1_VAL)
>  		return -ENODEV;
> @@ -155,17 +158,35 @@ static int fintek_8250_check_id(struct fintek_8250 *pdata)
>  
>  	switch (chip) {
>  	case CHIP_ID_F81865:
> +		chip_name = "F81865";
> +		break;
>  	case CHIP_ID_F81866:
> +		chip_name = "F81866";
> +		break;
>  	case CHIP_ID_F81966:
> +		chip_name = "F81966";
> +		break;
>  	case CHIP_ID_F81216AD:
> +		chip_name = "F81216AD";
> +		break;
>  	case CHIP_ID_F81216H:
> +		chip_name = "F81216H";
> +		break;
>  	case CHIP_ID_F81216:
> +		chip_name = "F81216";
>  		break;
>  	default:
>  		return -ENODEV;
>  	}
>  
>  	pdata->pid = chip;
> +
> +	pr_info("%s%s%s Fintek %s\n",
> +		uart->port.dev ? dev_name(uart->port.dev) : "",
> +		uart->port.dev ? ": " : "",
> +		uart->port.name,
> +		chip_name);

Drivers, if all goes well, should not print anything to the kernel log.
This isn't ok.

And even if it was, dev_info() would be the correct thing to do...

thanks,

greg k-h
