Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BE3C4361B
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 23:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A511F2333C
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 23:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436905AbgLKWwH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Dec 2020 17:52:07 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35963 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436883AbgLKWvv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Dec 2020 17:51:51 -0500
Received: by mail-oi1-f194.google.com with SMTP id 9so4563436oiq.3;
        Fri, 11 Dec 2020 14:51:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=h7zhj3Eq/PeLm/regPaAoJk6bDhExNvRnLL3xHOt2JE=;
        b=shKAtDuYzVzg1CNTqzvx7kKFYZMwD1wdkcqnOvcQG11GbdvXjbimYoNjuLHsjW2CeO
         CAlgVvkW2Q77Ho3oiTLpOu/hGdls8u1UwEqw4t6FyY1DGQ8iqecbyt95z/dUkCeVHN0b
         ryc/gCjEaL+XEsS+GB9kW9F5rBY4Mp1bIEmFuHwx1BNJun+I05hn1GYTQixxr8LBTrLe
         3hewt7K/LduvFp8y+Cd+p4YV3lfjsBJbj63jtIYXOh5bv6DPxPb1OLfmNCxq96D3lz2y
         8rBnNbO9KzO3c1yQ30gR34nn/kA1w9rqNpwdQy6mg13thZUNAZh9MeM7R7tgHkz/X3eg
         eGeg==
X-Gm-Message-State: AOAM532Bm06MHKv0cUuNQ0xnm5xAP87r9ABDwX0mbUEIhdvnpIE2uBka
        RZC/EE3DSh8uN0QAIFoHhQ==
X-Google-Smtp-Source: ABdhPJwDiOuBEqQDA5B+u90cdec7hl8WIumo6jw3kCYx5wAB1axlc4l+h2GK7j0hJsnP9QFfsq953A==
X-Received: by 2002:aca:b145:: with SMTP id a66mr11169400oif.92.1607727070606;
        Fri, 11 Dec 2020 14:51:10 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t72sm2146217oie.47.2020.12.11.14.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 14:51:09 -0800 (PST)
Received: (nullmailer pid 1106930 invoked by uid 1000);
        Fri, 11 Dec 2020 22:51:08 -0000
Date:   Fri, 11 Dec 2020 16:51:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
Cc:     linux-kernel@vger.kernel.org,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        'Jiri Slaby' <jirislaby@kernel.org>,
        'Rob Herring' <robh+dt@kernel.org>
Subject: Re: [PATCH v3] Serial: silabs si4455 serial driver
Message-ID: <20201211225108.GA1106590@robh.at.kernel.org>
References: <20201211193124.GA26514@dincontrollerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201211193124.GA26514@dincontrollerdev>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 11 Dec 2020 19:31:27 +0000, József Horváth wrote:
> This is a serial port driver for
>  Silicon Labs Si4455 Sub-GHz transciver.
> 
> The goal of this driver is to removing wires
>  between central(linux) device and remote serial devices/sensors,
>  but keeping the original user software.
>  It represents regular serial interface for the user space.
> 
> Datasheet: https://www.silabs.com/documents/public/data-sheets/Si4455.pdf
> 
> Signed-off-by: József Horváth <info@ministro.hu>
> ---
>  .../staging/serial/silabs,si4455.yaml         |   98 ++
>  MAINTAINERS                                   |    7 +
>  drivers/tty/serial/Kconfig                    |    8 +
>  drivers/tty/serial/Makefile                   |    1 +
>  drivers/tty/serial/si4455.c                   | 1328 +++++++++++++++++
>  5 files changed, 1442 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/staging/serial/silabs,si4455.yaml
>  create mode 100644 drivers/tty/serial/si4455.c
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/staging/serial/silabs,si4455.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/staging/serial/silabs,si4455.yaml#


See https://patchwork.ozlabs.org/patch/1415258

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

