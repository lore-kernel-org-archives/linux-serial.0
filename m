Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA9F193467
	for <linux-serial@vger.kernel.org>; Wed, 10 Jul 2024 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622120; cv=none; b=STvvryPt2uz9FqVNmWRq4h41fwxFUoaVqmfYpgQNmZ+hgdXKvo8gL8D7FTRejW3GoH4Wmtd+Faa4r7U0Mz3rUilENqxhwJVSh4NKDmLN0Adn7XXcDBQnYtDuVJMSGDD1RRnG+e8+cGBzcwfcDU+g7InkH2tDm2z0TH2EpmiAuG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622120; c=relaxed/simple;
	bh=7ZxJZY6gKoQFwNHdxiPGNOckl89lxdBAnIdeXwRvngo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=mFH03+XEreCRUr2QXhMcbEmfD0iCWXjeiJKc12xUrjXlNnYWv866mWTgE19mBrogkZUCBC9Y+R6BPv3jj5P8Pa8dRW/R6KWmmfdJ0CGhgQs3RIKhC4vUrRn+kT5HkLIAe/6n9HCJetRUjZhKen72Nzlrh1nlkK/OaqLHgWZzJCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mbxLu5p3; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mbxLu5p3"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240710143516euoutp01c5053965f3058aeb3762caacf03466bc~g4LLkwezR2713927139euoutp01f
	for <linux-serial@vger.kernel.org>; Wed, 10 Jul 2024 14:35:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240710143516euoutp01c5053965f3058aeb3762caacf03466bc~g4LLkwezR2713927139euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720622116;
	bh=aEBvXZqhS4HH+bJh8VEk5/tXzC2cbn/RN1jKxc/D+Ts=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=mbxLu5p3EamHhQp5Kew1KujYyRcsL3dho9oglRqdJgqt4zv6rtRO1N8Lr5tIy0bIe
	 0bl7RjrJkC91tuiS+Q+o9e2Tcv+/LtFtegoSV8mbkXtim8exhI1RgpvxJ9CBzFiWKe
	 UQt3fvjimOFNmTbFeHBSLZB43rkz6H4Fo9tRrbPE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240710143516eucas1p105f3f6ae03c7dbfa3024557a3b6be453~g4LLG7kls0056600566eucas1p1v;
	Wed, 10 Jul 2024 14:35:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id A6.5F.09875.32C9E866; Wed, 10
	Jul 2024 15:35:16 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240710143515eucas1p259fa5a03cb56cc2b3d82d124fb8f1cb1~g4LKpxdnc2890628906eucas1p2-;
	Wed, 10 Jul 2024 14:35:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240710143515eusmtrp2afbfab2c14d5a198be6ade93b7f9dfaa~g4LKpABwN2804928049eusmtrp2v;
	Wed, 10 Jul 2024 14:35:15 +0000 (GMT)
X-AuditID: cbfec7f4-9acd8a8000002693-a3-668e9c2375dd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 71.D7.08810.32C9E866; Wed, 10
	Jul 2024 15:35:15 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240710143513eusmtip12b69aa17ffc422426b00e9e44f936f53~g4LJAFqBO2253622536eusmtip1i;
	Wed, 10 Jul 2024 14:35:13 +0000 (GMT)
Message-ID: <0faacbeb-2ca3-4749-89a8-6dd81621a07d@samsung.com>
Date: Wed, 10 Jul 2024 16:35:13 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] clk: samsung: gs101: don't mark non-essential
 (UART) clocks critical
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, Greg
	Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Peter Griffin
	<peter.griffin@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, Tudor
	Ambarus <tudor.ambarus@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240710-gs101-non-essential-clocks-2-v3-2-5dcb8d040d1c@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7djPc7oqc/rSDNZuZrJ4MG8bm8WWV5tZ
	LNbsPcdkcf3Lc1aL+UfOsVo0L17PZvFurozFju0iFi9n3WOz2PT4GqvFx557rBaXd81hs5hx
	fh+TxZnFvewWF0+5WmyY8Y/F4v+eHewWh9+0s1r8u7aRxeJ5H1DFp1txFqs+/Wd0EPPYtnsb
	q8f7G63sHgs2lXpsWtXJ5nHn2h42j/1z17B7bF5S79G3ZRWjx+dNcgGcUVw2Kak5mWWpRfp2
	CVwZMxbMYyo4KVLxcmojewPjXoEuRk4OCQETib+7ljN2MXJxCAmsYJQ4N2MXM4TzhVHiyMQl
	rBDOZ0aJk3u+ssK0XPx0mB0isZxR4sWXTVD9Hxklll++xQRSxStgJ/HqwnywDhYBVYkdTxey
	QMQFJU7OfAJmiwrIS9y/NYMdxBYWSJJYcOMV2DoRgWssEp+fPwQ7hFmgjUni4aVWZpAqZgFx
	iVtP5oNtYBMwlOh628UGYnMKBErcPH0EqkZeonnrbGaIWx9xShw5ZdbFyAFku0isOBgDERaW
	eHV8CzuELSPxfyfISC4gu51RYsHv+1DOBEaJhue3GCGqrCXunPvFBjKIWUBTYv0ufYiwo8Ts
	jhcsEPP5JG68FYQ4gU9i0rbpzBBhXomONiGIajWJWcfXwa09eOES8wRGpVlIwTILyZOzkDwz
	C2HvAkaWVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIGJ8/S/4192MC5/9VHvECMTB+Mh
	RgkOZiUR3vk3utOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ86qmyKcKCaQnlqRmp6YWpBbBZJk4
	OKUamBZsi3x6VzJKY4Pgrat10x3u7khV7vJN2fzaPDvK2OGx7AzdvKk3wrrSHq2TrfWYK+So
	c14z917WhArNNfuSPrw9X+w/fRq37lHxqA/Kr6O/+pfoz/AQ2fA8vuq629/lV6cnXVgTl+gz
	/WzsdIm8u/sPChVteHztzLnYrQVJkhK6wsJch5qnzlW8nlAmcnzJrMSJrdv6nn3lnnnveJeO
	dtuxHZ57dxY91bD2kl8Qkxdt9O7Q6/bXns7s29eIT9Rxmf4mYmayX8ev24JxocvX64a7VvCK
	W87ZO8Nr0ycDvyVGKTk3/J7IcGQq/P0u47VTdrVwkH/NmgNG0c92H93BuuGw8n6BnkvnJX0+
	LG6dulOJpTgj0VCLuag4EQBlHAcPCwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42I5/e/4XV3lOX1pBoe7pSwezNvGZrHl1WYW
	izV7zzFZXP/ynNVi/pFzrBbNi9ezWbybK2OxY7uIxctZ99gsNj2+xmrxseceq8XlXXPYLGac
	38dkcWZxL7vFxVOuFhtm/GOx+L9nB7vF4TftrBb/rm1ksXjeB1Tx6VacxapP/xkdxDy27d7G
	6vH+Riu7x4JNpR6bVnWyedy5tofNY//cNewem5fUe/RtWcXo8XmTXABnlJ5NUX5pSapCRn5x
	ia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GjAXzmApOilS8nNrI3sC4
	V6CLkZNDQsBE4uKnw+xdjFwcQgJLGSUu/exkgkjISJyc1sAKYQtL/LnWxQZR9J5R4veDZWBF
	vAJ2Eq8uzAcrYhFQldjxdCELRFxQ4uTMJ2C2qIC8xP1bM9hBbGGBJIkFN14B1XNwiAjcYJG4
	agQyk1mgjUni19orrBALXjNK3F30hxmkgVlAXOLWk/lgy9gEDCW63oJcwcnBKRAocfP0Eaga
	M4murV2MELa8RPPW2cwTGIVmIbljFpJRs5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpe
	cn7uJkZgoth27OfmHYzzXn3UO8TIxMF4iFGCg1lJhHf+je40Id6UxMqq1KL8+KLSnNTiQ4ym
	wMCYyCwlmpwPTFV5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1M
	+2Vnb+LP3x5z+emhpa9LOHlZ5LyNxBpPzUyMqIn8oFFfPuGB4bqSnbnKIdrPLI+0OERcjF53
	UC9g79UvShsk/1/flNRSpDbtZe6rH6aPtq0+0XVkg55eBtMnn/hFJlN/cEkkp69y3vkj0XRa
	vR3rN53LTm4/dkhr1USKOPOxMq23mBhx1+mAx8KG3asiE98Z17F91Z6Yf3p3w5ZIn6VfDRvm
	rL1X/c6Uc2Jpd8yOol2HA80sn03uDT1qZVKm0e375IVNTpLl7RoNqSTPlGSpXTY3dx6K3pk0
	0ff2kpy3KcKRxqUdycoutVdivL8GXBZ6vYPPbuVHf+lTb//wu1qn6fdXtj12YP5rKtiZslaJ
	pTgj0VCLuag4EQAGpS7nnQMAAA==
X-CMS-MailID: 20240710143515eucas1p259fa5a03cb56cc2b3d82d124fb8f1cb1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240710132933eucas1p1b4367ec7a3938a39e732b3079eff6f32
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240710132933eucas1p1b4367ec7a3938a39e732b3079eff6f32
References: <20240710-gs101-non-essential-clocks-2-v3-0-5dcb8d040d1c@linaro.org>
	<CGME20240710132933eucas1p1b4367ec7a3938a39e732b3079eff6f32@eucas1p1.samsung.com>
	<20240710-gs101-non-essential-clocks-2-v3-2-5dcb8d040d1c@linaro.org>

On 10.07.2024 15:29, André Draszik wrote:
> The peric0_top1_ipclk_0 and peric0_top1_pclk_0 are the clocks going to
> peric0/uart_usi, with pclk being the bus clock. Without pclk running,
> any bus access will hang.
> Unfortunately, in commit d97b6c902a40 ("arm64: dts: exynos: gs101:
> update USI UART to use peric0 clocks") the gs101 DT ended up specifying
> an incorrect pclk in the respective node and instead the two clocks
> here were marked as critical.
>
> Since then, the DT has been updated to use the correct clock in
> commit 21e4e8807bfc ("arm64: dts: exynos: gs101: use correct clocks for
> usi_uart") and the driver here should be corrected and the work-around
> removed.
>
> Note that this commit has the side-effect of causing earlycon to stop
> to work sometime into the boot for two reasons:
>      * peric0_top1_ipclk_0 requires its parent gout_cmu_peric0_ip to be
>        running, but because earlycon doesn't deal with clocks that
>        parent will be disabled when none of the other drivers that
>        actually deal with clocks correctly require it to be running and
>        the real serial driver (which does deal with clocks) hasn't taken
>        over yet
>      * hand-over between earlycon and serial driver appears to be
>        fragile and clocks get enabled and disabled a few times, which
>        also causes register access to hang while earlycon is still
>        active
> (A wordier explanation can also be found in [1])
>
> Nonetheless we shouldn't keep these clocks running unconditionally just
> for earlycon. Clocks should be disabled where possible. If earlycon is
> required in the future, e.g. for debug, this commit can simply be
> reverted (locally!).
>
> Link: https://lore.kernel.org/all/d45de3b2bb6b48653842cf1f74e58889ed6783ae.camel@linaro.org/ [1]
> Fixes: 893f133a040b ("clk: samsung: gs101: add support for cmu_peric0")
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

Frankly speaking I'm not sure that anyone will find this comment and do 
local reverts before getting angry that earlycon doesn't work for his 
device and wasting his time.

I think that it would be much better to check if earlycon is specified 
in kernel's cmdline and if so, simply mark those problematic clocks 
critical in this driver. Make this code hidden under 
IS_ENABLED(CONFIG_SERIAL_EARLYCON) to avoid polluting release builds. 
Any comments?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

