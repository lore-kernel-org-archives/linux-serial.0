Return-Path: <SRS0=3mQv=5I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE220C4332E
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 19:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31A020719
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 19:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584991958;
	bh=2w2yYqtj1wTYNijyHaEdNTz4mjJMgi4sCq/s47qMEMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y4zWcmuUIC0mcQMkclEyDaTgWtDbePUhVkHq77LkLMaKsOOGrKN5eR2dl4hDhd7Ce
	 kev9abWHh9u49XJ0if5HFfmQJCtMc6pq6LknwL+R7Gpa0XV3iFdyTC2Y+6yhtvTbEL
	 Rqa5dUWMjfK7ouqGV/stUbE7ZC7zDE5ovcum1dmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgCWTci (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:32:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33467 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgCWTci (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Mar 2020 15:32:38 -0400
Received: by mail-io1-f67.google.com with SMTP id o127so15638718iof.0;
        Mon, 23 Mar 2020 12:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tGWDTIGwqblQ9A69FHsnP/KkSp6PxYWf2FN7H7nd5IM=;
        b=hDWlXtiAK5qi7St6qOBUEW5eRPfDANq7aPTQy1lGsTzbFQQg1uKDJMur2nhTJKy5zx
         g1kEZS0fWlsKw6JJfC8d/dyHq9vS8S0EpCtXmAyMWHmH+R9Xgl/8UISri6Dodtt7O8kx
         U7c5XOOaAVo6IwxEPH76wcvk41UxMptqakpOvfx0JZpDXScXt27e21Uk8JTPwbWvEzmY
         hd197DoIa9ER7NEizagMgN2PkYoWlTG8xTOaXQGDNM7gfmFy0tk8AzQtjnzedIOINVAH
         WNQLsUbtv2mOdPiKhX2O/G7kJWvLzkB0awbidISwUXSKZcnxlPQkwSX2eCsR9jw78Itg
         hN/A==
X-Gm-Message-State: ANhLgQ2I8Y7CN3WtyuRBx5eoyt7L+Xoo4BGjHznlvKydXk3Rnpc6+MH5
        E3F7TsrnPjfuDpt4NWNmCg==
X-Google-Smtp-Source: ADFU+vvsqraqDoMPKC97ZYwRS/aUG3mf9ci2H7tHa50R+nT9xxAnn3i+OZBrHisC/W9bBeKHPW+BAg==
X-Received: by 2002:a02:cbb6:: with SMTP id v22mr11925348jap.78.1584991956045;
        Mon, 23 Mar 2020 12:32:36 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w3sm4616589ior.55.2020.03.23.12.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:32:35 -0700 (PDT)
Received: (nullmailer pid 695 invoked by uid 1000);
        Mon, 23 Mar 2020 19:32:34 -0000
Date:   Mon, 23 Mar 2020 13:32:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sean Wang <sean.wang@mediatek.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2 2/2] dt-bindings: serial: Convert slave-device
 bindings to json-schema
Message-ID: <20200323193234.GB8470@bogus>
References: <20200306090046.8890-1-geert+renesas@glider.be>
 <20200306090046.8890-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306090046.8890-3-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri,  6 Mar 2020 10:00:46 +0100, Geert Uytterhoeven wrote:
> Convert the serial slave-device Device Tree binding documentation to
> json-schema, and incorporate it into the generic serial bindings.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Update references to slave-device.txt,
>   - Allow any child node names,
>   - Typo s/connnected/connected/.
> ---
>  .../devicetree/bindings/gnss/gnss.txt         |  2 +-
>  .../bindings/net/broadcom-bluetooth.txt       |  2 +-
>  .../bindings/net/mediatek-bluetooth.txt       |  2 +-
>  .../devicetree/bindings/net/qca,qca7000.txt   |  2 +-
>  .../bindings/net/qualcomm-bluetooth.txt       |  2 +-
>  .../devicetree/bindings/net/ti-bluetooth.txt  |  3 +-
>  .../devicetree/bindings/serial/serial.yaml    | 56 +++++++++++++++++++
>  .../bindings/serial/slave-device.txt          | 45 ---------------
>  MAINTAINERS                                   |  2 +-
>  9 files changed, 63 insertions(+), 53 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/slave-device.txt
> 

Applied, thanks.

I dropped qualcomm-bluetooth.txt change for now.

Rob
