Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C01C05027
	for <linux-serial@archiver.kernel.org>; Mon, 20 Feb 2023 07:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjBTHsq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Feb 2023 02:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBTHsp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Feb 2023 02:48:45 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1415AD0A
        for <linux-serial@vger.kernel.org>; Sun, 19 Feb 2023 23:48:42 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ec43so537118edb.8
        for <linux-serial@vger.kernel.org>; Sun, 19 Feb 2023 23:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ABMMf1qjvMawq2HDu1XvrGhqDlAoQW2kAxqzPOhWN70=;
        b=XEfAD/9vrYpksdZ/7k0mU/7o4jyso+kiadF6VgGI07ymu1JdOF4amZvlbdB52vyYg/
         yAfRhzg8IQmItpbj2RfsqxakT7o3DCHqDl2nP3vyHkK3BVm+9cPOPtOoLu5hc57nR5kw
         loiPx0vHTJPQeP4JCRofZFOjVGbzEKGBMzAu1XQbYqyg+iG5DYlMkvj1srlcsd8UCaZX
         VE5rvY7qJFZ7EyWCcVRZCfKGzwXph2MSJ9EFezmSJ4qlq7uzjJxHyl0lwNqwLPD21TDe
         dP/MlxFYI7ZBT04azWKvPR6AuJCLiSOmGvlHJEjkygiTUhGrBSsybp19bHL6ROxsIw9V
         4KrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABMMf1qjvMawq2HDu1XvrGhqDlAoQW2kAxqzPOhWN70=;
        b=nJ0o2c3mRfVAeIHYVmyH/RBIwtwjFgkE2ahXsYLlNhcFFfJ7xIpwQ+1nf6yZVLOk6W
         wLosfJZUIWxGt99DxNg6oKOC+Fe1ogLLtAnIrIYihI+Qn6WfQwh4tyo2CGeD4r1ZLVNd
         iGY1uaa1XbGGEiADRLE/uNkFCvmYAkXqwCrS2t3jAzuMfLXU+vDcG0yeQo8kC9ZxzOmH
         LfqX06FCzWTTYFt8uBFT7lFKMyeA41Gkb1UbuyblGlmb7D1S5Kh2oOLmWVjHna+5PP4G
         pWZf2ivfIz9D+T932tCnuhHtf2mz1Ai+AMXtGA2oiJCaoPhbJ5doeM32UaqEZ5W7Txu8
         JPkw==
X-Gm-Message-State: AO0yUKWPI7UUQ22TvQ02MzlCHV2ztHBE73Z0HBgdfTxe5dJE1pHzIQl4
        /xwvwyehCFnEF8FRqDMFjUW1AQ==
X-Google-Smtp-Source: AK7set+JgHIgqiCblF/8oLRBKMlqy32x4NIvnlJuOjKK+tQO7fwpnnxBqoC0pQVYGxSW+33FwGalXA==
X-Received: by 2002:a17:906:ef8c:b0:8b1:806b:7dbb with SMTP id ze12-20020a170906ef8c00b008b1806b7dbbmr10318241ejb.51.1676879321478;
        Sun, 19 Feb 2023 23:48:41 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a8-20020a170906274800b0085fc3dec567sm5464560ejd.175.2023.02.19.23.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Feb 2023 23:48:40 -0800 (PST)
Message-ID: <715e59a9-af84-9ec0-7d0f-d323b7f068df@linaro.org>
Date:   Mon, 20 Feb 2023 08:48:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] dt-bindings: serial: imx: Document mandatory clock
 properties
To:     Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
References: <20230219142250.10176-1-marex@denx.de>
 <20230219142250.10176-2-marex@denx.de>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230219142250.10176-2-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 19/02/2023 15:22, Marek Vasut wrote:
> The UART IP must be connected to clock, document the properties in DT bindings.
> Update example to match Linux arch/arm/boot/dts/imx51.dtsi .
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

