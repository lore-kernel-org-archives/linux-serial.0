Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5D5C433E0
	for <linux-serial@archiver.kernel.org>; Sun, 17 Jan 2021 15:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD3C2255F
	for <linux-serial@archiver.kernel.org>; Sun, 17 Jan 2021 15:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbhAQPqt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 17 Jan 2021 10:46:49 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:41086 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbhAQPqn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 17 Jan 2021 10:46:43 -0500
Received: by mail-oo1-f51.google.com with SMTP id q6so3516233ooo.8;
        Sun, 17 Jan 2021 07:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=YYZdReruX4QPpNn9itV0r843NXru2A244Vndhzd0IdI=;
        b=Mo5hoMopcczSObbsjbIE1fNqSGIEaTo2q8lGTQ4gCCNwk9XqnxWitBTdFS+qTAd4K0
         QHGfx9LnRLQK+Lxhwd98jXjuoUm7VCzr8CcOYpiRUgqJLvX4Ydmhw7WoG6wD9SepUcCD
         snKtGjnTilVu8OmxbAeKG7oyxgzkAaoMLgeOG6AQ9LcbZ6DDGfO8YeDogyeHxanuE6mr
         SaWN981n3E9xkqiDrJsg2kdKrGiH4jfC95HQXWyxrPCHpe2EgThVqMV3RNHT14CePPlh
         5OlZqDMOUG7z+ErN+1F9GIGX6nx8U+Gw+2xHGySCJHgynNcF/T0e4e0ifP02XXEDUuqT
         g7Wg==
X-Gm-Message-State: AOAM5326oiG/Uuv2aUeqoDTr4QzwZNzP8SpqSeqLuolOXDNriSFVur9I
        LhAPpwDm1sYWrRqoIp5FQw==
X-Google-Smtp-Source: ABdhPJwVtq7EztM2ZiB62TEnbKGxQL6nj+sao0EbrChJ1paylGZ7W62l8XhMZKKH3hDWLm9ubS1rkQ==
X-Received: by 2002:a4a:2cc9:: with SMTP id o192mr14787473ooo.66.1610898361904;
        Sun, 17 Jan 2021 07:46:01 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m15sm3197353otl.11.2021.01.17.07.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 07:46:01 -0800 (PST)
Received: (nullmailer pid 1730316 invoked by uid 1000);
        Sun, 17 Jan 2021 15:45:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
In-Reply-To: <20210115211543.33563-2-alcooperx@gmail.com>
References: <20210115211543.33563-1-alcooperx@gmail.com> <20210115211543.33563-2-alcooperx@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add support for the Broadcom UART driver
Date:   Sun, 17 Jan 2021 09:45:57 -0600
Message-Id: <1610898357.217119.1730315.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 15 Jan 2021 16:15:42 -0500, Al Cooper wrote:
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

See https://patchwork.ozlabs.org/patch/1427364

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

