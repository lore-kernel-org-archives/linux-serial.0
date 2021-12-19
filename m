Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8249C433F5
	for <linux-serial@archiver.kernel.org>; Sun, 19 Dec 2021 17:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhLSRiE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Dec 2021 12:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbhLSRiE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Dec 2021 12:38:04 -0500
Received: from wp441.webpack.hosteurope.de (wp441.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:85d2::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A7AC061574;
        Sun, 19 Dec 2021 09:38:03 -0800 (PST)
Received: from [2a03:7846:b79f:101:21c:c4ff:fe1f:fd93] (helo=valdese.nms.ulrich-teichert.org); authenticated
        by wp441.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1mz08G-0008Vr-EW; Sun, 19 Dec 2021 18:38:00 +0100
Received: from valdese.nms.ulrich-teichert.org (localhost [127.0.0.1])
        by valdese.nms.ulrich-teichert.org (8.15.2/8.15.2/Debian-8+deb9u1) with ESMTPS id 1BJHbwM7008691
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Dec 2021 18:37:58 +0100
Received: (from ut@localhost)
        by valdese.nms.ulrich-teichert.org (8.15.2/8.15.2/Submit) id 1BJHbujc008689;
        Sun, 19 Dec 2021 18:37:56 +0100
Message-Id: <202112191737.1BJHbujc008689@valdese.nms.ulrich-teichert.org>
Subject: Re: [PATCH] serial: 8250: Move alpha-specific quirk out of the core
To:     lukas@wunner.de (Lukas Wunner)
Date:   Sun, 19 Dec 2021 18:37:56 +0100 (CET)
Cc:     krypton@ulrich-teichert.org (Ulrich Teichert),
        gregkh@linuxfoundation.org (Greg Kroah-Hartman),
        jirislaby@kernel.org (Jiri Slaby), linux-serial@vger.kernel.org,
        rmk+kernel@armlinux.org.uk (Russell King),
        torvalds@linux-foundation.org (Linus Torvalds),
        rth@twiddle.net (Richard Henderson),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        mattst88@gmail.com (Matt Turner), linux-alpha@vger.kernel.org,
        LinoSanfilippo@gmx.de (Lino Sanfilippo),
        p.rosenberger@kunbus.com (Philipp Rosenberger),
        glaubitz@physik.fu-berlin.de (John Paul Adrian Glaubitz)
In-Reply-To: <20211218090601.GA1016@wunner.de>
From:   Ulrich Teichert <krypton@ulrich-teichert.org>
X-Mailer: ELM [version 2.5 PL8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;ut@ulrich-teichert.org;1639935483;1d5b0d39;
X-HE-SMSGID: 1mz08G-0008Vr-EW
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Lukas,

> On Thu, Dec 16, 2021 at 09:36:20PM +0100, Ulrich Teichert wrote:
> > > struct uart_8250_port contains mcr_mask and mcr_force members whose
> > > sole purpose is to work around an alpha-specific quirk.  This code
> > > doesn't belong in the core where it is executed by everyone else,
> > > so move it to a proper ->set_mctrl callback which is used on alpha only.
> [...]
> > > The quirk applies to non-PCI alphas and arch/alpha/Kconfig specifies
> > > "select FORCE_PCI if !ALPHA_JENSEN".  So apparently the only affected
> > > machine is the EISA-based Jensen that Linus was working on back then:
> [...]
> > > Up until now the quirk is not applied unless CONFIG_PCI is disabled.
> > > If users forget to do that, the serial ports aren't usable on Jensen
> > > and the machine may not boot in the first place.  Avoid by confining
> > > the quirk to CONFIG_ALPHA_JENSEN instead.
> > 
> > Wouldn't that mean that you can't use a generic Alpha kernel on the Jensen
> > anymore? CONFIG_ALPHA_JENSEN is only set if you specifically select the
> > Jensen as target, not when you build a generic kernel. That would be a step
> > back in my opinion, as the Debian generic kernel from debian-ports did
> > as least boot up on real hardware and the serial console worked just fine
> 
> The generic Alpha kernel has CONFIG_PCI=y, so the quirk is not applied,
> both with and without the present patch.

Right.

> You should be able to trigger the lockup that the quirk seeks to avoid
> by closing the tty of either of the serial ports.  E.g., if you're using
> the serial console, "cat" something to the other serial port's tty.
> That will clear TIOCM_OUT2 in serial8250_do_shutdown() and should thus
> provoke the lockup.  Alternatively, compile and run the little program
> below on the Jensen.  (Pass a serial port tty as argument.)
> 
> Should you not be able to reproduce the lockup, then the quirk wouldn't
> be necessary anymore and could be removed.
[del]

Thanks for the explanation and the reproducer program. I tried yesterday
to install a recent Linux-Alpha distribution on any of my Alphas to
be able to build natively and check my self-build kernels before burning
a CD-ROM, but I failed. Neither gentoo nor Debian nor T2 was installable on
my Miatas (the Personal Workstations) or my Avanti (AlphaStation 400),
either failing to boot or recognizing the disks or the CD-ROM, or switching
to a framebuffer which did not work or just dying on the hardware detection.
That was a bit frustrating, but I have to follow plan B now and do cross-builds
from amd_x64 to Alpha - that's easy for the kernel (infact, that's what
I've been doing from the start), but generating something bootable that
way is a challenge and needs more time than I usually have during the week,
but I will tackle it over my xmas vacation,

CU,
Uli
-- 
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de | Listening to:
Stormweg 24               |Eat Lipstick: Dirty Little Secret, The Baboon Show:
24539 Neumuenster, Germany|Work Work Work, The Bellrays: Bad Reaction
