Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96859C636CA
	for <linux-serial@archiver.kernel.org>; Sat, 17 Jul 2021 17:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 737A461151
	for <linux-serial@archiver.kernel.org>; Sat, 17 Jul 2021 17:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhGQRdW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 17 Jul 2021 13:33:22 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59940 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232010AbhGQRdW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 17 Jul 2021 13:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=6l0CstberAqKZPlDzrCY/biBtWYITP+X3kt4+P+sPGs=; b=qX
        6sJHcNOI4tx7tSjjDMM1T5XSQG/EqhAmg6aD4xu8oqWPhIc9QbqIiRcJO7hOHsTH2V5pXjJUXIY4q
        r1oxM6Wm3gsilOzp0SewiOIPsGZk2B3Xpbqcrq//yGYgqAf2cgitK6LNzGAKbhYYL5fkw7FyT/va/
        a0evCFDoz10tNNM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1m4o8p-00DkKr-Kd; Sat, 17 Jul 2021 19:30:19 +0200
Date:   Sat, 17 Jul 2021 19:30:19 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/5] dt-bindings: mvebu-uart: document DT bindings for
 marvell, armada-3700-uart-clock
Message-ID: <YPMTq1wSo1YLJBQi@lunn.ch>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210717123829.5201-1-pali@kernel.org>
 <20210717123829.5201-4-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210717123829.5201-4-pali@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jul 17, 2021 at 02:38:27PM +0200, Pali Rohár wrote:
> This change adds DT bindings documentation for device nodes with compatible
> string "marvell,armada-3700-uart-clock".
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  .../bindings/clock/armada3700-uart-clock.txt  | 24 +++++++++++++++++++
>  .../devicetree/bindings/serial/mvebu-uart.txt |  9 ++++---
>  2 files changed, 30 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/armada3700-uart-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/armada3700-uart-clock.txt b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.txt
> new file mode 100644
> index 000000000000..144bc6d7eae8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.txt

Since this is a new binding, please use YAML.

      Andrew
