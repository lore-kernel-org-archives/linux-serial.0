Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2B7C6FD1D
	for <linux-serial@archiver.kernel.org>; Fri, 17 Mar 2023 09:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjCQJJE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Mar 2023 05:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjCQJIk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Mar 2023 05:08:40 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE833B852
        for <linux-serial@vger.kernel.org>; Fri, 17 Mar 2023 02:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=7N+obhHRyum7hOTsORbeWdi9Y9AC
        K7wXKzCB9yu4KsE=; b=j62SsgavC82OgLafoiAIckLBWKUo4lQbg6UPtiwN+0DE
        4it5ORJxUFKiMRFxaWLTLqmYWt//X6nk3HHVVEPldIvW+zlBpbLhbmMdlikFqMD/
        fgcfXwzndmB9TB8DzIPlx+O+wRrDdh9Ms5ISseeLJJ8ZOcUbhAhHLgyvRj3aiVE=
Received: (qmail 4170448 invoked from network); 17 Mar 2023 10:07:29 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Mar 2023 10:07:29 +0100
X-UD-Smtp-Session: l3s3148p1@5Iok6BT3Po8ujnvb
Date:   Fri, 17 Mar 2023 10:07:27 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] tty: serial: sh-sci: Fix transmit end interrupt handler
Message-ID: <ZBQtzwCDDbIYM+yv@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
References: <20230316160118.133182-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdVX=sM-1y+-3PQDsjf8K3nLoS4WfSYfv6UAP=92T_oHaQ@mail.gmail.com>
 <OS0PR01MB5922EA7DC64F0D2C36B490A986BC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXgwkJ2O7y98HW6n8SOgbuEx1uFrt1Jc-X2CzpC3y1P0Q@mail.gmail.com>
 <TYCPR01MB593334BB3847CCC45A1B6C7286BD9@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <CAMuHMdUN=0aJ-7huv0XrhG3LMu8q_SEuqHU48ytTgGAYEjng5A@mail.gmail.com>
 <TYCPR01MB593390150CAC755AE540D7D586BD9@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <TYCPR01MB5933865E5D673865B7C4A85586BD9@TYCPR01MB5933.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P/5OshVCHii0RPDa"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB5933865E5D673865B7C4A85586BD9@TYCPR01MB5933.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--P/5OshVCHii0RPDa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Biju,

> Wolfram, Can you please confirm transmit end interrupt handler worked for you
> with the commit 4c84c1b3acca ("ARM: shmobile: r7s72100: add scif nodes to dtsi")

That was nearly 10 years ago :) I can't recall if a specific interrupt
worked. But SCIF worked. So, if it was needed for proper operation, then
it probably worked. If it was not needed, no idea.

This is all for a Fixes: tag, or? Is it that important?

Happy hacking,

   Wolfram


--P/5OshVCHii0RPDa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmQULc8ACgkQFA3kzBSg
Kbbt/A//R2kPWS3dRk0CN6rhoyk2btm4CaiHvZoBLmQfDAoOI0zF+ePQEvQKzjGh
HdHXWmxjkEarWcXkAo5tdAsWhpc7gdvIw90tM6J6uOh3hDg76aHE5Aq7z+nDqHg2
cNC6Hgy1uCO+YS6m/Kp5542IUVLbdjgafQPCwd18p5hbkziw3yOU9Tfw5dE5hcoA
E74tGgWPYSFwuA0rBFbbdzEIKUFF9oP4RPgG1T6LHwoKWgDopkZqjmXixPFr3T+E
ii9BVY9X7BjQtsvAYF10odiJrH0+KoGysqYduvB5NT3O/FOtCs6T3WeVpIAdNLEx
nop6cbsD5XZKDrT6fUsMg2Bs0VWEZ2qttgB36nmdSFs26kSCjMJh5t3OELcGWEcx
RyM+ZNBcsmNrBhH/j2I1myWiDDpMwYNNlVxUaF0em2cXWuIVlpnYJTT0vwoJk2gQ
VDuSReaqDkjHUJOlG4Uv8kRlujRe3h/QobrNe4eM+/QEID+dSwkH7FuO8sI0RYpC
vVi/421AZuTOipakklVOkSRaUcVV+f1q+ZPnP4U1yZsWVOc9u0DgKuvDN5+5joyq
7o81MPOy9zoJXUztSmwTVmpx0IMG0FGEZpGmWU9C0gw0N84PJnhjYazU4QVIqSmg
F26P2s786p4HfWui+fhzdPdZUCmz72AQMBlQvLyLaBijRdsoCHQ=
=xtAU
-----END PGP SIGNATURE-----

--P/5OshVCHii0RPDa--
