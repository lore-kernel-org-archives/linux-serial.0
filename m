Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A39C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 11 Jan 2021 10:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A630821744
	for <linux-serial@archiver.kernel.org>; Mon, 11 Jan 2021 10:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbhAKKAZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Jan 2021 05:00:25 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:40746 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbhAKKAZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Jan 2021 05:00:25 -0500
Received: by mail-ej1-f53.google.com with SMTP id x16so23809327ejj.7;
        Mon, 11 Jan 2021 02:00:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T8T/O0ZlTJGLCjZbDX0PD9JZEkqddMeqh2KTM2iKu8k=;
        b=ohT8YdtKk17FeFIR3YugMEE+o0rMNpoeCKtgp1L89IIHmX/h2jqSLhA05VD164kZwL
         s6e6zJjxZIFEISQb3bxM6F5FhMQYIjTerx5Ahm2KVd9y7Yf9hZ+PltDFtjygTCvAd/C6
         jDfOGnCLgva7uqenqhLXqUkJ9+CVt5x01ATWnz+Xb0XRDTnCpgVWY8425FEbE1w2BU16
         wQZW6p10/4/X/nJwquj0YMt+1HF/lepwo+yUnrqanDFglknkiWW+suF/pkmrRuYdXOB8
         J0OuIxzq8SW9m62obE6DdxGUqTtsGRhQ57Z1j+aYw2tsVjrDOR4JmG32xDiuIDgcD24a
         MFIg==
X-Gm-Message-State: AOAM530c4rPrJM4VGJAY/PW8F6AuYh2RaFVxb8ZOcjVzxuFfhEcYwPaN
        WzIeCy8is5Z9kehmqaexf5g=
X-Google-Smtp-Source: ABdhPJznV8Dt+uZrNWIQOGNosnX8IcpJUXUdaTHl1pHDy/ueH99EE7egorYvLE83L8+vlNI0OoPEEQ==
X-Received: by 2002:a17:906:4c55:: with SMTP id d21mr10257637ejw.116.1610359183463;
        Mon, 11 Jan 2021 01:59:43 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id a6sm7483946edv.74.2021.01.11.01.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 01:59:42 -0800 (PST)
Subject: Re: [PATCH v2 4/8] serial: stm32: add author
To:     Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>
References: <20210106162203.28854-1-erwan.leray@foss.st.com>
 <20210106162203.28854-5-erwan.leray@foss.st.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <e1d17cb6-a057-f427-dc77-6be139d39624@kernel.org>
Date:   Mon, 11 Jan 2021 10:59:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210106162203.28854-5-erwan.leray@foss.st.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 06. 01. 21, 17:21, Erwan Le Ray wrote:
> Update email address add new author in authors list.

Parsing error :).

> Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
> 
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index 717a97759928..938d2c4aeaed 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -3,7 +3,8 @@
>    * Copyright (C) Maxime Coquelin 2015
>    * Copyright (C) STMicroelectronics SA 2017
>    * Authors:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
> - *	     Gerald Baeza <gerald.baeza@st.com>
> + *	     Gerald Baeza <gerald.baeza@foss.st.com>
> + *	     Erwan Le Ray <erwan.leray@foss.st.com>
>    *
>    * Inspired by st-asc.c from STMicroelectronics (c)
>    */
> 


-- 
js
suse labs
