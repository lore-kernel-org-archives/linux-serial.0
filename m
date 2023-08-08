Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CB3C04FE1
	for <linux-serial@archiver.kernel.org>; Tue,  8 Aug 2023 16:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjHHQ3c (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjHHQ2C (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Aug 2023 12:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9543D12508;
        Tue,  8 Aug 2023 08:50:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFCC36246E;
        Tue,  8 Aug 2023 08:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C263C433C7;
        Tue,  8 Aug 2023 08:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691484295;
        bh=V0JjdjWFu8BlALkRvb98EGszbrLZ7TsBsZIaq0wNp3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QlJoo9863UPXmu6vUeNZZrupDqQMvlQtd/gwa+jI7UzoH7tQVnWI55mdW7GH2fNAy
         geM9QPQ/FSDiOUIwuFk1Sjp6YhcqOEpaDtXkygPiGf1a3PADEkjCs1nDYDsZGtfTia
         OsWh9lm+rh4LaGznlvpdJ1PO9dFuX9C53oNR3GscQsr9Yle/ABIUam8JSERftaFdgC
         qf9e/lZUikS4GjY8tqCCViYu6HFe4TVq/CwTNKrkN7mFe6oKkENSHFJnrmAIbo/y6+
         DrpL621Z16qIgO+EWd1uKkRSIu9NebLeeqVPDBZF+Yc1C9S6d0l/jNf9kkMMzj4X73
         rboi9s6paiz8A==
Date:   Tue, 8 Aug 2023 09:44:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nick Hu <nick.hu@sifive.com>
Cc:     zong.li@sifive.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 1/2] serial: sifive: Add suspend and resume operations
Message-ID: <20230808-pristine-celibate-60957ea523c0@spud>
References: <20230808072625.2109564-1-nick.hu@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tg8By4CLw6nciaNc"
Content-Disposition: inline
In-Reply-To: <20230808072625.2109564-1-nick.hu@sifive.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--tg8By4CLw6nciaNc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 03:26:25PM +0800, Nick Hu wrote:
> If the Sifive Uart is not used as the wake up source, suspend the uart
> before the system enter the suspend state to prevent it woken up by
> unexpected uart interrupt. Resume the uart once the system woken up.
>=20
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Where is patch 2/2?

--tg8By4CLw6nciaNc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNIAggAKCRB4tDGHoIJi
0kjiAP9splKZLGeVPLX6Pjze+Q7jOtbYC3DyEPCQhvlQE23anAEA83jEjSG4Cz/0
RPCozvkWTm9LHI8WRpoHeTGj21egiAM=
=gbl6
-----END PGP SIGNATURE-----

--tg8By4CLw6nciaNc--
