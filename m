Return-Path: <SRS0=H5Pf=3U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2BDC2D0DB
	for <linux-serial@archiver.kernel.org>; Fri, 31 Jan 2020 14:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DE520707
	for <linux-serial@archiver.kernel.org>; Fri, 31 Jan 2020 14:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580480315;
	bh=UVLWZxIDBYWd9H73LXBOM30bLjJwyxsxii3y/RGdWnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B4//Umh6oxz7BCEbbRPBGBM6d9llAp4Z1bVxJoWjGDWM6N4Qi0l99VyZmzk/Q/e4S
	 ZMW8oBadu+1TaTmq8UMdqrACDvSHNrtCq1nTbOzukzsL7dvEMspZKXHxFAy2KCIBqC
	 lvVkPD6Cr6W9/VXx2HjWT1uAlUVqTRZmCLusbQHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgAaOSe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:18:34 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41966 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbgAaOSe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 Jan 2020 09:18:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so4970052lfp.8;
        Fri, 31 Jan 2020 06:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RRvjvKaIDcznORWD7pzM9Yuu5rDxm6DZTIai7ItMTCY=;
        b=T6jG415nP1mUBd8wNeHqU+QhT6oZqvkSw/eXeNsmYrbshiseOUc1RGqBUTl6/uxiuj
         W/MV0BNqFPe2HU44C/nv+vBF+EPlVgGK3K9bF11acTq0y1CrISeOUXYiBAKAI72edYRq
         aYXeaW12Mn6L+Rceg6BnOYEnMAOjWYa1mBrbyXu1w8Zc2HM57qY6aoemus1Y6PcSwzxx
         XBA03yNuJOcI6JMIpl8c+Pf2aV9lJhPoRonaCvNNpFwe/CQ9LlRN6eAInQDmuywZx7BU
         TkL3cqTQQfrqig/6qAZ3tLbOzHVDpfeI8E4ePmaCPMQ9jr59j1+xzfK8w3gNuqzhWhpH
         3q8w==
X-Gm-Message-State: APjAAAWN7x9uFf9spSka204+Kzt0cQo4sJ38F0D076KLmDiaMu8HIA5r
        z/1mUkv/LqhANKbei2GZNXA=
X-Google-Smtp-Source: APXvYqxnvLsKIRH3WqGThPnejZYGMBJX+rv6HYVpfUZ7Q2ZmOLujCeAvS4hyk1B0JqSnn8ZMEo7/ow==
X-Received: by 2002:ac2:5499:: with SMTP id t25mr5514058lfk.194.1580480311842;
        Fri, 31 Jan 2020 06:18:31 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id g25sm4679595ljn.107.2020.01.31.06.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 06:18:31 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ixX80-0005ok-51; Fri, 31 Jan 2020 15:18:36 +0100
Date:   Fri, 31 Jan 2020 15:18:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Subject: Re: [PATCH v3] serial: uartps: Add TACTIVE bit in cdns_uart_tx_empty
 function
Message-ID: <20200131141836.GG10381@localhost>
References: <1580468685-11373-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580468685-11373-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jan 31, 2020 at 04:34:45PM +0530, Shubhrajyoti Datta wrote:
> From: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
> 
> Make sure that all the bytes are transmitted out of Uart by monitoring
> TACTIVE bit as well.
> Before setting up baud rate in set termios function, do not wait for
> Tx empty as it is taken care by the tty layer if user specified.

Since this is two logical changes I suggest you split it in two patches;
the first removing the wait from set_termios, and the second adding the
TCACTIVE check.

> Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v3:
> removed the wait from the set_termios and added the TACTIVE to cdns_uart_tx_empty
> As suggested by Johan.
> 
>  drivers/tty/serial/xilinx_uartps.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index ed2f325..ebd0a74 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -32,7 +32,6 @@
>  #define CDNS_UART_NAME		"xuartps"
>  #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
>  #define CDNS_UART_REGISTER_SPACE	0x1000
> -#define TX_TIMEOUT		500000
>  
>  /* Rx Trigger level */
>  static int rx_trigger_level = 56;
> @@ -656,8 +655,9 @@ static unsigned int cdns_uart_tx_empty(struct uart_port *port)
>  {
>  	unsigned int status;
>  
> -	status = readl(port->membase + CDNS_UART_SR) &
> -				CDNS_UART_SR_TXEMPTY;
> +	status = ((readl(port->membase + CDNS_UART_SR) &
> +				(CDNS_UART_SR_TXEMPTY |
> +				CDNS_UART_SR_TACTIVE)) == CDNS_UART_SR_TXEMPTY);
>  	return status ? TIOCSER_TEMT : 0;

Please rewrite this to avoid some of the line breaks (e.g. split readl()
from the test).

Johan
