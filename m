Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFE2C43216
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 16:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206DC60EB5
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 16:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhHLQ20 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Aug 2021 12:28:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55024 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhHLQ2Z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Aug 2021 12:28:25 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED7361FF60;
        Thu, 12 Aug 2021 16:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628785678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QAE7sEehwRiCK7nYYG8EaaX+mG9I2XBerEvEmdPzQkc=;
        b=Anv8C14tFX68hzAs9z2JcuJewxTm2xCPQCNB5DjhMxFNpF93/f4ReFANJHtwMt8u3+TRT7
        UQCSUlqCVx6l3WQBS2XNJ+5PllFUh+039EqofcvS/m9wF9QJM5L5KKXpeUb9RAXTULpfp2
        uW9RYAY/ErLaQR/1w/VQi2Rn2Q5OSnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628785678;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QAE7sEehwRiCK7nYYG8EaaX+mG9I2XBerEvEmdPzQkc=;
        b=U+YuYB/Ambc45cQD0GlJxC4FHZRE+le5G4rd4RwyUhOgkjaVxF36PhcF+Prnc5kDdya4Bl
        8yuNA75v77sxD7BQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5975713ACC;
        Thu, 12 Aug 2021 16:27:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id QAivFA5MFWF5AgAAGKfGzw
        (envelope-from <afaerber@suse.de>); Thu, 12 Aug 2021 16:27:58 +0000
To:     Chester Lin <clin@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, s32@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-4-clin@suse.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Subject: Re: [PATCH 3/8] dt-bindings: serial: fsl-linflexuart: Add compatible
 for S32G2
Message-ID: <96c02ee6-cd3a-59df-0b3b-1632bb355019@suse.de>
Date:   Thu, 12 Aug 2021 18:27:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805065429.27485-4-clin@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05.08.21 08:54, Chester Lin wrote:
> Add a compatible string for the uart binding of NXP S32G2 platforms. Here
> we use "s32v234-linflexuart" as fallback since the current linflexuart
> driver still works on S32G2.
> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  .../bindings/serial/fsl,s32-linflexuart.yaml  | 26 ++++++++++++++++---
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> index acfe34706ccb..e731f3f6cea4 100644
> --- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> @@ -21,10 +21,20 @@ allOf:
>  
>  properties:
>    compatible:
> -    description: The LINFlexD controller on S32V234 SoC, which can be
> -      configured in UART mode.
> -    items:
> -      - const: fsl,s32v234-linflexuart
> +    minItems: 1
> +    maxItems: 2

Are these necessary for oneOf?

> +    oneOf:
> +      - description: The LINFlexD controller on S32G2 SoC, which can be
> +          configured in UART mode.
> +        items:
> +          - enum:
> +              - fsl,s32g2-linflexuart
> +          - const: fsl,s32v234-linflexuart

This reads inconsistent to me: Either this oneOf is for S32G2 only, then
please turn the enum into a const. Or change the description to "on SoCs
compatible with S32V234" if we expect the enum list to grow.

I believe the idea here was to avoid unnecessary driver compatible and
earlycon compatible additions, while preparing for eventual quirks
specific to S32G2.

@NXP: Should this be s32g2- like above or s32g274a- specifically? Do you
agree this is a useful thing to prepare here, as opposed to using only
s32v234- in the s32g2* DT?

I assume the ordering is done alphabetically as S32G < S32V;
alternatively we might order S32V234 first and then the compatible ones.

> +
> +      - description: The LINFlexD controller on S32V234 SoC, which can be
> +          configured in UART mode.
> +        items:
> +          - const: fsl,s32v234-linflexuart

To minimize this S32G2 patch, would it be valid to do oneOf for the
single S32V in the preceding patch already? Then we would avoid the text
movement and re-indentation above and more easily see the lines newly
getting added for S32G2.

>  
>    reg:
>      maxItems: 1
> @@ -41,8 +51,16 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> +    /* S32V234 */

Could this be:
  - description: S32V234
    |
?

>      serial@40053000 {
>          compatible = "fsl,s32v234-linflexuart";
>          reg = <0x40053000 0x1000>;
>          interrupts = <0 59 4>;
>      };
> +
> +    /* S32G2 */

This should not be part of the S32V example, but a new one:

  - |

(or with description, as discussed above)

> +    serial@401c8000 {
> +        compatible = "fsl,s32g2-linflexuart", "fsl,s32v234-linflexuart";

Potentially affected by naming discussions above.

> +        reg = <0x401c8000 0x3000>;
> +        interrupts = <0 82 1>;
> +    };

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
