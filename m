Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95352C761A6
	for <linux-serial@archiver.kernel.org>; Wed, 29 Mar 2023 08:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjC2IWD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Mar 2023 04:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjC2IVh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Mar 2023 04:21:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDC1558E
        for <linux-serial@vger.kernel.org>; Wed, 29 Mar 2023 01:20:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bi9so19071110lfb.12
        for <linux-serial@vger.kernel.org>; Wed, 29 Mar 2023 01:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680078035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDEZImdx7nfwOHvp4OeGgm65ZkjVGi5Ql4SNtee6RD8=;
        b=sn4gtOWUAijsH+th7lILTt6mPbspY3c9QElMIqDJ8w3lVNCEs7Z8zi7FRabQEgkl0R
         xsUPvxtPaRoTdwlDw2+Wbs18WSysCU1xw2BtKpNRc8aImg6OmF9YeDVtnrTng+il4QC7
         c+W8lcBWrVnbIACihneyKtboYiiZm+giGZvSjQWjzzezAYR/XWRE+9iuvtKDE6VSrx7H
         EYQWV0Cfsp+wk/a9G0TPZC1kuuiiGYKsi7NRZvm/6BD4FMZ9DkCf1dZ1tyqzZqXD/oA+
         H6jfIWUkcJ68guazfBLNJUZheyVtLrC9gi0VF4QF5XwySB0J48ABf4zebiw4L1yRtAwk
         NVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680078035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDEZImdx7nfwOHvp4OeGgm65ZkjVGi5Ql4SNtee6RD8=;
        b=HJi28mNd8YniPrpPN1lFjaSNt4nfsKpaC463vBKNys/J0CBSPDspX9mhAkeJzXCZlc
         vHU/LIV3oWinsYORNpb73szC8FOSeXtuTa3sseqtqLIaI0FNXtXB+jRcZ6Sd/NmoKINc
         85gBPTqgewL8+CSvdaCR+XamUV68VTZqFMb7NoWSyjVe1TETJU6k6PK26GrQVMdwE8yw
         t8u4/YE154f3glOx0rd7zHVJdqPSVV5VNSJIX/+b+qvfO8ABhYqcHO8p/aBmtyakggJ0
         UjIathqsrQ8OIcI4nxC2W4g7kA7CjnUlLRXijh6u6CtU7bWAyRME5mPcVo/XyZjJK1X9
         hgvQ==
X-Gm-Message-State: AAQBX9cxhAoyfmJR1hc35SegSvXRwXYd+VBP0Ps+CNuRxmLFiZsZUqmE
        s+3up/H4HcGsRAav7rKnfIap4Q==
X-Google-Smtp-Source: AKy350YuQqZwb2YTBHv7l0OviW05o4Ewp7fcXR4dK/s6jfhETNu5ZQYcF4+AHDyPTfHKB74qAi3nTQ==
X-Received: by 2002:a19:c206:0:b0:4ea:f632:474f with SMTP id l6-20020a19c206000000b004eaf632474fmr4916464lfc.40.1680078035478;
        Wed, 29 Mar 2023 01:20:35 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j12-20020a19f50c000000b004b40c1f1c70sm5391002lfb.212.2023.03.29.01.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:20:35 -0700 (PDT)
Message-ID: <be0bf335-39fc-2eac-ed37-112881bac675@linaro.org>
Date:   Wed, 29 Mar 2023 10:20:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 07/12] dt-bindings: serial: Document ma35d1 uart
 controller
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-8-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328021912.177301-8-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 28/03/2023 04:19, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add documentation to describe nuvoton ma35d1 uart driver bindings.
> 

This depends on clock patches, so it must be taken together.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

