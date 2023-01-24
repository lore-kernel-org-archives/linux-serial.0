Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043D9C25B4E
	for <linux-serial@archiver.kernel.org>; Tue, 24 Jan 2023 19:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbjAXTGv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Jan 2023 14:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbjAXTGj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Jan 2023 14:06:39 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF564F34A;
        Tue, 24 Jan 2023 11:06:19 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id k1-20020a056830150100b006864d1cb279so9786333otp.5;
        Tue, 24 Jan 2023 11:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+NfNuCi5ZpkZRVMPOCnfqUcdZ8GqAml5t2tot6/EKCo=;
        b=vFUsRgnHXVuYLFs/BExuKBsEbB/pCM2mMpESXu//HVq42Fz67kTvUA1OpW4Ht+WVHy
         +sfWCJbSwHA8tH8Go0KhqETCZh1cQIezTP3zCVf5pbJSGTWxWWHkR+hqK7mw+mT2VN2q
         VpebT+enOxJsXlmPbiA04x2OyblFWxKsaIeJaTwpL8UmZwj/TjW2bN0qLi6nPcv4sLyu
         Cj2UvDbjRTliWFrHubc+ZqY74RjpcoQfHwvSgEssKp9y8dTF34cDRLhwQ4tYO8T8ZDOs
         5QmLRNHoHs+cZqJHnHJ2RW3WlTAzC0mVTvDbl/zOdRTf9UIY+itkxfi8F/crI7MaJeV2
         xS/A==
X-Gm-Message-State: AFqh2ko5nIPt//UCuKJILVkgBLo7oXXrzs266MC/4mh6k1s/HjHSdCh9
        l0A0g0Afu59DOO6EAMTnjg==
X-Google-Smtp-Source: AMrXdXsTcYlKXJ9N9liCZsK+H3xHRo9ad7d3ruICimNZnlrMn2kHv47BQEVx5SRda58GcPZNAtnl5Q==
X-Received: by 2002:a9d:6d88:0:b0:684:d32b:90fb with SMTP id x8-20020a9d6d88000000b00684d32b90fbmr14904662otp.20.1674587178696;
        Tue, 24 Jan 2023 11:06:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u15-20020a9d4d8f000000b00684e4d974e6sm1293320otk.24.2023.01.24.11.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 11:06:18 -0800 (PST)
Received: (nullmailer pid 1261085 invoked by uid 1000);
        Tue, 24 Jan 2023 19:06:15 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc:     jirislaby@kernel.org, robh+dt@kernel.org, sherry.sun@nxp.com,
        marcel@holtmann.org, linux-serial@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rohit.fule@nxp.com,
        devicetree@vger.kernel.org, amitkumar.karwar@nxp.com,
        linux-bluetooth@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, gregkh@linuxfoundation.org,
        netdev@vger.kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
In-Reply-To: <20230124174714.2775680-3-neeraj.sanjaykale@nxp.com>
References: <20230124174714.2775680-1-neeraj.sanjaykale@nxp.com>
 <20230124174714.2775680-3-neeraj.sanjaykale@nxp.com>
Message-Id: <167458712396.1259484.1395941797664824881.robh@kernel.org>
Subject: Re: [PATCH v1 2/3] dt-bindings: net: bluetooth: Add NXP bluetooth support
Date:   Tue, 24 Jan 2023 13:06:15 -0600
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On Tue, 24 Jan 2023 23:17:13 +0530, Neeraj Sanjay Kale wrote:
> Add binding document for generic and legacy NXP bluetooth
> chipset.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>  .../bindings/net/bluetooth/nxp-bluetooth.yaml | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/nxp-bluetooth.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/bluetooth/nxp-bluetooth.yaml:67:1: [warning] too many blank lines (2 > 1) (empty-lines)

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/net/bluetooth/nxp-bluetooth.example.dts:18.9-15 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/net/bluetooth/nxp-bluetooth.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230124174714.2775680-3-neeraj.sanjaykale@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

