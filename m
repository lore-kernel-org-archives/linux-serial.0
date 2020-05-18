Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E81C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 18:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C13207D3
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 18:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825344;
	bh=LiTBKino9KTbcuGvOtaKKg3BwINswV7yni3pj72+NHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uyGnLnVH7S4rnE36hB2BTzbi0CKqZQMkUvEfajoumj/MWqLUiOck5i3pQyskSSU++
	 HlRudXftgHwPBRey+5qw+FmXr2K8v6H9RASXCGOyi0TwymWyEz6uN7ie/vXdi7pGRY
	 ZJM3zLoWBNplok9LoePJfeUMPVSY02km8AiwopXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgERSJD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 14:09:03 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45850 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729782AbgERSI4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 14:08:56 -0400
Received: by mail-io1-f67.google.com with SMTP id w25so11581626iol.12;
        Mon, 18 May 2020 11:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gN2kYwYRCkHdI62QPFQF6soqDLltZV49mRfzlQrkSXk=;
        b=qaT9uxiAmxeH0fvJ67GZL1HRIsaLZlt/EYQZXkI8EUhJ8DI7WnNRRLZiqbUivGbhKx
         Z2uQmIjlWJQ0Msv2DYhLyfmz+6h/DXE6Hq7hRbw2QroXthKe7hIYqKiOV33vQYaO97bj
         iOEZNl5j6RdRa9KyZMl4jmlg444pt55mJE0CSVwCVZjK846erLHqRiKzj8yp+2PR7+8Q
         BCk2epTz1xYfQhKq9iHAHF84LmtZ+Uz4xj5QD+8jT+zh1KLc8/ZDcMHdacet4fCQAUIU
         noRsU+InqaJjoZrLhLXazFF4kzjPZnM8ephABkJxrHkK+d/mrtJCbCr9NG3cQR1VA6eq
         rNaA==
X-Gm-Message-State: AOAM5320VL2Mv7UVyfGSmU5Ho5OJWsThWBDvNDFlYU0ZkQvKB/HvWi0v
        7SCVk/T/TvMJKL1khaGv6Q==
X-Google-Smtp-Source: ABdhPJyeaqLaNG693I+N/qeJEJ0zJBdBiVM9Z/LtSt0R3Z6HMlfqY9SzDBPUV2kOoPd+LfA/1DmudQ==
X-Received: by 2002:a02:ce26:: with SMTP id v6mr15459993jar.40.1589825334724;
        Mon, 18 May 2020 11:08:54 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s2sm732417ilj.29.2020.05.18.11.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 11:08:54 -0700 (PDT)
Received: (nullmailer pid 10875 invoked by uid 1000);
        Mon, 18 May 2020 18:08:53 -0000
Date:   Mon, 18 May 2020 12:08:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Mack <daniel@zonque.org>
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        pascal.huerst@gmail.com
Subject: Re: [PATCH 1/4] dt-bindings: sc16is7xx: Add flag to activate IrDA
 mode
Message-ID: <20200518180853.GA18566@bogus>
References: <20200508143757.2609740-1-daniel@zonque.org>
 <20200508143757.2609740-2-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508143757.2609740-2-daniel@zonque.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 08, 2020 at 04:37:54PM +0200, Daniel Mack wrote:
> From: Pascal Huerst <pascal.huerst@gmail.com>
> 
> This series of uart controllers is able to work in IrDA mode.
> This adds a flag to the device tree to enable that feature if needed.
> 
> Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> index c1091a923a89..9317c320c82c 100644
> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> @@ -21,6 +21,8 @@ Optional properties:
>    the second cell is used to specify the GPIO polarity:
>      0 = active high,
>      1 = active low.
> +- linux,irda-mode-port-0: Use IrDA mode on port #0
> +- linux,irda-mode-port-1: Use IrDA mode on port #1 (for dual-port devices only)
>  
>  Example:
>          sc16is750: sc16is750@51 {
> @@ -55,6 +57,8 @@ Optional properties:
>    the second cell is used to specify the GPIO polarity:
>      0 = active high,
>      1 = active low.
> +- linux,irda-mode-port-0: Use IrDA mode on port #0
> +- linux,irda-mode-port-1: Use IrDA mode on port #1 (for dual-port devices only)

How about an array of 1 or 2 entries instead?

>  
>  Example:
>  	sc16is750: sc16is750@0 {
> -- 
> 2.26.2
> 
