Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E411C6FD1E
	for <linux-serial@archiver.kernel.org>; Tue,  7 Mar 2023 19:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjCGTue convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Mar 2023 14:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjCGTuO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Mar 2023 14:50:14 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E7FB9CA8
        for <linux-serial@vger.kernel.org>; Tue,  7 Mar 2023 11:41:24 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id y2so14304782pjg.3
        for <linux-serial@vger.kernel.org>; Tue, 07 Mar 2023 11:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678218046;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CWFDL0Togo3L/5bvFloyMlrVxNWJz2dZaxBpDesLPPY=;
        b=O2aaVSwe2pE5WKkYEfCrVJRKLfMr/1wOrCm4O4i8pZVLSVwsbzyzggE7D59wnPxrw5
         y0qH3qnoAUj5OHB3R9lijXaQyxvIkKmHDXCTGrbF24KC4kLMlrlUJcfajypuEEQZTSaZ
         uA4JXxCr3lpuwheDmd3H151TPxlWTn+q7RGjYVttMmYUATdg2dx3WwXVdFF1EROV/SrP
         wdWsWDNESAlBtiopceD6OxfvBTtLK0VWNQzJMcSD3nlnltjlc/wgu7lzt+KgFjqpuEZO
         S2miVocYN+WOcoPUMDMS7qIDOYXmWSBGY/UKnFgXa5FV2pjNf52YMl2g6awxJk19gNdR
         R/IA==
X-Gm-Message-State: AO0yUKXBLN01mcdwlIR75NOL3IXQRsdOFH95JFwASUL8JF0sBA4VHSMk
        94cBCOFgWMJhhIRKHZ0Wi35R5A==
X-Google-Smtp-Source: AK7set9Pfl0SQYm8o4d/CzeLw+E0U3nXeg314CNzFcmKQNtPX+Scglz04h5m+eRyrouDFqS1XFo04A==
X-Received: by 2002:a17:90b:4b49:b0:234:234c:72d9 with SMTP id mi9-20020a17090b4b4900b00234234c72d9mr16195349pjb.14.1678218046516;
        Tue, 07 Mar 2023 11:40:46 -0800 (PST)
Received: from localhost (63-228-113-140.tukw.qwest.net. [63.228.113.140])
        by smtp.gmail.com with ESMTPSA id fy1-20020a17090b020100b0022bfcf5d297sm9742902pjb.9.2023.03.07.11.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 11:40:45 -0800 (PST)
From:   Kevin Hilman <khilman@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Bernhard =?utf-8?Q?Rosenkr?= =?utf-8?Q?=C3=A4nzer?= 
        <bero@baylibre.com>, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        daniel.lezcano@linaro.org, chunfeng.yun@mediatek.com,
        angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
        allen-kh.cheng@mediatek.com, sean.wang@mediatek.com,
        zhiyong.tao@mediatek.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 8/9] dt-bindings: serial: mediatek,uart: add MT8365
In-Reply-To: <0dec66ce-424c-e682-3f73-594e5b1edb65@gmail.com>
References: <20230125143503.1015424-1-bero@baylibre.com>
 <20230125143503.1015424-9-bero@baylibre.com>
 <0dec66ce-424c-e682-3f73-594e5b1edb65@gmail.com>
Date:   Tue, 07 Mar 2023 11:40:45 -0800
Message-ID: <7httywfiyq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Matthias,

Matthias Brugger <matthias.bgg@gmail.com> writes:

> On 25/01/2023 15:35, Bernhard Rosenkränzer wrote:
>> Add binding description for mediatek,mt8365-uart
>> 
>> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>
> Greg will you take 5,6 and 8 from this series through your branch or are you Ok 
> if I take them. They are all just adding a new compatible string to the 
> following files:
> Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> and
> Documentation/devicetree/bindings/serial/mediatek,uart.yaml

Might I gently suggest that you take these along with patch 9 through
your tree?

The driver portions were all been merged and the bindings and DT all
reviewed since end of January.

Thanks,

Kevin
