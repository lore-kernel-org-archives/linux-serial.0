Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9578FC433DB
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 14:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AF9619C3
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 14:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhCWOhk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:37:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230359AbhCWOhN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Mar 2021 10:37:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EFB4619B1;
        Tue, 23 Mar 2021 14:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616510232;
        bh=GYdSef73Ih0liGvmbu7PRz6w0m+pFX/EdQ9/F+bTQC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LhKy7a8lZSfXVovVKfo+UjJcSIWpVN/dklyEF/B+VPyGLXZ5qw3YUnSTgE3kedeXx
         KqQgpgt4PZRVw4FFInrtAn3HGhUQ6s2dd+woQRjhGSg9zS1kAjK5nkOan5Exg5DnTU
         M3simwT1k0KjGMu2NNlOPFOO9OLByBz3CXBJWpqHL41VZqT/A6OpvtqbdBzbY5xu63
         1oy21/0c+Assw+gkDhfvcLCcg3xhyzHgAbsNE/e/kaOjXIerl8wbD5kfAOLeCAPEGy
         KNZV5u3wQh3uYTZYSb3yixBjuF+orkPc6sZ1uw/zfX6Ckh9ez6HcrvQ83Abqutt+TR
         caMhee4jFoo+g==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lOi9x-0003bJ-HJ; Tue, 23 Mar 2021 15:37:29 +0100
Date:   Tue, 23 Mar 2021 15:37:29 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Nobs <samuel.nobs@taitradio.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] serial: imx: drop workaround for forced irq threading
Message-ID: <YFn9KenzUQl4KPRt@hovoldconsulting.com>
References: <20210322111036.31966-1-johan@kernel.org>
 <20210322113402.naqzgkoe2xesnw4b@pengutronix.de>
 <20210322113918.ze52gq54cpsspgej@linutronix.de>
 <20210322115536.knkea7i6vrfpotol@pengutronix.de>
 <YFiZuXWYmxPIaQH9@hovoldconsulting.com>
 <20210322134032.kmirudtnkd4akkgu@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="txnopxRBdafKGJCz"
Content-Disposition: inline
In-Reply-To: <20210322134032.kmirudtnkd4akkgu@pengutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--txnopxRBdafKGJCz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2021 at 02:40:32PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Johan,
>=20
> On Mon, Mar 22, 2021 at 02:20:57PM +0100, Johan Hovold wrote:
> > On Mon, Mar 22, 2021 at 12:55:36PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Mon, Mar 22, 2021 at 12:39:18PM +0100, Sebastian Andrzej Siewior w=
rote:
> > > > On 2021-03-22 12:34:02 [+0100], Uwe Kleine-K=C3=B6nig wrote:
> > > > > On Mon, Mar 22, 2021 at 12:10:36PM +0100, Johan Hovold wrote:
> > > > > > Force-threaded interrupt handlers used to run with interrupts e=
nabled,
> > > > > > something which could lead to deadlocks in case a threaded hand=
ler
> > > > > > shared a lock with code running in hard interrupt context (e.g.=
 timer
> > > > > > callbacks) and did not explicitly disable interrupts.
> > > > > >=20
> > > > > > This was specifically the case for serial drivers that take the=
 port
> > > > > > lock in their console write path as printk can be called from h=
ard
> > > > > > interrupt context also with forced threading ("threadirqs").
> > > > > >=20
> > > > > > Since commit 81e2073c175b ("genirq: Disable interrupts for force
> > > > > > threaded handlers") interrupt handlers always run with interrup=
ts
> > > > > > disabled on non-RT so that drivers no longer need to do handle =
this.
> > > > >=20
> > > > > So we're breaking RT knowingly here? If this is the case I'm not =
happy
> > > > > with your change. (And if RT is not affected a different wording =
would
> > > > > be good.)
> > > >=20
> > > > Which wording, could you be more specific? It looks good from here =
and
> > > > no, RT is not affected.
> > >=20
> > > The commit log says essentially: "The change is fine on non-RT" which
> > > suggests there is a problem on RT.
> >=20
> > I don't think you can read that into the commit message.
>=20
> From a strictly logically point of view you indeed cannot. But if you go
> to the street and say to people there that they can park their car in
> this street free of charge between Monday and Friday, I expect that most
> of them will assume that they have to pay for parking on weekends.

That analogy would almost seem to suggest bad intent on my side.

To say that this workaround is no longer needed on !RT does not imply
that it is needed on RT. If anything it suggests I have considered RT,
I'd say.

> So when you said that on on-RT the reason why it used to need a
> workaround is gone made me wonder what that implies for RT.

Fair enough. I thought it was obvious from the commit message and the
commits referred to, and that RT wouldn't depend on patching random
mainline drivers like this without a clear marking such as using raw
spin locks.

Greg's already picked this one up and this is hopefully the last one
we'll see of these.

Johan

--txnopxRBdafKGJCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCYFn9JQAKCRALxc3C7H1l
CP6CAP9iJ4aA9z+rdfbnn/Y/zhfYXeYc9JiMRlPSnOD3jLivqgD/Ws9s4cQePwRZ
AszzqGt96E0Nv19TD+uN9D1T0QqvIgg=
=aZC4
-----END PGP SIGNATURE-----

--txnopxRBdafKGJCz--
