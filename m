Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93CFC001E0
	for <linux-serial@archiver.kernel.org>; Mon, 14 Aug 2023 06:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjHNG7G (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Aug 2023 02:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjHNG6j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Aug 2023 02:58:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AE4E65
        for <linux-serial@vger.kernel.org>; Sun, 13 Aug 2023 23:58:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-525597d891fso1404476a12.3
        for <linux-serial@vger.kernel.org>; Sun, 13 Aug 2023 23:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691996317; x=1692601117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fC9uTjaIAJ5FjIaqRIZtFBZkLO2XpgWA4xpYOOTE2qk=;
        b=cMkdSpxCMvVPajP4PIy88jdv8ncvtVYL4/+ff0B+5ffKoxi3CaejoPppwJ+TrGEoru
         uUpKWR45EoM4qP251Dwx6DgfdWD4C03lFAB35yKKJgLUsxVxEZchtbzJSeCkAn2aD/Il
         TP8bis/HXGg/Qqak0Mk7cfmk1AWXXV5nuvtvDLtS9RC+IBYAPd9irNHbNmvXxqFwMVek
         DHsE/6ecoJwzHAFTxnHHclHayzo3gvlR8MuWHJPP5uduhGW0a9Ejdb6OrCs6PYKxm83A
         hL51IzmZDT/ekqvYLCEtej/JBOBtjkEbjtp1N7A1bAKBAWs26bHSaoTqG2nal+CNnPIE
         axvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691996317; x=1692601117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fC9uTjaIAJ5FjIaqRIZtFBZkLO2XpgWA4xpYOOTE2qk=;
        b=DLMfgvBCHtGp/lx1h85w5+CVLTsVyclFJic0tUZWEDF/ywlApGmwd9l5u58HkLZ9yE
         O1zz6kq4G3/sJxoOUKO4NtAt8wxHGSRLvg+kw0Y1Q6cJQPYy1DvP1sDTD9px09eR9mLP
         o5oe7eBqRuxgkJQ+B10sIuhfJZ7va1/GeQHUyruMsuXIW+CQN1ID6UdrDDW8c4DlxYhw
         d+dTCxmFLBQkXBlEYIa9f7RJSvorRXmg4WtA/L8BhLmvzxVxqAW1cLNJz1W5BcDukzWt
         P5jI0puL+Qj/tNAZaLrpwSgRdLu43I56zP/XxZBngCa7ThfA7qi3dQZLAMFcGCYcI/ue
         iPMw==
X-Gm-Message-State: AOJu0Yz/OBF0Qn9XQuA5j/zkQPdJVCffXgibTYm8jmBrodbUb2aERz6z
        QQrgRwVzsVeanoK3BZasr2XM0g==
X-Google-Smtp-Source: AGHT+IFdIjWhw+ZlarVW/WzN/jbxn2nY95E8dloTVuccAnbzjSG1NMzfG42cKrTjSIxJgaiEyeyWUw==
X-Received: by 2002:a17:906:76d3:b0:99b:4fff:6bb with SMTP id q19-20020a17090676d300b0099b4fff06bbmr7626704ejn.4.1691996316874;
        Sun, 13 Aug 2023 23:58:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090655c600b0098748422178sm5322389ejp.56.2023.08.13.23.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 23:58:36 -0700 (PDT)
Message-ID: <66cbafc5-f490-511c-df9b-02c2e5e40811@linaro.org>
Date:   Mon, 14 Aug 2023 08:58:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] serial: mxs-uart: fix Wvoid-pointer-to-enum-cast warning
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Andi Shyti <andi.shyti@kernel.org>
References: <20230810085042.39252-1-krzysztof.kozlowski@linaro.org>
 <2023081004-lapped-handbag-0324@gregkh>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2023081004-lapped-handbag-0324@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10/08/2023 17:44, Greg Kroah-Hartman wrote:
> On Thu, Aug 10, 2023 at 10:50:42AM +0200, Krzysztof Kozlowski wrote:
>> `devtype` is enum, thus cast of pointer on 64-bit compile test with W=1
>> causes:
>>
>>   mxs-auart.c:1598:15: error: cast to smaller integer type 'enum mxs_auart_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>>
>> Cc: Andi Shyti <andi.shyti@kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/tty/serial/mxs-auart.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
>> index 8eeecf8ad359..a9b32722b049 100644
>> --- a/drivers/tty/serial/mxs-auart.c
>> +++ b/drivers/tty/serial/mxs-auart.c
>> @@ -1595,7 +1595,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
>>  		return -EINVAL;
>>  	}
>>  
>> -	s->devtype = (enum mxs_auart_type)of_device_get_match_data(&pdev->dev);
>> +	s->devtype = (uintptr_t)of_device_get_match_data(&pdev->dev);
> 
> This feels like a compiler issue as devtype is a enum mxs_auart_type
> variable, so the cast shoudl be correct.

While the cast is obviously safe here, the warning in general is
reasonable - people were make too many mistakes by assuming pointers are
integers...

Just for the record (not saying that others doing is proof of correctness):

https://lore.kernel.org/lkml/20230809-cbl-1903-v1-1-df9d66a3ba3e@google.com/T/

But maybe Nathan can share his thoughts whether we should just disable
this warning for kernel?

> 
> And if not, unitptr_t isn't a valid kernel type, so that's not a good

It is in include/linux/types.h, so do you mean that it is not
recommended for in-kernel usage? I can go with kernel_ulong_t - which is
a kernel type - if the cast is agreed.

> solution either.  Worst case, it's how big a pointer is, which is not
> going to be what an enum is if you have a sane compiler :(


Best regards,
Krzysztof

