Return-Path: <SRS0=pdp3=6O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B99C83000
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 14:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0179206D9
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 14:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588256392;
	bh=eU5uFIZ+TrO/AEPKp0xouEQdXkDnD7Ewu9/+joj1rDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pRZQhegxG6bNVbAJWStreBr6xPcSFT1+b1qjVj6j60ZdFWCGf/BzkPZnEqiUqoK/1
	 VQui7uBfOzo08mHjG6zLhPO8teLRnnmCH7XLO/Lm8ymXt3Pl2H26r9s2AcGp8rEuVC
	 JcxMm0aCeCzW//pxZZnvxiErfo3JC9r00PepJRlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgD3OTw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:19:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37486 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgD3OTw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 10:19:52 -0400
Received: by mail-ot1-f68.google.com with SMTP id z17so5016420oto.4;
        Thu, 30 Apr 2020 07:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ORT6q3YM/a4y/ufIe0NOUUS99F5v0I2U1Ba6yQGsXc8=;
        b=Dv38gT5LZnJzHSpse/Y1F7J0XbPgSZ9jwLQxSGPU3tOCCO5ITVJsBBcRiZbdawMPRz
         Yys+RPNdF5g1FWolVw/owageX8QQPGveYq2nt2fUv6os1+GW0PlZA3+/CJrCFNGEF6Wm
         NLCwNHdj5IyXCAcxTnDQC5nqjmjMZbg1E06p3Jkz8dcv78j9NQUnV6ubbQrfo6jJ/s+F
         wTFQy+D9n5lahMM8AC5WHDdsL61LC6crfCdSm/Rd2mxNFvFMQbViP5+AWa4lUZXe85cE
         5AEpWi2pxTTnnGAHXV2munujAAvFvlVXxhdGUssmtR1EfMgtMH2vEzYDeDitwR2YQtTk
         f43g==
X-Gm-Message-State: AGi0PuZhnYEhqp9vQXstxwYMQNQqFxy7HnDQbpQlcnX5hw6oagFEWz/V
        y5CmiHGcQ9zQhCJOIsqLUw==
X-Google-Smtp-Source: APiQypK+7JO40xIM1ksCSBqc62gTtnbxdhSzsZM3Blqb6PtVvstoaWRzXII06Q4xa12tJeRxnQsJRQ==
X-Received: by 2002:a05:6830:2148:: with SMTP id r8mr2562337otd.368.1588256390986;
        Thu, 30 Apr 2020 07:19:50 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l37sm8590ota.68.2020.04.30.07.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:19:50 -0700 (PDT)
Received: (nullmailer pid 21750 invoked by uid 1000);
        Thu, 30 Apr 2020 14:19:49 -0000
Date:   Thu, 30 Apr 2020 09:19:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 2/2] dt-bindings: serial: Convert 8250 to json-schema
Message-ID: <20200430141949.GA21645@bogus>
References: <20200419201716.679090-1-lkundrak@v3.sk>
 <20200419201716.679090-3-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419201716.679090-3-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, 19 Apr 2020 22:17:16 +0200, Lubomir Rintel wrote:
> Some fixes were done during the conversion:
> 
> Slightly better examples. The original example was for an OMAP serial
> port, which is not even described by this binding, but by
> omap_serial.txt instead.
> 
> Added compatible strings, that were used, byt not documented:
> andestech,uart16550, cavium,octeon-3860-uart, fsl,16550-FIFO64,
> nvidia,tegra186-uart, nvidia,tegra194-uart, nxp,lpc1850-uart,
> opencores,uart16550-rtlsvn105, ralink,mt7620a-uart, ralink,rt3052-uart,
> ralink,rt3883-uart and xlnx,xps-uart16550-2.00.b.
> 
> Removed "serial" compatible string. It's redundant with the node name
> (which, in OFW, serves the same purpose as the compatible string).
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1, addressing review from Rob Herring [1]:
> - Utilize anyOf: instead of allOf: to express mutual exclusivity of
>   clock-frequency and clocks.
> - Allow ns16550a where ns16550 is used but actually has a working FIFO;
>   add a comment about ns16550a being preferred
> - resets: specify maxItems based on actual use, drop description
> - current-speed: add type ref
> - used-by-rtas: add type
> - no-loopback-test: add type, fix a typo in description
> - fifo-size: add type ref
> - auto-flow-control: add type
> - tx-threshold: add type ref
> - {rts,cts,dtr,dsr,rng,dcd}-gpios: drop description, redundant to
>   serial.yaml
> 
> [1] https://lore.kernel.org/lkml/CAL_Jsq+GDnYviCdszhghhEVB55giPHk8N9w_KASPXG_=H+ZQig@mail.gmail.com/
> 
>  .../devicetree/bindings/serial/8250.txt       | 102 --------
>  .../devicetree/bindings/serial/8250.yaml      | 223 ++++++++++++++++++
>  2 files changed, 223 insertions(+), 102 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/8250.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/8250.yaml
> 

Applied, thanks.

Rob
