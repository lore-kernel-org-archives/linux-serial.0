Return-Path: <SRS0=EYjC=7H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F00C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 08:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0812068D
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 08:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590395281;
	bh=p+YWUnUppyZcn1hbCF3nbv+9vnNhL3Cj/jwq0koy6Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VFFfM3cE/ZGSZryqSyJM4ggqJV+Hu3srsabzpk2+qTJUFPuP3urg5QNLILkz/Mw3V
	 jGPtdraGU96iI8Uu9yxdJtApZ0rpyUNUdRfkdX/ZcWtAj5wGlGaLChwTgFR28je/hw
	 wbc5Lo7BLA6EYOYYjKVjyO1mZeaXrUA+t93brBWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgEYI2B (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 May 2020 04:28:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38708 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgEYI2A (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 May 2020 04:28:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id 202so10062094lfe.5
        for <linux-serial@vger.kernel.org>; Mon, 25 May 2020 01:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TmkrzH+S4A1mzb9IC/D09qd9h09wrz/7A5z02wDs0AU=;
        b=oAjWGQ6+arsjH/hnRElKMabVP7bXRsTEWWIOyMtKdGBz3cmGIUrlenbLV0TNy3mm69
         qgFPfi8/rBhRSeJewtoLxVHrUrDnlCO3KYzsVmpZPAs0GJlHFDT7fc0LP//VIwTDdkmM
         3yxzaIOXc6gf1N2ZGp4ddhDbh/Mdky9ndJO2ppO/ZylqqLrIxvRrZqUS0EmfETW2lJxR
         UXqLPJKxr73MX/qbd2qSJFm+Xeq9rw/z5dpGWdpZ9L5wRdhXRbuchoaXPpA2XxXp3CZh
         EcEFw0suK5rocSDHXGuP1hfpGrRdTmCJLoiLAY/E6tphJ7/19q+dLpMfZjQD4pNfZSB1
         ITyQ==
X-Gm-Message-State: AOAM532hsazidgVSUJUA+t+eDHOzo0xaFS6sFrSevUtefPofqpr6wetd
        nHSfyr9Rquq1Ck1QJeDsMcE=
X-Google-Smtp-Source: ABdhPJx5J/uu8zfeRfc9CGMoESPFWPwi0PO4t8jPviCwTUn84WrwGg9iX0rDTeKykb2z8ZRpcCjIUQ==
X-Received: by 2002:a19:4206:: with SMTP id p6mr13947048lfa.52.1590395278682;
        Mon, 25 May 2020 01:27:58 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id h8sm3057209ljg.28.2020.05.25.01.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 01:27:58 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jd8Sc-0001fz-ET; Mon, 25 May 2020 10:27:50 +0200
Date:   Mon, 25 May 2020 10:27:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Denis Ahrens <denis@h3q.com>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] 16C950 UART enable Hardware Flow Control
Message-ID: <20200525082750.GB5276@localhost>
References: <BACA4F76-3D51-4854-894B-2E69272B5676@h3q.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BACA4F76-3D51-4854-894B-2E69272B5676@h3q.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, May 24, 2020 at 06:31:44PM +0200, Denis Ahrens wrote:
> From: Denis Ahrens <denis@h3q.com>
> 
> Enable Automatic RTS/CTS flow control for the 16C950 UART in Enhanced Mode
> like described in the Data Sheet Revision 1.2 page 28 and 29.
> 
> Without this change normal console output works, but everything putting
> a little more pressure on the UART simply overruns the FIFO.
> 
> Signed-off-by: Denis Ahrens <denis@h3q.com>
> ---
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index f77bf820b7a3..024235946f4d 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2168,7 +2168,9 @@ int serial8250_do_startup(struct uart_port *port)
>                 serial_port_out(port, UART_LCR, 0);
>                 serial_icr_write(up, UART_CSR, 0); /* Reset the UART */
>                 serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
> -               serial_port_out(port, UART_EFR, UART_EFR_ECB);
> +               serial_port_out(port, UART_EFR, UART_EFR_ECB |
> +                                               UART_EFR_RTS |
> +                                               UART_EFR_CTS);
>                 serial_port_out(port, UART_LCR, 0);
>         }

This doesn't look right as you're now enabling automatic flow control
for everyone.

Try adding this to set_termios() instead when enabling flow control.

Also your patch has had all tabs turned into spaces. You may need to fix
your mail setup. Try sending the patch to yourself first and make sure
you can apply it (also take a look at git-send-email).

Johan
