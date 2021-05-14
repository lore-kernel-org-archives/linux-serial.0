Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2DBC433B4
	for <linux-serial@archiver.kernel.org>; Fri, 14 May 2021 06:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD7A61183
	for <linux-serial@archiver.kernel.org>; Fri, 14 May 2021 06:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhENGxL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 May 2021 02:53:11 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:34777 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhENGxL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 May 2021 02:53:11 -0400
Received: by mail-ed1-f47.google.com with SMTP id l7so33599870edb.1;
        Thu, 13 May 2021 23:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dgfi7m6CEgAhvc7ZaK8fhbVwaLHprqVFXn+MIcMEgcQ=;
        b=Mg3fJejXwvvw7mQgXCoNYmBskB37t1uVotk75nLANryflaUiuEwqc9USsAa3gFnvvA
         AwmQj0iFrNzxcMgogF4sXucAIRc37DdOveCiAY5DxE1ei/a6XgQI8hlkstzAcLBXvN33
         0pn2hLXwRGJftBDW/rgX1F8xNs+6wnjpTBKkxOR73rbpsJDL8yWKxN7Ji3wcMqxZTPaA
         UfLCHrvXgKNsZvMNamHOxANXyZF26HPsy2BvAMjrx7qIlEjTxdrfpWxlDYXKt6SzlLG2
         LOZ9xeuXJL7RenF0yMNgmja1frltyJtSoX0JU/RgZeukWPrtiZftZYnuivUlr6G4P+B4
         yuXw==
X-Gm-Message-State: AOAM533v6FjGfBLQHR4JgdNdDnD/Dwuc+of+y/NAsuylzSCOTTdYN9jX
        SSfmZWn/dcNruzsXH4prKjV2jzbFTok=
X-Google-Smtp-Source: ABdhPJwSsm48aU7FhrFdOBU9siS5Yfin6+5GcJFRxNBFT5HVzGOup9BJHgei8DrIf+j2AME++JK9Kw==
X-Received: by 2002:a05:6402:84b:: with SMTP id b11mr54391190edz.289.1620975118989;
        Thu, 13 May 2021 23:51:58 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id q18sm3915894edd.3.2021.05.13.23.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 23:51:58 -0700 (PDT)
Subject: Re: [PATCH] serial: kgdb_nmi: remove redundant initialization of
 variable c
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210513230224.138859-1-colin.king@canonical.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <ea469561-4103-4fd9-2c53-30d3e797e16d@kernel.org>
Date:   Fri, 14 May 2021 08:51:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210513230224.138859-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 14. 05. 21, 1:02, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable c is being initialized with a value that is never
> read, it is being updated later on. The assignment is redundant and
> can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/serial/kgdb_nmi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
> index db059b66438e..7e07ee915f3f 100644
> --- a/drivers/tty/serial/kgdb_nmi.c
> +++ b/drivers/tty/serial/kgdb_nmi.c
> @@ -115,7 +115,7 @@ static void kgdb_tty_recv(int ch)
>   static int kgdb_nmi_poll_one_knock(void)
>   {
>   	static int n;
> -	int c = -1;
> +	int c;
>   	const char *magic = kgdb_nmi_magic;
>   	size_t m = strlen(magic);
>   	bool printch = false;
> 


-- 
js
suse labs
