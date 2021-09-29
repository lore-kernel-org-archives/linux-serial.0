Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C0AC4332F
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 13:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE436140F
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 13:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbhI2NsN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Sep 2021 09:48:13 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43819 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243959AbhI2NsI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Sep 2021 09:48:08 -0400
Received: by mail-ot1-f46.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so2881211otb.10;
        Wed, 29 Sep 2021 06:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=jMZb3TV+GJOIlxYCtMJdnxRmPdNBMSRN7GDKf7v1GGY=;
        b=QlAioYR0G4YPTlfVsugj35S0sKRs/iCAfueMC46+S8eqPlPpUp33ApArdtTDRAf/l8
         zYMsxpPH6LJeqg1yd2duUhcgP15bRl02jDr97cHuVZN2fa9obiX9QRoyJgV7XkMwQ7F+
         2PCfdtxDOW7HMJ8C9MgY+emlpZXbZdGihG1wiSTobFvAe91t7rOSTplJmuGGbsBN4LiJ
         bnPSIDcTbXMv8XwvIKDEgFcr35Ul4UuzYFJMlmGEW1q1i+y6W8H7NKcTs0oIbIgl086O
         zFJalxz4lscTkw/K540a2U4RMcFv3llANLh+b+kkifKB5zq1IdTh/yA1UuavKrp8+She
         Db7Q==
X-Gm-Message-State: AOAM531z+7gqT2CdfMHninzkCTvilMNXcdJFKJbYPsvFj/9ARAST7+BG
        B3l+/3CQKLavgGfmAZiHzQ==
X-Google-Smtp-Source: ABdhPJyC+B83kIvYCirQ6AHYKd5p7GEICSCPf10mnyatSw/XSns3MaJbeKFs1e6tNnUnD3PK7GebaQ==
X-Received: by 2002:a05:6830:1e77:: with SMTP id m23mr48262otr.305.1632923187328;
        Wed, 29 Sep 2021 06:46:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c5sm456042otb.35.2021.09.29.06.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 06:46:26 -0700 (PDT)
Received: (nullmailer pid 3674444 invoked by uid 1000);
        Wed, 29 Sep 2021 13:46:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-serial@vger.kernel.org,
        =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <20210929082034.15098-4-pali@kernel.org>
References: <20210929082034.15098-1-pali@kernel.org> <20210929082034.15098-4-pali@kernel.org>
Subject: Re: [PATCH v6 3/6] dt-bindings: mvebu-uart: document DT bindings for marvell,armada-3700-uart-clock
Date:   Wed, 29 Sep 2021 08:46:25 -0500
Message-Id: <1632923185.716457.3674443.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 29 Sep 2021 10:20:31 +0200, Pali Rohár wrote:
> This change adds DT bindings documentation for device nodes with compatible
> string "marvell,armada-3700-uart-clock".
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> ---
> Changes in v6
> * Fix license
> * Rename node to clock-controller@12010
> * Remove maxItems
> ---
>  .../bindings/clock/armada3700-uart-clock.yaml | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml: $id: 'http://devicetree.org/schemas/clock/marvell,armada-3700-uart-clock#' does not match 'http://devicetree.org/schemas/.*\\.yaml#'
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
./Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/clock/armada3700-uart-clock.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml: ignoring, error in schema: $id
warning: no schema found in file: ./Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
Documentation/devicetree/bindings/clock/armada3700-uart-clock.example.dt.yaml:0:0: /example-0/clock-controller@12010: failed to match any schema with compatible: ['marvell,armada-3700-uart-clock']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1534231

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

