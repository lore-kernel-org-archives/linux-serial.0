Return-Path: <SRS0=kbyA=24=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C311DC33C8C
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jan 2020 12:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFEF2073D
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jan 2020 12:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578401472;
	bh=Sf9QMWvQXX+5/S9v1xQntnvRcer0zNLZyar3klmPIf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QwBvLuzojoGSLqzci6nK5+IlmT6Bt9MtMls+99VasXuLhacF/3fF97HlgDapswORb
	 TJjcOMuh38zG0diR529vQL7vWybtSnakbOgmZjICQAYyP02OdClUwFz3h1i7QC7jLW
	 Om5t7X8kfII7NN6szFznZg3uI88oN3mfuzVSprg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgAGMvM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:51:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42751 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGMvM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jan 2020 07:51:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id y4so40241491ljj.9
        for <linux-serial@vger.kernel.org>; Tue, 07 Jan 2020 04:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hm36PezGaqqFxtG41Oya12SMyXNQ1HU0DZDf0OfnI+c=;
        b=nxGMcG11bv/OFLKuI8K8Rk5QIZz3jpUcfaW9vqOatPKXu2m61qak8l0FsYSKUN6ViB
         TwQRJYYlq6uW1BCgl3yPX6JpEvHGVQhBJwUHnWJBDCXKXKJoOUVFpmfRjZCeTffZ5/zm
         uZVKhljPOeIXpfswLMY90+jFKFgmcApCCEki80t1n21DQA2NQkk3RVO4tzj+L/Zie8Pt
         2UJVWV5iMvcxR7EPLeddC0P+zL7vtjaj0nBw5zvGD8miGr8/wDv8VVYJOKYXtAae+joL
         i4j+qkMZXWy9S9AQRhAZvXRkJ+Wu5G97rpj0cW32Lu7H937j8sZWy5lJEyIBLgHIYpAS
         Qu8A==
X-Gm-Message-State: APjAAAUTiWRb5Swe/8oNzLZvnXY0kqmWIcm9aJI8PGV6OR/V7JF1MxY8
        y4daQRmncIYc1rGF3Nt0yZ0=
X-Google-Smtp-Source: APXvYqxJ8aCQCls4ZfxtVaRaune5IwmhTbbx7sQ+R3X2NTH6Dfr9bd8FUNcs9XEjFkn/cAvUIE3CGg==
X-Received: by 2002:a2e:9e55:: with SMTP id g21mr42021417ljk.245.1578401469951;
        Tue, 07 Jan 2020 04:51:09 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id 21sm28872685ljv.19.2020.01.07.04.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 04:51:09 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1iooKL-0006RC-F8; Tue, 07 Jan 2020 13:51:17 +0100
Date:   Tue, 7 Jan 2020 13:51:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jacmet@sunsite.dk, git@xilinx.com,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCHv2] serial: uartps: Add monitoring TACTIVE bit in
 set_termios
Message-ID: <20200107125117.GG30908@localhost>
References: <1578398223-27523-1-git-send-email-shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578398223-27523-1-git-send-email-shubhrajyoti.datta@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 07, 2020 at 05:27:03PM +0530, shubhrajyoti.datta@gmail.com wrote:
> From: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
> 
> Before setting up baud rate in set_termios function, make sure
> all the data is shifted out from the Uart transmitter by
> monitoring TACTIVE bit in the channel status register.

set_termios() is not supposed to do that unconditionally. Instead the
user specifies whether the output buffer shall been drained (e.g. using
TCSADRAIN) and the tty layer takes care of it.

Almost no other serial driver does this, which is a hint that you're
doing something wrong.

I suggest you remove the check instead and possibly amend tx_empty() if
you need to check CDNS_UART_SR_TACTIVE as well.

> Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v2: fix the signed-off
> 
>  drivers/tty/serial/xilinx_uartps.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 4e55bc3..7424f33 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -690,11 +690,15 @@ static void cdns_uart_set_termios(struct uart_port *port,
>  	unsigned int ctrl_reg, mode_reg, val;
>  	int err;
>  
> -	/* Wait for the transmit FIFO to empty before making changes */
> +	/* Wait for the transmit FIFO to empty and Transmitter to shift out
> +	 * all the data before making changes
> +	 */
>  	if (!(readl(port->membase + CDNS_UART_CR) &
>  				CDNS_UART_CR_TX_DIS)) {
>  		err = readl_poll_timeout(port->membase + CDNS_UART_SR,
> -					 val, (val & CDNS_UART_SR_TXEMPTY),
> +					 val, ((val & (CDNS_UART_SR_TXEMPTY |
> +					 CDNS_UART_SR_TACTIVE)) ==
> +					 CDNS_UART_SR_TXEMPTY),
>  					 1000, TX_TIMEOUT);
>  		if (err) {
>  			dev_err(port->dev, "timed out waiting for tx empty");

Johan
