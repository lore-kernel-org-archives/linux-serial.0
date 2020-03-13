Return-Path: <SRS0=O7Uh=46=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4E8C10DCE
	for <linux-serial@archiver.kernel.org>; Fri, 13 Mar 2020 13:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90BC2073E
	for <linux-serial@archiver.kernel.org>; Fri, 13 Mar 2020 13:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584105367;
	bh=cYl8UilvI8TSR3Dr5f1EHPAAgkQktD/qtw/h/6dKS6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yWOGUV6Z3VL1N5eHSVgzhpg4JWJ4/X/LeqAbyU+6brVPd64ngr9v25CnrT7NLjuH/
	 xgMJ3b2SM7CcTlSVUsPVJkYQe2X5sruUSjLx7cMNP8rRTHzYa1jYcanjAh1q2EaxaB
	 AKPz66fjCe/wAverP7OAskQ7et+R2owr8KuBehfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgCMNQG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:16:06 -0400
Received: from foss.arm.com ([217.140.110.172]:55062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgCMNQG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Mar 2020 09:16:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C44EBFEC;
        Fri, 13 Mar 2020 06:16:05 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 044253F67D;
        Fri, 13 Mar 2020 06:16:05 -0700 (PDT)
Date:   Fri, 13 Mar 2020 13:16:03 +0000
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
Message-ID: <20200313131603.GG5528@sirena.org.uk>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-7-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yZnyZsPjQYjG7xG7"
Content-Disposition: inline
In-Reply-To: <1584105134-13583-7-git-send-email-akashast@codeaurora.org>
X-Cookie: This page intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--yZnyZsPjQYjG7xG7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 13, 2020 at 06:42:12PM +0530, Akash Asthana wrote:

> +	se->avg_bw_cpu = Bps_to_icc(mas->cur_speed_hz);
> +	se->peak_bw_cpu = Bps_to_icc(2 * mas->cur_speed_hz);

As I commented on the previous version to no reply there seem to be a
lot of cases where the peak bandwidth is just set to double the normal
bandwidth without obvious analysis.  Should this default be centralized?

--yZnyZsPjQYjG7xG7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5rh5IACgkQJNaLcl1U
h9AtyAf/XGCSN/P2UBMgDB7zS2/kHyiB75d+zQ4/Y9kOYRRUEmraGjcBvlQ7hPn0
8hDCOOdWQp+X3iY8ttBkizIjAaCUiZmBd2aG7POa4PTMB1+oS1TFXrmws+ay3y3k
AGSiIcaVWMok+DPTsNcRAwnjI+qw+4kzyvvShiRE6Ph/T1EE5/UL96CFf6pW8phf
x3ehV4YsJ+ZIhHFe1NAD+xKtlO6WrQxin6K3D9KxfjAp8qF7BobdNMxQZZh0kff1
432vNAgsp/g/O+SHfSZWzUtsTiznj9IQ1WcQQVHQmhAsiOKd8xihsUYcsL+B8biv
xaZIVqWrbN9/wiOrtAxMRsrXMJFJpg==
=l0mj
-----END PGP SIGNATURE-----

--yZnyZsPjQYjG7xG7--
