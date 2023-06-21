Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305D0EB64D8
	for <linux-serial@archiver.kernel.org>; Wed, 21 Jun 2023 08:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjFUITj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Jun 2023 04:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjFUITd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Jun 2023 04:19:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A116C1710;
        Wed, 21 Jun 2023 01:19:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3111cb3dda1so6478064f8f.0;
        Wed, 21 Jun 2023 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687335570; x=1689927570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sEBXGDM0wjJ/zM8cN1Vi9lb6f9acCG4RqU8UZ86rmj4=;
        b=DTyci+4wUuLtfGbgE84wRwhEvOziU1Wao2FJmFloY6rnODeSkLN5XpfMkCmEia3T45
         Huz4875RZiZXk6xlpTQL5pZ/IjiavW3OcKqBBxK9pNIFlMs1X0Cc5HInru0s8XVOC8Da
         QjBKMmmen2d04TAX+/XA+k3toFdYiOGJ2csXHNd/gB8MdAilb0ZkM/AhoUwfFoUIhP1G
         K/d5HY8WbOyKmSiS9WzMOdkUZ4rQUMaUXHPPSDGqUlZlPz90VslKGMpDZbkW0DcgZ2JJ
         wcorw47MEUvhxNOy0BM/iTY4SvIt/yC+5LfZcf5a90LMm7zvqX6xqegMMab8MZZtbpDa
         h+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687335570; x=1689927570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sEBXGDM0wjJ/zM8cN1Vi9lb6f9acCG4RqU8UZ86rmj4=;
        b=F7u1b6AGoGmco/Bo09J6jy73zYrGxuCfmR5awHCWSRHrSOplXbFZnWD6ZNs1JeprzJ
         3JIt86onSdpdPwNB/7W+4ZZwI4K5kYpcPIrfv7Q6a54GKAtCsK2l0V1ia9Hng83MKP6w
         YalFC5+HQ79Bk2F7L4frbhAA+0luhaeobwWlSLrFI8abMBgaCgbjbFHYG82/c4+jMgD5
         FuPAmj+oIvevoDmtZcRMknD47PAzSxcLqk/IMckWHpqcpqSpAANd8KOTRq+4TDmycaqi
         MUT4CD2pZH/zMDNduwfHShgsdHq0kQIr3Kg4Ic6BZ5++Lo8aGUrdufF3ewOuF4L4sL/O
         snsA==
X-Gm-Message-State: AC+VfDxmmcpeDU01+0FNcfxQHQ+CvMLW2RL8B5KnuKrwrDSutIZWL8G4
        pEh5ZDed1exOpGSMyqGn0c0=
X-Google-Smtp-Source: ACHHUZ5M7BXTEHiWE9RuAyvQEp+84nCPb4jokhVEDDaF7XfuotRquJtFamXQJlG0K906hxelDMnyVA==
X-Received: by 2002:a5d:4bc1:0:b0:310:ee6d:aa64 with SMTP id l1-20020a5d4bc1000000b00310ee6daa64mr13443808wrt.11.1687335569832;
        Wed, 21 Jun 2023 01:19:29 -0700 (PDT)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d58e4000000b00311299df211sm3814367wrd.77.2023.06.21.01.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 01:19:29 -0700 (PDT)
Message-ID: <c1133b79-d106-197d-640b-09c2024393ea@gmail.com>
Date:   Wed, 21 Jun 2023 10:19:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] serial: atmel: don't enable IRQs prematurely
Content-Language: fr
To:     Jiri Slaby <jirislaby@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Elen Song <elen.song@atmel.com>,
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
 <0876fda2-80ca-20f9-397d-6990e3f40e98@kernel.org>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <0876fda2-80ca-20f9-397d-6990e3f40e98@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Le 20/06/2023 à 06:50, Jiri Slaby a écrit :
> On 19. 06. 23, 13:47, Dan Carpenter wrote:
>> On Mon, Jun 19, 2023 at 02:44:11PM +0300, Dan Carpenter wrote:
>>> On Mon, Jun 19, 2023 at 01:01:49PM +0200, Jiri Slaby wrote:
>>>> On 19. 06. 23, 11:45, Dan Carpenter wrote:
>>>>> The atmel_complete_tx_dma() function disables IRQs at the start
>>>>> of the function by calling spin_lock_irqsave(&port->lock, flags);
>>>>> There is no need to disable them a second time using the
>>>>> spin_lock_irq() function and, in fact, doing so is a bug because
>>>>> it will enable IRQs prematurely when we call spin_unlock_irq().
>>>>>
>>>>> Just use spin_lock/unlock() instead without disabling or enabling
>>>>> IRQs.
>>
>> Maybe I should add a "a second time".
>>
>> "Just use spin_lock/unlock() instead without disabling or enabling
>> IRQs a second time."
> 
> No, I'm just stupid and I apparently fail to understand written text at
> times.
> 
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> 
> thanks,
Acked-by: Richard Genoud <richard.genoud@gmail.com>

Thanks !
