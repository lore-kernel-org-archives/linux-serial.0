Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFAAC433FE
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 15:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhKZPgn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 10:36:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43850 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378099AbhKZPen (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 10:34:43 -0500
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 10:34:42 EST
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9F76622B7;
        Fri, 26 Nov 2021 15:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8885DC93056;
        Fri, 26 Nov 2021 15:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637940230;
        bh=lzIuBUVHSRheLgKjp2iAmDpqP8z3z3dOQmo6cQC7aaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VV3aQTyFms4Mx030/6p6yJP8LJ1VYKc9aZT2ZJG47IzcbZvBhhzXVIvXAe93ypdWg
         XaYVeKfhId1rtJw+b9zcQehOrSDOzGljo3w5sx7iSdIB0raNLFw6HidryF2S1CgkVQ
         d0Gv2hOs1V1aHEudwCsMS4WX7Su9LbZQl+ORHUUg=
Date:   Fri, 26 Nov 2021 16:23:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Add resets to the PL011 bindings
Message-ID: <YaD8A+ZN8ic5IJLM@kroah.com>
References: <20211120011418.2630449-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120011418.2630449-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Nov 20, 2021 at 02:14:18AM +0100, Linus Walleij wrote:
> Some PL011 implementations provide a reset line to the silicon
> IP block, add a device tree property for this.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Probably it's easiest to apply this to the DT tree.

Fine with me, if the DT maintainers do not mind:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
