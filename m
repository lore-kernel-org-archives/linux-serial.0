Return-Path: <SRS0=qe7h=EL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89BBC00A89
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 12:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FA4F20739
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 12:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b="A235DEjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgKEMVh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Nov 2020 07:21:37 -0500
Received: from mail.horus.com ([78.46.148.228]:50629 "EHLO mail.horus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKEMVh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Nov 2020 07:21:37 -0500
Received: from [192.168.1.20] (178-190-199-171.adsl.highway.telekom.at [178.190.199.171])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "E-Mail Matthias Reichl", Issuer "HiassofT CA 2014" (not verified))
        by mail.horus.com (Postfix) with ESMTPSA id 6C1C16409C;
        Thu,  5 Nov 2020 13:21:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1604578895;
        bh=m7TWDGR/XOwMZ6PC2+scU+HaRp+UnMcyShuqW8iBPVY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=A235DEjC61KEVIjZCxaUffmEsyZ9XE+w4H/xuX2tsmoWz8a7guhi0K4BgdlIelvil
         eIeWOIJ5vfojwn/MZO4QgI2T1oHDC0AplV54D2PtD6h/Q6Jcp3Sh/s8gLpYw0h5PFG
         /XPAMn4XiCMIKDb9LZHe8qOS01cZYZ0edUqWPnDA=
Received: by camel2.lan (Postfix, from userid 1000)
        id 6DFEB1C75C3; Thu,  5 Nov 2020 13:21:34 +0100 (CET)
Date:   Thu, 5 Nov 2020 13:21:34 +0100
From:   Matthias Reichl <hias@horus.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, speakup@linux-speakup.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Crash when specifying non-existent serial port in speakup /
 tty_kopen
Message-ID: <20201105122134.GA6084@camel2.lan>
Mail-Followup-To: Matthias Reichl <hias@horus.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, speakup@linux-speakup.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201104145737.GA11024@camel2.lan>
 <20201104201323.dzyt73tbd2jykcrt@function>
 <20201104211504.GA20012@lenny.lan>
 <20201104213005.khivjvcwkaz7kz4g@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104213005.khivjvcwkaz7kz4g@function>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 04, 2020 at 10:30:05PM +0100, Samuel Thibault wrote:
> Matthias Reichl, le mer. 04 nov. 2020 22:15:05 +0100, a ecrit:
> > > This looks like only a warning, did it actually crash?
> > 
> > Yes, scroll down a bit, the null pointer oops followed almost
> > immediately after that
> > 
> > [   49.979043] BUG: kernel NULL pointer dereference, address: 0000000000000090
> 
> Ah, [   50.102938]  tty_init_dev+0xb5/0x1d0
> 
> probably the trailing release_tty call that does
> 
> tty->port->itty = NULL;
> (itty is after a struct tty_bufhead + the tty pointer, that looks
> plausible).
> 
> so probably an if (tty->port) in release_tty could help?

Thanks a lot, good catch! This is indeed where the crash happens
and checking for tty->port in release_tty() prevents that.
I'll send a patch.

so long,

Hias
