Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835ECEB64D7
	for <linux-serial@archiver.kernel.org>; Tue, 20 Jun 2023 04:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjFTEuO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Jun 2023 00:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjFTEuJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Jun 2023 00:50:09 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF7A1703;
        Mon, 19 Jun 2023 21:50:05 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-519c0ad1223so5192299a12.0;
        Mon, 19 Jun 2023 21:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687236604; x=1689828604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXrEnEf5nkr5AbcNKuHq2ICQiTDBVe4q2pTx0g+a6jM=;
        b=SqRAs+dwwPvEWb/4/P5idGnp+jrP6QNVkQJ0KoNY4IQMemkJf7IhDx5TcxQZ4gwOfC
         aQM6l92sEK7Iw6psCed8CS7E5FzfHFyCdz9TZVxCrRlr3VS8zJuHXXRwI51sh1ypb23p
         H1iUU1IEQOQ3uzNXgzXOQyOL4qCFZfzVHZwa8f22gI1P+qGUVdEPOoI1IgpqeVmIx8pr
         fIRTD4qBmsu2sQP2ELzCupl61DBaOrmkXMiz5FY+DC2Wiaf4t+2cJ4G+PI95At7Zqhke
         FVoN2Cv/Me9W/3eLp7AAmsh9okbDlLT8MrV08bCQQpQGV3MxlOuNB3x42tmLOV47z02a
         yJXg==
X-Gm-Message-State: AC+VfDzFD02O/TQThrNm+s+CNC6w8UEol4MWMNIRZLLiagV470a0ZVkT
        f3sw52UDubqkdYMA85Un7M8=
X-Google-Smtp-Source: ACHHUZ5Mib/isIUgNNckhfTMVbDjnhcs0pitiRJRPJKaFYDUTHuICaA5xJxHkAH7SyCyhpEBuBkhyg==
X-Received: by 2002:a17:906:6a1e:b0:989:15b1:9989 with SMTP id qw30-20020a1709066a1e00b0098915b19989mr1017063ejc.68.1687236603783;
        Mon, 19 Jun 2023 21:50:03 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id a7-20020a17090680c700b009786c8249d6sm610631ejx.175.2023.06.19.21.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 21:50:03 -0700 (PDT)
Message-ID: <0876fda2-80ca-20f9-397d-6990e3f40e98@kernel.org>
Date:   Tue, 20 Jun 2023 06:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] serial: atmel: don't enable IRQs prematurely
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Elen Song <elen.song@atmel.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cb7c39a9-c004-4673-92e1-be4e34b85368@moroto.mountain>
 <d87d9f00-8d85-6220-43d3-51ef8e793193@kernel.org>
 <c0c661bb-2584-46cd-9c72-8f1d9ccbaee4@kadam.mountain>
 <0be8c2ad-499a-4cf1-af98-920af542c5b9@kadam.mountain>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <0be8c2ad-499a-4cf1-af98-920af542c5b9@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 19. 06. 23, 13:47, Dan Carpenter wrote:
> On Mon, Jun 19, 2023 at 02:44:11PM +0300, Dan Carpenter wrote:
>> On Mon, Jun 19, 2023 at 01:01:49PM +0200, Jiri Slaby wrote:
>>> On 19. 06. 23, 11:45, Dan Carpenter wrote:
>>>> The atmel_complete_tx_dma() function disables IRQs at the start
>>>> of the function by calling spin_lock_irqsave(&port->lock, flags);
>>>> There is no need to disable them a second time using the
>>>> spin_lock_irq() function and, in fact, doing so is a bug because
>>>> it will enable IRQs prematurely when we call spin_unlock_irq().
>>>>
>>>> Just use spin_lock/unlock() instead without disabling or enabling
>>>> IRQs.
> 
> Maybe I should add a "a second time".
> 
> "Just use spin_lock/unlock() instead without disabling or enabling
> IRQs a second time."

No, I'm just stupid and I apparently fail to understand written text at 
times.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs

