Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F007CCD6E61
	for <linux-serial@archiver.kernel.org>; Wed, 11 Oct 2023 11:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjJKL6v (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Oct 2023 07:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjJKL6u (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 07:58:50 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B411EB8
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 04:58:47 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7b3d33663so29567197b3.3
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 04:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697025527; x=1697630327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcZX87bVMqxb05uB6AITFLlBPsFoCe5WSTHnOrtHLWk=;
        b=PCMwqTGTQSOdLQ5tzB4LsBush06zF9Zytml2uVqQkmENIq1Anj3QU+O/JMLl5UsA9O
         CRbAFcOwQT0RPu+6/7RLcQ5TrfwJHGs7VdDD14IaWsOnPwYE+OANIc7ibaSyn98ltawr
         pkEfoE/+K09sQdCV0je8/kBBvH6sZ1c0sumoDBXIjZrrGQKUFZUmXKqlAsnMucWux04+
         ALpHIOj69o21eamlYt6rE013p0AM/etYpPlkAazk09YPXC3g9A0VEmIcmKhwYsFDTd4d
         Sff5IkEAnKB6JpOir1RF++S0ZeHLahrAg7dCONmokRf0iwnYS2RqZb0VTdin48DSn+80
         pHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697025527; x=1697630327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcZX87bVMqxb05uB6AITFLlBPsFoCe5WSTHnOrtHLWk=;
        b=mPCXG+gySIyRO2JW3d2MSGP5b0L0Hw5EIrMTMxHGYue+1Y2+VxoAttBGKiqtxtilSK
         3HutEPWrM2dBq2TuSbhBKw04bzQ2L1/KbX9B0wDwSq6UYsQifBBpWWAoauTWTldzla3R
         mBNjAz0X8e3Xgy/k2qjPDY5Hocm01FL+ZbW/Sc2RDhKC7RdVctWeuemFhw7/ki26LuU6
         y2YJpcLRkgqK/8x5MPxg4zEDZoQnMniY0OvCPog5d/lV7uQPNW3ifqUmdREylfLrr16R
         vRiQ+o+xfiruy3CqrUZS6oWbBZdg3Qe8Gu3yURfzocplB1g0fu7x+QW0c2fJ6qvuHSdD
         Lukg==
X-Gm-Message-State: AOJu0YzRBUsd+0JjbaB4cwT7aMoRFOo9d7KwsOgoKBN/ommZehNZqRqL
        lL4xNJg3hxGvyPfenNht/muEhNm1iRHf5fShDuQxSA==
X-Google-Smtp-Source: AGHT+IEMT7FKO0GU0LYWIJk61ZoZMd77YWiVGpHr+v/XgAesZ5a9ZC1QYGCxEuGoxQsKfMhFwWDDkXPOv2GeSnJqJoE=
X-Received: by 2002:a81:5c86:0:b0:59f:4f56:59bc with SMTP id
 q128-20020a815c86000000b0059f4f5659bcmr22662562ywb.42.1697025526803; Wed, 11
 Oct 2023 04:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231010224928.2296997-1-peter.griffin@linaro.org>
 <20231010224928.2296997-9-peter.griffin@linaro.org> <2023101111-banknote-satin-1f77@gregkh>
In-Reply-To: <2023101111-banknote-satin-1f77@gregkh>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Oct 2023 13:58:35 +0200
Message-ID: <CACRpkdbsP5B2=5QRNidsPGyGn8gDPJPMMLyJ7U=nhhohff8UiQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/20] dt-bindings: serial: samsung: Add
 google-gs101-uart compatible
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Peter Griffin <peter.griffin@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        conor+dt@kernel.org, sboyd@kernel.org, tomasz.figa@gmail.com,
        s.nawrocki@samsung.com, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, cw00.choi@samsung.com, tudor.ambarus@linaro.org,
        andre.draszik@linaro.org, semen.protsenko@linaro.org,
        saravanak@google.com, willmcvicker@google.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel-team@android.com, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 11, 2023 at 9:48=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:

> >        - enum:
> >            - apple,s5l-uart
> >            - axis,artpec8-uart
> > +          - google,gs101-uart
>
> These shouldn't be needed, just declare the device as the same as what
> the chip really is (i.e. a samsung uart), that way no .yaml or kernel
> driver changes are needed at all.

We strive to have these as unique as possible, as it is a hardware
description. It is fine to write drivers in Linux or any other OS just
being aware of a "courser" idea of what UART this is, in this case
would have looked something like this:

    compatible =3D "google,gs101-uart", "samsung-uart";

And the driver would be able to match to just the latter string
(these are listed in "particularity order").

BUT! The binding authors chose not to go that path, instead they
have one unique compatible string per hardware/integration version,
essentially per-SoC. So in this case it is just:

    compatible =3D "google,gs101-uart";

It is kind of impossible to fix now as well, because these bindings
are already deployed. So they are like a BIOS: written in stone.

It is possible to add dual compatibles for this *and following*
variants, but I don't know how Krzysztof feels about that, and as
others point out, probably knowledge of the exact SoC is
necessary.

Yours,
Linus Walleij
