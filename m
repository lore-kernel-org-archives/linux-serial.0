Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE683C2D0E4
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 21:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8092322264
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 21:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbgKTVEb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Nov 2020 16:04:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38959 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730524AbgKTVEb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Nov 2020 16:04:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id z16so10024557otq.6;
        Fri, 20 Nov 2020 13:04:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hG0Yjdk9OimqrWpKYF/IkVWg6nsHdnZMFyZuaLz0d1k=;
        b=M/WmwzU09ZqN89i/h+j5sU3eJv5VcQgJrLEAI0sWgrAVuyB9szLyD7n9K9eBv/wNTr
         8ReidoP+Ph3/e1KDo8KYXu+m/kWBJoIhqEKdd6UcLUX/NLCzMV9v0UgD2apx8R7w5vd2
         z8SPGfV6ree2X1bcy7rNBVM12hK9AHh+If9MHAdSIowld9cgW0XyVSfpvzIRyyXU9e+y
         id9ENlpC+ZVj+lsa8g36ZfUSa2cpHOpw83QD/9NnB1n1/fw7mhgSKV6jCtbXb2V057fH
         2Rlz7RlO1BM+zufq7xlxKxMWsIEGRxHJxk0sET5iAuvF1YVnWKOAxXoGK6OHRcmb9dJC
         wb0g==
X-Gm-Message-State: AOAM531Djiy7wQNDeFdOsrUs6A0S1oQdiO0NSsVFK4HY/OxH4osCrRLR
        RVJ9uOqKYRiQ4F1YMOEwE6V5KagdFw==
X-Google-Smtp-Source: ABdhPJwLeMlOc9JnvLCoMo/5Ni0hEffgWksdYu0UKsb07/EKXhO37Q+3KKYnD25MH0HsDzi9KghYyg==
X-Received: by 2002:a05:6830:22c9:: with SMTP id q9mr16142414otc.48.1605906270299;
        Fri, 20 Nov 2020 13:04:30 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n3sm2254605oif.42.2020.11.20.13.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 13:04:29 -0800 (PST)
Received: (nullmailer pid 1736597 invoked by uid 1000);
        Fri, 20 Nov 2020 21:04:28 -0000
Date:   Fri, 20 Nov 2020 15:04:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: Add support for the Broadcom UART driver
Message-ID: <20201120210428.GA1736336@robh.at.kernel.org>
References: <20201120194305.8847-1-alcooperx@gmail.com>
 <20201120194305.8847-3-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120194305.8847-3-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 20 Nov 2020 14:43:04 -0500, Al Cooper wrote:
> Add DT bindings for the Broadcom 8250 based UART driver. This
> UART is based on an 8250 but adds additional functionality. The
> additional features include the ability to use DMA for transfers and
> a baud rate clock system that is more accurate at high baud rates.
> This UART is backward compatible with the standard 8250 UART.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  .../bindings/serial/brcm,bcm7271-uart.yaml    | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml


See https://patchwork.ozlabs.org/patch/1404090

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

