Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D674915A1
	for <linux-serial@vger.kernel.org>; Tue,  8 Sep 2026 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895510; cv=none; b=F5l+5Z1zw88pE8bXklRavuyJ3IiBFcE502UVYA7VEeHVN1jRkDHVzAJzidDpCWMPCSkad6194YgYU82GiKMv4BLjlw0Ng4iZ/djriqZiZQCpOVbr78/LU3phsPQb8dnpy2vk7b1GhGYLIaZPAMx39yRQwJI5IxW79R0pTUvDftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895510; c=relaxed/simple;
	bh=MGtDZ2Q+c9nMcvNrm3D2NePamqw4oqikX+ZihyLR3RA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TN6IMe8BCbaLbdb+cp185co1yDKGNSVw8rUjIzLlnQE/CRhMCd7N9yQXQQo/LBCaMem6P3BYZKMuhH8RU0kdJukXuEKBGLYkbDSOTsi0HRmw40y967gMGv5+qtT5sPLGxYZoS7BWL1C6gsQy/8HLBQ4Ds85PE4hn5r0vFI49HUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvTjouFA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvTjouFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8148C1F00A3A;
	Tue,  8 Sep 2026 19:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895508;
	bh=W8QFmrhiuSRU5LfNWpOtgDFbI3NNNY64qRrGyGmAOWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mvTjouFApUxCI3ojWVN7emM3amJzm4FVtuXy4ROxvl1nht9O7WbL7fS8ULsNS3fPL
	 CFNT1dewCzMuPIDzko4mNd1Z/q2toiMfGrw9ik1SQedtQwlasnMJLbc3xqxB6cQP+Z
	 oFZpxXAjPo1zeUtQkXBl0HUVqqeQ9JlgL8nGHQP43qtlKgrHD7DskhEx4pEzRLcEKt
	 5tlcAuidB7abcx3YKXaie1hQ3CEdLfL11kPDAFOJjsIc+zb5cyXby6aIdZWOw1THW+
	 QZS6Y1kSZI3EIwiJq+rXYdyjIPKf7XakxTBe2lDihskc9kjE6+t3eCgKeq6aGBdQPy
	 qfEH7ZQPHY0aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] soc: qcom: geni-se: Correct QUP Core ICC vote
 constants
Reply-To: sashiko-reviews@lists.linux.dev
To: "Viken Dadhaniya" <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260909-correct-icc-bandwidth-vote-constants-v1-1-fbebf6b3c341@oss.qualcomm.com>
References: <20260909-correct-icc-bandwidth-vote-constants-v1-0-fbebf6b3c341@oss.qualcomm.com>
 <20260909-correct-icc-bandwidth-vote-constants-v1-1-fbebf6b3c341@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 19:25:08 +0000
Message-Id: <20260908192508.8148C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The new Bps constants for QUP Core 2X clock votes are too large =
and will be clamped by the RPMh BCM voter, breaking dynamic bandwidth scali=
ng for frequencies >=3D 150 MHz.
--

commit 4b7db07800053a04e9ce8152ed56486618d8f495
Author: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date:   Tue Sep 8 19:05:33 2026 +0000

soc: qcom: geni-se: Correct QUP Core ICC vote constants

This commit corrects the QUP Core 2X clock rate constants by scaling
them up to their intended raw Bps thresholds. The previous values were
under-voting the QUP Core clock.

> diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/ge=
ni-se.h
> index 29a53bbc0dd49..2243005f5e2ee 100644
> --- a/include/linux/soc/qcom/geni-se.h
> +++ b/include/linux/soc/qcom/geni-se.h

[ ... ]

> -#define CORE_2X_100_MHZ			5000
> -#define CORE_2X_150_MHZ			7500
> -#define CORE_2X_200_MHZ			10000
> -#define CORE_2X_236_MHZ			16383
> +#define CORE_2X_100_MHZ			50000000
> +#define CORE_2X_150_MHZ			75000000
> +#define CORE_2X_200_MHZ			100000000
> +#define CORE_2X_236_MHZ			118000000

[Severity: Medium]
Will these higher bandwidth values be clamped by the interconnect framework?

When these values are converted to kBps via Bps_to_icc() (e.g., 75,000 for
the 150 MHz state) and passed to the RPMh BCM voter, they undergo scaling
in bcm_aggregate().=20

With standard QUP parameters (vote_scale=3D1000, buswidth=3D4, unit=3D1000)=
, a
kBps vote of 75,000 evaluates to a calculated vote of 18,750 or higher
depending on aux_data.width.

The hardware TCS command mask in the RPMh voter is limited to 14 bits:

drivers/interconnect/qcom/bcm-voter.c:tcs_cmd_gen() {
	...
	if (vote_x > BCM_TCS_CMD_VOTE_MASK)
		vote_x =3D BCM_TCS_CMD_VOTE_MASK;
	...
}

Because BCM_TCS_CMD_VOTE_MASK is 16383, any vote resulting from these new
thresholds for >=3D 150 MHz will exceed the mask and be clamped to 16383.

Does this result in a loss of dynamic bandwidth scaling granularity for
these higher frequency requests, effectively always requesting the maximum
frequency state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-correct-ic=
c-bandwidth-vote-constants-v1-0-fbebf6b3c341@oss.qualcomm.com?part=3D1
