Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483C0C4332D
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jan 2021 18:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8AF233FD
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jan 2021 18:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbhAGSQy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jan 2021 13:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbhAGSQx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jan 2021 13:16:53 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9243DC0612F5;
        Thu,  7 Jan 2021 10:16:08 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id g20so11076437ejb.1;
        Thu, 07 Jan 2021 10:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xw3+iv4jWbYW97YeUypwG7nXusRKeVRrFbIKS0p0C4Q=;
        b=J6lRL3JoxLzgWSk2bres0wN6NMur16znBTo5G/6SfORLVzqj4LISPZgYwxFf1b93J0
         5wU+iGKtasRmjtko9hRKqeQAjX5OcSSu2lgRmplNGM8r1qHQRAyN3WHf2D8LcEuAde5w
         /Yr7BzY69ZanYET+IXg0x2hQ16nqb8sbCDpUhMQIml4ikAQ7JmqX+z/v8S8+E3Q/E7MB
         +eDaijn9TOILv+OeM3q0Xo22swHJswkEWsL2M2dOmw2LR9ir8b+m/jDs9DDmTEOJBjTG
         Q8n9qwVsQEl+ou8Jn/GZUHpfxv1l9Z4+fyO5LSUyAMbTTweUXWvjuH0A+dOb7Re1RgcB
         /WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xw3+iv4jWbYW97YeUypwG7nXusRKeVRrFbIKS0p0C4Q=;
        b=FdqEC62XwZSuCb87gVFK3nO5E/7O1qNfCcXN80yzhhNJXhah2rglK6nUcfBmKfGarv
         l/4nqrCiPxrQtLTptmH+xSuJGhXzsZCcARdsbBjPTz4KUy8z2XvRArKgV3dxLPA+Fq2V
         EB62EYQqAM73mY1TxFlEizJTcnjJm7rwbfyu3ICVffye1ajAz3OECP5vfnkjohtcbfrH
         ybEODaTDYAF4T+2UdAcWVYopkDZnjtq7KxA9dRS2vDtmB0R4aECoPPM12KN1IjXko3NE
         H5T2Dm6IiGL3kos80ZVMpyEkmXhHk5PWO5c2gX/rmDyTYDoPbHDvu8vWmdu4IQTHQh4m
         u4Mg==
X-Gm-Message-State: AOAM532XShD6zzeIITefQ+Re/td2XocC/PNMBhcIt53+pZT/BHN4/T69
        QANL/GsdtYUtSg5rePAyI1g=
X-Google-Smtp-Source: ABdhPJwK9ItKYY98MYFMnpwlqVeRDt7Zu9FaY6RcOPw0FA8Rl8SNjtzI2LmVs9WPpi6Ps4eSkyCo4Q==
X-Received: by 2002:a17:906:3999:: with SMTP id h25mr47734eje.146.1610043367343;
        Thu, 07 Jan 2021 10:16:07 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id z12sm2739571ejr.17.2021.01.07.10.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 10:16:06 -0800 (PST)
Date:   Thu, 7 Jan 2021 20:16:04 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] tty: serial: owl: Add support for kernel debugger
Message-ID: <20210107181604.GA427955@BV030612LT>
References: <036c09732183a30eaab230884114f65ca42ca3b9.1609865007.git.cristian.ciocaltea@gmail.com>
 <X/cm1+wVQpoXj5Xr@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/cm1+wVQpoXj5Xr@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

Thank you for the review!

On Thu, Jan 07, 2021 at 04:20:55PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 05, 2021 at 07:02:02PM +0200, Cristian Ciocaltea wrote:
> > Implement 'poll_put_char' and 'poll_get_char' callbacks in struct
> > 'owl_uart_ops' that enables OWL UART to be used for kernel debugging
> > over serial line.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

[...]

> > +
> > +static void owl_uart_poll_put_char(struct uart_port *port, unsigned char ch)
> > +{
> > +	while (owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU)
> > +		cpu_relax();
> 
> Unbounded loops?  What could possibly go wrong?
> 
> :(
> 
> Please don't do that in the kernel, put a max bound on this.

I didn't realize the issue since I had encountered this pattern in many
other serial drivers, as well: altera_uart, arc_uart, atmel_serial, etc.

> And are you _SURE_ that cpu_relax() is what you want to call here?

I'm thinking of replacing the loop with 'readl_poll_timeout_atomic()',
if that would be a better approach.

Kind regards,
Cristi

> thanks,
> 
> greg k-h
