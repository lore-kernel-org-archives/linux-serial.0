Return-Path: <SRS0=wTQQ=5W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4B5C2BA19
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 10:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDDE206C3
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 10:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586169278;
	bh=Dy6A1BPjkxsEMEbPvIlsLup/B7+8hLbcJYcf6pY6yZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w847b1Lb50COb1vRrM3MMi/m01lOM0uUwScjkkuXPmC4uzJcm0HvCwIcV1OpWPbo3
	 sbSRbBAoSum7Xs+ccqUXIEeQWxDaXKOiP9QtcqiRSl9S80yGWDlPs1R6gBO/FI9I49
	 zQ4NjsyIVZJ6M2+WwhW6WGQBoyveRFPhl/jAmDf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgDFKei (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:34:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42828 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgDFKeh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Apr 2020 06:34:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id cw6so18548866edb.9;
        Mon, 06 Apr 2020 03:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GCDV/KSvNbnbn8FBlMojoXonpi0B/XmPXkgkMx9qThM=;
        b=Ox2HwkChMa6hQqSwnXfPzTmw9Ncg/625Hs8H+8iCVuLf15ykN0RFT+4g8iDCv3wVUw
         1Zhph8NRyNZ/wTNovQLNN7gTn1O+Y9iCm1lqIcZVeYFLitLgNx5cDotZBqs315UXkrMl
         NX30UUU+y5oTYlsv2PChuvKW1ZI4mYkWjYqgPETC8xePY60jPJQbY8LU4Ziyb59gqQR3
         t1vcmNcm2npd5+9Ljj9B3PohOOc6Kj0Go6BI53Ic5TdNhicJ1k/vLmQW0mLBGIZe6Syk
         ZZfLS1bp6b1DSEbLAA78XgYZjRudvLI7BuYfqFrtrKF02GW9nXVeJQuRQ2YTOxB8Qfe1
         0nfw==
X-Gm-Message-State: AGi0PubMkBg1b/fCOV20n6xiM8QaXnq49Pxa6An4u7RtC3P5hMzUI5wv
        TjPkfwyqA+OZ4VuX5L/ZfrY=
X-Google-Smtp-Source: APiQypL+eEKtkUOFf2EjtwdZr1+7NBkU7zGNKIK4C1nCqA7ypoV3kzmuidwmBCJ4nftZsbAUPe55Cw==
X-Received: by 2002:aa7:d042:: with SMTP id n2mr18050403edo.374.1586169275172;
        Mon, 06 Apr 2020 03:34:35 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id f13sm2407349edn.50.2020.04.06.03.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 03:34:34 -0700 (PDT)
Date:   Mon, 6 Apr 2020 12:34:32 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     gregkh@linuxfoundation.org, Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v5 2/2] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Message-ID: <20200406103432.GA16798@kozik-lap>
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <CGME20200406103158epcas2p2aaf3ef769a232dc28c04cb4ae91373bd@epcas2p2.samsung.com>
 <20200406103127.17105-1-hyunki00.koo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406103127.17105-1-hyunki00.koo@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 06, 2020 at 07:31:25PM +0900, Hyunki Koo wrote:
> Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> 
> This is required for some newer SoCs.
> 
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
> v2: 
> line 954 : change rd_regl to rd_reg in for backward compatibility.
> line 2031: Add init value for ourport->port.iotype  to UPIO_MEM 
> v3:
> line 2031: remove redundant init value  for ourport->port.iotype 
> v4:
> correct variable types and change misleading function name
> v5:
> add dt-binding and go as first patch in this series.
> 
> ---
>  drivers/tty/serial/samsung_tty.c | 76 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 64 insertions(+), 12 deletions(-)

For me it is fine, although Greg wanted the write functions to be
consistent with read around default case.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
