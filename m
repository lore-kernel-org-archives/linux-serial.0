Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1732C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 28 Sep 2021 17:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D706127C
	for <linux-serial@archiver.kernel.org>; Tue, 28 Sep 2021 17:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242006AbhI1R51 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Sep 2021 13:57:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241520AbhI1R50 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Sep 2021 13:57:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C3E06120C;
        Tue, 28 Sep 2021 17:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632851746;
        bh=wFMOSOkKaoktyKZUKcg3mKHp2fe43aaRClNuubaI42Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o0ojco2xtDtrKPWflJBck9j6+5oP5GGMoH+esu2d0vS2KLn2abHzDuuuVlxkUiKPd
         RSm2Un6V/FtxodML1ZhLKkGGsXjbmRC4fGKY0Rxq7fK2kPszUhQGMOtkEKjmg0WPmL
         xV++XFNyBeNFr7CGS64clP3K0BxcOYX5OBGOSzhmeXlHvePSCROPdRvpwGn6EbfkNX
         N7ANbE5FuyMGEogE+h9pBmZKfutYbnfo95BUHgnLHTODzU6Z0Iz89El72UBhn5OEyf
         pJ7Py/8w7ov2eN2wV4Onp7ZEc9aYWjE7C8w/fI5AeB06sQmhEJz9G6FIV2Wq+bxHQV
         4oDQw1cxfFuMQ==
Received: by mail-ed1-f49.google.com with SMTP id x7so71662265edd.6;
        Tue, 28 Sep 2021 10:55:46 -0700 (PDT)
X-Gm-Message-State: AOAM5329G97P/qAPkrk8GUfi59rDXbNAt/G9nYnzTWgMyZ4rHhiIh8Qo
        96Ii5tSg33MNmMrPZ4PHFBHLlPk/z60HQInPxg==
X-Google-Smtp-Source: ABdhPJzzNJpGnWD7YxPzLRtANNBDGlQPzoPdPY8LMOSqmUJeIBaIOJ5HQ0U1KJZunHnLsxxoX4hKgzugKIeE2prsiuo=
X-Received: by 2002:a17:906:a294:: with SMTP id i20mr8213411ejz.128.1632851736030;
 Tue, 28 Sep 2021 10:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210922105433.11744-1-pali@kernel.org> <20210922105433.11744-4-pali@kernel.org>
 <CAL_JsqKS1rjEeM558d2n6Uk1+tCazASoGJ-kDS144PsH8-Akwg@mail.gmail.com> <20210927204524.giaormuph3vcy4ls@pali>
In-Reply-To: <20210927204524.giaormuph3vcy4ls@pali>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 28 Sep 2021 12:55:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKO+o4Ny92We8CtRuDWrhv8z_91ejy9SSyobC4rupQrig@mail.gmail.com>
Message-ID: <CAL_JsqKO+o4Ny92We8CtRuDWrhv8z_91ejy9SSyobC4rupQrig@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 3/6] dt-bindings: mvebu-uart: document DT
 bindings for marvell,armada-3700-uart-clock
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Sep 27, 2021 at 3:45 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Monday 27 September 2021 15:17:59 Rob Herring wrote:
> > On Wed, Sep 22, 2021 at 5:56 AM Pali Roh=C3=A1r <pali@kernel.org> wrote=
:
> > >
> > > This change adds DT bindings documentation for device nodes with comp=
atible
> > > string "marvell,armada-3700-uart-clock".
> >
> > Please resend to the DT list so that checks run and this gets reviewed
> > in a timely manner.
> >
> > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > ---
> > >  .../bindings/clock/armada3700-uart-clock.yaml | 57 +++++++++++++++++=
++
> > >  1 file changed, 57 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/armada370=
0-uart-clock.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/armada3700-uart-=
clock.yaml b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.=
yaml
> > > new file mode 100644
> > > index 000000000000..5bdb23e0ba3e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.y=
aml
> > > @@ -0,0 +1,57 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> >
> > Dual license. checkpatch will tell you which ones.
>
> Did not tell me :-(
>
> $ ./scripts/checkpatch.pl -f Documentation/devicetree/bindings/clock/arma=
da3700-uart-clock.yaml
> Traceback (most recent call last):
>   File "scripts/spdxcheck.py", line 6, in <module>
>     from ply import lex, yacc
> ModuleNotFoundError: No module named 'ply'
> total: 0 errors, 0 warnings, 57 lines checked
>
> Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml has no=
 obvious style problems and is ready for submission.
>
> Huh, Perl needs Python?? Anyway...
>
> $ sudo apt install python3-ply
> ...
>
> $ ./scripts/checkpatch.pl -f Documentation/devicetree/bindings/clock/arma=
da3700-uart-clock.yaml
> Traceback (most recent call last):
>   File "scripts/spdxcheck.py", line 10, in <module>
>     import git
> ModuleNotFoundError: No module named 'git'
> total: 0 errors, 0 warnings, 57 lines checked
>
> Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml has no=
 obvious style problems and is ready for submission.
>
> Second attempt...
>
> $ sudo apt install python3-git
> ...
>
> $ ./scripts/checkpatch.pl -f Documentation/devicetree/bindings/clock/arma=
da3700-uart-clock.yaml
> total: 0 errors, 0 warnings, 57 lines checked
>
> Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml has no=
 obvious style problems and is ready for submission.
>
> And no error :-(

Looks like file mode requires '--strict' to enable while patch mode doesn't=
.

Rob
