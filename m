Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F00C41535
	for <linux-serial@archiver.kernel.org>; Fri, 10 Nov 2023 18:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345758AbjKJS1P (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346097AbjKJS0H (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Nov 2023 13:26:07 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95ED446EA
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 09:31:21 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c39ad730aaso1991110b3a.0
        for <linux-serial@vger.kernel.org>; Fri, 10 Nov 2023 09:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1699637481; x=1700242281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnwW179nyTllOKG0D16X3B6vz95PczJo8nLjcbrxEZU=;
        b=bn272Y5JiOt/O02gW8mNR85H6jSjT3vEZgqRpIOQvdjawbNqUObezMJbK3bNvaiwKS
         gAwM0aBlex8aTKM1V7uU9FXYHJjw4gtu0QXc6AS8TWXKNf7/gqWg95HBbKhbvFQKMNm+
         b0lVDqaNx1PlcN0uosDAd/yhGTpsG13y/aOu/p5elwSh+TpRXMzuObtp0RuQ8QTHwbTn
         kwRj7N4hOae+XfgzdwIM5U2umj13VxAJQ4oMjGZuxAeSp3Osf+ap8QQIMhBjpqPEBxgq
         JpXb2d8Ms2jDnVOAUC+gTAclpMtFidzEGqdbEtVAeAS5RV0j56qAuDN/vKYf/YoUbIfV
         uk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699637481; x=1700242281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnwW179nyTllOKG0D16X3B6vz95PczJo8nLjcbrxEZU=;
        b=bfxRzIxjDsuIX75/XY+GPfBXKXmFur98y8PlmcoPtwV+bzAYvly9YgWRtI1WIMGrSC
         dyAQzv69vcCyrwSB3v3ZEWdL5XQ8o7PiZzR3xTzkTb6U2Ac1LblbskksyPRNwXahkDFZ
         1aauvzwRbfo1h3N3WEe7WJufQEPwR54kTbC3w1fNqiLLyUZeCLodlw7VEe/gFx1r34Fv
         Zxn82StifcFQQu73+1RCCV+e29a8Uq3r7h7T1Fc8VAO1fMwnbFClwFuYcG0dTpv/I2Eu
         vJ+XvAzrmKnrXtL3AjNtKGMIxXOjk5bOQOMQtwXdmyQRtmLtkxqE6wXaQnA/mMrvWCOQ
         E5ag==
X-Gm-Message-State: AOJu0YwWD4Ofqind+Sp5lwNussDX0/O11TBj/p3UF28cefwtcE3sQhd4
        51wyStWhTop8S+rWl+q9kmO0pg==
X-Google-Smtp-Source: AGHT+IFiAMSaqTolxOW1ag3pPDpxGq3qo4a1pcOE2s9npsdIWcyo8J+kunGA0rlXT5isrpxVTj+xew==
X-Received: by 2002:a05:6a21:2702:b0:17f:8f9f:14c2 with SMTP id rm2-20020a056a21270200b0017f8f9f14c2mr6512532pzb.27.1699637481277;
        Fri, 10 Nov 2023 09:31:21 -0800 (PST)
Received: from [10.46.15.71] ([156.39.10.100])
        by smtp.gmail.com with ESMTPSA id b10-20020a056a00114a00b0068bbd43a6e2sm13263773pfm.10.2023.11.10.09.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 09:31:20 -0800 (PST)
Message-ID: <bf3c7786-4b62-40d7-93c2-77665afe37ae@sifive.com>
Date:   Fri, 10 Nov 2023 09:31:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 39/52] serial: sifive: Convert to platform remove callback
 returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Nick Hu <nick.hu@sifive.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yangtao Li <frank.li@vivo.com>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
 <20231110152927.70601-40-u.kleine-koenig@pengutronix.de>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231110152927.70601-40-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2023-11-10 7:30 AM, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/sifive.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

