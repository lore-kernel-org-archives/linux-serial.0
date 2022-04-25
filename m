Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43276C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 25 Apr 2022 18:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244468AbiDYSmU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Apr 2022 14:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244458AbiDYSmT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Apr 2022 14:42:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E8546148
        for <linux-serial@vger.kernel.org>; Mon, 25 Apr 2022 11:39:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r13so31371329ejd.5
        for <linux-serial@vger.kernel.org>; Mon, 25 Apr 2022 11:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/xh4WXVTs7GMegefI7747tXqjfg2a1/ldWnws8bMyYY=;
        b=kk74G6qpFgDNWr9L2SkhCWE1MyrhKM2CNtoYhcY4E9QrXY5Mku35Xucbeh3Pv4JGC6
         l2xI+x+oPJA2EaOUqHHk3yPBC85VLT6Bp3zCyEiFw8kMBbVkxbYtWCDwEUHs+GrgCnBg
         YxHN6hWqvO2IHvyQpGUAjxt8YW1zm6sBPZoaQglXQi1XDQQUliPAM6WfmsnnacrxS5K2
         PQRM5mfT4eA5Zoo8R+whrtx1TSKrRQNxi21JGv93WvuXrstolyOCiQvt2MYSxeeYylsw
         obwbpq1kAWPcxyB84xiMS/DveHk7OIC5w0456b/Gm/agZdqOtBTLOe2ZWWCWpCss2o/L
         gVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/xh4WXVTs7GMegefI7747tXqjfg2a1/ldWnws8bMyYY=;
        b=mBsPYz5hl781vBVtLBHDoQb9F45x7PgGTh7NCvihqww+6oOp3CUmud+m32VSb1ekLO
         QiRWzaaaHfVY4UhJsa9655DismukESIGb+Z+oirrKFTCMBBPgVsb/uA8joVkmFjwrCe2
         JWEp9hesZZQ04GpNXvV9fnjwQBJuof2TjZq6YfZWHXW6bpXyKyyXsV5OiRZpplek9awV
         7P0yYSRW+Ncm4RtCoaWPA3iHUljfE4aJtMLEh69s3rvRkjCANR98NQ97T+eGCJH+r3sn
         Y9C3drKC9njthV5wUTfEEu2rTQcl39cLtn7tlK5eFNckJOPe6GFm3fxX/yMGDk74M9rh
         J0zQ==
X-Gm-Message-State: AOAM532wvV8QVlFsxIh001JDvf0ZZji5gDN9XyeN13eP2BnnRPOcGPDl
        sovl6bFDYrBYeSvaWLmVd1RVhw==
X-Google-Smtp-Source: ABdhPJybKgZ/h5Rgya0pjy4YBGuKkkNESez2u3qtnRopwPp1OGz7XLM3O8JlzUy9qMmIYSZOejlwLw==
X-Received: by 2002:a17:906:5597:b0:6ce:f3cc:14e8 with SMTP id y23-20020a170906559700b006cef3cc14e8mr17515737ejp.426.1650911953407;
        Mon, 25 Apr 2022 11:39:13 -0700 (PDT)
Received: from [192.168.0.244] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ot2-20020a170906ccc200b006ef9bb0d19bsm3890344ejb.71.2022.04.25.11.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 11:39:12 -0700 (PDT)
Message-ID: <1a2ad0ad-cdbc-4b84-7de8-761db0572058@linaro.org>
Date:   Mon, 25 Apr 2022 20:39:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: Add r8a779g0 CPG Core Clock
 Definitions
Content-Language: en-US
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        geert+renesas@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20220425064201.459633-1-yoshihiro.shimoda.uh@renesas.com>
 <20220425064201.459633-3-yoshihiro.shimoda.uh@renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220425064201.459633-3-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 25/04/2022 08:41, Yoshihiro Shimoda wrote:
> Add all Clock Pulse Generator Core Clock Outputs for the Renesas
> R-Car V4H (R8A779G0) SoC.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
