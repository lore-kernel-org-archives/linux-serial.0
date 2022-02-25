Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5169C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 25 Feb 2022 11:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiBYL3o (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Feb 2022 06:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbiBYL1u (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Feb 2022 06:27:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C4B2E68E
        for <linux-serial@vger.kernel.org>; Fri, 25 Feb 2022 03:26:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D933A618D3
        for <linux-serial@vger.kernel.org>; Fri, 25 Feb 2022 11:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAC4C340E7;
        Fri, 25 Feb 2022 11:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645788399;
        bh=/EQC2+hurUghaTs9k02ju6DGcunTRsZBKpPefUfy+nA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mEjqOXYuVDzrlZp8/xVfCsZ+lrUoX3BKe4IEjBcXztRuSWQ3bLwXNiKZwISsk73Fl
         YOiWTVKvrElr0muDlwPepzWB7byaWL4SPYE3vLJCSkuOqVPuAIMXLryGTie1BlQNW/
         scTV/V4tVI1zwly2QMQXBRvpoW1aktXi2y03xpaY=
Date:   Fri, 25 Feb 2022 12:26:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>
Cc:     linux-serial@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        Daniel Mack <daniel@zonque.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof =?utf-8?Q?Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Lech Perczak <l.perczak@camlintechnologies.com>
Subject: Re: [PATCH 0/6] sc16is7xx: Hardware flow control fixes
Message-ID: <Yhi87AJy1RxIiFfO@kroah.com>
References: <20220221105618.3503470-1-tomasz.mon@camlingroup.com>
 <Yhigd0pu2hmSLirE@kroah.com>
 <5c677799-411c-0c4f-fd99-15ac6dcb4844@camlingroup.com>
 <YhizqKXxxVJ6lZtP@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YhizqKXxxVJ6lZtP@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 25, 2022 at 11:47:04AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Feb 25, 2022 at 10:37:01AM +0100, Tomasz Moń wrote:
> > On 25.02.2022 10:25, Greg Kroah-Hartman wrote:
> > > On Mon, Feb 21, 2022 at 11:56:12AM +0100, Tomasz Moń wrote:
> > >> sc16is7xx driver assumes that the device handles hardware flow control
> > >> automatically. This is not really true as the driver does inadvertently
> > >> clear the bits that enable hardware flow control.
> > >>
> > >> This patch series solves multiple issues present in the driver. While
> > >> the patches are fairly independent, there are some dependencies. The
> > >> "sc16is7xx: Properly resume TX after stop" adds IER bit set function
> > >> that is later used in "sc16is7xx: Set AUTOCTS and AUTORTS bits". Also
> > >> the patches that control which interrupts are enabled are dependent on
> > >> each other.
> > >>
> > >> Patches should be applied respecting the order in the series. The whole
> > >> series applies on top of "sc16is7xx: Fix for incorrect data being
> > >> transmitted" [1].
> > > 
> > > The first 3 patches of this series applied.  Please rebase and resend
> > > the remaining.
> > 
> > The remaining patches did not apply because the "sc16is7xx: Fix for
> > incorrect data being transmitted" by Phil Elwell was not applied.
> > 
> > The Phil Elwell patch was independently developed and made it to the
> > list before I sent the patch series. For that reason I based the series
> > on top of that patch and mentioned it in the cover letter.
> 
> If that patch was not applied, then just rebase your series on my branch
> and resend it.

Ah, Phil's patch is in a different branch, and will be sent to Linus
later today, so you might just want to wait until Monday to resend your
remaining patches and then they will apply as my tty-next branch will
merge with that at that point in time.

thanks,

greg k-h
