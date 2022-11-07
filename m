Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD18DC4332F
	for <linux-serial@archiver.kernel.org>; Mon,  7 Nov 2022 20:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiKGU1g (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiKGU1f (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Nov 2022 15:27:35 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD18DD2;
        Mon,  7 Nov 2022 12:27:32 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id q186so1017268oia.9;
        Mon, 07 Nov 2022 12:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3H8ClgcI0ymBxPx6cLH6CRePq5Du7IS4PnD3S+Hqfq4=;
        b=FhM2r0moynYABUs30a6LIPdwZKa2qeNekrGqhJjg24gFmqZtuSTQ0Oc6La6LgZ4oGw
         rz6vRCi3Lfwj898zbqoG4SHwDzW+fNvjZIQ+WlJAWKifS97tV8FstD4KbpYy0n5v0KDx
         fWqFwWioxf4qnqoBX0D6VbknQJSEmjGtXOUQEqgvNYbiXzjkz40hKjNbzbT0I7Dn7QtE
         plZH9zIqZWO/YiW1JDGAbS4J33HLe52+7ft9G5NsSV+VDr9PETiXE80jekJK4mQ8gkDO
         VzLH8wiBVKp4olaCLMqorDdktBMjJ4iuxGl9cXf7gQwvnDQmDIR8WlKSoGYcq3Y+4WS6
         HGqA==
X-Gm-Message-State: ANoB5pmx30oSizdY/sgvZ5Q7WO0I6UCZkn/AHbldQBRsi1qX5a6fqKNZ
        9smJkPe0943N8CfZ2omRjg==
X-Google-Smtp-Source: AA0mqf5BdaFcCRbC0ePcKnRo+beRxTjUbIE7EHAOLUExpIWMwDMolbzjdYfVcU5qfnQy3dYRj5VFAQ==
X-Received: by 2002:a05:6808:1787:b0:35a:7f71:c99c with SMTP id bg7-20020a056808178700b0035a7f71c99cmr5275091oib.18.1667852851754;
        Mon, 07 Nov 2022 12:27:31 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fp19-20020a056870659300b0013b8b3710bfsm3599492oab.13.2022.11.07.12.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 12:27:31 -0800 (PST)
Received: (nullmailer pid 1585282 invoked by uid 1000);
        Mon, 07 Nov 2022 20:27:33 -0000
Date:   Mon, 7 Nov 2022 14:27:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: arm,sbsa-uart: Convert to
 json-schema
Message-ID: <20221107202733.GA1574416-robh@kernel.org>
References: <20221104104303.1534876-1-thierry.reding@gmail.com>
 <0f97ef6c-234e-d677-75ba-11b22586c95e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f97ef6c-234e-d677-75ba-11b22586c95e@linaro.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 04, 2022 at 10:25:42AM -0400, Krzysztof Kozlowski wrote:
> On 04/11/2022 06:43, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Convert the ARM SBSA UART device tree bindings from the free-form text
> > format to json-schema.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  .../bindings/serial/arm,sbsa-uart.yaml        | 37 +++++++++++++++++++
> >  .../bindings/serial/arm_sbsa_uart.txt         | 10 -----
> >  2 files changed, 37 insertions(+), 10 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt

Note that NXP LS2160a has a warning with this. The warning is correct 
because both PL011 and SBSA UART is wrong IMO. The question is which one 
is it really. I would assume someone went with SBSA for some reason. The 
pl011 compatible should be ignored given 'arm,primecell' is missing.


> > diff --git a/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml b/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
> > new file mode 100644
> > index 000000000000..afaa1ef7f2e6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
> > @@ -0,0 +1,37 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/serial/arm,sbsa-uart.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ARM SBSA defined generic UART
> > +
> > +maintainers:
> > +  - Rob Herring <robh@kernel.org>
> > +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This shouldn't be Greg but someone nothing the hardware. Rob might work,
> but maybe also Russell who is mentioned in maintainers entry?

I'm fine with it given I already have pl011 binding.


> Please resend with him cced.
> 
> > +
> > +description:
> > +  This UART uses a subset of the PL011 registers and consequently lives
> > +  in the PL011 driver. It's baudrate and other communication parameters
> > +  cannot be adjusted at runtime, so it lacks a clock specifier here.

Differences to PL011 are relavent, but location of the (Linux) driver is 
not.

> > +
> > +properties:
> > +  compatible:
> > +    const: arm,sbsa-uart
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +allOf:
> > +  - $ref: serial.yaml
> > +
> > +unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +...
> 
> Example would be nice, although it  is not a requirement.
> 
> 
> Best regards,
> Krzysztof
> 
> 
