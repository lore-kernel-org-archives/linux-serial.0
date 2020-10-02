Return-Path: <SRS0=IMut=DJ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E76C47423
	for <linux-serial@archiver.kernel.org>; Fri,  2 Oct 2020 12:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F7D20679
	for <linux-serial@archiver.kernel.org>; Fri,  2 Oct 2020 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601642499;
	bh=M/lT3YH6Tnnvafox0OSBDVIrxXRVcmEkqpvUZB4Mn/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pj4zBvb56jKjgBiijDejBVST7KhaHPsMjonZQ/Kf0r5WNMTHJCjfYnz0yC5UaKaDU
	 DFKoq/d+lGDWRwdJJwk7rr3y0uLhbWlKKgBX0fOOHmgZf94Tj2v/vUoUmUeIzt6PsO
	 /Cr9c3EaD0WwfPEGGaK5Du7c867qHLDJvgc+xJjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbgJBMlb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 2 Oct 2020 08:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387885AbgJBMl2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Oct 2020 08:41:28 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3233720672;
        Fri,  2 Oct 2020 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601642487;
        bh=M/lT3YH6Tnnvafox0OSBDVIrxXRVcmEkqpvUZB4Mn/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AwV9J4TAktP10SFJ5Zw9X0ClFFyx7d8AP1/4PJVxhrgwz85hxwlI+w3THdKbkGqzw
         QUZBMiiP5mNi25X+RIFWmVFjaQAcgXSUVBqbrczKdIInbxLdbGFubwyNjtf2rSGHjY
         TJ5Dy8HZwX/njtKlWgnyrXpLCQjseV7kDqO2OLhc=
Date:   Fri, 2 Oct 2020 14:41:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: fsl-imx-uart: fix i.MX 53 and 6
 compatible matching
Message-ID: <20201002124126.GA3348316@kroah.com>
References: <20200925212649.23183-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925212649.23183-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 25, 2020 at 11:26:49PM +0200, Krzysztof Kozlowski wrote:
> The i.MX 53 and i.MX6Q DTS use two compatibles, i.MX 6SL/6SLL/SX three
> so update the binding to fix dtbs_check warnings like:
> 
>   serial@21ec000: compatible: ['fsl,imx6q-uart', 'fsl,imx21-uart'] is not valid under any of the given schemas
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/serial/fsl-imx-uart.yaml          | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

This doesn't apply to my tty tree :(

