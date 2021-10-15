Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DC1C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 00:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7C46105A
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 00:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhJOAPK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Oct 2021 20:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229718AbhJOAPK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Oct 2021 20:15:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D117460FDC;
        Fri, 15 Oct 2021 00:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634256784;
        bh=GXQ6Dh4zhTUPR+A2V7JaDgrHk+2tJmJdA1ZsI5rpSH4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=EEY5oL1O5M1SLzo2ikY6/dNHRHMQsbn/G2GNKe3rG2gCNG9ropEjn56EM4H/iStEu
         lYr9xSibCNZHXxen0f6bOPPernLsrg0wy6Oxhdp9PxB/5dcv0JbPTkyqGfEggbBxPT
         Wz3d9wwoYi/8iVENfi+jfk9aSrFniUM1vJOWt07s1tnJD8R4vpdRfAgyrVny/AeY7B
         u0Bje2o3RRdjEzzVfsP9oam8mZ8uHpUCN2goeZpn2y85H5Ufr+fs62kDP3vCVrsdwH
         3+Lb0fDrSu4vNng427LfDuJ3sKSgOfA8qhrMy4OGhn6JtpSbqdnpC72qfHNw4xdOxu
         0Wy50rjcNXuIQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210930095838.28145-4-pali@kernel.org>
References: <20210930095838.28145-1-pali@kernel.org> <20210930095838.28145-4-pali@kernel.org>
Subject: Re: [PATCH v7 3/6] dt-bindings: mvebu-uart: document DT bindings for marvell,armada-3700-uart-clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 14 Oct 2021 17:13:03 -0700
Message-ID: <163425678347.1688384.10695189000353676651@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Pali Roh=C3=A1r (2021-09-30 02:58:35)
> diff --git a/Documentation/devicetree/bindings/clock/marvell,armada-3700-=
uart-clock.yaml b/Documentation/devicetree/bindings/clock/marvell,armada-37=
00-uart-clock.yaml
> new file mode 100644
> index 000000000000..175f5c8f2bc5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-cl=
ock.yaml
> @@ -0,0 +1,59 @@
[..]
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    uartclk: clock-controller@12010 {

The uart device is at 0x12000 and the clock-controller is at 0x12010?
This looks like a node is being put into DT to represent a clk driver.
Why can't we register a clk from the uart device driver itself? I think
we talked about this a month or two ago but it still isn't clear to me.

> +      compatible =3D "marvell,armada-3700-uart-clock";
> +      reg =3D <0x12010 0x4>, <0x12210 0x4>;
> +      clocks =3D <&tbg 0>, <&tbg 1>, <&tbg 2>, <&tbg 3>, <&xtalclk>;
> +      clock-names =3D "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal";
> +      #clock-cells =3D <1>;
> +    };
> --=20
> 2.20.1
>
