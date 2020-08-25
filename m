Return-Path: <SRS0=bk4J=CD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A646C433E1
	for <linux-serial@archiver.kernel.org>; Tue, 25 Aug 2020 22:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99EC20767
	for <linux-serial@archiver.kernel.org>; Tue, 25 Aug 2020 22:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598393571;
	bh=Of113EnxCqZ07WTSyQiM3vjm12EBTMirsA3n9O6h8Lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bdTqJoX+7tEKG52QUQ2R8sa7cEMtOgiNVlE2pSE1rwP0dlpqi6E4QpHkwkJDMypaS
	 Nq9NdYUkTGBx7yG6a/BGjIX23TRw3LBUSdJD1bQKj4caF1xgq8t/RLxn+BCqJvu42a
	 CJyE1gFiQXiHNy0VQe49hsm9CJ4Yfu8Haym2dzEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgHYWMv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:12:51 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:36055 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgHYWMv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Aug 2020 18:12:51 -0400
Received: by mail-il1-f195.google.com with SMTP id f75so121215ilh.3;
        Tue, 25 Aug 2020 15:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FtjWOGoBGwHdWV2mCBLJ32YFGif1JFKNUa42upB2AAM=;
        b=t5vCAEskRx/+e14DLFTY3NLOSPxL8Zs5e1DzdJCd3fmRKwxmzxiFS5eVrzbF7WxcnE
         +QkED894zCPPyNfR1piSWQIVd2gKmZJw8GOR79vEaWjY7OIy9h25a1CY1yhBJ1DajmRA
         FUfLk6/lTluu00YDrAhgY37isuBKbUphZjwfFMvdnOQy3+JhUqLna1j/LVzp09Smtm5O
         WI+II9iAV6Xv/3uF506sxqvRg0Ohz6AUUupJjCvtE3kMbnczjRkI/w3Bh8Giyao8+fOa
         SZJ9qbqycUVvkWDtiF9PsdRMuwT/PXAUNJ8BSzzmMesY0OT25+oUNZZB4IJoEBFvAfpo
         AKpA==
X-Gm-Message-State: AOAM530tFCVEgDClV4wpK9uN5i+1E8ewwCMgoHSxkMYQsy7cGlUbnOlp
        6o3vmtiRPjoznyVwYcHpDAcNswbr7U9eUU8=
X-Google-Smtp-Source: ABdhPJzp2v3fVY1P4ngfkmA53AKhzUHzmoTGfLtjsRJZeHZ5ogRB6fzJiGIPCI2pH60VdBnwDBrPKw==
X-Received: by 2002:a92:c7d4:: with SMTP id g20mr11066461ilk.40.1598393569835;
        Tue, 25 Aug 2020 15:12:49 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id p124sm74373iof.19.2020.08.25.15.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 15:12:49 -0700 (PDT)
Received: (nullmailer pid 1435001 invoked by uid 1000);
        Tue, 25 Aug 2020 22:12:47 -0000
Date:   Tue, 25 Aug 2020 16:12:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        jslaby@suse.com, git-dev@xilinx.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/2] bindings: serial: Add xilinx compatible
Message-ID: <20200825221247.GA1429623@bogus>
References: <1597855439-746-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597855439-746-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 19, 2020 at 10:13:58PM +0530, Shubhrajyoti Datta wrote:
> Add the arm,xlnx-sbsa-uart compatible.
> Xilinx versal uart is similar to sbsa-uart except that it has
> termios configurable.

Yet still not just a pl011? Sigh.

> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  Documentation/devicetree/bindings/serial/pl011.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
> index c23c93b..6e123b1 100644
> --- a/Documentation/devicetree/bindings/serial/pl011.yaml
> +++ b/Documentation/devicetree/bindings/serial/pl011.yaml
> @@ -20,6 +20,7 @@ select:
>          enum:
>            - arm,pl011
>            - zte,zx296702-uart
> +          - arm,xlnx-sbsa-uart
>    required:
>      - compatible
>  
> @@ -32,6 +33,7 @@ properties:
>        - items:
>            - const: zte,zx296702-uart
>            - const: arm,primecell
> +          - const: arm,xlnx-sbsa-uart

You are defining compatible must be:

compatible = "zte,zx296702-uart", "arm,primecell", "arm,xlnx-sbsa-uart";

Probably not what you want. And breaks ZTE.
