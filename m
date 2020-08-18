Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47B1C433E1
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711ED2076E
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597739068;
	bh=lvoIx6zrtGarVXAFh0+hsNcvEEOGzgbtQEZQV2jEKKQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=uX0wg6Bkjj1OIEmyyhcZrhL2KQl729R1zxGxmrC8r/2IwAAHAVQwO0qPHmapHzpks
	 +ehl7jISlP7UnBHWco4uH0OlBWHLd7poiUo59s5M6gCu6868zvF9xPNu37l2Jj8bnq
	 JxCtpZlS4LAWWvh9r/d+bz/zwTH6fmyGR/P28UXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgHRIY2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:24:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46963 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRIY1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:24:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id t15so14524657edq.13;
        Tue, 18 Aug 2020 01:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WG22D/gwZ7xzs/C2AvkIzCxxa5fNF2uLuw1FILLARV8=;
        b=gTOa0Q7AyzdAfG2XeblskmxdJAPUKwf7K6gc+tadpCuXvEOhvEzt54eauQMcSVcuGE
         tm7fjmkojuDiMrF4KsEZtZgNhsTlxkTpLAicYkDuWnaH24g043MCkrWgm7g/LWZqFXt8
         YqGl00EvlpY033V5eBqTV/v/Wf+SKUZpi2yoACO+5lrJ8NAomUEeSAYS0g0DOguVXEj3
         OTdz/Q3LvMTdiX9JA5aME8fHAGtnSW+2RRXYFHQZEFnoss0fb67e+vlM1zXqvn+d19Wy
         23SD3Oo6AHRXlfKeHNVExhq5AC4IwxKfP0xkb+HqzoBJAx4TakOy6F2f0Y3FpkEGv4LC
         QWYQ==
X-Gm-Message-State: AOAM5310QAltC+12JO+PUPCTfqdu9ryFiLKA6eR7jDtzSaHldaGdi0xC
        K4moIIc8VwKqcLRrP5/isTJbMGfcM5k=
X-Google-Smtp-Source: ABdhPJz29GU6yDuS7iEntVoMeX2Yk00xshKe72YBZjf1eLG7m2SSRiqOYxhUKRBAqe9u8irh36qeZQ==
X-Received: by 2002:a05:6402:17c2:: with SMTP id s2mr18192711edy.188.1597739064422;
        Tue, 18 Aug 2020 01:24:24 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id v10sm15115731eda.87.2020.08.18.01.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 01:24:23 -0700 (PDT)
Subject: Re: [PATCH] n_gsm: Fix write handling for zero bytes written
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200817135454.28505-1-tony@atomide.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <1b8538a8-d8b6-4287-36e1-aa1e0863ff2d@kernel.org>
Date:   Tue, 18 Aug 2020 10:24:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817135454.28505-1-tony@atomide.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 17. 08. 20, 15:54, Tony Lindgren wrote:
> If write returns zero we currently end up removing the message
> from the queue. Instead of removing the message, we want to just
> break out of the loop just like we already do for error codes.

When exactly does the only writer (gsmld_output) return zero for
non-zero len parameter?

> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/n_gsm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -691,7 +691,8 @@ static void gsm_data_kick(struct gsm_mux *gsm, struct gsm_dlci *dlci)
>  			print_hex_dump_bytes("gsm_data_kick: ",
>  					     DUMP_PREFIX_OFFSET,
>  					     gsm->txframe, len);
> -		if (gsm->output(gsm, gsm->txframe, len) < 0)
> +
> +		if (gsm->output(gsm, gsm->txframe, len) <= 0)
>  			break;
>  		/* FIXME: Can eliminate one SOF in many more cases */
>  		gsm->tx_bytes -= msg->len;
> 

thanks,
-- 
js
