Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA8EC433ED
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 13:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1AA61451
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 13:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242976AbhDUNyU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 09:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242830AbhDUNyU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 09:54:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B4426144B;
        Wed, 21 Apr 2021 13:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619013226;
        bh=0rKvhLDt7blseOg5lD76BiIXxaQkYgn7bjwS1ztIl8w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RN1PJp8eNC1a0HXnqqlbRdq3tj69BR6ciaOgMKHpaCH0u+hk/Q+SyiuQSByjJjB8t
         6q0fcravS1r/cD8UooCi6dTSjzevxOINfEF8/oj5Qhw59oGjyOsyxd5Cjw3iNbr61G
         Sx0ViEpZI2DGgfcQdL0ZtGBHBFRcUJ7eCsS3+mODfLQHX4ARnwBZduAlLXU7yBbidQ
         S6f+nu4w5wq1qNcncwImZphH30sVR6z20rOvBfP91Q0Njvr4qfXM5W5C7pgyLAyq9d
         Fveqs175c9iSeruoputPHo4hZusrQyB9op1eD1eO/hAzrXjIlCHh2IRU1UVoGyZSTb
         RLpy6/nkbL2fA==
Received: by mail-ej1-f50.google.com with SMTP id r20so13868188ejo.11;
        Wed, 21 Apr 2021 06:53:46 -0700 (PDT)
X-Gm-Message-State: AOAM533olciDEHoMp9Jm4pYKjoAJw8bAJRiEoBfvs6pXOvUPLEOSl7lh
        HwXjBEX4ZXpbN+MpirVKGJ4OaLc8/X5/cZD1OQ==
X-Google-Smtp-Source: ABdhPJwIHkkky38gGfZa2TH3r1i3DdQKvoDkySZpNTy1vBol05zTr9KSCzZmWWJgkBCrSSa5CinqqrbXNCD9NtNQ5lU=
X-Received: by 2002:a17:906:7806:: with SMTP id u6mr30969225ejm.130.1619013224782;
 Wed, 21 Apr 2021 06:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210415073105.3687-1-thunder.leizhen@huawei.com>
 <20210420200246.GA3717650@robh.at.kernel.org> <fa6c6079-8061-5774-8252-31956ac84ae2@huawei.com>
In-Reply-To: <fa6c6079-8061-5774-8252-31956ac84ae2@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 21 Apr 2021 08:53:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKggh0XDCHg8E694Zjuz2yiJ6tkxHDBDsMM3Y_XiZxypA@mail.gmail.com>
Message-ID: <CAL_JsqKggh0XDCHg8E694Zjuz2yiJ6tkxHDBDsMM3Y_XiZxypA@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: serial: Add label property for pl011
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 21, 2021 at 4:38 AM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2021/4/21 4:02, Rob Herring wrote:
> > On Thu, Apr 15, 2021 at 03:31:05PM +0800, Zhen Lei wrote:
> >> When there is more than one pl011 serial port present, the label prope=
rty
> >> allows a custom name to be used for briefly describe the usage or posi=
tion
> >> of each serial port.
> >>
> >> Without this "label" property, many dtbs_check warnings similar to the
> >> following are reported:
> >> arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dt.yaml: \
> >> serial@ffd74000: Additional properties are not allowed ('label' was un=
expected)
> >>         From schema: Documentation/devicetree/bindings/serial/pl011.ya=
ml
> >
> > I think this should go into serial.yaml instead.
>
> Yes=EF=BC=8CBut if I add "label: true" into serial.yaml, it doesn't work.=
 I haven't figured out why.

Change the 'additionalProperties: false' to 'unevaluatedProperties: false'.

> By the way, should "$ref: /schemas/serial.yaml#" be replaced with "$ref: =
/schemas/serial/serial.yaml#"?

Oh, yes! Looks like it should be fixed for the other serial schemas
too. There is a /schemas/serial.yaml schema from dt-schema which
predates the kernel one, but it just has the $nodename. The kernel one
is much more complete.

Rob
