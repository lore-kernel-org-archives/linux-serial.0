Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBEFC43217
	for <linux-serial@archiver.kernel.org>; Mon, 21 Nov 2022 10:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiKUKJ5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Nov 2022 05:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiKUKJv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Nov 2022 05:09:51 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC75EFAED
        for <linux-serial@vger.kernel.org>; Mon, 21 Nov 2022 02:09:48 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id r12so18109546lfp.1
        for <linux-serial@vger.kernel.org>; Mon, 21 Nov 2022 02:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i3YXumFsPw6lbI2IHMtFObomGfN5gHhNwcdgLP+EhJk=;
        b=jMQDqklr6GJhwiLPT9kPQTPmexECun/4HMUGVLBEqBvYISI8XEuWKkoKtj+dKN2kW8
         LnyRPehM4XhFvmvIv7o8L1T7/0ugBPOT9oMyWvlsqngtdLPsdhc4DftPtJVqPwZ3ajMF
         zB5BQky4xx8qaU/c7Wuq25mcd7cAeoJdiEwFZ1lptGOkknfifq8ztal99bBbiWwkWfeM
         5wjxp2czMpvgnJavWNh1b6EWfwNwQ9tncKAkyrzSefAaBJDi9YSwOtA9aR826sp/4z67
         iIIsu0EgU2jqZF5JijtlmtYruvIVVwTIl2+CscNbK7DLfXToq2+9aMY/qiUQ8lg2sfEx
         hQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3YXumFsPw6lbI2IHMtFObomGfN5gHhNwcdgLP+EhJk=;
        b=sQk6jY/L7x9ZEF2Glq+YUabrlainArE0AvrolV5NvVggBJXY/N9o+Tx+P2+zBrAGey
         54/MaVwrxIvU+hUCeE9IedBHgrDjnE2ns+iK+GAh9EEmS9cGdnwJLK2hXGbZpZXN+3Zk
         Kot334vfRmJS+RSZf8PRlT3DXSbvnwGboiXH/H2j8kipvVCnY+h8Ql57FYUbVn9dfz5J
         YrBtMjsKukigGUtu4Sg5sFAzdAZr8y+hwBgodWVLPyPUvzewRJ7g8ukpyDpuKfLR4dag
         6rRs+k/eZf6GvzXBSxaxugIi+sT+bmSAizxul2SxhsIh/xtnj/EzWj8HMoWgm2F6tktE
         A5jA==
X-Gm-Message-State: ANoB5pkjt7p5hqc6xsWddwQWafqXiCAm9LbcauCdr4vNj/21Q8fdxQEO
        8k1gDmlcbgONPSGkvvcy9inZTg==
X-Google-Smtp-Source: AA0mqf6DBfrEF5O0+Ktio6r059/CuVFDgOS3eqygqMtw5mUk3rI1/U6Kjd8+p/QbRjRwyx2S7laiMA==
X-Received: by 2002:ac2:5e2c:0:b0:4a2:243a:ef6e with SMTP id o12-20020ac25e2c000000b004a2243aef6emr942157lfg.454.1669025387158;
        Mon, 21 Nov 2022 02:09:47 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id be34-20020a056512252200b0049e9122bd1bsm1975586lfb.164.2022.11.21.02.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:09:46 -0800 (PST)
Message-ID: <9d287ce2-a826-5777-8d88-8e05e6924670@linaro.org>
Date:   Mon, 21 Nov 2022 11:09:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/7] riscv: dts: bouffalolab: add the bl808 SoC base
 device tree
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20221120082114.3030-1-jszhang@kernel.org>
 <20221120082114.3030-6-jszhang@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221120082114.3030-6-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 20/11/2022 09:21, Jisheng Zhang wrote:
> Add a baisc dtsi for the bouffalolab bl808 SoC.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/Makefile               |  1 +
>  arch/riscv/boot/dts/bouffalolab/bl808.dtsi | 74 ++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> 
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index ff174996cdfd..b525467152b2 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +subdir-y += bouffalolab

Nothing to build there, so not yet.


Best regards,
Krzysztof

