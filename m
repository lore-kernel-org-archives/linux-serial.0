Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7B2C001DC
	for <linux-serial@archiver.kernel.org>; Fri, 21 Jul 2023 19:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjGUTHD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 Jul 2023 15:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjGUTHD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Jul 2023 15:07:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C1830CA;
        Fri, 21 Jul 2023 12:07:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BE2B61D90;
        Fri, 21 Jul 2023 19:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338E2C433C7;
        Fri, 21 Jul 2023 19:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689966420;
        bh=f0ZRrnP6tojXFAiwzaQtFQtyKw9mc8jinyICr4pXldI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CovPaoGyhrwdFzcdnlXSH9KRKxPq6jNApoogSoAUBFj8rNF1ZxunEaxE8+EK2asB4
         CREP3NxeGBC9Q2fn6zB/d3iox6mMpN1z/vaNRFpdxVP+3q5CudzclFcS1TrYHwxOTo
         7/NmBBy2LUp6RsU4iV4wGwYyDsjTtbwkMYV3BGnEcj+PcaziIAvuzJ7oW+ilsqid3C
         d6fs2H6mm6GHKQrrU9rcinIhRqlR61WcdNQF1J/uj/uGOiW5yrErYw076gupf4QqUz
         tdWL1VFhpoTNwcQCOJRw0IBsvMLR03vf0Y3S8FlQp2qZxwBZfhZMVsFEUZ7KkizmlB
         s8kpZMCpq9Sdg==
Received: (nullmailer pid 1595231 invoked by uid 1000);
        Fri, 21 Jul 2023 19:06:58 -0000
Date:   Fri, 21 Jul 2023 13:06:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: Remove obsolete cavium-uart.txt
Message-ID: <168996641744.1594899.13726641325222848108.robh@kernel.org>
References: <20230707221602.1063972-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707221602.1063972-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On Fri, 07 Jul 2023 16:16:02 -0600, Rob Herring wrote:
> cavium-uart.txt binding is already covered by 8250.yaml, so remove it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/serial/cavium-uart.txt           | 19 -------------------
>  1 file changed, 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/cavium-uart.txt
> 

Applied, thanks!

