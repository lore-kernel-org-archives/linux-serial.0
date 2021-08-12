Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA136C432BE
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 16:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E806103A
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 16:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhHLQFM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Aug 2021 12:05:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39438 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhHLQFL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Aug 2021 12:05:11 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E6F5222AF;
        Thu, 12 Aug 2021 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628784285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hd5YnS5VlsByO54UINflxFxM7cPEyatBOwZmq8q+1yw=;
        b=YotCp8PjStL4i9ffUhS9OoZX8QnH2jB2T/zk6/oQWD3WHdpPYMmveaqDEw7oId8so/Esu4
        F0HIeCyp+gdzwOqnaJj1VQj/1JZHQsE4Eazs6QU6BaXIQ2w+5dx2NziXeHfnuGaxFdrXmq
        MaFZgG82KZeixNCbQrDWkj0vQf8kCsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628784285;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hd5YnS5VlsByO54UINflxFxM7cPEyatBOwZmq8q+1yw=;
        b=OQuQ6s6K3EktLNE86QftmfX7DWBZd9pvqvcwE+zzMBxxZMjI5KN0YAaXc6xsjREBlTbt8t
        uj3+YfCflhWq/iCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C8F1813ACC;
        Thu, 12 Aug 2021 16:04:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 8uSJL5xGFWEDfAAAGKfGzw
        (envelope-from <afaerber@suse.de>); Thu, 12 Aug 2021 16:04:44 +0000
To:     Chester Lin <clin@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Jagan Teki <jagan@amarulasolutions.com>, s32@nxp.com,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-3-clin@suse.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Subject: Re: [PATCH 2/8] dt-bindings: serial: fsl-linflexuart: convert to
 json-schema format
Message-ID: <1ff13837-e6ca-c476-376d-b4f80450a259@suse.de>
Date:   Thu, 12 Aug 2021 18:04:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805065429.27485-3-clin@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05.08.21 08:54, Chester Lin wrote:
> Convert the FSL LINFlexD UART binding to json-schema.
> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  .../bindings/serial/fsl,s32-linflexuart.txt   | 22 ---------
>  .../bindings/serial/fsl,s32-linflexuart.yaml  | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml

Thanks for your effort, Chester.

> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
> deleted file mode 100644
> index f1bbe0826be5..000000000000
> --- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -* Freescale LINFlexD UART
> -
> -The LINFlexD controller implements several LIN protocol versions, as well as
> -support for full-duplex UART communication through 8-bit and 9-bit frames.
> -
> -See chapter 47 ("LINFlexD") in the reference manual[1].
> -
> -Required properties:
> -- compatible :
> -  - "fsl,s32v234-linflexuart" for LINFlexD configured in UART mode, which
> -    is compatible with the one integrated on S32V234 SoC
> -- reg : Address and length of the register set for the device
> -- interrupts : Should contain uart interrupt
> -
> -Example:
> -uart0: serial@40053000 {
> -	compatible = "fsl,s32v234-linflexuart";
> -	reg = <0x0 0x40053000 0x0 0x1000>;
> -	interrupts = <0 59 4>;
> -};
> -
> -[1] https://www.nxp.com/webapp/Download?colCode=S32V234RM
> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> new file mode 100644
> index 000000000000..acfe34706ccb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

Since this is dual-licensed and BSD-2-Clause would seem compatible with
GPLv3, this could probably be s/GPL-2.0-only/GPL-2.0-or-later/ ? Not a
blocker.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/fsl,s32-linflexuart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale LINFlexD UART
> +
> +description: |
> +  The LINFlexD controller implements several LIN protocol versions, as well
> +  as support for full-duplex UART communication through 8-bit and 9-bit
> +  frames. See chapter 47 ("LINFlexD") in the reference manual
> +  https://www.nxp.com/webapp/Download?colCode=S32V234RM.
> +
> +maintainers:
> +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +  - Rob Herring <robh@kernel.org>

@Shawn: I assume we need both of them to ack this (or an S32V maintainer
to volunteer), since they were not named in the .txt file before?

> +
> +allOf:
> +  - $ref: "serial.yaml"
> +
> +properties:
> +  compatible:
> +    description: The LINFlexD controller on S32V234 SoC, which can be
> +      configured in UART mode.
> +    items:
> +      - const: fsl,s32v234-linflexuart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    serial@40053000 {
> +        compatible = "fsl,s32v234-linflexuart";
> +        reg = <0x40053000 0x1000>;
> +        interrupts = <0 59 4>;
> +    };

Otherwise looking sane,

Reviewed-by: Andreas Färber <afaerber@suse.de>

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
