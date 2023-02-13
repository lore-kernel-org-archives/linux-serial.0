Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC69DC636D4
	for <linux-serial@archiver.kernel.org>; Mon, 13 Feb 2023 08:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjBMIdi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Feb 2023 03:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBMIdh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Feb 2023 03:33:37 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955CCB44D
        for <linux-serial@vger.kernel.org>; Mon, 13 Feb 2023 00:33:32 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a2so11250824wrd.6
        for <linux-serial@vger.kernel.org>; Mon, 13 Feb 2023 00:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fEuMhDtTRyInCB0boBwGOOTw3vKK+wSd5q+B5cK43j0=;
        b=v/qvFBSOYuV+0xErSQhuo4flcS7Nd+4MGv4eNJpeljpVKcRVlO0ImzzeV4V4yRwQDF
         Rd00rcR87JGhvC2jqwzWH91C1SwN6pXaMmyOt87Q5Luc3G/DWsvu5KUm//tIV6xCUcuz
         EL+y1i9zIm03AVRkrsnatQgxoltZyzzhd8Wee8Z802osB5V2mbc2Zu6yAUaOQFf5tccs
         1nYkBvfv2jKY0oAS12RtHa1CXZvZpy1rD1csBDkRwiHvz39z+ODBf7r5GOL77JomYt6y
         Uv4P4qybjKyvFOPM/99NSJwtMnSlLQc1fhUeoOJY2nL05UXGYNQnbYYHJWpxcAaex/iz
         k6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fEuMhDtTRyInCB0boBwGOOTw3vKK+wSd5q+B5cK43j0=;
        b=wSR3ZwPVounpao0EpdpKLCe9f5B5qrB3gTYyuYCFOghg6lep0U7fOR56x6lqtPwWh5
         BNHPRBcyKIijpef/hVbwlF9Dwz8Hp8acLXlGA9X5DY7Q9OnsSPuR23mKb6myDJz7eDMt
         wy7ZHjsL/A0UL3q4UCsoEptEk9/Zwua6jD00XSYnACpjhLSKIkGFOG4d1cM6XJGRKSUl
         2VRvtHQNcSEiQSMWVwmwpai8EqXFG0SqthBPp/G0tc9uEVRoM7LMfIoLNwWH5QZnuZO9
         HNOPDtYJpeYRKueKYJo3mDdbsFjBtUQENdPXB43lR9qMpYCzteCYS/Z1qYG8BhpalVZk
         xs5Q==
X-Gm-Message-State: AO0yUKXzjKiy9ZcynN+6X0rVASnPcBmxWkU1lVsDLP0xmSKtZzY22Qrp
        bhjFCzYAGx9Scb7fcSsGj/r9Y3U7yQ+IJIeP
X-Google-Smtp-Source: AK7set82macE5tb15uEC+cZmeEexWQ0A9YHhP1uRG8SIw9kE96Oxcd3ctJpgCaP9KHVdVj108eHEZA==
X-Received: by 2002:adf:f34d:0:b0:2c5:3fcb:681e with SMTP id e13-20020adff34d000000b002c53fcb681emr10489748wrp.4.1676277211159;
        Mon, 13 Feb 2023 00:33:31 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d508c000000b002c55ec7f661sm568329wrt.5.2023.02.13.00.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 00:33:30 -0800 (PST)
Message-ID: <b59c8885-562d-f680-622e-3859bf7ff8db@linaro.org>
Date:   Mon, 13 Feb 2023 09:33:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/4] dt-bindings: aspeed: Add UART controller
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
 <20230210072643.2772-2-chiawei_wang@aspeedtech.com>
 <2d0d1866-95f9-942d-57e0-06a5ed17d35d@linaro.org>
In-Reply-To: <2d0d1866-95f9-942d-57e0-06a5ed17d35d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10/02/2023 10:12, Krzysztof Kozlowski wrote:
> On 10/02/2023 08:26, Chia-Wei Wang wrote:
>> Add dt-bindings for Aspeed UART controller.
> 
> Describe the hardware. What's the difference against existing Aspeed
> UART used everywhere?

I expect the answer here. You are adding duplicated driver and bindings
instead of merging with existing ones. That's common issue and
explanation "it is different" is not enough.

Best regards,
Krzysztof

