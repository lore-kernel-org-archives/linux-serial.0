Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A209FC433F5
	for <linux-serial@archiver.kernel.org>; Mon,  7 Mar 2022 07:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbiCGHtp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Mar 2022 02:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiCGHto (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Mar 2022 02:49:44 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D64D32074
        for <linux-serial@vger.kernel.org>; Sun,  6 Mar 2022 23:48:50 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 890DB3F5FA
        for <linux-serial@vger.kernel.org>; Mon,  7 Mar 2022 07:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646639328;
        bh=NL82W9UcwLeLIZxdqDUqeSVzfk3euX+LYU1WgY6zZBY=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=NtshgHo3yu4DqpCEs7QR0mz7WIJ9Olnr0AWYcQCUh9/yZJT6EC39SGCW6nhY/l9Zd
         ZUTNlg1TlIEzcSp7Id3s9Tc7Z2yVV8pEtJJSVczwIM4Drw6BK2vWF1EPmYVplqdwLz
         e7TO7aSAdpLfKpRWhym+nXH4ZB0loDt3ofptsSD/trg5Gp0s/Qlu9BmmFHsKWDrjQk
         iSCnCmNPXT8keGRWvClvvbSlnhHj72rvYoLn3QzSi110iz6K+wrTPWBeYGrT7Ibo6b
         lzhbXCbbrCF7ijzARt37HoyIuogOk+DyWdf1tYm8oMN7bBmB5SGAs3o1gyLozjTJdr
         2FuZKZFQykYeg==
Received: by mail-ej1-f71.google.com with SMTP id q22-20020a1709064cd600b006db14922f93so670521ejt.7
        for <linux-serial@vger.kernel.org>; Sun, 06 Mar 2022 23:48:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NL82W9UcwLeLIZxdqDUqeSVzfk3euX+LYU1WgY6zZBY=;
        b=4L3qx3fGUmntSquDrMKtrEu4PAVPqRH3dk30bnR8EexwLw3d75e9+s6WaFS6uhwpiI
         BGQRQPz2Y9/45o5LijW1dlRX6P2zVJTgjLFEtE6f+1MPolJuVx9qDiR4V+VswFiqoB3t
         YHrd4pMDLATYjBOXffZtQskdyqLYDviwMoVv5V0hR8OL6SEDBXoOhE9ty2EtpablVx11
         sHturptc8+DEzEazXrtmS7MLGgjUjQPbIIBt8DU5gIbhMhtS1/cHRIhdC9zkRB4nGzcG
         Rw8Wda++90tn9sjQ5mNpCgUeZVlEB+Rof4pquTP7rkQLfQs9W31aA7uB60b/3uv/6JC4
         tbaA==
X-Gm-Message-State: AOAM532EWk1X6kpsMKxSVHkN3i2fnZTQyNSwEF1DXIfc1epy2L3F0TGr
        oPBHfq86NQ+Up2LchA2zIY+O+pQtIH9YCWz5StYvCptLi9G+97rhPCiEnUMKVSw4pFfv5iGLjnl
        LnBkf7dSRCnsOCD4AUbR9rr+5RdheXTk/ZVPbsBmTlQ==
X-Received: by 2002:a17:906:3748:b0:6db:3859:dca7 with SMTP id e8-20020a170906374800b006db3859dca7mr926529ejc.309.1646639328048;
        Sun, 06 Mar 2022 23:48:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmbeaf98JCz8PXhYFFfAm6gNhhUWExmMXo4RnKFzBbjb4e8QDroAu2DeDUG1UhXEKBwoQ4KA==
X-Received: by 2002:a17:906:3748:b0:6db:3859:dca7 with SMTP id e8-20020a170906374800b006db3859dca7mr926519ejc.309.1646639327844;
        Sun, 06 Mar 2022 23:48:47 -0800 (PST)
Received: from [192.168.0.140] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id b6-20020a50e386000000b00410d64cb3e4sm5978356edm.75.2022.03.06.23.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 23:48:47 -0800 (PST)
Message-ID: <df43dd5e-253c-3d16-2b18-0a0a2dedaadd@canonical.com>
Date:   Mon, 7 Mar 2022 08:48:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/7] tty: serial: samsung: constify
 s3c24xx_serial_drv_data
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
 <20220304080348.218581-3-krzysztof.kozlowski@canonical.com>
 <ba2a4504-b886-09b6-71ea-528c99a869f6@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <ba2a4504-b886-09b6-71ea-528c99a869f6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 07/03/2022 07:36, Jiri Slaby wrote:
> On 04. 03. 22, 9:03, Krzysztof Kozlowski wrote:
>> The driver data (struct s3c24xx_serial_drv_data) is only used to
>> initialize the driver properly and is not modified.  Make it const.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ...
>> @@ -2726,13 +2726,13 @@ static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
>>   		.ufcon		= S3C2410_UFCON_DEFAULT,
>>   	},
>>   };
>> -#define S3C6400_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c6400_serial_drv_data)
>> +#define S3C6400_SERIAL_DRV_DATA (&s3c6400_serial_drv_data)
>>   #else
>> -#define S3C6400_SERIAL_DRV_DATA (kernel_ulong_t)NULL
>> +#define S3C6400_SERIAL_DRV_DATA (NULL)
>>   #endif
>>   
>>   #ifdef CONFIG_CPU_S5PV210
>> -static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>> +static const struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>>   	.info = {
>>   		.name		= "Samsung S5PV210 UART",
>>   		.type		= TYPE_S3C6400,
>> @@ -2755,9 +2755,9 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>>   	},
>>   	.fifosize = { 256, 64, 16, 16 },
>>   };
>> -#define S5PV210_SERIAL_DRV_DATA ((kernel_ulong_t)&s5pv210_serial_drv_data)
>> +#define S5PV210_SERIAL_DRV_DATA (&s5pv210_serial_drv_data)
>>   #else
>> -#define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
>> +#define S5PV210_SERIAL_DRV_DATA	(NULL)
> 
> 
> All these changes are somehow irrelevant to the subject/to this patch. 
> Care to put them into a separate patch?
> 
> There is no need to put NULL into parentheses.

I wanted to make it consistent with the other, but indeed I can skip it.

> 
>> @@ -3062,7 +3062,6 @@ static int __init apple_s5l_early_console_setup(struct earlycon_device *device,
>>   OF_EARLYCON_DECLARE(s5l, "apple,s5l-uart", apple_s5l_early_console_setup);
>>   #endif
>>   
>> -MODULE_ALIAS("platform:samsung-uart");
> 
> This is as well a different change to what is claimed.

D'oh, this was not intended. Thanks for spotting it.


Best regards,
Krzysztof
