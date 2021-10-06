Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456ACC433FE
	for <linux-serial@archiver.kernel.org>; Wed,  6 Oct 2021 21:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2613C61177
	for <linux-serial@archiver.kernel.org>; Wed,  6 Oct 2021 21:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbhJFVNX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Oct 2021 17:13:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239589AbhJFVNX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Oct 2021 17:13:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4ACF611CA;
        Wed,  6 Oct 2021 21:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633554690;
        bh=LNqbS/LMwUeuhG2zkUpaTJ+yjUbdFlkv6r1NbAyBvEc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YA++Nn5DpRsJi+OnbxNBvrKTC0QUnxtkG5HvT15TNnluNwqOWca6cjEBPol7eX+Oc
         gX4GS/tDGlyxOhqmR6munc5e39ebDn4xizkooCyR5IZblmn19m1n1Hx/dqcJcgT/Cn
         e5TmZF+hE85IXK9/NUWGoGXDidmnb8/ou3wjU7dfNyTGAl1+VzrXzBaDlsO5QD22PZ
         55AA3Gbx8a/ahzfbbUYCjW43mrvy7uzB6vSXWRkwIJ+Rsq1d29pFCJghA6bqwTQCG+
         fpMEqaBP2q2P9IAH8ljNjb22rLb7v+4a+3RYp3G0DqbuFBMh00MyavtESllwwxmuPS
         ly0UOPPYKD6KQ==
Received: by mail-ed1-f42.google.com with SMTP id p13so15257047edw.0;
        Wed, 06 Oct 2021 14:11:30 -0700 (PDT)
X-Gm-Message-State: AOAM530w5P+KpJpCX5ejr1a4Q74JSg79PK64+3lcgQpJ2ei2Ytw21Jpm
        FyOjwGlIKIwv5CV2cX75HJPWljetpIofayoeqA==
X-Google-Smtp-Source: ABdhPJzKiId+LYfDotK6HTjCThex+azZFfK2kUjEIgU9HIOsNulHfvi5yvu457cW9uYkiTtQpx2oaFO6JaLRVhFLVcs=
X-Received: by 2002:a17:906:7217:: with SMTP id m23mr644987ejk.466.1633554689344;
 Wed, 06 Oct 2021 14:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210930095838.28145-1-pali@kernel.org> <20210930095838.28145-5-pali@kernel.org>
In-Reply-To: <20210930095838.28145-5-pali@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 6 Oct 2021 16:11:18 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+b5T+q2HbnvWNwg4FZEPnwJgyK2-QF1wCs-=VTvC67Ww@mail.gmail.com>
Message-ID: <CAL_Jsq+b5T+q2HbnvWNwg4FZEPnwJgyK2-QF1wCs-=VTvC67Ww@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] dt-bindings: mvebu-uart: update information about
 UART clock
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
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 30, 2021 at 4:59 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Device "marvell,armada-3700-uart" should use
> "marvell,armada-3700-uart-clock" compatible clock.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  Documentation/devicetree/bindings/serial/mvebu-uart.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
