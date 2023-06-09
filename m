Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AA3C7EE29
	for <linux-serial@archiver.kernel.org>; Fri,  9 Jun 2023 11:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbjFILzL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Jun 2023 07:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239947AbjFILyw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Jun 2023 07:54:52 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F456420B
        for <linux-serial@vger.kernel.org>; Fri,  9 Jun 2023 04:54:30 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51494659d49so2887686a12.3
        for <linux-serial@vger.kernel.org>; Fri, 09 Jun 2023 04:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686311609; x=1688903609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hFLyNFdjW8q+t01Kpf1PQ/GPcGV/1xyWhVkZdWigx8Q=;
        b=P84n5OXIDE2oJV4pFMoCu86Pu6g9l83iWP+oBjcYzqOt4w0dgvH1Vx+7XepY21LFHE
         Xg3oJ7wnQfgo0RirnxhJx6TW90TYkyH6AGvHvivTGiMLi/B+iyhjW4f9yJW0pYBKy0os
         2idCU13J4k6Uxh4gErJwjA5KPORzBc4Jjv7RUUvMlLnkemwkDj8Y5td+AMfzJxqh5+v/
         oNDrWVbO1PC8d6MNDtpCVBHf4ySqkSH9pSdXYmq6go/yBkv1mcU/ET8rcmcAJy1NXUXc
         RiWFe9lPbg2xCS67V62jIBnQBxkIhT3dfE83y8d3MYDc84iwzxGXjVkai9P6JJNnL1k6
         CNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686311609; x=1688903609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFLyNFdjW8q+t01Kpf1PQ/GPcGV/1xyWhVkZdWigx8Q=;
        b=BOQXVOGSDFldHe+ka0zW5q2zEtwDSRBhUQV3rwrHL8p0s5ZKuR6nxY13TX8DhGn0oX
         HNuv5SgC6jLHFmHZBHM0W/lqZ/7mQFULRfjZ64Ns/YIWABUOhHBgsDRZA0ZAUWyH4nUQ
         kMN6pPG22EyaxCha2+6SGyuc5rfjLblL/X4OQwMzNoIrjkciYiYqJe8ojUkGQLMZgNsG
         KnlbutwRwhKjNK6iodyULBLKHdMKf4WJ37bw4IfXaBtSwH6/oZnYUX/TRzoUIszbV8je
         UEtpmHWhnERoFqsphUsaGFAO0zixwAkF5Wug4ovX0YUGPzl13CxV3Hqzk3UZrefktuEf
         vcWg==
X-Gm-Message-State: AC+VfDwXp25vBZnOPsGbZ1JZjp01xeZxsQ6uakWd1juH4p/tr+c1RZGv
        HDVUHFVDDQcvQOlfOtdOsJU6xQ==
X-Google-Smtp-Source: ACHHUZ4NZJ1Rx44rsznhdvEIYrZ5YDVyZDaKGvwoc5f2sIGzzVpBTv1xaoE4WfaUaNDrDmxPlcB9Dw==
X-Received: by 2002:a17:907:980d:b0:969:e9ec:9a0 with SMTP id ji13-20020a170907980d00b00969e9ec09a0mr1603279ejc.77.1686311608931;
        Fri, 09 Jun 2023 04:53:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090617c300b009788dfde0b2sm1222514eje.12.2023.06.09.04.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 04:53:28 -0700 (PDT)
Message-ID: <4d27c8ea-f5bd-704d-e8fc-823799854bb5@linaro.org>
Date:   Fri, 9 Jun 2023 13:53:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() when iterating clk
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
 <93bf8f574310256fcea50e5c5a62b5c37e20bb14.1686285892.git.christophe.jaillet@wanadoo.fr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <93bf8f574310256fcea50e5c5a62b5c37e20bb14.1686285892.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 09/06/2023 06:45, Christophe JAILLET wrote:
> When the best clk is searched, we iterate over all possible clk.
> 
> If we find a better match, the previous one, if any, needs to be freed.
> If a better match has already been found, we still need to free the new
> one, otherwise it leaks.
> 
> Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative. Review with care.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

