Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DB3C1B0D8
	for <linux-serial@archiver.kernel.org>; Mon,  7 Dec 2020 23:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B4F7239ED
	for <linux-serial@archiver.kernel.org>; Mon,  7 Dec 2020 23:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgLGXA3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Dec 2020 18:00:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43614 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgLGXA2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Dec 2020 18:00:28 -0500
Received: by mail-ot1-f66.google.com with SMTP id q25so2375844otn.10;
        Mon, 07 Dec 2020 15:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ryKCDDAkk+LV0sbl1XJFzvGmfw+a/jMbuTJ6LeZrxos=;
        b=EP+FQxfUFjj6+dxY5oM3FuIz3kD00mCp3yOkvH1zZ/oIAOE9W3aFkwlHsVf1tb1sFZ
         SQYaIIg7jb4SkievyxkU7qmgnJDc1vtzl80Sme9hkoOV45pNdwy8ky/gQioU27ro1NtV
         EiGmD1l/69wEBr62rYPkEZdH8gbeDwbEaTXOdpTpthxeURxIrxDuf8YyWTQQC7i0uyJr
         auYJyA34zjvUWDb/aTF3IC/P3erQlCBaPxr9OoxrFfAIRshYC6z4n2AIW3V03F+suehP
         iSO13SlzHEJdDikqTBj9zLth74j4Z0RC6ENwV7ASGj0twjcbt74OHvQCmjADcSloVW35
         t6Rw==
X-Gm-Message-State: AOAM532h1NbrLAj+IPppZeZRDqmfKiLUiHZRyBzO7G6jVhtYwsJma0Ke
        IDgBC1XHLsDtwgu2/yUpeg==
X-Google-Smtp-Source: ABdhPJy2UBAeXVe2clCBgV3IV5LD9Vpm36/ML8hriGF/63dM/VNU5ZdbvxkVSr6vw82vbgIGBslvqg==
X-Received: by 2002:a9d:7394:: with SMTP id j20mr9731736otk.229.1607381981912;
        Mon, 07 Dec 2020 14:59:41 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f67sm2971797otb.60.2020.12.07.14.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:59:40 -0800 (PST)
Received: (nullmailer pid 1005800 invoked by uid 1000);
        Mon, 07 Dec 2020 22:59:39 -0000
Date:   Mon, 7 Dec 2020 16:59:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-mediatek <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Karol Gugala <kgugala@antmicro.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Stafford Horne <shorne@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media <linux-media@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/5] dt-bindings: devapc: add the required property
 'additionalProperties'
Message-ID: <20201207225939.GA1005697@robh.at.kernel.org>
References: <20201204093813.1275-1-thunder.leizhen@huawei.com>
 <20201204093813.1275-5-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204093813.1275-5-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 04 Dec 2020 17:38:12 +0800, Zhen Lei wrote:
> When I do dt_binding_check for any YAML file, below wanring is always
> reported:
> 
> xxx/soc/mediatek/devapc.yaml: 'additionalProperties' is a required property
> xxx/soc/mediatek/devapc.yaml: ignoring, error in schema:
> warning: no schema found in file: xxx/soc/mediatek/devapc.yaml
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/devapc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
