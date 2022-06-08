Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364C3CCA47F
	for <linux-serial@archiver.kernel.org>; Wed,  8 Jun 2022 10:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiFHKUU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Jun 2022 06:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbiFHKT2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Jun 2022 06:19:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F21CF7
        for <linux-serial@vger.kernel.org>; Wed,  8 Jun 2022 03:07:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fu3so38944821ejc.7
        for <linux-serial@vger.kernel.org>; Wed, 08 Jun 2022 03:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uwozKY9IoRm2unnovWBUEXcVhf9p+HCIyh3s3hKT5vQ=;
        b=n0VfOVvrrkIOalvK8xRLNFd+esu27i0xirYjW+RFkVQgVZkWh64Mdjk79XeqZN+QCx
         JnHT3RcjJr3UaQPb6LgQ3RZk0rjuRV+faz3KnWChGXk6G9EUxkgeHDb4Qw/tf6LSNq9D
         SuVcBOGqn5ZgSCpdMmNVyJYTALMQvU2itIy+wujWAr/Y1hMKkg0xg7Pbx5JqzNFJeSvI
         oa09wBRQbWLCuTNSxXg2tg7FWkoZbnRc+p7wdumlA7HhZoXgPHvTTljGVEneASCRNrkm
         F1HUPHlWw9SHP9ATOsCLyR7lcAVMk6kMkLkIJwROq3UooMafbV6X7xialLi4KFOLeo8e
         kTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uwozKY9IoRm2unnovWBUEXcVhf9p+HCIyh3s3hKT5vQ=;
        b=KkdQLoQcrWoc88wA/Qw4TeB6sZ8j0uD0/79J3m3IksmTn8n6f8+AGpFLoOvOICMvOz
         npVIPP7aZY4bX4vVMzhPTndelbq80ylJ/JCbz/eb5uD4iN50EUGkGjSF7R/tCWQT5Wa1
         iUkFDJ2nucLPmOCzXOfaG5LutR1CnyV1v0qHObPe4zlnS9pmO9gQU7iOlWeD7O9cUPt1
         px03ChEyd+UpPIvz+mM8+O2MkZueRSd/CbJ26ub8Zbsyfw3L/ZfopAC3rV5SzVtC3gHV
         y66PBCv5iLY5CSloLQ0r76DT8Qp3zUt2lPvOfNbYMGwipfubrr4W2/5D+8AjSmwsXxZL
         msmw==
X-Gm-Message-State: AOAM531reqpA2gcmEA5u6mbpXyqcLBJcdE+XaR3dCal21n2PknaFFhDi
        6fVkmX1JrXLB/mgVE6AA4ZiXYg==
X-Google-Smtp-Source: ABdhPJzDQJRXBOzErKRVkLtw792RnQ9hYbK6BqKk+RLDWlTglkhS2dUR49w+HXT/bwY07t0Tq6uriw==
X-Received: by 2002:a17:906:9f1c:b0:711:cdda:a01f with SMTP id fy28-20020a1709069f1c00b00711cddaa01fmr14516948ejc.372.1654682827093;
        Wed, 08 Jun 2022 03:07:07 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ay25-20020a056402203900b0042cf43e1937sm12020228edb.75.2022.06.08.03.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 03:07:06 -0700 (PDT)
Message-ID: <3aa70c91-d6d7-e2eb-9c45-a1fb0a5751ca@linaro.org>
Date:   Wed, 8 Jun 2022 12:07:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 10/20] ARM: dts: nuvoton: add reset syscon property
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220608095623.22327-1-tmaimon77@gmail.com>
 <20220608095623.22327-11-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220608095623.22327-11-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 08/06/2022 11:56, Tomer Maimon wrote:
> Add nuvoton,sysgcr syscon property to the reset
> node to handle the general control registers.

Wrong wrapping.

Best regards,
Krzysztof
