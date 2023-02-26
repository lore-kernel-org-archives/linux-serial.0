Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0255C6FA8E
	for <linux-serial@archiver.kernel.org>; Sun, 26 Feb 2023 16:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjBZQrM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 26 Feb 2023 11:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZQrL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 26 Feb 2023 11:47:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739D010A91
        for <linux-serial@vger.kernel.org>; Sun, 26 Feb 2023 08:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677429983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jXLwVOOJoGY+zkLl0eqln2qfNOxwPfkhKTYmBdbFnNw=;
        b=cgb/DqWVdKB4E1uJwgw0y+xtM4SUPhFci2iathEwlXDE9NG+8ni5JWwGBiUPsXRS5DA5YW
        y9mV2a5eVCJ718mShpSJB6HpaTdHI3Z8BeVgd2hiNuBWY/mKwAqQxjv/ZsFERVBMUVnr23
        /SUOmYZK6j6q+SaThy22zKIaErL9i9w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-9-teh7z93VPf2SdqT7FjVdeg-1; Sun, 26 Feb 2023 11:46:22 -0500
X-MC-Unique: teh7z93VPf2SdqT7FjVdeg-1
Received: by mail-qv1-f70.google.com with SMTP id pp11-20020a056214138b00b0056c228fa15cso2189948qvb.4
        for <linux-serial@vger.kernel.org>; Sun, 26 Feb 2023 08:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXLwVOOJoGY+zkLl0eqln2qfNOxwPfkhKTYmBdbFnNw=;
        b=6oe1DF64RxcFwFKxC3miFOHd/h/Iv1jFxVlWvtMIIu6kI+vUCmRQlgyvHS/5fOHB4w
         qUR+E53uNHE20W8yp/mH3LSqQk5AzjVlt7YCb90dgeCl0DuHwUuEaFyTL9DnDpDtGZYS
         f3Df8Nz8BhtFbEO5RJRvqbjVPSCoJ0Fz3wMrVtFtwLD+yvJDWd8Ed4gz5AF6QZrfMtcF
         DjXyGEXce1vH56xXS5qJ+nP6pf4eOPjx27igRpmBXSPyJIgJvCRwj8nJcs3vevpQKOfE
         CqeVEqKf1eR5lJ7aUVvSgNVccTDQgVKMmGIUvqaNGebm54fsPmpVpiGG9TFMdgmzMGnj
         nY/w==
X-Gm-Message-State: AO0yUKX1PWxAX++luLJojNxSJm7TwqlgKuFfgBH/nYtoqrjsp6W2DKUC
        +aXuMJLJRMnn7FCedktOZ8QY0f5fJ85nDFXkDzQbOANvObmILr6pGlKWDaI5PCJwW2JSkoQn901
        CcyuvgFftrSyroAbaP4HJMb34
X-Received: by 2002:a05:622a:188f:b0:3bf:c5a3:6143 with SMTP id v15-20020a05622a188f00b003bfc5a36143mr10305878qtc.27.1677429981671;
        Sun, 26 Feb 2023 08:46:21 -0800 (PST)
X-Google-Smtp-Source: AK7set+J5Y1FNkmeB9QKkGZZsIj5CJdqN6/C2lt1gadB8832cQWDxWWsqmqnYZQYvw1blhThgAO+1Q==
X-Received: by 2002:a05:622a:188f:b0:3bf:c5a3:6143 with SMTP id v15-20020a05622a188f00b003bfc5a36143mr10305863qtc.27.1677429981419;
        Sun, 26 Feb 2023 08:46:21 -0800 (PST)
Received: from [192.168.1.19] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id 186-20020a370ac3000000b0073b878e3f30sm3281701qkk.59.2023.02.26.08.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 08:46:20 -0800 (PST)
Subject: Re: [PATCH v2] tty: serial: fsl_lpuart: select SERIAL_FSL_LPUART for
 SERIAL_FSL_LPUART_CONSOLE
To:     Randy Dunlap <rdunlap@infradead.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jindong Yue <jindong.yue@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>
References: <20230226145441.3150640-1-trix@redhat.com>
 <89b8e519-7e93-6367-6cd1-efe6c0dced57@infradead.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6ad940b4-13c1-dcbb-daad-9ae4e0856434@redhat.com>
Date:   Sun, 26 Feb 2023 08:46:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <89b8e519-7e93-6367-6cd1-efe6c0dced57@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 2/26/23 7:44 AM, Randy Dunlap wrote:
> Hi Tom,
>
> [adding the recent commit signers]
>
> On 2/26/23 06:54, Tom Rix wrote:
>> A rand config causes this link error
>> ld: drivers/tty/serial/earlycon.o: in function `parse_options':
>> drivers/tty/serial/earlycon.c:99: undefined reference to `uart_parse_earlycon'
>>
>> The rand config has
>> CONFIG_SERIAL_CORE=m
>> CONFIG_SERIAL_EARLYCON=y
>> CONFIG_SERIAL_FSL_LPUART=m
>> CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
>>
>> SERIAL_FSL_LPUART should have been selected instead of depends on-ed.
>>
>> After applying the configs are
>> CONFIG_SERIAL_CORE=y
>> CONFIG_SERIAL_EARLYCON=y
>> CONFIG_SERIAL_FSL_LPUART=y
>> CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
> This works, but I thought that the point of the recent patch was to make the driver modular.
>
> You said:
> "commit 5779a072c248db7a40cfd0f5ea958097fd1d9a30 removed the =y. so it could be built as a module."
>
> That's not the same as what is happening here.

As you pointed out SERIAL_FSL_LPUART is not tristate so the it likely 
never worked to be modular.

Let me fiddle a bit with this and see, if it doesn't work, I'll submit 
the revert.

Tom

>
> I think it would be better to revert the commit mentioned above.
>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>> v2: Add how the configs changed to commit log
>> ---
>>   drivers/tty/serial/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index 625358f44419..b24d74d389fc 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -1313,7 +1313,7 @@ config SERIAL_FSL_LPUART
>>   
>>   config SERIAL_FSL_LPUART_CONSOLE
>>   	bool "Console on Freescale lpuart serial port"
>> -	depends on SERIAL_FSL_LPUART
>> +	select SERIAL_FSL_LPUART
>>   	select SERIAL_CORE_CONSOLE
>>   	select SERIAL_EARLYCON
>>   	help

