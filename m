Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C0DC4167D
	for <linux-serial@archiver.kernel.org>; Tue, 14 Nov 2023 12:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjKNMxE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Nov 2023 07:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjKNMwx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Nov 2023 07:52:53 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95EF1735
        for <linux-serial@vger.kernel.org>; Tue, 14 Nov 2023 04:52:49 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso5525147276.2
        for <linux-serial@vger.kernel.org>; Tue, 14 Nov 2023 04:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699966369; x=1700571169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dm5tIBxlFob9g4Fl4wFAfi9oUFoS3/1CELy15DVM1mI=;
        b=IUva1w1nEizlrvNSoUb3UCdQBfVmQ5Q4YZp7nEJb92vakCXDD3tvM56YuNFWj73t56
         TOoZ95mU9fpkZD2KzIW51MFjmpbE6+hIE3T+so0B1GAhA59XFPmZTZSjSDtLr8mydiBn
         Ef9QF2o6CrkfgsAZcZmj+S4j8KOM99mRlpubKhiM/m53A3QLZcc5PUzMkjqGMDY8tRdu
         PS8vjaJPg0kpvBHmKGd8zxZQbZXG+Bwl+WJuQcx5XkAv1XEgI7/vnmvOcFgAVwjfcR2L
         th8L1YtixZdLUKGq3erttfLhik3qL8eBf1l3jQIVwmRRUC1q/x+O6K6Hk1CZ3y4DfDHl
         jIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699966369; x=1700571169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dm5tIBxlFob9g4Fl4wFAfi9oUFoS3/1CELy15DVM1mI=;
        b=b0fg4J5vVAHYuVfpo8OxFYk8Xv+rgr6aeI7tqOqggKFHBMd4cclEe3nEdgI6h5lq6z
         9C/VIfgOquzditeCV7Xz6jdqKz+8WaXEFKDD9edQ8dQC9g6MZ3ynAk9e/eIowlt4Cpc3
         HFjl31kQVkuH+xFjdPRVJMAVL7K/kSwmOrUZ4tG3NZeG5ehP0Rqj4Ap47F8FChhAs/9d
         x5ToJlfnNBwtJ3yZ0584SPb1V8rMxQ4UOqTSAYTMPIDstUzbv2KSJnQnrPgrU1fl/UVd
         QfZYCDs2QAWLcaoAgYADRenf65C1LX/YiYth6oaLJYHbOsiGK6EP/BsqolxSK64MEZt4
         b76A==
X-Gm-Message-State: AOJu0YztORuPX/rNMiyP4+KlM/mvD0tq4dXVz09e178Wcdh5ZfikLMNj
        iDUnWiVrgclRYCotA1qfqwI331kHwQRWGKfk57xArw==
X-Google-Smtp-Source: AGHT+IHb5y2/nAMzpAAbpcAqsc2332J3Hl+TEbnJYw6VgROQL9pFrDJMQLjA7DxF+w42E0bHCOIHzfYDBAjoO7yaXoA=
X-Received: by 2002:a25:6951:0:b0:da3:ab41:2fc8 with SMTP id
 e78-20020a256951000000b00da3ab412fc8mr8347458ybc.16.1699966368706; Tue, 14
 Nov 2023 04:52:48 -0800 (PST)
MIME-Version: 1.0
References: <CGME20231031095014epcas2p2814fa2bb5f940ccb0d0951667df34f98@epcas2p2.samsung.com>
 <20231031094852.118677-1-jaewon02.kim@samsung.com> <CACRpkdZRMJgWkLwKstpN_9=VGutbE1wBv+X_a15RJ=7ddNtbHw@mail.gmail.com>
 <15d9340a-dd4f-43fc-96c6-f6a8daf76e11@linaro.org>
In-Reply-To: <15d9340a-dd4f-43fc-96c6-f6a8daf76e11@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 13:52:36 +0100
Message-ID: <CACRpkdYrJMnJLHa1+Vtga3WdYySx9ioGzqmnf1uZKGdBxEWa_Q@mail.gmail.com>
Subject: Re: [PATCH 00/10] Introduce ExynosAutov920 SoC and SADK board
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 13, 2023 at 8:59=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 13/11/2023 15:11, Linus Walleij wrote:
> > Hi Jaewon,
> >
> > thanks for your patches!
> >
> > On Tue, Oct 31, 2023 at 10:50=E2=80=AFAM Jaewon Kim <jaewon02.kim@samsu=
ng.com> wrote:
> >
> >>   dt-bindings: pinctrl: samsung: add exynosautov920 pinctrl binding
> >>   pinctrl: samsung: add exynosautv920 pinctrl
> >
> > It is best if I can apply these two separately once Krzysztof is happy
> > with them. I hope that would work? I don't see any specific dependencie=
s.
>
> That's fine. I might have conflicting pieces in-flight, but then I'll
> funnel these through you as well. I can apply these to my
> samsung-pinctrl tree and send them to you as usual, unless you prefer to
> apply yourself.

Oh that's best of course, you take them when you think they are ready.

I was more referring to that we should be able to merge the two pin control
patches apart from the rest of the series.

Yours,
Linus Walleij
