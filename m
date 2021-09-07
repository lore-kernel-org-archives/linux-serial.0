Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EDFC433F5
	for <linux-serial@archiver.kernel.org>; Tue,  7 Sep 2021 06:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7C361100
	for <linux-serial@archiver.kernel.org>; Tue,  7 Sep 2021 06:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbhIGHAg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Sep 2021 03:00:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234243AbhIGHAf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Sep 2021 03:00:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17B806103E;
        Tue,  7 Sep 2021 06:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630997970;
        bh=ryRid3J2fsQadfh/YT1iw6bV3VSQSER/I7xMYiaP9b8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Im7aRQYYwaolx6pMtl84QmPf1n5t5CbshYbRO4pbA2eGc8cC5wh1OEHHLjXH5GJ9Y
         0furFK1FYcV0GeQgQ9zZF87nQyEO+9EKjGge1ZSN0zrIJbIF1qkKef1oKUkkB28D+q
         wHCB1I6Kg6IR+NUaprmNS2KwprJoR5ZAUFhpwJOe4FhoJOY2vyCMhEEOnrAn1Gr8gb
         5IJ0AFFLjDoKAY19jjIm1MGCd5b0JRy1nT98tqOJSiBMOQxrlddYWdYoR3wFMchi1C
         5dmTMcObz6GW1Xe2QSRKtgzVB5wUSm9YD6zDlTIlUEvmOc13YLdmUJvSmzwouVCqv8
         1xqXwfrSPfkOg==
Received: by mail-pj1-f43.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so910519pjw.2;
        Mon, 06 Sep 2021 23:59:30 -0700 (PDT)
X-Gm-Message-State: AOAM532WYjN51cqGgxn8eileVn05QDnv+xcwp3ZXCPPahF5QpW/3rawi
        pugKBb+zUr62s1NVaZQjnD4nlglkYS3/TzWnUUE=
X-Google-Smtp-Source: ABdhPJzuiXAU3Njs3qHP0itPJivYcah6VQ3WQtL0F795tm/YRYBtL5gjJyQ539ZAn0iyBxPlf/BInef1vExv9CfCNQ0=
X-Received: by 2002:a17:902:a3c1:b0:13a:47a:1c5a with SMTP id
 q1-20020a170902a3c100b0013a047a1c5amr13820893plb.13.1630997969685; Mon, 06
 Sep 2021 23:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210805065429.27485-1-clin@suse.com> <20210805065429.27485-2-clin@suse.com>
 <YRaxt1LCF+hWaMJU@robh.at.kernel.org> <YR0akXYPYthDuvCh@linux-8mug> <11f8b913-1057-7d30-e936-f27483f9a6e2@suse.de>
In-Reply-To: <11f8b913-1057-7d30-e936-f27483f9a6e2@suse.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 7 Sep 2021 08:59:18 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdZ2iP3-BUk+p5A=UnbGia7s2GAOh84htcEjwB1wNAJrQ@mail.gmail.com>
Message-ID: <CAJKOXPdZ2iP3-BUk+p5A=UnbGia7s2GAOh84htcEjwB1wNAJrQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: arm: fsl: add NXP S32G2 boards
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     Chester Lin <clin@suse.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Jagan Teki <jagan@amarulasolutions.com>, s32@nxp.com,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 6 Sept 2021 at 22:38, Andreas F=C3=A4rber <afaerber@suse.de> wrote:
>
> Hi Chester,
>
> On 18.08.21 16:34, Chester Lin wrote:
> > On Fri, Aug 13, 2021 at 12:53:59PM -0500, Rob Herring wrote:
> >> On Thu, Aug 05, 2021 at 02:54:22PM +0800, Chester Lin wrote:
> >>> Add bindings for S32G2's evaluation board (S32G-VNP-EVB) and referenc=
e
> >>> design 2 board ( S32G-VNP-RDB2).
> >>>
> >>> Signed-off-by: Chester Lin <clin@suse.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
> >>>  1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documen=
tation/devicetree/bindings/arm/fsl.yaml
> >>> index e2097011c4b0..3914aa09e503 100644
> >>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> >>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> >>> @@ -983,6 +983,13 @@ properties:
> >>>            - const: solidrun,lx2160a-cex7
> >>>            - const: fsl,lx2160a
> >>>
> >>> +      - description: S32G2 based Boards
> >>> +        items:
> >>> +          - enum:
> >>> +              - fsl,s32g274a-evb
> >>> +              - fsl,s32g274a-rdb2
> >>> +          - const: fsl,s32g2
> >>
> >> Given this is an entirely different family from i.MX and new?, shouldn=
't
> >> it use 'nxp' instead of 'fsl'? Either way,
> >
> > It sounds good and Radu from NXP has mentioned a similar idea for the
> > compatible string of linflexuart. To keep the naming consistency, shoul=
d we
> > change all 'fsl' to 'nxp' as well?
>
> I assume that question was just unclearly phrased, so for the record:
>
> ABI stability rules forbid us from changing "all 'fsl'" in compatible
> strings or property names.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
Documentation/devicetree/bindings/ABI.rst
>
> Deployed firmware providing mainline-merged platforms with DTBs using
> fsl prefix (e.g., the quoted LX2160A) needs to continue working with
> newer drivers, and deployed mainline Linux should continue working after
> firmware updates that modify the DTB provided to Linux.

This is a new platform/SoC therefore there is no ABI. There is no
requirement in the kernel that a new ABI (which you define in this
patchset in the bindings) should be compatible with something
somewhere. It's some misunderstanding of stable ABI. Therefore all new
compatibles are allowed to be nxp, not fsl.

No one here proposed renaming existing compatibles from fsl tro nxp.
We talk about new ones.

Different question of course whether you want to be nice to some
existing out-of-tree users... but then have in mind that we don't care
about out of tree. :) Anyway being nice to out-of-tree is not part of
ABI. It's just being nice and useful.

Best regards,
Krzysztof
