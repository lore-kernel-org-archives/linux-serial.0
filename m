Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13611EE4996
	for <linux-serial@archiver.kernel.org>; Mon, 21 Aug 2023 15:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjHUPvS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Aug 2023 11:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjHUPvS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Aug 2023 11:51:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9329EEE;
        Mon, 21 Aug 2023 08:51:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 273B16158A;
        Mon, 21 Aug 2023 15:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8469DC433C8;
        Mon, 21 Aug 2023 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692633075;
        bh=9otT1DHO31j/FkSQJXYWTDcERJPz93WsiClsF2PPdps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kCLWkFDUIpB6MufmfuoIifz1l5a/qhpbnMWLHoLQ+FTzyQuAMsihbmu2lor1uOepk
         3ZlhiUr2mAvMr5BLqtoEf7bV4nS8QQtTesykhNRBK2EK6c7kCTp92qEJvH+Msw6a5D
         XWsq93Qmh4dgZIqhh7xAnVWfjoEdYseMHTjVLWOhyuyHXqSk9iXxDOrwSfmERVZ1BA
         jG7JbgpSOZfxU/oqQU9Tuq6PhagOj0BZ4+j06x59k1SIB+DZ2lE+fShIkFiM4VqG3U
         DpqFx9sYEAQdj7Qu7p2pTkNofLB3OtbtpkR214/6qeqV4Qrvejn14+KegAT9QoC9Oo
         wYB3xY4weGVGQ==
Received: (nullmailer pid 1727484 invoked by uid 1000);
        Mon, 21 Aug 2023 15:51:13 -0000
Date:   Mon, 21 Aug 2023 10:51:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: snps-dw-apb-uart: make
 interrupt optional
Message-ID: <169263307160.1727322.12090577692395034504.robh@kernel.org>
References: <20230806092056.2467-1-jszhang@kernel.org>
 <20230806092056.2467-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806092056.2467-2-jszhang@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On Sun, 06 Aug 2023 17:20:55 +0800, Jisheng Zhang wrote:
> The driver fall back to poll style when there's no irq. "poll" still
> looks better than no support.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

