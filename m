Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35EEC41513
	for <linux-serial@archiver.kernel.org>; Sun,  6 Aug 2023 10:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjHFKUS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 6 Aug 2023 06:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHFKUR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 6 Aug 2023 06:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C981F19AF;
        Sun,  6 Aug 2023 03:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EF2760B7B;
        Sun,  6 Aug 2023 10:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30056C433C7;
        Sun,  6 Aug 2023 10:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691317214;
        bh=JS7SbQltzXmLLHZXOJHcS/NlOPGxdeIhj38NQNHwqaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RQM2gANfMD4mem5dZ6lBPkykA/uSRX6aQVocic5ePnw12eeWRjHzFhObY3Ydn7OXe
         AfpsZNow0h2nIkVF78B8016PQdAK9C5Wh9Dt+m43UTLzFtvDqNBr01y8j86AjeR5Or
         ekR8QpJU3J+PktbWbc8D6u5zc+utshvUHlW/6svk=
Date:   Sun, 6 Aug 2023 12:20:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] serial: 8250_dw: fall back to poll if there's no
 interrupt
Message-ID: <2023080643-chalice-exploring-e7ca@gregkh>
References: <20230806092056.2467-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806092056.2467-1-jszhang@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Aug 06, 2023 at 05:20:54PM +0800, Jisheng Zhang wrote:
> When there's no irq(this can be due to various reasons, for example,
> no irq from HW support, or we just want to use poll solution, and so
> on), falling back to poll is still better than no support at all.

Ouch, really?  Why not just fix the hardware instead?

