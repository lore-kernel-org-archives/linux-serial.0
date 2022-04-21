Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78251C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 21 Apr 2022 07:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386191AbiDUHrL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Apr 2022 03:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386135AbiDUHqM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Apr 2022 03:46:12 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3473A1C912
        for <linux-serial@vger.kernel.org>; Thu, 21 Apr 2022 00:42:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id el3so574891edb.11
        for <linux-serial@vger.kernel.org>; Thu, 21 Apr 2022 00:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9Txp+p/Jb7cGORtQTcTM0SdgBYGc0np99cgJFPz7OZY=;
        b=f7u9Frh/sGhF22UliPgdw0W7YCyOiHF/yqF9Ej0BFpqGs3Jk9WsJL6Iai5V8eCmTSL
         F7V2K8v9hzcxxFVmMywL2JN6vVfvGx1eOuuWd0DbLj4fiah4qEobVc2XmhYFhypKbsgK
         DxuoZY04mlKPpVLOC71ph/jUKvGW3Jc18JxQ9KI2YYzqqanCSWsJa/QpwyzESYkh1UMv
         X3G8DSaPwtZUEi/BSbWIH/LyWRwSNWAkrF3mS/iHIF0VQt4QfvPQrRdiNqLDDw2v3LHf
         +FXQh5Bea9gRzxQhBz2c1XjiGy16cdFn4iD1W5PRgFTw5/cyCgEH7ihdVAEWQAb+6Flc
         XweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Txp+p/Jb7cGORtQTcTM0SdgBYGc0np99cgJFPz7OZY=;
        b=rvONAGYu1ZeXqUK9mJArHsb2EvyTRzVCVdoK6Tn1LHXapT66ho5QNdq8b0jUER74Dv
         OTNOoFQFgNDTc+w8bLKFufXXlP829gsVFplpQ0+Cx9bjGl0/X13AQjHlU44en+CNRNnk
         cDuzjFSNDfoHRzR9NBhnsXpH1bqYEk0hbF3/F1/XiRFRm6g4dcOo935hR9q8g7P9MgLc
         l1LpuP5vlhThvvli1vRIYPWRt59juaqaRE9unMH6qgk50ENWqIy9d1mrUXzOG26fm4JD
         Sg+p22lmelnaDbPhaZjpRmnFFsnD2WIj+cdJmnkLshUnGklfCo1Gjxb62g/XG3Ywej0S
         Ab2g==
X-Gm-Message-State: AOAM531FmdLdufTw8Fq/2d9ic61wzeEbfDYlUQJ7MTf2yxohswfR4CHH
        Z1LVSs+L4cIwfmm4T3P1WBL+cQ==
X-Google-Smtp-Source: ABdhPJwgURaGYxcz2whLZl5/LX9NiM1NFCwRsTEI1x/LHttzgS0aG+A1McOp99ZcY97ES4RkdgmwCQ==
X-Received: by 2002:a50:baa1:0:b0:418:849a:c66a with SMTP id x30-20020a50baa1000000b00418849ac66amr28069530ede.234.1650526963798;
        Thu, 21 Apr 2022 00:42:43 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q8-20020a056402040800b004227b347ee3sm9307797edv.56.2022.04.21.00.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 00:42:43 -0700 (PDT)
Message-ID: <eb20be87-5876-79f6-be43-9597d11b13e2@linaro.org>
Date:   Thu, 21 Apr 2022 09:42:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 04/15] dt-bindings: power: renesas,rcar-sysc: Document
 r8a779g0 SYSC bindings
Content-Language: en-US
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        geert+renesas@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20220420084255.375700-1-yoshihiro.shimoda.uh@renesas.com>
 <20220420084255.375700-5-yoshihiro.shimoda.uh@renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220420084255.375700-5-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 20/04/2022 10:42, Yoshihiro Shimoda wrote:
> Document bindings for the R-Car V4H (aka R8A779G0) SYSC block.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
