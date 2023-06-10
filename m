Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62189C7EE2F
	for <linux-serial@archiver.kernel.org>; Sat, 10 Jun 2023 17:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjFJRdH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 10 Jun 2023 13:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjFJRdG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 10 Jun 2023 13:33:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0753E35BC
        for <linux-serial@vger.kernel.org>; Sat, 10 Jun 2023 10:33:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51494659d49so4975010a12.3
        for <linux-serial@vger.kernel.org>; Sat, 10 Jun 2023 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686418380; x=1689010380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L4bnIpR9CgJpJzTmXfn0C/1nmTJ0UiQ90VgxrCtMoa4=;
        b=lXFuf4nVjc9DVvhKA87gweSooacUOZJK857m/2VVWgdNpiU1331/eee+BBLkVMbCQD
         HieERfMLCBE4pYvAs6VkEr2/GPABUcauccqZrvxz9AmSoGT1tqa+PvXeotdx320y0R5e
         NjchVIlrAChbtawzmBT1LTAC1qIaajxxwBXEe3eqxYFgAmn0xOUCtsAeMMFPNQc5x52Q
         3C12OIpYsR+7pl/p38Fn81GQw5QArvOg2ADA8q3oe5htS7k4XhPoQKOViMzXPbQ1Quy3
         fwLuT6IYqnvIetYm44TK1VStGmDVbHuWp8AmYb8LwS2Mf/pMAaun+diNfwusrdpgMnHk
         FEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686418380; x=1689010380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4bnIpR9CgJpJzTmXfn0C/1nmTJ0UiQ90VgxrCtMoa4=;
        b=KN8+BujDzL23M1UIysoTQlqqmJi2PDWmf0M26aAPhJYI2oMcc1bji/u1vAniiVgjQS
         ENTsBY3ZsHd1bqiVWb8YMMdOBDHz4jd/XyB7/hAtVQrU+4/cgthloYz77fyKHLoOYfpg
         +52n4tbCxUCxbN1lYPHLnwFilzv88kye4ANHTTtLgx2i+f392ZwG7ExI1+bObBvWaWBZ
         qgSsexMzFc5Z45o+BNBGYX9b5wQcwwr7+0pNY6THaql0oOy4EI6y8cpu8nJH7xPkkcaM
         h6AKjVH00ECHBNmzVtxGWd2+Ct7idco0IOl+FtTUhnuPahnNlWdDB+OX2X1khFWdzD2O
         VHyw==
X-Gm-Message-State: AC+VfDzoV/okImJjzzlUKEejWk4o75u2jupGbKybXlJ3wkHIvtiN+ohQ
        68LObSnDM8I3M/igVhBt/iVJjw==
X-Google-Smtp-Source: ACHHUZ5s9ZGmlGSKCjaP75e/iHcNsj70nZVM80Q/d9NXNiLFEfbrf0lDd3oBuKAPWKlPs+2PenADaQ==
X-Received: by 2002:a05:6402:546:b0:516:4107:7847 with SMTP id i6-20020a056402054600b0051641077847mr1600897edx.3.1686418380442;
        Sat, 10 Jun 2023 10:33:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g13-20020a056402114d00b0051830f22825sm587844edw.90.2023.06.10.10.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 10:33:00 -0700 (PDT)
Message-ID: <7a66ca20-0f79-6182-1f5c-1770e83b53a9@linaro.org>
Date:   Sat, 10 Jun 2023 19:32:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() in case of error
Content-Language: en-US
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
 <20230610102607.7nonyh5xhuhpyy6e@intel.intel>
 <58d3f250-499d-5a18-6798-f9833cc2dbbd@wanadoo.fr>
 <20230610145429.uvmxxgxc5tc6x5b5@intel.intel>
 <eb935f16-1f89-0be9-86c9-24e8a88c2d8b@linaro.org>
 <20230610171015.vf7emd5crpr7n4mg@intel.intel>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230610171015.vf7emd5crpr7n4mg@intel.intel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10/06/2023 19:10, Andi Shyti wrote:
> On Sat, Jun 10, 2023 at 06:23:58PM +0200, Krzysztof Kozlowski wrote:
>> On 10/06/2023 16:54, Andi Shyti wrote:
>>> On Sat, Jun 10, 2023 at 04:07:51PM +0200, Christophe JAILLET wrote:
>>>> Le 10/06/2023 à 12:26, Andi Shyti a écrit :
>>>>>> @@ -1459,8 +1459,10 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
>>>>>>   			continue;
>>>>>>   		rate = clk_get_rate(clk);
>>>>>> -		if (!rate)
>>>>>> +		if (!rate) {
>>>>>> +			clk_put(clk);
>>>>>>   			continue;
>>>>>
>>>>> could you also print an error here?
>>>>>
>>>>
>>>> Is:
>>>> 	dev_err(ourport->port.dev,
>>>> 		"Failed to get clock rate for %s.\n", clkname);
>>
>> Why do we need it? Most of other users of clk_get_rate() don't print.
> 
> that's not a reason not to print it.

This is the reason, because it was the conscious choice - not to print,
otherwise drivers are unreadable.

> 
>> Probably because such condition is highly unlikely if not impossible.
> 
> still... that's not a reason not to print it.

It is a reason not to print it in the driver. Code readability is more
important than adding error messages for every possible case in the driver.

> 
> All errors are unlikely and if it's unlikely, why there is no
> unlikely(!rate)? Which doesn't improve the reason not to print
> it.
> 
> The more unlikely, the lauder you need to be:
> 
> WARN_ON(!rate)... maybe too much!
> BUG_ON(!rate)... way too much!
> 
> But these are inversely proportional to the likeliness of the
> error.
> 
>> This makes simple function unnecessarily bigger...
> 
> and... that's not a reason not to print it :)

This is the reason not to print it in the driver, because it makes the
code less maintainable. Such unlikely errors should be handled by core,
not by every driver. If this error message here is reasonable, I would
argue that it is reasonable to add it to other places... try doing it.
You will see to what silly code it leads.

It's like adding dev_err to regmap_mmio read/write failures - code will
be difficult to read.

Best regards,
Krzysztof

