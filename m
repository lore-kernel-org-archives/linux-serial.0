Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA19C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 30 Nov 2021 02:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbhK3CF5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Nov 2021 21:05:57 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:33679 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhK3CF5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Nov 2021 21:05:57 -0500
Received: by mail-oi1-f180.google.com with SMTP id q25so38349425oiw.0;
        Mon, 29 Nov 2021 18:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1I30zQ57Iz9HeCHxtCDf+hCw5ji/uXEXw3peZo9U+Bc=;
        b=mHdbZIYF3BmFQBpyngI3Xzw7BOQnXS/93dFpFDhgIfrqxWxCYD2Pc6XYh1e0oEBSlA
         fw4AHoN79sFimex+i5xfpqBeS7x5cCbFn1FhMn7bkoYx8VadVM2fcIs7H6rh/zHw0SkP
         kdSNyAdvte1K+FkGKmJCxjWaUB4PIxxvxKwi7KnUk0wQaj5Q7MyynXkK5oRwZMoPdkNE
         tEJilJY/kcX9gtCKvhsffdnrpQWBz3ZL/DwY/hj+8lvOnuMo/5NCetI6eJcw4WzoeFX1
         OkaFU6XaQLghwpX0YcOOOWOFFsfi7BUsYIVdUpARIMgoRpscsqcRoXdtmDVS6Bu/3b5w
         r8+w==
X-Gm-Message-State: AOAM533HsAVgbv/liheUHJSVgZxPD3iVBR9LeyO++hgfcQ56+Yu7DMcO
        Kn5Qijh68+o192Sk38xU1J4+xIYdIA==
X-Google-Smtp-Source: ABdhPJxttJkDdHkB++w28ewMjHgHgVZ6jrQNJBYbxFXOJfBLQ/YcyHy3l6qMtVgALCNnepr/vMrfAg==
X-Received: by 2002:aca:581:: with SMTP id 123mr1665138oif.13.1638237758598;
        Mon, 29 Nov 2021 18:02:38 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j5sm2942427ots.68.2021.11.29.18.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 18:02:37 -0800 (PST)
Received: (nullmailer pid 1023372 invoked by uid 1000);
        Tue, 30 Nov 2021 02:02:36 -0000
Date:   Mon, 29 Nov 2021 20:02:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Add resets to the PL011 bindings
Message-ID: <YaWGPPAkIFx6bddg@robh.at.kernel.org>
References: <20211120011418.2630449-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120011418.2630449-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, 20 Nov 2021 02:14:18 +0100, Linus Walleij wrote:
> Some PL011 implementations provide a reset line to the silicon
> IP block, add a device tree property for this.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Probably it's easiest to apply this to the DT tree.
> ---
>  Documentation/devicetree/bindings/serial/pl011.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!
