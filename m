Return-Path: <SRS0=6uIZ=5C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126FAC10F29
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 13:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D725A2075E
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584450379;
	bh=5rle59ERLTAh4CkX246zWaIETVEqjqMs4A11EPscjgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yAbpI8F0VYV5MmxFcq2VPFZCYYQ6tmreUJ68YLfTpD6JZZHaTdmMLXMsAkReZuZRk
	 b+e3VCPAw7q1FjAtX6uU1YIWyMAJX6SGfdhPe4/Q6PnCVwL9uTynVkgf6vPBT6ZFqt
	 0VS2LQD6Xld/iH/g3vodrvlDrC+043wh6ILGN4pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgCQNGT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:06:19 -0400
Received: from foss.arm.com ([217.140.110.172]:37940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgCQNGT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Mar 2020 09:06:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5466830E;
        Tue, 17 Mar 2020 06:06:18 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A72F53F534;
        Tue, 17 Mar 2020 06:06:17 -0700 (PDT)
Date:   Tue, 17 Mar 2020 13:06:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org, evgreen@chromium.org
Subject: Re: [PATCH V2 6/8] spi: spi-geni-qcom: Add interconnect support
Message-ID: <20200317130616.GE3971@sirena.org.uk>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-7-git-send-email-akashast@codeaurora.org>
 <20200313131603.GG5528@sirena.org.uk>
 <aa197568-3bac-6962-d39d-3261f68c0514@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <aa197568-3bac-6962-d39d-3261f68c0514@codeaurora.org>
X-Cookie: There's only one everything.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2020 at 03:05:21PM +0530, Akash Asthana wrote:

> We are taking care of actual throughput requirement in avg_bw vote and the
> intention of putting peak as twice of avg is to ensure that if high speed
> peripherals(ex:USB) removes their votes, we shouldn't see any latency issue
> because of other ICC client who don't vote for their BW requirement or
> *actual* BW requirement. Factor of 2 is chosen randomly. Please
> correct/improve me if this is not okay.

> If this is okay, I will centralize this design for SPI QUP, I2C and UART
> driver.

That seems reasonable to me, it was just the fact that every driver
seemed to be doing the same thing that I was noticing - what was being
done seemed OK.

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5wy0cACgkQJNaLcl1U
h9Ae3QgAggJnWHS/CyykvzCHo7E8nPR1L9kx3kYVZpAuCtrYfxzrw9cs6+7l/K1G
CKM6uVeL3GtVc7wO+8Y3B6KSmyXcNYMZnHTk/skQlxv2i32r3gRIYxXbl1xqoZXn
8r//df86MC+eLCnCLLngJD57k4mHG6yP0+05zpZ28N8F0rSFbG5+hC303bojUM9i
/wi8QJBfXtABa4qZ1UpiAlUghsIIjLQDn+LYHFDALx1Ju/5XShsVHfIMaJuVeVQ4
vbfLjXl+GDyNSQ8Yxa7Thzojxjys+Wk1ZFChxJ7FPfhGEYWjAv/Q8k12R7D/oUl9
4srH0EJ6Y77GgPuPPEQpQYO6ecHiMg==
=e7Eb
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
