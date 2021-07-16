Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01315C636CA
	for <linux-serial@archiver.kernel.org>; Fri, 16 Jul 2021 19:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC6A61405
	for <linux-serial@archiver.kernel.org>; Fri, 16 Jul 2021 19:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhGPT3Z (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Jul 2021 15:29:25 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:35737 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhGPT3G (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Jul 2021 15:29:06 -0400
Received: by mail-io1-f48.google.com with SMTP id d9so11845049ioo.2;
        Fri, 16 Jul 2021 12:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=52z2fggFE76lV+jwVY4+h2N/nguFoK/TfvmA+Fnhx74=;
        b=INHycpsPsWj7jv0B4V59pV8zgp2wDbST9iRkvpj+VuyaeIDNcGc4MnuURT6K4nlqM1
         Xn8SHU8LDMlW5UoXFGMCBrDByFLNJpXyUImqOjLGx/cBtKeLkYdVkSs1U3LM6uHVeqNc
         udny/EjRffmZ6r6BBVzC8RKLBXL4m87AyhR4++q8w7Vssi52paFzc0MFC/eijzytcnN4
         l7QL98HDqBhgCg3KJl6PiqoP+3eE6PhsOr9biGOKcsjZpf/XeTt7lMhDCWmf6kFbIPf9
         JakK5MchrYYwrEr2thTWv4VUf4muYUJK8udNSEBDhL3TD7xha8xeeLTmFN1GkAuQv7sA
         B6GQ==
X-Gm-Message-State: AOAM531fmx3rwrYz1/5nfULbWqAy49cV/dVTDZ/jq0R/HLLV22eYSEXv
        yrixYmVMwCJ1CwKpjstoDg==
X-Google-Smtp-Source: ABdhPJwGZt4ru1529eW1ltxLK83X/UjpNzWoifQBZeUek2y113cnYjYL98uZ5xoUS65eOMuYt/MuVg==
X-Received: by 2002:a5d:80da:: with SMTP id h26mr8615946ior.206.1626463569790;
        Fri, 16 Jul 2021 12:26:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r3sm5190223ilg.20.2021.07.16.12.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 12:26:09 -0700 (PDT)
Received: (nullmailer pid 3840951 invoked by uid 1000);
        Fri, 16 Jul 2021 19:26:06 -0000
Date:   Fri, 16 Jul 2021 13:26:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     shubhrajyoti.datta@xilinx.com, soren.brinkmann@xilinx.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, navam@xilinx.com,
        peter.crosthwaite@xilinx.com, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        michal.simek@xilinx.com
Subject: Re: [PATCH v2] dt-bindings: serial: convert Cadence UART bindings to
 YAML
Message-ID: <20210716192606.GA3840890@robh.at.kernel.org>
References: <20210715092252.225740-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715092252.225740-1-iwamatsu@nigauri.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 15 Jul 2021 18:22:52 +0900, Nobuhiro Iwamatsu wrote:
> Convert serial for Cadence UART bindings documentation to YAML.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> 
> ---
> v2:
>   - Fix enum of compatible
>   - Change from additionalProperties: false to unevaluatedProperties: false
>   - Update compatible string in examples.
> 
>  .../devicetree/bindings/serial/cdns,uart.txt  | 27 --------
>  .../devicetree/bindings/serial/cdns,uart.yaml | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
