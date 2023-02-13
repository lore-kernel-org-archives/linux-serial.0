Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE67C636D7
	for <linux-serial@archiver.kernel.org>; Mon, 13 Feb 2023 08:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBMIbg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Feb 2023 03:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjBMIbf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Feb 2023 03:31:35 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A56293EE
        for <linux-serial@vger.kernel.org>; Mon, 13 Feb 2023 00:31:34 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o15so7938434wrc.9
        for <linux-serial@vger.kernel.org>; Mon, 13 Feb 2023 00:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gz6xm7NoqnSOUARx/CNCDCfdeCI4cT5lZ/yhcZmlHMg=;
        b=U5aZIVwzZo8Q4S4+FGo8CVxrW/Nc6LBfif9lyHMNpX0bZmxYinkZwCqhJppeddapMX
         O+OzsuACDo7fqmYAu+ujfyuYvzxTpzWiwpRDYsH2dnwbfHQhFgQgQDYksm12D/iA7q7B
         LPwHBUVFJrWs0lUyDoAxVHMSkHPpL1XdJby8J9jBqwDs6osv6Qm+Htdv1UvMpe6IaoT7
         dHMxT2NpCisvKDRhpjjvb0Po3rTrDFAgsAUH2fkvRKTzk2SmPyX3nvGnjxKEi1oIxMPS
         Ll8B6MRsqpFqz3I4gkpc5SYDyebDBA1Xy4LzHoW/4M/zKKAUlMV2p6mxdxsQdp/ljV/D
         k28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gz6xm7NoqnSOUARx/CNCDCfdeCI4cT5lZ/yhcZmlHMg=;
        b=d/0h5X2v4S4YIJ5Txvk+Dr38skqtbWD43KlVw0KJ+s0pkqr8t+RuIpeus1uxbPEZl6
         1HxdCFm48NdavgVSLlezO7zZF/8p3EKbSkThLd+mYHUntiomY7rebnId431aakbqKOZk
         CKRUuiqDYLMXff5nLp6LOYi9+rEw+j8aAlE4+5NgIBBaTOyI5V2NOKB2cSovEbaJImxO
         gr1EzGrpfaxT1EXpIlyXyDcow3L67l9zk7lAm8mt/fNamle16dk0/HkgGqo4lBmj39IN
         jgUsp4zXqulLG9EgKOtEf4wkpOULBBiJvULx3Ng3uzLNITMmuo3o2NINoAf564HGygah
         seLw==
X-Gm-Message-State: AO0yUKVDsXAgDt+Rm07gxLW2plCgrJA9Umh3MYIzFV9Lf4LyPrd4PG1U
        M/2/BkwT979KlV/EPQMTpFFwiA==
X-Google-Smtp-Source: AK7set+N7x2GSsWP/iFk+wfnyxzr8inqcA6iJA/Kh83OJ6pl7nPyZAAMwrqzG83xPneO0KZeX6Egbw==
X-Received: by 2002:adf:ec83:0:b0:2c5:56f6:52ce with SMTP id z3-20020adfec83000000b002c556f652cemr3195215wrn.26.1676277092816;
        Mon, 13 Feb 2023 00:31:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h8-20020a5d5048000000b002c54d97b1ecsm5767203wrt.72.2023.02.13.00.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 00:31:32 -0800 (PST)
Message-ID: <ad200b06-368a-1f01-41e1-6b639d128186@linaro.org>
Date:   Mon, 13 Feb 2023 09:31:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/4] soc: aspeed: Add UART DMA support
Content-Language: en-US
To:     ChiaWei Wang <chiawei_wang@aspeedtech.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
 <20230210072643.2772-3-chiawei_wang@aspeedtech.com>
 <c1e096fa-5941-cdd8-2cdc-ecf04661a389@linaro.org>
 <KL1PR0601MB37818F70A166356FED0FEC9C91DD9@KL1PR0601MB3781.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <KL1PR0601MB37818F70A166356FED0FEC9C91DD9@KL1PR0601MB3781.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 13/02/2023 02:50, ChiaWei Wang wrote:
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Friday, February 10, 2023 5:14 PM
>>
>> On 10/02/2023 08:26, Chia-Wei Wang wrote:
>>> This driver provides DMA support for AST26xx UART and VUART devices.
>>> It is useful to offload CPU overhead while using UART/VUART for binary
>>> file transfer.
>>>
>>> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
>>> ---
>>>  drivers/soc/aspeed/Kconfig             |   9 +
>>>  drivers/soc/aspeed/Makefile            |   1 +
>>>  drivers/soc/aspeed/aspeed-udma.c       | 447
>> +++++++++++++++++++++++++
>>>  include/linux/soc/aspeed/aspeed-udma.h |  34 ++
>>
>> NAK.
>>
>> DMA drivers do not go to soc, but to dma subsystem.
> 
> The UDMA is dedicated only to UART use and is not fully fit to the DMAEngine subsystem.
> For example, the suspend/resume operations of common DMA engine are not supported.
> After observing certain existing DMA implementation in other soc folders, we put UDMA in the soc/aspeed as well.
> If it is not appropriate, should we integrate UDMA into the UART driver or try to make UDMA DMAEngine based?


You did not Cc dma folks, so how would I know... Maybe soc is right
place if the DMA driver is not suitable for other consumers than UART.
Maybe not.

Best regards,
Krzysztof

