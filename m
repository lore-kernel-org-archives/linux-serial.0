Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40CAC7EE31
	for <linux-serial@archiver.kernel.org>; Thu,  1 Jun 2023 10:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjFAKPT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Jun 2023 06:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjFAKOw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Jun 2023 06:14:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613D31BF
        for <linux-serial@vger.kernel.org>; Thu,  1 Jun 2023 03:12:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5149bdb59daso1008449a12.2
        for <linux-serial@vger.kernel.org>; Thu, 01 Jun 2023 03:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685614349; x=1688206349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lzBh9mt20nfbX1HPDV7qUtSParf3lregFrOcYZNJYTg=;
        b=RaRPkC6VX2Q/BjwDKUPe+k/HHA2K3PeWdWSAlQMRdEG/tnmTVrcItIo7UYOv/QMizh
         fXun4KbthwnGlMhHwbgtd1oo0pSD4tiWSV8j6L+PqAHjUoVQCnLEH1tSQLXECiMPP5v6
         bgZKjutzE6DvR4vNMNFNrJxz+V+Ag7u9SgM08zR4S7s0q2pXk03J6eaL6GcmetjkLuDG
         7xJkZdck6h+X2pSZdQWxMjsKNExIzpLdVou7k01rUwpL9J1GZ4IJHi0UJ8BEy/5/Bixs
         vM/7MUOZaU7XwYyyYoDTTz41nXYpYF8yiasDYOtkzXoJQisFzrA35rh9BfkblJBmsXhr
         6aFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614349; x=1688206349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzBh9mt20nfbX1HPDV7qUtSParf3lregFrOcYZNJYTg=;
        b=IO7XpqxhdCr1UZ8Mg54eHM7bsml/jTWuP18ZbBYHtgIrooEHYShSZXvPejgZCzRHLz
         OUGm0AbS5t1q9KrXbbUQ6KeArnbwrVLYDw5NtVwJ+Hn1KlDH0mwAdakeXhwf3nsTmqGB
         Hv15AhKS3tPcHwK9GaTzOKH7PrysyC7aWtBkQUZ95pltQpWoRQdb3qQ/ZWpNXa484aJy
         +x43LuQi0vcI6Zy+3zFwkeMvBlVe7f89YxXIf9I8milsSQlqdIQSy7GQEgi1QiLNuPmi
         ybexmfmW/huQTBovkb9Z0UfJNZaK91W+Ru3wPLOEjx7DhBkvp34/vq83e0LAvhvQJTc1
         0txA==
X-Gm-Message-State: AC+VfDwJgOpqtQf9w919g5R4zeTEvXcSn/XcZlvESLhjFz1ufOx6Sfw0
        AnyxsQ+f7zHQAAx9yRjlhBh4Vw==
X-Google-Smtp-Source: ACHHUZ6Nyi5zWDsnRjCwCJM1Qxx+HYhDiHldJG4dN+0BYNHIkTDm05bT22FK85uiKCYBn46fmDiSdQ==
X-Received: by 2002:aa7:c390:0:b0:514:9eae:b0a7 with SMTP id k16-20020aa7c390000000b005149eaeb0a7mr5187743edq.17.1685614348806;
        Thu, 01 Jun 2023 03:12:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id l18-20020aa7c3d2000000b0051499320435sm5620034edr.14.2023.06.01.03.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:12:28 -0700 (PDT)
Message-ID: <608f0c96-e01e-20e7-6227-1d2066223aac@linaro.org>
Date:   Thu, 1 Jun 2023 12:12:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] dt-bindings: serial: 8250_omap: add
 rs485-rts-active-high
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-kernel@vger.kernel.org
References: <20230531111038.6302-1-francesco@dolcini.it>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531111038.6302-1-francesco@dolcini.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 31/05/2023 13:10, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add rs485-rts-active-high property, this was removed by mistake.
> In general we just use rs485-rts-active-low property, however the OMAP
> UART for legacy reason uses the -high one.
> 
> Fixes: 767d3467eb60 ("dt-bindings: serial: 8250_omap: drop rs485 properties")
> Closes: https://lore.kernel.org/all/ZGefR4mTHHo1iQ7H@francesco-nb.int.toradex.com/
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

