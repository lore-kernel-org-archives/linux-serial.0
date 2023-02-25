Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD29DC64EC7
	for <linux-serial@archiver.kernel.org>; Sat, 25 Feb 2023 17:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBYRwZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Feb 2023 12:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBYRwZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Feb 2023 12:52:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F5318B39
        for <linux-serial@vger.kernel.org>; Sat, 25 Feb 2023 09:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677347496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZfVA+6E0piJ9TsCzaJQSVioT3VsJtuol4xTkuWpyLRc=;
        b=SrO0ytFxnxLfJshIC6R/QOxnJUmo2pXF5O6kuS4l9K1jlaOnfVBrdq70C6y9RlhbgBJVJ2
        d4onrvk0Aw09PGEzjizSGB1IBjhc4zXQ3YU19A/xg8YeMyJ6tWnRInLPQXIHB9+iG/u4es
        T/1yx4z9H1oTTTh0xLXVn/dK6MSfceE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-246-Td2BTJTfNcC5ESEXZ6zBEA-1; Sat, 25 Feb 2023 12:51:34 -0500
X-MC-Unique: Td2BTJTfNcC5ESEXZ6zBEA-1
Received: by mail-qk1-f198.google.com with SMTP id ou5-20020a05620a620500b007423e532628so1421818qkn.5
        for <linux-serial@vger.kernel.org>; Sat, 25 Feb 2023 09:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfVA+6E0piJ9TsCzaJQSVioT3VsJtuol4xTkuWpyLRc=;
        b=ivGcfYLW8HB4iBJlBe8uuloQ4wzk2dbhqqO0Y+XfVh6rUM0ngZoQYKA/kp2dyh29Xi
         T1gKgQESpS1Cl7P18r4pngflp9eAl5hN5SLXV8c73E8vqpCXUyjAzj+hE21Q6c7814DN
         ifq/Xg1D43uZGfYRzBcF1x2N4vRPOilikvrzyjyFraqQYvN7ceqbmBYruylSnfKVhJLv
         jN6g6gMrfCj23BQN9ztWM0+gxLi68vKRFdnw5j43QUz0kJ1TacXdtyYApLYtY7c82rYd
         wTzdCatHnMKuGl7VLkcsBBIwrKk5THj0cl2X7SagcUKqlwR9Qgyzioik3n+1Lvi04p+o
         7oXA==
X-Gm-Message-State: AO0yUKW23/npDeKwFQs0zeakT720AKLuXjMJGwNkSGK1WvHcT1wdIQdt
        rJ5wikXAhgU+Xb5Tc8sJBlOEpmFhpq+qNHQVaFW3Sen4ap6EAcBxJLfO9jDVgtHNA6q6JiLe9O8
        o29a0fMzRqzrcJsJN/uqfOgwg
X-Received: by 2002:a05:622a:1742:b0:3b1:80ab:38e with SMTP id l2-20020a05622a174200b003b180ab038emr20877213qtk.0.1677347494370;
        Sat, 25 Feb 2023 09:51:34 -0800 (PST)
X-Google-Smtp-Source: AK7set+JQCZVRSS/enJBur9zp7QKou+WPTT363tZdGgTCF+Ql5Z1/szT76071uTjVXXy8ypLn+aQsQ==
X-Received: by 2002:a05:622a:1742:b0:3b1:80ab:38e with SMTP id l2-20020a05622a174200b003b180ab038emr20877196qtk.0.1677347494108;
        Sat, 25 Feb 2023 09:51:34 -0800 (PST)
Received: from [192.168.1.19] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id g3-20020ac84803000000b003be56bdd3b1sm1582499qtq.92.2023.02.25.09.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 09:51:32 -0800 (PST)
Subject: Re: [PATCH] tty: serial: fsl_lpuart: select SERIAL_FSL_LPUART for
 SERIAL_FSL_LPUART_CONSOLE
To:     Randy Dunlap <rdunlap@infradead.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230225173949.651311-1-trix@redhat.com>
 <0f8a8857-5e18-e49a-0361-197b4bc892ab@infradead.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <026ee207-3b90-c7ae-a7fd-66a34cd3ee90@redhat.com>
Date:   Sat, 25 Feb 2023 09:51:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0f8a8857-5e18-e49a-0361-197b4bc892ab@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 2/25/23 9:46 AM, Randy Dunlap wrote:
> Hi--
>
> On 2/25/23 09:39, Tom Rix wrote:
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
>> Signed-off-by: Tom Rix <trix@redhat.com>
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
> Most other _CONSOLE Kconfig have:
>
> 	depends on SERIAL_FSL_LPUART=y

commit 5779a072c248db7a40cfd0f5ea958097fd1d9a30 removed the =y. so it 
could be built as a module.

Tom

>
> e.g.
>
> but I noticed a few others with a similar problem.
>
>>   	select SERIAL_CORE_CONSOLE
>>   	select SERIAL_EARLYCON
>>   	help

