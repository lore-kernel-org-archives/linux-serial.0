Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE604C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 28 Dec 2021 17:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbhL1RdO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Dec 2021 12:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhL1RdN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Dec 2021 12:33:13 -0500
X-Greylist: delayed 101736 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Dec 2021 09:33:13 PST
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33859C061574
        for <linux-serial@vger.kernel.org>; Tue, 28 Dec 2021 09:33:13 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 603E228005304;
        Tue, 28 Dec 2021 18:33:11 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5385A2B0CE4; Tue, 28 Dec 2021 18:33:11 +0100 (CET)
Date:   Tue, 28 Dec 2021 18:33:11 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Ulrich Teichert <krypton@ulrich-teichert.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH] serial: 8250: Move alpha-specific quirk out of the core
Message-ID: <20211228173311.GA18155@wunner.de>
References: <20211218090601.GA1016@wunner.de>
 <202112191737.1BJHbujc008689@valdese.nms.ulrich-teichert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112191737.1BJHbujc008689@valdese.nms.ulrich-teichert.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Dec 19, 2021 at 06:37:56PM +0100, Ulrich Teichert wrote:
> Thanks for the explanation and the reproducer program. I tried yesterday
> to install a recent Linux-Alpha distribution on any of my Alphas to
> be able to build natively and check my self-build kernels before burning
> a CD-ROM, but I failed. Neither gentoo nor Debian nor T2 was installable on
> my Miatas (the Personal Workstations) or my Avanti (AlphaStation 400),
> either failing to boot or recognizing the disks or the CD-ROM, or switching
> to a framebuffer which did not work or just dying on the hardware detection.
> That was a bit frustrating, but I have to follow plan B now and do cross-builds
> from amd_x64 to Alpha - that's easy for the kernel (infact, that's what
> I've been doing from the start), but generating something bootable that
> way is a challenge and needs more time than I usually have during the week,
> but I will tackle it over my xmas vacation,

No worries, whenever you get to spend more time with the Jensen and come
across issues with the serial ports, we can look into it.

I've just sent out an updated version of the patch which also applies
the Jensen quirk if a generic kernel is used.  It auto-detects at
runtime whether the kernel is running on a Jensen.  If on the other hand
the kernel is compiled specifically for the Jensen, the quirk is applied
unconditionally.

I've also realized that a code comment in sunsu.c refers to the Alpha
quirk, so I'm updating it to point to the new location.  It looks like
a JavaStation thin client of the same era had a similar hardware erratum
as the Jensen.

Thanks,

Lukas
