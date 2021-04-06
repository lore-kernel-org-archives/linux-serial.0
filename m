Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00B6C433ED
	for <linux-serial@archiver.kernel.org>; Tue,  6 Apr 2021 04:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D4E613B7
	for <linux-serial@archiver.kernel.org>; Tue,  6 Apr 2021 04:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242515AbhDFExZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Apr 2021 00:53:25 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:51779 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242526AbhDFExY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Apr 2021 00:53:24 -0400
Received: by mail-wm1-f54.google.com with SMTP id p19so6663766wmq.1;
        Mon, 05 Apr 2021 21:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pGjKyi8vekONRl3p6jIWrVsnQ3+iq1XbiLrvChgmELo=;
        b=FtQ0ZpPWm6dD6LjBBSPhw5VDhDZcPbqqIwej8IzxHkM4OOlQTfcIeoEqWcDFPIo8Jc
         NeQTkRJK/fbAz/FaaI8+xUiitJZCHc/NQeHTzNWC/JNtg3uWx9WNGirLFQpVAphEeqDT
         dFUgnMj1z3CRI0uGLtRbiMVEKPrjbB8WgBm/VBppgZbtLVtROsc2s03j++UJp0US+Dc2
         i/T7A7p3Bpa7BZEAZecGSYYnWc1vsu3mjGizFTjdU2j9F9fI6AqyrAheuzgWD5J7QegR
         S+t68piKvmwpHAFIWsFSceix3o5YEEnkywZ1R3OmHYT6oGcmq9VwnA0e4j4Uq4Ua2aXu
         pTyg==
X-Gm-Message-State: AOAM5321ARY6efRtCgUXXrV9XchsY8Gluw4u5u06gTn1O+sQZ4lE9bla
        4+wPQfTArrBKzurEkSBxdWw=
X-Google-Smtp-Source: ABdhPJwJtKMxlCBqJRzJpqR1Sz+pTP/UUONlWasdNasQFDX7nOzYNIASQhewwvtJG9Isw/e53Ppofg==
X-Received: by 2002:a1c:2683:: with SMTP id m125mr2187799wmm.178.1617684795821;
        Mon, 05 Apr 2021 21:53:15 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id h14sm36214686wrq.45.2021.04.05.21.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 21:53:15 -0700 (PDT)
Subject: Re: [PATCH -next] serial: 8250: Make symbol 'brcmuart_debugfs_root'
 static
To:     Zucheng Zheng <zhengzucheng@huawei.com>, alcooperx@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, hucool.lihua@huawei.com
References: <20210401074919.56573-1-zhengzucheng@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <7d91eb53-cde3-934c-a75f-833f98e6b156@kernel.org>
Date:   Tue, 6 Apr 2021 06:53:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210401074919.56573-1-zhengzucheng@huawei.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 01. 04. 21, 9:49, Zucheng Zheng wrote:
> symbol 'brcmuart_debugfs_root' is not used outside of 8250_bcm7271.c,
> so this commit marks it static.
> 
> Signed-off-by: Zucheng Zheng <zhengzucheng@huawei.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/serial/8250/8250_bcm7271.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
> index 63883185fccd..ebba7f2e960c 100644
> --- a/drivers/tty/serial/8250/8250_bcm7271.c
> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
> @@ -239,7 +239,7 @@ struct brcmuart_priv {
>   	u32		rx_abort;
>   };
>   
> -struct dentry *brcmuart_debugfs_root;
> +static struct dentry *brcmuart_debugfs_root;
>   
>   /*
>    * Register access routines
> 


-- 
js
