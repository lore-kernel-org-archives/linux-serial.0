Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E045C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 21:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E3AA611F0
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 21:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243195AbhJOV54 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Oct 2021 17:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229921AbhJOV5z (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Oct 2021 17:57:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD0C661184;
        Fri, 15 Oct 2021 21:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634334948;
        bh=a/PKEB79rge1XrRUfmeasHckwgBHCh9o8ibzTCo/fw0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=B++huS3Zx4+xJH4mRegAJ9HTh26DHfq/mDCB/4lo9wviALq/OMCqnNkVUGIyBKzr6
         pSlfrvt3OafxB0wTL1giMzIHXVQLAuoYZZIP8lnjxLY1gDw7EqK8zJY/GkPaknjsML
         g0BXXm6QmcSV1gDkftnylIqRRwO0DQVOXa9nH0ybQChWM2KbfmV9RO/lvmyzYsZ0ZU
         eY5uEsuHBo24mEq8LBj+p5Ouu9/IXW59MdSxy4tjVXufQbWGhYnrGF+zfk7upVFEWk
         E3XDHZJHYZy3CTuSVadKurlnolyFwgZWvd73gMjvGH+eZhJpPV5vk+Kg4px1F/xdU8
         eEdbozZP3KCsw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211015093701.pfvkighxsndj4ujg@pali>
References: <20210930095838.28145-1-pali@kernel.org> <20210930095838.28145-4-pali@kernel.org> <163425678347.1688384.10695189000353676651@swboyd.mtv.corp.google.com> <20211015090937.gnt66hgugrhwnkei@pali> <20211015093701.pfvkighxsndj4ujg@pali>
Subject: Re: [PATCH v7 3/6] dt-bindings: mvebu-uart: document DT bindings for marvell,armada-3700-uart-clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
To:     Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Date:   Fri, 15 Oct 2021 14:55:47 -0700
Message-ID: <163433494758.1688384.5994009027317282677@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Pali Roh=C3=A1r (2021-10-15 02:37:01)
> On Friday 15 October 2021 11:09:37 Pali Roh=C3=A1r wrote:
> > On Thursday 14 October 2021 17:13:03 Stephen Boyd wrote:
> > > Quoting Pali Roh=C3=A1r (2021-09-30 02:58:35)
> > > > diff --git a/Documentation/devicetree/bindings/clock/marvell,armada=
-3700-uart-clock.yaml b/Documentation/devicetree/bindings/clock/marvell,arm=
ada-3700-uart-clock.yaml
> > > > new file mode 100644
> > > > index 000000000000..175f5c8f2bc5
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/clock/marvell,armada-3700-u=
art-clock.yaml
> > > > @@ -0,0 +1,59 @@
> > > [..]
> > > > +  '#clock-cells':
> > > > +    const: 1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - clocks
> > > > +  - clock-names
> > > > +  - '#clock-cells'
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    uartclk: clock-controller@12010 {
> > >=20
> > > The uart device is at 0x12000 and the clock-controller is at 0x12010?
> > > This looks like a node is being put into DT to represent a clk driver.
> > > Why can't we register a clk from the uart device driver itself? I thi=
nk
> > > we talked about this a month or two ago but it still isn't clear to m=
e.
> >=20
> > We have already talked about it and I have already wrote reasons. UART
> > clk is shared for both UART1 and UART2. And UART clk regs are in both
> > address spaces of UART1 and UART2. UART1 or UART2 can be independently
> > disabled on particular board (as pins are MPP which may be configured to
> > different function). So you have a board only with UART2, you have to
> > disable UART1 node, but at the same time you have to access UART clk to
> > drive UART2. And UART clk bits are in UART1 address space.
>=20
> It is explained also in commit message of patch 2/6.

Cool, thanks for the pointer.

Why are the two uarts split into different device nodes? It looks like
it's one device that was split into two nodes because they're fairly
similar hardware blocks, and one or the other may not be used on the
board so we want to use status =3D "disabled" to indicate that. Sadly the
hardware team has delivered them as a single package into the SoC at
address 0x12000 and then stuck a common clk for both uarts into the same
uart wrapper. Here's a clk, job done!

Is it a problem to map UART1 address space when it isn't used on the
board? I'm trying to understand why it can't work to register two uart
ports from one device node and driver. It seems to be the main reason
why we're introducing another node for the clk registers when it feels
like it could all be handled in the existing uart driver.

For example, we could have a static clk pointer in the uart driver
indicating the clk has been registered, and then register the clk if
uart1 or uart2 is the first device to probe and then store that clk in a
global (with clk_hw_get_clk(), I think that's a thing now). If uart2
probes first it can take the reg property and subtract some number to
find the clk, and if uart1 probes first it can take the reg property and
add some number to find the clk. Either way, the binding doesn't change
in this case and we don't have to add another binding for this same uart
hardware.

Then if someone wants to cleanup the binding they can combine both uarts
into one node, make a new compatible string and add some property to
indicate that one or the other uart isn't used. Probably also add some
property to map the uart alias to the uart hardware block inside the
wrapper node.
