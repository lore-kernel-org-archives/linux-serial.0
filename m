Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A090C47094
	for <linux-serial@archiver.kernel.org>; Mon,  7 Jun 2021 16:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 152DE600CD
	for <linux-serial@archiver.kernel.org>; Mon,  7 Jun 2021 16:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhFGQxt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhFGQxt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Jun 2021 12:53:49 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406A9C061789
        for <linux-serial@vger.kernel.org>; Mon,  7 Jun 2021 09:51:57 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w33so27428790lfu.7
        for <linux-serial@vger.kernel.org>; Mon, 07 Jun 2021 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4mY/aNK/og5BaCE3D+Ny9Z2cDDmDcGfMUwRlGjnX3tQ=;
        b=TXp4IbHjVz71UiTx0UWCQGNLQxfjQX9bcho7bgq34ep3jBC3rJAEm1XWmopBDEP1PY
         Ky6/5T1oqefS1wuoNkV+oHgsd/hn+DcJDF714WU/7OmThepqrr9C0eLmaaIEkKmyjN0H
         04eSsDmd9AyJJON3KDF3rTn92z2JXJdcZhv7MSj+HmtC2x/Nb+Mb3kWambXctp8G+oLt
         cjHJ0QJnc/H8yKBygCHILJcx4y6NmXb4FQVIM6pFHsy6dBSxg2tX6U9VPtEwTi26UQJQ
         LUNyccqZ3XBlcMvwyMp60yivVAYgZl1rN3+K9+NPX0CI7n3BU/A+jk8csY6CH5ZqOkHg
         NRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4mY/aNK/og5BaCE3D+Ny9Z2cDDmDcGfMUwRlGjnX3tQ=;
        b=Qql+g0aORBYe0klAwbdmq8BdN/YNo9ZXyqFAum51GEsYpDB5a+Cp97xw+7JY2cviUW
         DUL7jkpenOWDGGI1cPeAZ0kGS8na3Y04PSmRow+9O7+b82+nKjvlck5McPb8lAdlCGXw
         G2Nm5ScNXx17/zf+P0PkFZwCqifiPLzhRdV1t594A4TWRW3WIdoD3aRbuJPTxDJnwfpZ
         Ynf6vs8CVzGiBjSGqPmhK8GbL9HTxBlyTL3Omkb7C45DgrhPTCeDRKLVK34atZ7HDMpQ
         cPDBruN8jUM9A6SsVzsHTkwVL278qYNA6HCcbBx8ezS8imDt7GGFAAJ+/GPrZNVEKw6I
         wVAg==
X-Gm-Message-State: AOAM532zooNtVfP9ZQ+aJ5eqGjMhZ8rcpPPchRzqUJb3rESfNvZcEn7d
        32pMAJTs2oGhWnGtrYIO18Rj/A==
X-Google-Smtp-Source: ABdhPJzykmnUgpGISjR0uJmq5XnV9TbmCLV1ND5n9szNrE2dQx1yoIxjQZbfSem/7JOoSNWsf/ciaw==
X-Received: by 2002:a05:6512:3054:: with SMTP id b20mr5102380lfb.375.1623084715624;
        Mon, 07 Jun 2021 09:51:55 -0700 (PDT)
Received: from localhost (h-62-63-236-217.A463.priv.bahnhof.se. [62.63.236.217])
        by smtp.gmail.com with ESMTPSA id x5sm1550665lfu.233.2021.06.07.09.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 09:51:55 -0700 (PDT)
Date:   Mon, 7 Jun 2021 18:51:54 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] serial: sh-sci: Remove unused STEPFN() macro
Message-ID: <YL5OqsVMxbHm2EWa@oden.dyn.berto.se>
References: <970387d104dea5bb7ea674bb89229641467e629b.1623076891.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <970387d104dea5bb7ea674bb89229641467e629b.1623076891.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Geert,

Thanks for your patch.

On 2021-06-07 16:43:45 +0200, Geert Uytterhoeven wrote:
> The last user of the STEPFN() macro was removed in commit
> d5cb1319a91d4f13 ("serial: sh-sci: Remove manual break debouncing").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/tty/serial/sh-sci.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 4baf1316ea729931..946c4bd920f48960 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -840,9 +840,6 @@ static void sci_transmit_chars(struct uart_port *port)
>  
>  }
>  
> -/* On SH3, SCIF may read end-of-break as a space->mark char */
> -#define STEPFN(c)  ({int __c = (c); (((__c-1)|(__c)) == -1); })
> -
>  static void sci_receive_chars(struct uart_port *port)
>  {
>  	struct tty_port *tport = &port->state->port;
> -- 
> 2.25.1
> 

-- 
Regards,
Niklas Söderlund
