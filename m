Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E563E81E1B
	for <linux-serial@archiver.kernel.org>; Fri,  6 Oct 2023 16:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjJFQ7c (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Oct 2023 12:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjJFQ7c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Oct 2023 12:59:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1073C6;
        Fri,  6 Oct 2023 09:59:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B528BC433C8;
        Fri,  6 Oct 2023 16:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696611570;
        bh=XTOhAODJ0nu3rRz5Q+XkYzDl0/6KlZeZubRu0IJN6lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D25LSNZbgitfyeTwZoCl/0W37aILce9NLNSJX8HCUtvRJLnLQud2KRl95b7mUG3kX
         azeguVm4yPiaoLUiXrvODIP3wAk/+xoYA1r/WumEaouVE+++UTY9Kejz2AJA3T9HPF
         UnT/doQEpfH6Owa1UN6MVlCWJxlv8uwAwnExCRy6xVkUci4s/g4FLVu90CUEktOUsb
         +cymHF7+Yw0W/15l3i3oqhhYKuUmat9tFYd5lHU0fFZoNJAF1iDs/gD7FRNuQDV29A
         gFB2FPq+p3l40Tc7kAV0LeEJr7UNr7kWMGkRF+iQFPAzABDUfM8oj/KrfL2HQxMpgb
         lYa18lyqwsfmQ==
Received: (nullmailer pid 4070229 invoked by uid 1000);
        Fri, 06 Oct 2023 16:59:28 -0000
Date:   Fri, 6 Oct 2023 11:59:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: serial: allow naming of Bluetooth with
 GPS children
Message-ID: <169661156826.4070185.14168502845724693794.robh@kernel.org>
References: <20231005093247.128166-1-krzysztof.kozlowski@linaro.org>
 <20231005093247.128166-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005093247.128166-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On Thu, 05 Oct 2023 11:32:47 +0200, Krzysztof Kozlowski wrote:
> Some devices attached over UART combine Bluetooth and GNSS/GPS receiver,
> so allow "bluetooth-gnss" naming of children nodes.
> 
> Link: https://lore.kernel.org/all/20231004070309.2408745-1-andreas@kemnade.info/
> Suggested-by: Andreas Kemnade <andreas@kemnade.info>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

