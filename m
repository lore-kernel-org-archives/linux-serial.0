Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605F6C6FD20
	for <linux-serial@archiver.kernel.org>; Wed,  8 Mar 2023 14:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjCHOaS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Mar 2023 09:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjCHOaG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Mar 2023 09:30:06 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35B784831
        for <linux-serial@vger.kernel.org>; Wed,  8 Mar 2023 06:29:25 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so1273207wmq.2
        for <linux-serial@vger.kernel.org>; Wed, 08 Mar 2023 06:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678285763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VJ89bgjwAq+pShFJM6RxMYNop2d8WVlgJ36rQMMJ4eM=;
        b=YdonUz4xOW0eFNZKwHudpDzlHIbOr45eQE0qUxNDxYp3f2t08zob05lymsOaXglaQ5
         7Mi8D/FA6hX7eu4klOL1vAErXGkEUhpEipjyOfRSFZcof2DJpaxRey5Fkz+scgd3RI1y
         hBepafmLgER0CegeNdhGr+F1MEQ18NYfhVBTCpIzviy6IEmTtzswrNGjdsgdUBp2FJXQ
         NtJFuoAp1BOu0CQz5/LSarMyI6YWKvhPJn8q3UvQEX1wxNIYtJi4ikTAO0l2Pqfly2Gh
         YmAFwtbXR5ox5w/YW3Gwc6BmkTLHIu5YYDbStjAzW2D7o8PhaTT1oIykQDCcGs/VH4o1
         pVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678285763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJ89bgjwAq+pShFJM6RxMYNop2d8WVlgJ36rQMMJ4eM=;
        b=bbUw0tXqGsn3uga5RZ/kE2LTnQgp8x/ry5MrRuq8RAIt6L2vCuW0XnYJ2ilPM0EwoA
         rGRNecSHaAYt1J04vpTyieTeubpqvTJcboxoG5nCYHqxqsy1i46t3HXp9oIaPDKGCbvk
         ziYrs7Jda2RLAvl7IdCXOhI00a47qxXIsb1riftiQHIlMVPeXS8qyQRXpTTK5QBNSorZ
         CqhGtm5kCuNXQID9lQcqQuxJP20sw9FoAMdjKLK2YiqVUjKWKeeK6O2f532/SwDWRpP3
         oDQWLuxAY/MP07s4BEYPcA9pZuPFRpMSY392izyQUWY9up2Du8QyBJ2FgEGYyeVnqGXo
         OECQ==
X-Gm-Message-State: AO0yUKWTn5wyYI1bLfnODgBm62ty17VSX9/hmz1G4gROA2R2s9yGGnjZ
        Czw3RxxihUsnnJHZ9p5YgQLWJw==
X-Google-Smtp-Source: AK7set+HAv5fmjg10kPMR7nSiF8/ZvozyEcaeqRI+z3ppiDYu2deL0rbHyTQZTm/HTLfpWTrq1mZ2A==
X-Received: by 2002:a05:600c:3b11:b0:3e5:4fb9:ea60 with SMTP id m17-20020a05600c3b1100b003e54fb9ea60mr13743367wms.9.1678285763151;
        Wed, 08 Mar 2023 06:29:23 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id e15-20020a5d594f000000b002c56046a3b5sm15411660wri.53.2023.03.08.06.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 06:29:22 -0800 (PST)
Message-ID: <6d5fa55a-c9cc-c1a3-3f60-33a99c8b91bc@linaro.org>
Date:   Wed, 8 Mar 2023 14:29:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/4] serial: qcom-geni: fix console shutdown hang
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230307164405.14218-1-johan+linaro@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230307164405.14218-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 07/03/2023 16:44, Johan Hovold wrote:
> This series fixes some of the fallout after a recent series adding
> support for DMA transfers to the Qualcomm geni serial driver.
> 
> Most importantly it fixes a hang during reboot when using a serial
> console and the getty is stopped during reboot.
> 
> Doug just posted an equivalent fix here:
> 
> 	https://lore.kernel.org/lkml/20230307073155.1.Iaab0159b8d268060a0e131ebb27125af4750ef99@changeid
> 
> but the commit message only mentions the regression with respect to
> kgdb, which is not as widely used serial consoles generally, so I
> figured I'd post my version for completeness.
> 
> Either version of that fix should address the immediate regression, but
> fixing the underlying problems which have been there since the driver
> was first merged is going to be a bit more involved.
> 
> The rest of the series fixes a few bugs in the new DMA support that I
> found while investigating the console regression.
> 
> Johan
> 
> 
> Johan Hovold (4):
>    serial: qcom-geni: fix console shutdown hang
>    serial: qcom-geni: fix DMA mapping leak on shutdown
>    serial: qcom-geni: fix mapping of empty DMA buffer
>    serial: qcom-geni: drop bogus uart_write_wakeup()
> 


Tested this series on RB5

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>



--srini
>   drivers/tty/serial/qcom_geni_serial.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
