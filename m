Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B403FC77B7A
	for <linux-serial@archiver.kernel.org>; Thu, 18 May 2023 05:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjERFrW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 May 2023 01:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjERFrV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 May 2023 01:47:21 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD341719
        for <linux-serial@vger.kernel.org>; Wed, 17 May 2023 22:47:20 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-953343581a4so239419966b.3
        for <linux-serial@vger.kernel.org>; Wed, 17 May 2023 22:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684388838; x=1686980838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eRcxPv6i2LjuI0pmkTnJMMBCOEi56+JVbuNv0/EY6A=;
        b=SYKKGXuoHomSSQSZNFmDhoQaTpGEkOcE+eySyuwyQ3hEDBRX8F8w89XBteI4JSc1Qw
         wTts5iVa9tdzMwQUEmK2CQj1bZk9/snM+CrXfeFVDA2BVnHmHKgLH64iNNY7Ig7AY1l8
         Qs0uGM34gaYXAsD9Pn4VoJsB66/nyyg5MyqPzzPIV4S/UpyUTW+JrZjR4uyMXSloaFr6
         +h3/FuEjfLNtp57R2r0EgGL+ei/g1NqtPYvi3R7G4qWnv1N5RNkGmKRgoAQfNjq1EvE9
         EU1QL86ZsrtS14gEWF6jnvlQH8w7bJM1gX+PDfz7peJQGX7LhvpETafjU9X5NazbkZKc
         39Zg==
X-Gm-Message-State: AC+VfDxbIFfK17MCniUDsnGRpNlHmQqGq8xo61y5piqLsN/AK21eeOH3
        3SmhxvQ6FUuHydlVFiz0RSgWqfUHJoI=
X-Google-Smtp-Source: ACHHUZ59I3H6vUmV1k3rny1D7mM/VmSjzgyyobWhn5a5iNKfaVT+8oqh13OcdcYgyqKUF0ypB2Lmvw==
X-Received: by 2002:a17:906:7949:b0:969:ffcb:1eb4 with SMTP id l9-20020a170906794900b00969ffcb1eb4mr28875926ejo.2.1684388838321;
        Wed, 17 May 2023 22:47:18 -0700 (PDT)
Received: from [10.223.1.187] ([195.39.106.162])
        by smtp.gmail.com with ESMTPSA id b2-20020a170906660200b0096557203071sm481061ejp.217.2023.05.17.22.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 22:47:17 -0700 (PDT)
Message-ID: <0e159dd4-a693-8c8c-2810-f60eb3a7f74c@kernel.org>
Date:   Thu, 18 May 2023 07:47:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] serial: stm32: Ignore return value of
 uart_remove_one_port() in .remove()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20230512173810.131447-1-u.kleine-koenig@pengutronix.de>
 <20230512173810.131447-2-u.kleine-koenig@pengutronix.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230512173810.131447-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12. 05. 23, 19:38, Uwe Kleine-König wrote:
> Returning early from stm32_usart_serial_remove() results in a resource
> leak as several cleanup functions are not called. The driver core ignores
> the return value and there is no possibility to clean up later.
> 
> uart_remove_one_port() only returns non-zero if there is some
> inconsistency (i.e. stm32_usart_driver.state[port->line].uart_port == NULL).
> This should never happen, and even if it does it's a bad idea to exit
> early in the remove callback without cleaning up.
> 
> This prepares changing the prototype of struct platform_driver::remove to
> return void. See commit 5c5a7680e67b ("platform: Provide a remove callback
> that returns no value") for further details about this quest.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs

