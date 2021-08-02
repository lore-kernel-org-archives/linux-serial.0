Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E17C43214
	for <linux-serial@archiver.kernel.org>; Mon,  2 Aug 2021 14:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E30610CC
	for <linux-serial@archiver.kernel.org>; Mon,  2 Aug 2021 14:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhHBOpv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 Aug 2021 10:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234313AbhHBOpv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Aug 2021 10:45:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEF9660F51;
        Mon,  2 Aug 2021 14:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627915541;
        bh=b3goBFQFlOeosgGSS9BAcZLInoN1rgbRE/qkSS4IUwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5QKCazERFukk3GhG9g7lKnYjLV4cHHODJD6YUhbm0BxCZ5rgUDcSvBvGdPJepnML
         zgZHM/wKeujvshgV9nXr/8axigN3iWv2Pst3p+qHPEY4H8StJnd3idQPjN9jGtVVT4
         g5xRSqqOCNt6zfCAvvHMGhIQphvaKzQlHlVtmOoWPk4c5WtkpMW/3z/+8CJp0oLK/Q
         zlKNNl1zJjCJx2LhVvnPPDnHYDp83bSVdIMciBcrbDz6QpNt7+vhfNrkEw81oVres7
         XkDvgKCJeOZb0uHuvPcMtXzK8vSkDoxljGn0q7hg1IA51Y0BzjuMuHGLRtbXZZFsFC
         ANgBRQ40Pi5NA==
Received: by pali.im (Postfix)
        id DAAA2B98; Mon,  2 Aug 2021 16:45:38 +0200 (CEST)
Date:   Mon, 2 Aug 2021 16:45:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/5] dt-bindings: mvebu-uart: document DT bindings for
 marvell, armada-3700-uart-clock
Message-ID: <20210802144538.zbnshv3xml3t4euj@pali>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210717123829.5201-1-pali@kernel.org>
 <20210717123829.5201-4-pali@kernel.org>
 <YPMTq1wSo1YLJBQi@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YPMTq1wSo1YLJBQi@lunn.ch>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Saturday 17 July 2021 19:30:19 Andrew Lunn wrote:
> On Sat, Jul 17, 2021 at 02:38:27PM +0200, Pali Rohár wrote:
> > This change adds DT bindings documentation for device nodes with compatible
> > string "marvell,armada-3700-uart-clock".
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  .../bindings/clock/armada3700-uart-clock.txt  | 24 +++++++++++++++++++
> >  .../devicetree/bindings/serial/mvebu-uart.txt |  9 ++++---
> >  2 files changed, 30 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/clock/armada3700-uart-clock.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/armada3700-uart-clock.txt b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.txt
> > new file mode 100644
> > index 000000000000..144bc6d7eae8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.txt
> 
> Since this is a new binding, please use YAML.

Changed in v4.
