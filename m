Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D059DC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 21 Apr 2022 07:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386215AbiDUHyp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Apr 2022 03:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386198AbiDUHyi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Apr 2022 03:54:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEE2DFB3
        for <linux-serial@vger.kernel.org>; Thu, 21 Apr 2022 00:51:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b24so5397984edu.10
        for <linux-serial@vger.kernel.org>; Thu, 21 Apr 2022 00:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SWnz07/ydUSDSFIRmRvvVdm20TH0m+rczRpHxI08538=;
        b=EwmR9yCZo4NDwqX1l0iMzrveU/Y7tFFwuzOLGL9RkQEcE/JqAECh2XqEp+X6xDFHOM
         J93ZttPP4flslham+xT8xhDfXTRpBs4Ge6Z/+z2Eato/JTYarti7C18gbvR2LmPJkzFU
         Njsif7tDcPHSlzj45tlm6+WJVL/vJ7PLjSJyVBv9OQv+vJj+L2FGmVXa6jtYrwpVZLql
         LLdPsV6ew7J0SFu4Rufwt5c2xgM9OtfPZVPA510Db1HsKbCweuageDeNttTrm408QwjK
         SZw6Ob5MeReu3WT9tlX6s95I6HyIrUtml6ww/ImB+A+RCEEdBSfGx9+t5pUGwhAoBl6D
         2YCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SWnz07/ydUSDSFIRmRvvVdm20TH0m+rczRpHxI08538=;
        b=pZhbk5a58w+tZxrWBe/diHsDpBFmgSTwWx6MMte6DwJ82Sl2B4XNLBCbRBVLK4+x/j
         QuUUlVB/LmBrrJ437xoTPyF3QcPYZAqRh8fOBp9vuxXP9LfDrv/AwbQfRTfBk+0iuJEd
         lAY/BWZm9WcJMbR33PFKB1MbDPHC+euyUlen81MiI09w/qw9U1Bc/qygvliLoJII20cM
         Ik6FwueXtUUh4dp37oWdIosZYd4tpgWs803aFq765DhpDhZJrNkIkNyRKykarbMBwglc
         HF6fynTY0Y2lXgCWnRzbvJb/lbt4urHQkuGY0+pHIfAbtfqRVpdREWs6z8XvPRj8ImXi
         TW4w==
X-Gm-Message-State: AOAM532dOzfQvicL584Yk1mbVJLNbHZeHUgB5+QoWA2xOCls0tk29nf4
        Aa2/qSQVIMjPN6/ZYVOlZtlJSQ==
X-Google-Smtp-Source: ABdhPJwsgt7zi76Zv2CQz+yv0v/+CbVB1kMAgrzEXSk+VepEHFrCcVidOiNP5TKdoT+PQBEhuT3oBQ==
X-Received: by 2002:aa7:cac8:0:b0:410:cc6c:6512 with SMTP id l8-20020aa7cac8000000b00410cc6c6512mr27561204edt.408.1650527508001;
        Thu, 21 Apr 2022 00:51:48 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p22-20020aa7c4d6000000b004209e0deb3esm11099378edr.30.2022.04.21.00.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 00:51:47 -0700 (PDT)
Message-ID: <efd15268-d851-c9fc-fe07-0ff40c851746@linaro.org>
Date:   Thu, 21 Apr 2022 09:51:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 15/15] arm64: dts: renesas: Add Renesas White Hawk boards
 support
Content-Language: en-US
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        geert+renesas@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20220420084255.375700-1-yoshihiro.shimoda.uh@renesas.com>
 <20220420084255.375700-16-yoshihiro.shimoda.uh@renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220420084255.375700-16-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 20/04/2022 10:42, Yoshihiro Shimoda wrote:
> Initial support for the Renesas White Hawk CPU and BreakOut boards.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/Makefile          |  2 +
>  .../dts/renesas/r8a779g0-white-hawk-cpu.dtsi  | 45 +++++++++++++++++++
>  .../boot/dts/renesas/r8a779g0-white-hawk.dts  | 22 +++++++++
>  3 files changed, 69 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a779g0-white-hawk.dts
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
