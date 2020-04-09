Return-Path: <SRS0=pwFA=5Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1982C2BA19
	for <linux-serial@archiver.kernel.org>; Thu,  9 Apr 2020 23:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63668206E9
	for <linux-serial@archiver.kernel.org>; Thu,  9 Apr 2020 23:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586473812;
	bh=8OFgHrPretT2WAPVFApoTK3GfJPqI2wWEcDBoetTRKM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QQ5tINxntxLwgEDZC9FpRjUIoE32UTk5HKEaykj2FCDSrtZJWkB9ViAk4Vjg5IBZf
	 tNPlqt86SxqU63bsZ3SEyuuvFgTTeGBzZEM1eK3b8P+Br6BNTwPT0qHpB/ojRdiKcM
	 t5PSdxCzyiUo5nQOgdjDi+afNasOpn23Rm3+LeDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgDIXKL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgDIXKL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Apr 2020 19:10:11 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF0920857;
        Thu,  9 Apr 2020 23:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586473811;
        bh=8OFgHrPretT2WAPVFApoTK3GfJPqI2wWEcDBoetTRKM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qrvkpzYWrPM0GNRn4cWlWkQNAAXJhlL0F+lb5xoOtWijOJc1Cyn15U7/Wo2wwXJV+
         avyMw32F2J8HyiF73EpYvwWqnmzQhb5EwGX/aczZS6rGeGGYQvJt9ZyxffcMJwPUtE
         T4mDYfLt/NVQ0ZzYNMC/2uGrxPkma0bweJ2ArSu0=
Received: by mail-qk1-f177.google.com with SMTP id g74so498968qke.13;
        Thu, 09 Apr 2020 16:10:11 -0700 (PDT)
X-Gm-Message-State: AGi0Pua1PIXscWzU9I2DwX8QHQC9j0bjhfB4DTEQ8wRLc2C9Jj928HsW
        92Y79AFds2wATvKCpLqFH/UoacmxvEycDFsH3Q==
X-Google-Smtp-Source: APiQypK5c4bIIsJuf4gcSsePb84IEjbUIt1AQt3bj2eBJj23vvVEpjuXEmsZmuGVsntKTeSLS0Xv3p/Zrqdn/EirRIg=
X-Received: by 2002:a37:c43:: with SMTP id 64mr1264128qkm.119.1586473810462;
 Thu, 09 Apr 2020 16:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <CGME20200406230906epcas2p3f5703f7f9f00cd1cf7dbe5cfd304481f@epcas2p3.samsung.com>
 <20200406230855.13772-1-hyunki00.koo@samsung.com> <20200406230855.13772-2-hyunki00.koo@samsung.com>
In-Reply-To: <20200406230855.13772-2-hyunki00.koo@samsung.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 9 Apr 2020 17:09:59 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+M__rmo1Ouh1swEnujibHGufXyHp1AEK3ZL+TkXq-MqA@mail.gmail.com>
Message-ID: <CAL_Jsq+M__rmo1Ouh1swEnujibHGufXyHp1AEK3ZL+TkXq-MqA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: serial: Add reg-io-width compatible
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 6, 2020 at 5:09 PM Hyunki Koo <hyunki00.koo@samsung.com> wrote:
>
> Add a description for reg-io-width options for the samsung serial
> UART peripheral.
>
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
> v5: first added in this series
> v6: clean description of reg-io-width
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> index 9d2ce347875b..1a0bb7619e2e 100644
> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> @@ -29,6 +29,12 @@ properties:
>    reg:
>      maxItems: 1
>
> +  reg-io-width:
> +    description:
> +      The size (in bytes) of the IO accesses that should be performed
> +      on the device. If omitted, default of 1 is used.
> +      - enum: [ 1, 4 ]

Can't this be implied by the compatible strings?

This isn't actual json-schema either with the enum under the
description. Run 'make dt_binding_check' before you send schemas.

There's a keyword for expressing the default value too. Hint: It's 'default'.

Rob
