Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDEEC54EE9
	for <linux-serial@archiver.kernel.org>; Tue, 13 Sep 2022 14:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiIMOBI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Sep 2022 10:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiIMOBH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Sep 2022 10:01:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE42D19295
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 07:01:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A8EA61344
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 14:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D04C433C1;
        Tue, 13 Sep 2022 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663077665;
        bh=9levNuHKXVrvH/ja1t4Mvp3ZcGIsekFd+mjdHlHB4gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qEOT43R3+L3e4gyhttkg1N+hwwub02KyTmbDmPblK/R6p9T/+RGa+sZpbygu99hot
         mXKDPy6HBrh4RcysipACmhtM/8PwcFFeEDyWouFnHAIY/+BtDM2vnXJuGx44f+U+xi
         LYYaucqO4NiUZAzl49KNawwMCIDqPfIRMG4rwAJQ=
Date:   Tue, 13 Sep 2022 16:01:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anders Blomdell <anders.blomdell@control.lth.se>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-serial@vger.kernel.org
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
Message-ID: <YyCNOV9no9NPwv8m@kroah.com>
References: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se>
 <YyA9maUOlPIExIUd@kroah.com>
 <ff41c70a-767a-45b8-f993-1f70ad3d9254@control.lth.se>
 <YyB4AtFJx++PeA6S@kroah.com>
 <7a99a59e-838d-c9da-6ead-167398642c07@control.lth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a99a59e-838d-c9da-6ead-167398642c07@control.lth.se>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 13, 2022 at 02:43:03PM +0200, Anders Blomdell wrote:
> 
> 
> On 2022-09-13 14:30, Greg Kroah-Hartman wrote:
> > On Tue, Sep 13, 2022 at 02:16:39PM +0200, Anders Blomdell wrote:
> > > I get incorrect baudrates, my oscilloscope gives:
> > > 
> > > Programmed	Measured
> > > 
> > >    2400		  5208
> > >    4800		 13150
> > >    9600		 10410
> > >   19200		 71420
> > >   38400		142000
> > >   57600		201600
> > > 115200		138800
> > 
> > I'm sorry, I have no context here at all, what does this pertain to?
> Programmed baudrate and the measured (actual) baudrate

I really don't know what to do here, sorry.  Are you saying a specific
commit has broken this?  If so, did you test if you made a change it
fixed the issue?

What do you suggest happen here?

still confused,

greg k-h
