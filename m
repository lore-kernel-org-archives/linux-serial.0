Return-Path: <SRS0=Q4yL=AE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D65C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 23 Jun 2020 10:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C82320768
	for <linux-serial@archiver.kernel.org>; Tue, 23 Jun 2020 10:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592909849;
	bh=iRkw0xFnoVAw8okWWLZWHBDHmZ4IX8+3KhsF9mtAHMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zXSGjKvzkD5LJPtGAnJBBJXEzJ6NkBqq3Hk0jZeZqc5aKq4pEpQ0I/jofNKUIMidO
	 SA0yDLxXFb4pFmR0Ct9/JOmRZeH+aZ/FSILMJeRoMsbmEhe/gTNSOCTcKVamoUZqho
	 OdxunxrgApmAEeVEA5pBfbPaN+A/YEeEy8U0U4m0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732300AbgFWK52 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732205AbgFWK52 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Jun 2020 06:57:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B8BE20738;
        Tue, 23 Jun 2020 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592909848;
        bh=iRkw0xFnoVAw8okWWLZWHBDHmZ4IX8+3KhsF9mtAHMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pnhohF/zFVVxbHXdDWMaU8xlCbJqiIE8u/vTBUMyvTLCWyldXnfHqY83UyAq6pIGB
         98SpmHhnfXchISOVnBM7yKrmP8zysgz1VcMgf9kknDqnMJOXF0vy0vnyPRjWcTM/q8
         Z7pIuWF1GaAEthRn65m2K3FtUNFk8GpvTg3w2kME=
Date:   Tue, 23 Jun 2020 11:57:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org, evgreen@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 6/8] spi: spi-geni-qcom: Add interconnect support
Message-ID: <20200623105725.GC5582@sirena.org.uk>
References: <1592908737-7068-1-git-send-email-akashast@codeaurora.org>
 <1592908737-7068-7-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline
In-Reply-To: <1592908737-7068-7-git-send-email-akashast@codeaurora.org>
X-Cookie: No motorized vehicles allowed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 23, 2020 at 04:08:55PM +0530, Akash Asthana wrote:
> Get the interconnect paths for SPI based Serial Engine device
> and vote according to the current bus speed of the driver.

Acked-by: Mark Brown <broonie@kernel.org>

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7x4BUACgkQJNaLcl1U
h9DnSAf+IN0s+n8VEWl4lI3UNLYubAUrS3o4rQIpDmGYGgeLf6Hsn18VzYTp4TPI
YQfdE7lKKSzxsIOnUreMtYhlZyEEdB7cvIaKOZNVq81EPuUOWlHefuClCFFm/hX7
Hoqj66HDjO0g1/ILDpE8vgZNt80ETU3z6A1L1m6U8SV15sq30cVYOM8l51gVyD87
iMQw8GXKKywdPZADOWQTYuYBFJaslSDn6RT7CE/yVhGksdE6jyh+VIVcQbov30bN
0Wydkr842OmzT7HLQXwaz2A0HWxe1bZwh9zP2kfgMz+CIfIHlLh1CpIlEiQo90dT
J88TfoT/YJyM9FjGdiVs1v+GLaauQg==
=Gs1S
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
