Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B02CDB465
	for <linux-serial@archiver.kernel.org>; Thu, 19 Oct 2023 12:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345637AbjJSMJT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Oct 2023 08:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345837AbjJSMJH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Oct 2023 08:09:07 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16FF10E5;
        Thu, 19 Oct 2023 05:07:12 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6cd0a8bc6dcso826900a34.2;
        Thu, 19 Oct 2023 05:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697717232; x=1698322032;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wFRRjT0zTXmC6p8qcDVTA0QbXQCr167IFLosJYeNDXo=;
        b=prf/oksbjLM3iv73MFwm65sL63gCESPsv7lKDDbW7uD9MMJafKWzsmsM2vAKd0j6QH
         pbQ2l3Q87KOM+50e/+wFE6f3wHHCn5DMLxAVKIkQbndDYmWaEsocvV9a05gJSUBjYqcg
         Q7PcWT+eSZhXf/6YrNwLafZbQSXThmSZh66bCIlC5KoBfOQpuTCPl4G9npKZ7p3ct+a1
         kXTIhmTypVfKLGKSlZgoW11aN+X2dmRnqykUeENIshwSVN2EwoucykadFqrtQAFOVJX2
         fLfykCaOfERK94mmBL+4yzBpM1w03LU2ke4Bjt4waQSaedz7I7N90hCaY222djpaImNN
         UVlw==
X-Gm-Message-State: AOJu0YyHp7u0MF8nZ6JDkOasaE/D+9dThr85J3g+AESzhPEVHnOMZGi+
        0n/kpgBlp4CWDhge/J9VZw==
X-Google-Smtp-Source: AGHT+IEfITQC2V/bgA2b+RHY/6I/+aBRIkh/P1bJ3rw0OSLx58gTCW38pQSGxGPP+yMClqzepIgtvw==
X-Received: by 2002:a05:6830:2010:b0:6cd:bc23:4b55 with SMTP id e16-20020a056830201000b006cdbc234b55mr2070985otp.13.1697717231931;
        Thu, 19 Oct 2023 05:07:11 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m3-20020a4abc83000000b0057377b1c1c8sm994141oop.24.2023.10.19.05.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 05:07:11 -0700 (PDT)
Received: (nullmailer pid 549233 invoked by uid 1000);
        Thu, 19 Oct 2023 12:07:10 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
        conor.culhane@silvaco.com, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alexandre.belloni@bootlin.com, imx@lists.linux.dev,
        linux-i3c@lists.infradead.org, jirislaby@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, miquel.raynal@bootlin.com,
        linux-serial@vger.kernel.org, robh+dt@kernel.org, corbet@lwn.net,
        joe@perches.com
In-Reply-To: <20231018215809.3477437-3-Frank.Li@nxp.com>
References: <20231018215809.3477437-1-Frank.Li@nxp.com>
 <20231018215809.3477437-3-Frank.Li@nxp.com>
Message-Id: <169771723040.549216.11346182362736118901.robh@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-slave
Date:   Thu, 19 Oct 2023 07:07:10 -0500
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On Wed, 18 Oct 2023 17:58:06 -0400, Frank Li wrote:
> Add compatible string 'silvaco,i3c-slave' for slave mode.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/i3c/silvaco,i3c-master.yaml       | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml: properties:compatible:const: {'enum': ['silvaco,i3c-master-v1', 'silvaco,i3c-slave-v1']} is not of type 'integer', 'string'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml: properties:compatible:const: {'enum': ['silvaco,i3c-master-v1', 'silvaco,i3c-slave-v1']} is not of type 'string'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.example.dtb: i3c-master@a0000000: compatible: {'enum': ['silvaco,i3c-master-v1', 'silvaco,i3c-slave-v1']} was expected
	from schema $id: http://devicetree.org/schemas/i3c/silvaco,i3c-master.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.example.dtb: i3c-master@a0000000: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/i3c/silvaco,i3c-master.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231018215809.3477437-3-Frank.Li@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

