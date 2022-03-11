Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AFAC433FE
	for <linux-serial@archiver.kernel.org>; Fri, 11 Mar 2022 10:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347955AbiCKKlz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Mar 2022 05:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242008AbiCKKlx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Mar 2022 05:41:53 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56991C2D9E
        for <linux-serial@vger.kernel.org>; Fri, 11 Mar 2022 02:40:50 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 304B13F1AF
        for <linux-serial@vger.kernel.org>; Fri, 11 Mar 2022 10:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646995248;
        bh=X21HZt8T3IqWraDQ7iGgx+oLbWN9WZTETBwQGf+ZZUQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=KdcjXER4uQ15ZhxmI3i0zIVeFSQKIZek5+hagVNE5I56vSdFzQfUtno6aqjCUJqMh
         5H/SNAtPMBlQaHJkY4PVYaXBSN1btJzNBrvDMdFcA2EFDyv6o2FTTzwwun92FlsZik
         m0nqjITOhYvTMauZdBCkHM6jGTpPTRxBmcsa1cGrusJ9drPiayPdTousE6D+jTNCKN
         s+ZKT/K1kzfCzbddPTnTLIiyl9mBhkhLiSYlRMsLhNrEWytMEYJ5ZKfa/aT9fgnrP4
         ABzi/i0Y1rSzJFrVrm3KouQzgsFNYDX3WVGGxNk6NsFY4bb+JMPk2kCygAFSyE7uQM
         aQUBr+aAQELJw==
Received: by mail-ej1-f70.google.com with SMTP id hr26-20020a1709073f9a00b006d6d1ee8cf8so4667940ejc.19
        for <linux-serial@vger.kernel.org>; Fri, 11 Mar 2022 02:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X21HZt8T3IqWraDQ7iGgx+oLbWN9WZTETBwQGf+ZZUQ=;
        b=6nFKFLLfs7LqEYtcu6liQBZXynmN0k8IZOyBbffHqhH6O9TqpLOmvzTebF6CT7OSFe
         /XACLC5hy7/dQT0AUT5uSrf/jQWYIEhdbDYxtkJTgpqnu5qAzv5t0FHdl/NUy0NhSpvD
         vH0N68iFBPpXFDghwS8xSSTwKK+Rrys3jegm415yAauNxFuEqLk/6uayBonfwVAoF5BS
         sOxDBhkMS3HYb+W0NpTI015rf/d/YUMC7RSjxa0kHb5tzuwLDDb8lTIISpzPtjI5H861
         CgWtElJ7ZimMtDwQLox1w4SDEtLEMhVSI2r5mZJ4tOEjUKrq7OpFoeVNBVudc82NPgat
         blrQ==
X-Gm-Message-State: AOAM530Z+mJKqRZ/8V2QTdUVs4pKtk/QYjFGIVctkGqy3XZKavuI0bvv
        yUTlmGxCrouSbh6GUgyujGdTeM8Lh1Sa8T3VRtMHZAR1V64xX2K33r1FcdMEQCbixiotcKExmSG
        0/38LvPE25eLkKoiDxJzLOemyhNQDagcOEQwcug/31w==
X-Received: by 2002:a05:6402:68e:b0:415:d29e:dfe8 with SMTP id f14-20020a056402068e00b00415d29edfe8mr8020405edy.351.1646995247919;
        Fri, 11 Mar 2022 02:40:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx44n4lTaDW21Sf5vUfjbgKehNameHRuZxjI/VFFs7cXlR4x7K02XzPeqdOLSqhYmJx/XlfIw==
X-Received: by 2002:a05:6402:68e:b0:415:d29e:dfe8 with SMTP id f14-20020a056402068e00b00415d29edfe8mr8020389edy.351.1646995247762;
        Fri, 11 Mar 2022 02:40:47 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id m25-20020a170906161900b006d43be5b95fsm2830773ejd.118.2022.03.11.02.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 02:40:47 -0800 (PST)
Message-ID: <46c82688-79fd-fe65-b740-ac72a809f189@canonical.com>
Date:   Fri, 11 Mar 2022 11:40:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: samsung: Add ARTPEC-8 UART
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        krzysztof.kozlowski@canonical.com
Cc:     kernel@axis.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        alim.akhtar@samsung.com
References: <20220311094515.3223023-1-vincent.whitchurch@axis.com>
 <20220311094515.3223023-2-vincent.whitchurch@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220311094515.3223023-2-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/03/2022 10:45, Vincent Whitchurch wrote:
> Add a compatible for the UART on the ARTPEC-8 SoC.  This hardware block
> is closely related to the variants used on the Exynos chips.  The
> register layout is identical to Exynos850 et al but the fifo size is
> different (64 bytes in each direction for all instances).
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
