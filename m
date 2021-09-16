Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CD1C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 16 Sep 2021 09:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796DF611C8
	for <linux-serial@archiver.kernel.org>; Thu, 16 Sep 2021 09:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhIPJJ7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Sep 2021 05:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235114AbhIPJJz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Sep 2021 05:09:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCA8460F93;
        Thu, 16 Sep 2021 09:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783315;
        bh=WVZp7zAxrJcGJFceYnaC30L3NEug/ghHkDrrF8bTKWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R8zNlq+6LDpDSB6aIwW2FWWR18uvGGQl1jdbf63U4ouezWknqHqVmp3lEJDDV1pRu
         Fp/4G4fmivvsMWB2H3DVg/Q0l/Mhfh4TXTChCNcOWcNFwqneRbmLGMSRhpA0BTiBz4
         Xzvyb9Gjne5oOLhHdP1BXJtfqjjP+WGGA5DLbbBqscjFZknBvDLhYCaa2KZj0/cAwX
         ZkjPAiHcvdE6Hra3tpgqRr3xGPtl0m3vEOfqSZH4D/64PuJC/FQd+bbUpJVV1n3vHT
         sHhJeLOgNyijxqPAXxKOZJbcwVWhywOhamAXhrlCfRGRaskksh6YiDQpJqSMvTkJPR
         YgIqyI8Kwmalw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mQnNj-00059h-Oc; Thu, 16 Sep 2021 11:08:36 +0200
Date:   Thu, 16 Sep 2021 11:08:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Scott Wood <oss@buserror.net>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: SERIAL_8250_FSL should not default to y
 when compile-testing
Message-ID: <YUMJk6VKI40Caq5x@hovoldconsulting.com>
References: <c5f8aa5c081755f3c960b86fc61c2baaa33edcd9.1631710216.git.geert+renesas@glider.be>
 <YUMESxr907YHM3ZT@hovoldconsulting.com>
 <CAMuHMdX7_AOuGEjvTHpQ-4KHMH+m800KTu7wads6UTfMZiu9BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX7_AOuGEjvTHpQ-4KHMH+m800KTu7wads6UTfMZiu9BQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 16, 2021 at 10:55:49AM +0200, Geert Uytterhoeven wrote:
> Hi Johan,
> 
> On Thu, Sep 16, 2021 at 10:46 AM Johan Hovold <johan@kernel.org> wrote:
> > On Wed, Sep 15, 2021 at 02:56:52PM +0200, Geert Uytterhoeven wrote:
> > > Commit b1442c55ce8977aa ("serial: 8250: extend compile-test coverage")
> > > added compile-test support to the Freescale 16550 driver.  However, as
> > > SERIAL_8250_FSL is an invisible symbol, merely enabling COMPILE_TEST now
> > > enables this driver.
> > >
> > > Fix this by making SERIAL_8250_FSL visible.  Tighten the dependencies to
> > > prevent asking the user about this driver when configuring a kernel
> > > without appropriate Freescale SoC or ACPI support.
> >
> > This tightening is arguable a separate change which risk introducing
> > regressions if you get it wrong and should go in a separate patch at
> > least.
> 
> Getting it wrong would indeed be a regression, but not tightening
> that at the same time would mean I have to send a separate patch with
> a Fixes tag referring to this fix, following this template:
> 
>     foo should depend on bar
> 
>     The foo hardware is only present on bar SoCs.  Hence add a
>     dependency on bar, to prevent asking the user about this driver
>     when configuring a kernel without bar support.

I know this is a pet peeve of yours, but asking users about one more
symbol when configuring their kernels is hardly something that requires
a Fixes tag.

Either way it's a pretty weak argument for not separating the change.

Johan
