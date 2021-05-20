Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19AFC433ED
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 14:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9815D608FE
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 14:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241562AbhETONR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 May 2021 10:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240523AbhETOMR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 May 2021 10:12:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA2606100A;
        Thu, 20 May 2021 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621519856;
        bh=gIBY97jslXsti2SI4ZA+8vXGfXHxGk/m/lfeX2OPoFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cfbaxJfdUWFcEQ5oRVyzkKmYCpG5OO9V85ooMIrl87DTqruYMt2DiQxuD/P80qqPM
         /Pd/Kmm+pOFirbpfc5DO7eh6T5fOHA4epdGwP38XhtXMO9IWYw0vWurYjsDrJeBOkW
         D4gqDfQ9KXyp2S9FgzPlXMe4E6SXfgIEYVBV9TY4=
Date:   Thu, 20 May 2021 16:10:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org
Subject: Re: [PATCH 0/3] tty: serial: meson: add amlogic,uart-fifosize
 property
Message-ID: <YKZt7lCBhesXzoQP@kroah.com>
References: <20210518075833.3736038-1-narmstrong@baylibre.com>
 <9c6ce679-1721-be40-c1b2-6ae90503d2cb@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c6ce679-1721-be40-c1b2-6ae90503d2cb@baylibre.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 20, 2021 at 03:55:35PM +0200, Neil Armstrong wrote:
> Hi Greg,
> 
> On 18/05/2021 09:58, Neil Armstrong wrote:
> > On most of the Amlogic SoCs, the first UART controller in the "Everything-Else"
> > power domain has 128bytes of RX & TX FIFO, so add an optional property to describe
> > a different FIFO size from the other ports (64bytes).
> > 
> > This adds a property in the bindings, reads the property from the driver and updates
> > the DT with the new property.
> > 
> > Changes since v2:
> > - removed spurious blank line from bindings
> > 
> > Changes since v1:
> > - switched to a more generic "fifo-size"
> > 
> > Neil Armstrong (3):
> >   dt-bindings: serial: amlogic,meson-uart: add fifo-size property
> >   tty: serial: meson: retrieve port FIFO size from DT
> >   arm64: dts: meson: set 128bytes FIFO size on uart A
> > 
> >  .../devicetree/bindings/serial/amlogic,meson-uart.yaml       | 5 +++++
> >  arch/arm64/boot/dts/amlogic/meson-axg.dtsi                   | 1 +
> >  arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi            | 1 +
> >  arch/arm64/boot/dts/amlogic/meson-gx.dtsi                    | 1 +
> >  drivers/tty/serial/meson_uart.c                              | 5 ++++-
> >  5 files changed, 12 insertions(+), 1 deletion(-)
> > 
> 
> Could you apply patches 1 & 2 ?

Sure, will go do so now...

