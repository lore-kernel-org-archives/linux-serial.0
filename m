Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861D5C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 13:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A19461077
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 13:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhKANWo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Nov 2021 09:22:44 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:33787 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhKANWo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Nov 2021 09:22:44 -0400
Received: by mail-ot1-f46.google.com with SMTP id 107-20020a9d0a74000000b00553bfb53348so25326345otg.0;
        Mon, 01 Nov 2021 06:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=NQsXgN1/B5gwjOVAAacfDLhfdCYF4Dwe+DAjivz+Nyc=;
        b=kaDXexlIPEfQISaVbZXCafx1c5ElYiRWmllHY65SZTvEqJ8U89znHlYyNRfE5vXzlq
         HTsBUcRfsK9JIk5g64oc5/vfr6lkeYwNFZWFzS0JxAD15QQwFz6m4meHR7i4TuYhlK8A
         /Z3H1xoLdWeyOMH12x02rhaovVdsN9FhoxmJNXu/PyZlMKjX41JRTl3ZR6zfYt6z5t7D
         V+G9WPPKbYQ3ttZqq01roSm6EiZP+vt4Jt+moe0O2OC58fuz0XHMKxUM3vfwsXcRx7ng
         CWKVaIirJ6ARro9qeZSADxvCNYTnQeJVvHA3+ADX21zDI5XrVjGI5f10CN6ESwC5jESS
         8uuQ==
X-Gm-Message-State: AOAM5328t/rG4VrCYTSciZctzgwvSkMu1FkIUIsaYMZJ9Seh0f+zEbX+
        2nvAJRqmKWuz5ImVrgXqxGUCScKAmA==
X-Google-Smtp-Source: ABdhPJyzU4cxvEcItOGfrwaiiIz8T6WXPuadFqxeg4zVhDDGAM4Y5N64HkjfJRt7VwCNAaxicAaTwA==
X-Received: by 2002:a9d:a64:: with SMTP id 91mr13798795otg.198.1635772810834;
        Mon, 01 Nov 2021 06:20:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x28sm4236076ote.24.2021.11.01.06.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 06:20:09 -0700 (PDT)
Received: (nullmailer pid 278147 invoked by uid 1000);
        Mon, 01 Nov 2021 13:20:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     "hammer.hsieh" <hammerh0314@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        "hammer.hsieh" <hammer.hsieh@sunplus.com>,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        p.zabel@pengutronix.de, wells.lu@sunplus.com,
        tony.huang@sunplus.com, jirislaby@kernel.org
In-Reply-To: <1635752903-14968-2-git-send-email-hammer.hsieh@sunplus.com>
References: <1635752903-14968-1-git-send-email-hammer.hsieh@sunplus.com> <1635752903-14968-2-git-send-email-hammer.hsieh@sunplus.com>
Subject: Re: [PATCH 1/2] dt-bindings:serial:Add bindings doc for Sunplus SoC UART Driver
Date:   Mon, 01 Nov 2021 08:20:09 -0500
Message-Id: <1635772809.026695.278146.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 01 Nov 2021 15:48:22 +0800, hammer.hsieh wrote:
> Add bindings doc for Sunplus SoC UART Driver
> 
> Signed-off-by: hammer.hsieh <hammer.hsieh@sunplus.com>
> ---
>  .../devicetree/bindings/serial/sunplus,uart.yaml   | 116 +++++++++++++++++++++
>  MAINTAINERS                                        |   5 +
>  2 files changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/sunplus,uart.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/serial/sunplus,uart.yaml:36:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/serial/sunplus,uart.yaml:39:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/serial/sunplus,uart.yaml:42:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/serial/sunplus,uart.yaml:45:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/serial/sunplus,uart.example.dts:20:18: fatal error: dt-bindings/clock/sp-sp7021.h: No such file or directory
   20 |         #include <dt-bindings/clock/sp-sp7021.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/serial/sunplus,uart.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1548996

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

