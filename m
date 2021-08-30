Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523CBC4320A
	for <linux-serial@archiver.kernel.org>; Mon, 30 Aug 2021 15:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235E360F45
	for <linux-serial@archiver.kernel.org>; Mon, 30 Aug 2021 15:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbhH3PLj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Aug 2021 11:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhH3PLj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Aug 2021 11:11:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AA5B60F6C;
        Mon, 30 Aug 2021 15:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630336245;
        bh=NL8U16L4zUeFBY5oDWerWoR1p2Tof8Q5FTfmEfMD1C8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zkv2kk+iflAlIwvmfeuHyzY+fbQaJUjRDDU+Jl60iFsgbWUFQvzbBY2KucLRr79zv
         ujBeNtNyVuZsp7kuV+8rludg5cK29opKkCJL4fgXVlmghejDsRi7q6xCPbuvfpi4Vb
         I9yqpn6L6fD19T6ayk0J+I1829yytD8NFTv3diqutHA2GIcC18/QPco5WmzzZ1MWBD
         +Rc5kb3r094drs0/9Z79llK5vrOoDyqj/Ln2mn3/VGzPAeb/tDdwFYyY9Iy5I207kt
         MVgOUpC5gvpWua16e3IGZzZge07RefZ1O9hq2ZVr0GI/bXcuR1Wz7rF9zVauKIFvjw
         1pWZReHr0beOA==
Received: by mail-ej1-f47.google.com with SMTP id h9so31884388ejs.4;
        Mon, 30 Aug 2021 08:10:45 -0700 (PDT)
X-Gm-Message-State: AOAM531W6oV7nCcbq0GNwuN6tyRSSXakdj3s88Z7xPkQSnKyICab5l6C
        BUqlPme0HUOzrpgCiaZ2srlS5KN8kP0X+/ZXSw==
X-Google-Smtp-Source: ABdhPJxlbFncAG8e6gxo/IKfFqNeNBjwn/QydwqBwdoY47DHL5DAyx94XYxJau0m0nGvEBTVAiz6XabtertxLAghTys=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr26190170eje.341.1630336244250;
 Mon, 30 Aug 2021 08:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210819134859.19537-1-zajec5@gmail.com> <20210829131927.13682-1-zajec5@gmail.com>
In-Reply-To: <20210829131927.13682-1-zajec5@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Aug 2021 10:10:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK02ixi7pmSoc+PoyactDgiP1i3WhBCs7COj32gCuzhXQ@mail.gmail.com>
Message-ID: <CAL_JsqK02ixi7pmSoc+PoyactDgiP1i3WhBCs7COj32gCuzhXQ@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: serial: brcm,bcm6345-uart: convert to the json-schema
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Aug 29, 2021 at 8:19 AM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> =
wrote:
>
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> This helps validating DTS files.
>
> Redundant generic descriptions (e.g. "The base address of the UART
> register bank") were dropped and periph_clk was dropped from example as
> not required.
>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/serial/brcm,bcm6345-uart.txt     | 36 --------------
>  .../bindings/serial/brcm,bcm6345-uart.yaml    | 47 +++++++++++++++++++
>  2 files changed, 47 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm6345=
-uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm6345=
-uart.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
