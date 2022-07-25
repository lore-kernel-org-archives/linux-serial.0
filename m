Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE54C43334
	for <linux-serial@archiver.kernel.org>; Mon, 25 Jul 2022 23:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbiGYX0N (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Jul 2022 19:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiGYX0M (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Jul 2022 19:26:12 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A671B7BD;
        Mon, 25 Jul 2022 16:26:11 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so9805197otk.0;
        Mon, 25 Jul 2022 16:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xnFhTvVlYrrcoWqTeF1r68lRRBQLPoPsbaCYWGup+Vo=;
        b=d7j/7PXmdW+xeL5i5UKxOiQBIQLJ/WsF45VTkelkoGoMEGCQbth3ntrFfB/F9uwKuT
         jv9pLn4fWLKnJw/BHDmXNavktG0WtVo9/wgEvjfod5bnhXho1Vgt2CVvr2RtBABkW5Ih
         0AQES2JpVebO1iJJE+S60AN+rEf9R6KlBCEMaNv+7X8cjadgwXhPZisCsfturdZMCsrT
         rzju5RBzwHuebjazusBbr5koQCYP/QbsuViSh3wyubr8nv9O3jSKkeq96d85jgc8Rni/
         wZ6kPnyvEjBEeavPgVPlc+xd1HOd1ivvztFGHKpjIgCvC2nJjQH/NnnwAzF69iMVD2tB
         6zag==
X-Gm-Message-State: AJIora/8JiqDwJ6JXWH/MmJw8Bv1WLJGdSAykhlRIOZ4U38f874TRrq/
        AAKEx4ZYvsOs88W+0qLYhA==
X-Google-Smtp-Source: AGRyM1tSrCX6+vSPu5meOoqpG8k5p7fMqZhx876vaGZXdOsAHkQhAM0U3pW+khOSX46P3sFlouD54w==
X-Received: by 2002:a9d:6f01:0:b0:61c:b224:e7c9 with SMTP id n1-20020a9d6f01000000b0061cb224e7c9mr5740297otq.245.1658791571112;
        Mon, 25 Jul 2022 16:26:11 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s41-20020a4a96ac000000b00435a59fba01sm5383225ooi.47.2022.07.25.16.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:26:10 -0700 (PDT)
Received: (nullmailer pid 2952292 invoked by uid 1000);
        Mon, 25 Jul 2022 23:26:08 -0000
Date:   Mon, 25 Jul 2022 17:26:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@edgeble.ai>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-serial@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 12/22] dt-bindings: serial: snps-dw-apb-uart: Document
 Rockchip RV1126
Message-ID: <20220725232608.GA2952235-robh@kernel.org>
References: <20220723204335.750095-1-jagan@edgeble.ai>
 <20220723204335.750095-13-jagan@edgeble.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723204335.750095-13-jagan@edgeble.ai>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, 24 Jul 2022 02:13:25 +0530, Jagan Teki wrote:
> Document compatible string for Rockchip RV1126 SoC.
> 
> Cc: linux-serial@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
