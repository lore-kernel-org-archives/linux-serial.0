Return-Path: <SRS0=wTQQ=5W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156AFC2BA1E
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 10:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE042075E
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 10:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586170042;
	bh=u/X6i+pwbj4Go4hz551p6d+YJfNGL+983Ma99T64H9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=15pwVpeQXEgTxQ5E5xQ3gB4O2exqAqcfnhyoOSND9v2a11EX77/lkTjGu8we8mo6R
	 MeaxcPDmDU97s3JkWLH7nQuEDGWmHdtjFDn437xiVrsF7/fW5mXez6hCtnixMBsbAQ
	 LuiHN5KeMhNHq45IYDV17i5ITqK8Xl9mfS0ofq6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgDFKrS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:47:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42890 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgDFKrS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Apr 2020 06:47:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id cw6so18588492edb.9;
        Mon, 06 Apr 2020 03:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UAxqYdPL6az1VgPFrfxQ/rn+ZWBqyWdcAzok87Z4u2E=;
        b=LCyDFq6iTs1cx9oMAN6SI8W2jQYULe2C9YZszMNwTbZjL5scjRXcFeOnQZmtf0dH5n
         wL/wKInrZ9TI9SbAe+sjnbWcG8cs3ha3iI8hnDe7jO3NbJeWHLyy4IMr6699UHKS3hU/
         w1Ofq5SXXln9EyhM6MHKl1xd7D8fCo1K8pbagLqiPqkGIvvZHJuQWBIp/RKYB+VyIncR
         9kRY4Id4qgwNjV+wFFrvQ23/Z8i10+vC41kEd+5RcpxomZl3bqD7eoYMMY5Py8y8o65y
         ml9WCgwkuhxSipor65YyEeja5/1V5PHORWAXxkpXiILBWhJXVG4GuM/Mw6RByudfw1+m
         HP6A==
X-Gm-Message-State: AGi0Pub7BGaFOCx5l2mHAOCldNE2ArNr0djCTWMAQwKwxEB8/KnrXnvt
        3VRCTe645wKJ3uib9mNuaG0=
X-Google-Smtp-Source: APiQypKkmi8CBCaysXUslPpenLVQu3HtftW3JIysFyeclM2AJ0m49d4QSlRgMy7XSMhhvzq1JOaQ1w==
X-Received: by 2002:a50:e107:: with SMTP id h7mr19285192edl.124.1586170035816;
        Mon, 06 Apr 2020 03:47:15 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id r25sm2422181edy.77.2020.04.06.03.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 03:47:15 -0700 (PDT)
Date:   Mon, 6 Apr 2020 12:47:13 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     gregkh@linuxfoundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: serial: Add reg-io-width compatible
Message-ID: <20200406104713.GB16798@kozik-lap>
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <20200406103127.17105-1-hyunki00.koo@samsung.com>
 <CGME20200406103206epcas2p2bf3c65f96d94cc91fcdcd3e6db75e2a3@epcas2p2.samsung.com>
 <20200406103127.17105-2-hyunki00.koo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406103127.17105-2-hyunki00.koo@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 06, 2020 at 07:31:26PM +0900, Hyunki Koo wrote:
> Add a description for reg-io-width options for the samsung serial
> UART peripheral.
> 
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> index 9d2ce347875b..a57b1233c691 100644
> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> @@ -29,6 +29,14 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  reg-io-width:
> +    description: |
> +      The size (in bytes) of the IO accesses that should be performed
> +      on the device.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [ 1, 4 ]

I just noticed that the allOf is not needed. Just enum [1, 2] is enough.

With that change:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

> +
>    clocks:
>      minItems: 2
>      maxItems: 5
> -- 
> 2.15.0.rc1
> 
