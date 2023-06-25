Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2772EB64DC
	for <linux-serial@archiver.kernel.org>; Sun, 25 Jun 2023 10:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjFYKRl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 25 Jun 2023 06:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjFYKRk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 25 Jun 2023 06:17:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F1FE40
        for <linux-serial@vger.kernel.org>; Sun, 25 Jun 2023 03:17:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-988b204ce5fso275946166b.3
        for <linux-serial@vger.kernel.org>; Sun, 25 Jun 2023 03:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687688257; x=1690280257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oDxSibctoUXEH8FbhaW344l8fagqf+fw0uwilWaxAWw=;
        b=tz7Kt4Yc8ENCU95r/WVdJnYhWhiuAK8cY97qf2dl2pKKH9rC2MBRBZm2ewM/MCYLuN
         e9ET4YzOaMmrH+CtFmzX8i9sg7NvdHC6WfMZBFsL+Iisom5d4BGUytjPRCzDoyA4OHiC
         Y4rzPnjoYrSmM8oreWsPXTQI/iRlbNW3Mhs2aDP7m/Lzz0+7e5y3fmC7uwgY5Ym2qrBg
         bRzJWN9YY00V/OM7HJWzDpIdLwEdjXkCvDAtByA4clCUhUy6xvvEjW7csf/jmUrlU9Z9
         s+lH7+cDX6PB0bJrAx//0QpciBa4oqyy3GvwNgfyD08jFS8G+JztwVyL/qSy+epv9LAY
         0OAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687688257; x=1690280257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDxSibctoUXEH8FbhaW344l8fagqf+fw0uwilWaxAWw=;
        b=QClpGl3G488OcbghN2zSCjNtMWMVQcYx1ytpUbFPU9xM5THJMYd5Jp7iaxHuk5rwxB
         reEjUl74XZeppX0jS15fyrgqxu31jfG19wxeHnRJYyT0L8vwVJFl8PT/qDeGNJSe6abR
         ARtUL1mxMS0WkT+HAPYED4r+18ZlZ5bZM5HLty/8OeqFZak8a9edXyCPmOV4EE+cqnhc
         KC7Wo3IhNiy1TnXt9oLVTwAYu0vfbdm9C7jl0B9pyEGcAoEb8XkI2Cgpp4Navh9acpJ1
         oJy8K024CzQnK7Umb9MC7yqTR4sOpubHS8TuV1NOMbqWuGQ0gbpIipQJ1yjaApqwCsOh
         NGIw==
X-Gm-Message-State: AC+VfDyw3LHIPYb29nN0CDMPo7sCPaYgPK7nANlgDt03JBnugkBkylQN
        9iOFIGYog2dlmeQWsCt2kE04xA==
X-Google-Smtp-Source: ACHHUZ4LXduPHHt4DY5Lepb/cVmP4JxhlW6ONoMHpdxwOAmHFauWhKUSGJR7XfTA7B3mPHoSEflrIQ==
X-Received: by 2002:a17:906:4793:b0:974:32e:7de9 with SMTP id cw19-20020a170906479300b00974032e7de9mr23972957ejc.56.1687688256703;
        Sun, 25 Jun 2023 03:17:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id br7-20020a170906d14700b009893b06e9e3sm1922040ejb.225.2023.06.25.03.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 03:17:36 -0700 (PDT)
Message-ID: <d990a281-b4a3-1e26-1fdf-dfd35ab9cd24@linaro.org>
Date:   Sun, 25 Jun 2023 12:17:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] dt-bindings: serial: fsl-lpuart: add imx8ulp
 compatible string
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        shenwei.wang@nxp.com, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
References: <20230625094857.29644-1-sherry.sun@nxp.com>
 <20230625094857.29644-5-sherry.sun@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230625094857.29644-5-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 25/06/2023 11:48, Sherry Sun wrote:
> LPUART driver adds a new compatible string for imx8ulp, and imx93 is

What driver adds or not, is not really correct argument for
compatibility. There are plenty of compatible devices which have both
device ID entries in the driver. Why would you drop their compatibility
between each other? It does not work like that... Provide clear
rationale for this.

> much more compatible with imx8ulp than imx7ulp, so correct the
> dt-binding here.
> 

"Much more compatible" is too vague.


Best regards,
Krzysztof

