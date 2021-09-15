Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E906EC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 11:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53AB6134F
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 11:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhIOLuP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Sep 2021 07:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232586AbhIOLuO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Sep 2021 07:50:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA04761246;
        Wed, 15 Sep 2021 11:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631706536;
        bh=ULt7y7tlP2cZHmwB9aO/zjfoepDHbhQXuJJhhHwwVfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrbbakUZO/UiFPHZPDIrXQMt6Hd3ECtoD0+UmLKzNepXxi/s0Tgh0CFCILmJ3uQFc
         nv4KnwoKbtAogsmbjUJlgwVO2vViafyjsJ4Hq1iIAHkWQS9dGjtBCRvF7Ib+YXkRHd
         ENgzdWuw65sq8nw3xLOc51Ovn9mk1bBUapSarCfR1bkg0hoQIgw3D0XYFEaqFCidLP
         kvMxbQSPnjphSmrGX0XAO8KfWGaOK6Gr44X46CBt5TZFhZA646QvdB4K+QYJWZhqFk
         5uu8jvE1VXaXQHp+yKif0Pr6mcUW7UosGas93Cskl6IokuYRffJpc4+EHDkr2efYuC
         rT1CwPxnFTtug==
Date:   Wed, 15 Sep 2021 12:48:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 04/16] tty: make tty_ldisc_ops::hangup return void
Message-ID: <20210915114815.GC5389@sirena.org.uk>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091134.17426-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <20210914091134.17426-4-jslaby@suse.cz>
X-Cookie: Absence makes the heart grow frantic.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 14, 2021 at 11:11:22AM +0200, Jiri Slaby wrote:
> The documentation says that the return value of tty_ldisc_ops::hangup
> hook is ignored. And it really is, so there is no point for its return
> type to be int. Switch it to void and all the hooks too.

Acked-by: Mark Brown <broonie@kernel.org>

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFB3X4ACgkQJNaLcl1U
h9DDoQf/QaVYNcPoOnOAsOBcNtUmh0pOeb5CqVH3nYyw3lZ81HrC6mbb2BNeBptU
bXkoe19bi4VOCVDTblT77YP3A9+oMI4VqPeYQ9Q5oePhKlS9mK4B2IC5P1ZIxXFe
y7xtmFtyVfA/3TGFJXHGS39xliSQlSkaWYGfDrjarR+Vsci2+TIlEaD2c0IaHFqy
8xnWfnvhTDDdlnM/NIYqAwJ9kJk8CrsODwiW4JZMUhCreELTSDpRihSEn8jblyrG
xlEJVf0wpBpl+E/K4U3KDbI1XCgyoN5pYouXnPc0ThXDNcCDDqpPZeKNlFtnPhkN
R9Nocu9JUmTaLRjg+lFALleZCYgcbQ==
=/6qu
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
