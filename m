Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A14C2D0A3
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 21:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2966C2087C
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 21:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b="YQZe2GD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgKDVPI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 16:15:08 -0500
Received: from mail.horus.com ([78.46.148.228]:42175 "EHLO mail.horus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbgKDVPI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 16:15:08 -0500
Received: from lenny.lan (178-190-199-171.adsl.highway.telekom.at [178.190.199.171])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "E-Mail Matthias Reichl Lenny", Issuer "HiassofT CA 2014" (verified OK))
        by mail.horus.com (Postfix) with ESMTPSA id E90FD6409C;
        Wed,  4 Nov 2020 22:15:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1604524506;
        bh=ZmqoxBZmCuS4l4HVxbSnH/fUgSChRyk/zUn6nSHziPs=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=YQZe2GD2o1ZZMyW/nA6oR6+9hl/sNX26cobt5hg/GLXM771LU/LLo4ZRDkxZwKr2s
         ZrGGyz2SpixuFdLq58ajaSmOkSb8KSmS0V/EjATEkCNHx9k8xYaUbQYqLR1nlJT9hV
         AaizCxqcQzYUS4PsKjauf2uvJyWQlD9n4J2iwd+Q=
Received: by lenny.lan (Postfix, from userid 1000)
        id 0E725200B36; Wed,  4 Nov 2020 22:15:05 +0100 (CET)
Date:   Wed, 4 Nov 2020 22:15:05 +0100
From:   Matthias Reichl <hias@horus.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, speakup@linux-speakup.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Crash when specifying non-existent serial port in speakup /
 tty_kopen
Message-ID: <20201104211504.GA20012@lenny.lan>
Mail-Followup-To: Matthias Reichl <hias@horus.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, speakup@linux-speakup.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201104145737.GA11024@camel2.lan>
 <20201104201323.dzyt73tbd2jykcrt@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104201323.dzyt73tbd2jykcrt@function>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Samuel,

On Wed, Nov 04, 2020 at 09:13:23PM +0100, Samuel Thibault wrote:
> Hello,
> 
> Matthias Reichl, le mer. 04 nov. 2020 15:57:37 +0100, a ecrit:
> > I initially noticed this oops on x86_64 running kernel 5.4.59 when
> > I accidentally mistyped "ttyS0" as "ttyS9":
> > 
> > modprobe speakup_dummy dev=ttyS9
> 
> > [   49.978481] tty_init_dev: ttyS driver does not set tty->port. This would crash the kernel. Fix the driver!
> 
> This looks like only a warning, did it actually crash?

Yes, scroll down a bit, the null pointer oops followed almost
immediately after that

[   49.979043] BUG: kernel NULL pointer dereference, address: 0000000000000090

> > the missing tty->port is quite fatal.
> 
> It is fatal for module insertion yes (EINVAL) but IIRC that should be
> getting handled properly, making modprobe return the error?

When I did that on my desktop the tty system was pretty screwed. Mouse still
worked in X but no keyboard input possible.

> > It looks like spk_ttyio or tty_dev_name_to_number() / tty_kopen()
> > should perform some additional validation,
> 
> spk_ttyio_initialise_ldisc only has a dev_t so can't do much beyond
> calling tty_kopen.
> 
> tty_kopen is getting the index from the tty_lookup_driver call (actually
> get_tty_driver which uses p->minor_start and p->num) and passes it to
> tty_driver_lookup_tty. Perhaps in addition of p->num the driver should
> have another field to set, that tty_init_dev could use to reject with
> ENODEV indexes beyond what the driver actually provides?

It might be a bit more involved than a simple max port check, think
about hotplug (I have 16C950 ExpressCard devices I occansionally use
on one of my laptops) so there may be holes in the allocation numbers.
Not sure how/where to best solve this.

> > I couldn't make the kernel warn/crash yet by specifying non-existent
> > ttyUSB ports yet though.
> 
> That's probably because in the ttyUSB case the device allocation is
> dynamic and made exactly according to the number of actual devices,
> while for ttyS* there is a large overcommit of minor values.

Yes, that sounds reasonable (haven't looked at ttyUSB details, only
checked serial core devices yet).

so long,

Hias
