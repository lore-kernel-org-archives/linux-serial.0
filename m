Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FDEC76196
	for <linux-serial@archiver.kernel.org>; Tue, 11 Apr 2023 05:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjDKFsN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Apr 2023 01:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjDKFrt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Apr 2023 01:47:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D263C10
        for <linux-serial@vger.kernel.org>; Mon, 10 Apr 2023 22:47:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id jg21so17112813ejc.2
        for <linux-serial@vger.kernel.org>; Mon, 10 Apr 2023 22:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681192048;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FPSTEvA1ifnA/5RGYbPKGXrz8iL3NU8pq5huj3Csxpk=;
        b=Nh6EMI1/niHEAg8p5P9vKN6WLBSIq8QvUqdLO4i2ra+Awk7FSPXCr4c0sK4NjFTMuW
         yFIb8qSsHclNWh7/LnGcEHdLteW/njDWm+3Vbuhptzbqpz/Vbk7JQz0IFwc/5cW50kVo
         5IjimEMn97pyGMRbHgoaKdlXbuqRY1ju8XG/GbkUNrn49SeOIyBQA8p/rLTg0gkvr9kf
         aQBwJsyb9vzEtg4QxRZS1xeP9clqzoDue0pyNpMppx/ILC2TLp3zXiwCkCR96rpd+sqv
         RDyUmOqKwUNJiqbi0NKvCAJJNfXRuJ3lMvIsgg9jCX7D5yz9iU85gzAJ+rTisqlI5Ya3
         LrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681192048;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPSTEvA1ifnA/5RGYbPKGXrz8iL3NU8pq5huj3Csxpk=;
        b=YdpEEXAXJsB/SFP2pN4jMfrvA63fIJ1ogoxyL/9svRAdfmBynm9qQsFa7nc9w6llQh
         pGKKDsliKPl+irAf9v4yj+2NsaiqJRpQEnIW4w6nQM9cd5ScfkOoLVjVACsLAcTabGeK
         5Tpu+sSyb/zw3Mlqs+MDmo3AEt2y7tVq3qoIY47XZgOHq3euhMJGYlIk+UwBS+VHcQUt
         lDBwl7kU049oozlje+sX6lvkIOBjf/v+cQc2lGqzg0FhNJBgqEOFv2CGcMKglQ4hi9Wm
         +nG/ntlzqC6qzTGKXo2O3+wF8is1WwxG/a6L0Ojbf1TiX11625wLAZOlj9Eia+o2PGVr
         BSwQ==
X-Gm-Message-State: AAQBX9eZeRynh5yPo/4lE/Clj2s4tb9R8y1KmDR0acpwXHfGnzV4wqzw
        jT+GgLXVdIsH5szZZ9fdgLIWxg==
X-Google-Smtp-Source: AKy350Ze2IvxR1SdsI8p4QSbRcMerQCpJFSpsHupPSHWQnSu3X1qsk7l5wEW8sDOmhFk6Lqc1vgr7A==
X-Received: by 2002:a17:907:8c06:b0:934:286:f9 with SMTP id ta6-20020a1709078c0600b00934028600f9mr7749606ejc.27.1681192048068;
        Mon, 10 Apr 2023 22:47:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:dad2:72b7:3626:af61? ([2a02:810d:15c0:828:dad2:72b7:3626:af61])
        by smtp.gmail.com with ESMTPSA id o12-20020a1709064f8c00b0093f322187f0sm5739593eju.189.2023.04.10.22.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 22:47:27 -0700 (PDT)
Message-ID: <1560cfdd-1305-bf88-0235-1af452771d75@linaro.org>
Date:   Tue, 11 Apr 2023 07:47:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 3/6] dt-bindings: imx-thermal: add imx6sll and imx6ul
 compatible
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-imx@nxp.com, "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20230410205803.45853-1-stefan.wahren@i2se.com>
 <20230410205803.45853-4-stefan.wahren@i2se.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230410205803.45853-4-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10/04/2023 22:58, Stefan Wahren wrote:
> Currently the dtbs_check for imx6 generates warnings like this:
> 
> ['fsl,imx6sll-tempmon', 'fsl,imx6sx-tempmon'] is too long
> 
> So add them to the devicetree binding.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

