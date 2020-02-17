Return-Path: <SRS0=lWnk=4F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B803C34022
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 16:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5B1214D8
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 16:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581957117;
	bh=MLriwpgSY8SJL0JLquod6FFKeKcBWHvXJlgxf08Q1hI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2C97hQRU7PykTn+99/HlBOh1aBnqV7Xs2UnLmLf8o1T68QorayOUg8mrZ8WIC/EEy
	 rEAOWu2LU9cYuZLkqGzLrEdb8yXlD+8oFEwy1IRmNd9VwPXnigGltCoGelx49eoESx
	 0uIj6ChIdxyy4L1Ch56ghL1wnnxSY9mVix29RgU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgBQQbz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:31:55 -0500
Received: from foss.arm.com ([217.140.110.172]:38272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbgBQQbz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Feb 2020 11:31:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ECE130E;
        Mon, 17 Feb 2020 08:31:54 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4AD13F68F;
        Mon, 17 Feb 2020 08:31:53 -0800 (PST)
Date:   Mon, 17 Feb 2020 16:31:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH 4/6] spi: spi-geni-qcom: Add interconnect support
Message-ID: <20200217163152.GQ9304@sirena.org.uk>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-5-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9+VnUxDxRuy97YQ+"
Content-Disposition: inline
In-Reply-To: <1581946205-27189-5-git-send-email-akashast@codeaurora.org>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--9+VnUxDxRuy97YQ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2020 at 07:00:03PM +0530, Akash Asthana wrote:
> Get the interconnect paths for SPI based Serial Engine device
> and vote according to the current bus speed of the driver.

Acked-by: Mark Brown <broonie@kernel.org>

--9+VnUxDxRuy97YQ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Kv/cACgkQJNaLcl1U
h9C0DAf/ZL04JTosjXBLegMQrmn9rjYoKyenucR6bwhVK2SMK73TkxGKO7vjD/vN
it0Qg/z04vrqX/4Z6Nfbcmt0Y7T8RGK9YxWMGU7mVyup19Dqm0wYFc5qkBV2h3DY
k9/tUYoYmc6hddevcpgWwG38oU0eJJ9UoWVWvkOfCXK4VmjYnyxdUTcG4oRfDUFZ
rTjQlYIfYaqZJebjxTYB6cst1z2cvQ3ccOIYLH5PM5Z9V5BUx7mqz6ZsXQ/8qWZG
mVsA6RTuTPKlRsa3Fw++Y6QSIO4r4wLH96Z2JA7Dl8wVzofTtbrSFuel93qWz0Ny
e/uNxPQ+GY/Nx19wFOrfJ1ErkNi0pg==
=f/E0
-----END PGP SIGNATURE-----

--9+VnUxDxRuy97YQ+--
