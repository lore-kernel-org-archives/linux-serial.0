Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528491B2EE8
	for <linux-serial@vger.kernel.org>; Mon,  9 Sep 2024 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875019; cv=none; b=ib/ExK2lbj4Tqd1xotypxNSq93ftL0OddKc5AlwLwiwyrjEFAEGn/kajCijjdE+ohpPnlkBwKKtBD60ADt9Bm2GREHI7h2xpLPOosNX8gUu1103HVuToJVX39KF1hZ+iAxR57isWA8c4W/tr9OKKIymEzIw6OCSaAmHjbA5Jn9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875019; c=relaxed/simple;
	bh=N33HzbLifjRDnTRY55qJg9InbgItgUl2jl5vUNzrlLg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Znwi3zSLBDb7ZWJovjC7NDvz2NxM9h7SbBl2mKX8ZaBddOppknAeRPA8Z8ykE9/7JVSjiXEewvtHH+eSMcS7hN2nA174Va+8xp2+KEeFRbKf6AA2Ae7yVqCWkTWr7ice87Dq+Xc3CFLtL2owowx2igCcJTEUTzro1wzug+ahlC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZKsWV2Dx; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZKsWV2Dx"
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240909094329epoutp03c28a04b2c53fbf88d419ddd1e52b4bbe~zii1YGSKp3015030150epoutp03Y
	for <linux-serial@vger.kernel.org>; Mon,  9 Sep 2024 09:43:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240909094329epoutp03c28a04b2c53fbf88d419ddd1e52b4bbe~zii1YGSKp3015030150epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725875009;
	bh=5Zrr1Rlq5uzIUm8vNeMFejcvqoou7d/aqB91pgh4t4s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZKsWV2DxDaOiftVbPf3y4RIERaB6++e2G/uXFkmpgFNdn8hLZR7jfjSWEkmYrUQke
	 UTyMsqOTObsv7Z7H+s/XgqrGfxJP6HZs/QdMWhpBIt3k2q1zBrDeXDvE2O1bk5Cy+k
	 aeHgSzUqjufvDPhhdWWNC0V2wX0GPlswjLoWsnpw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240909094328epcas1p11835a41796b1e2bef4aa5dcbfdf76e70~zii0yooZR1286712867epcas1p1f;
	Mon,  9 Sep 2024 09:43:28 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.144]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4X2MMz4CMrz4x9Q7; Mon,  9 Sep
	2024 09:43:27 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	8B.57.09725.F33CED66; Mon,  9 Sep 2024 18:43:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240909094327epcas1p4bd962fc01182a76c07888e9222572917~ziizJ2yQF0942609426epcas1p4R;
	Mon,  9 Sep 2024 09:43:27 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240909094327epsmtrp2c5b4cb0000806f5027bc470fe4718015~ziizJLwuj0408104081epsmtrp2x;
	Mon,  9 Sep 2024 09:43:27 +0000 (GMT)
X-AuditID: b6c32a37-245b8700000025fd-5b-66dec33fe88e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BD.C1.07567.E33CED66; Mon,  9 Sep 2024 18:43:27 +0900 (KST)
Received: from [10.113.111.204] (unknown [10.113.111.204]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240909094326epsmtip1225d6acf41b5221a9123f91bd049df27~ziiy31slS1655516555epsmtip1k;
	Mon,  9 Sep 2024 09:43:26 +0000 (GMT)
Message-ID: <c73a59634ed8eeb099f4d5cb746f3b3e770391f5.camel@samsung.com>
Subject: Re: [PATCH v4 3/3] tty: serial: samsung: Fix serial rx on Apple
 A7-A9
From: Kwanghoon Son <k.son@samsung.com>
To: Nick Chan <towinchenmi@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>,  Alim Akhtar <alim.akhtar@samsung.com>, Greg
	Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Cc: asahi@lists.linux.dev
Date: Mon, 09 Sep 2024 18:43:20 +0900
In-Reply-To: <20240909084222.3209-4-towinchenmi@gmail.com>
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmnq794XtpBnuvy1k8mLeNzeLnVT6L
	5sXr2SzezZWxOH9+A7vFpsfXWC0u75rDZjHj/D4mizOLe9kt9i/tZXTg8tg56y67x6ZVnWwe
	++euYffYvKTe48XmmYwefVtWMXp83iQXwB6VbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZg
	qGtoaWGupJCXmJtqq+TiE6DrlpkDdJySQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAl
	p8C0QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtjw9eTjAUfhCpWHPzD3sD4g7+LkYNDQsBEYl2n
	ZhcjF4eQwA5GiTWLPjNDOJ8YJX73XmWEcL4xSkxsPc/axcgJ1jH7+jeoxF5GiQWLTzJBOO8Z
	JTZMn8oEUsUr4CGx+u0tNhBbWCBA4mDXP7BuNgF1iSVta9lBbBGBm0wSqx/bgNjMApISM6et
	ZgGxWQRUJfof7WQGsTkFrCRevZvFDFGjLbFs4WswW1RAXqLh4QlmiF2CEidnPmGBuG4mh0Tj
	UVMI20Vi8e4lbBC2sMSr41vYIWwpic/v9kLFsyWOfoSxSySuz1oE9aWxxP6lk5lAYcQsoCmx
	fpc+xAl8Eu++9rBCgo5XoqNNCMKUl7jVWQ7RKCpx5ulHqIEeEn93fmKGB9XDy0tZJzDKz0Ly
	zCwkD8xCWLaAkXkVo1hqQXFuemqxYYExPE6T83M3MYKTp5b5DsZpbz/oHWJk4mA8xCjBwawk
	wttvdy9NiDclsbIqtSg/vqg0J7X4EKMpMEgnMkuJJucD03deSbyhiaWBiZmRsYmFoZmhkjjv
	mStlqUIC6YklqdmpqQWpRTB9TBycUg1MTRL687sbG8Ly5sr3XXqypuHhVuOr3JqO8qJbFuy7
	eDhxQ2dG2fan9xs4A6RuJt+OOHy5sHWmbESZ5QZj9rMCk6bVyoSzvJn9oFakSPPMzFCN85LS
	ptMrM/Kz5yYlNxyekq+0puSh9LXMLYuOZm46c2kV86d7PrGzb2t+v+1w7Snvyig/30dsZY83
	eBmem6NpaHde1SxUqPDOadPCGAPJEsemvsM7soX/hhbHi03//MN57zyV9EptR5uJZcG5b3j5
	Eo5qvLjzbcO11vfdGs90Pjl5rZM/1P9UxUZe06kimC+cY2H+zA3zrX/9YzW7sEt2+ZKbRy1/
	p/1bJnpT9on7zIj0fNUeC4vp+8506/5WYinOSDTUYi4qTgQAeac/5ScEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSnK794XtpBqeWMVo8mLeNzeLnVT6L
	5sXr2SzezZWxOH9+A7vFpsfXWC0u75rDZjHj/D4mizOLe9kt9i/tZXTg8tg56y67x6ZVnWwe
	++euYffYvKTe48XmmYwefVtWMXp83iQXwB7FZZOSmpNZllqkb5fAlfHjT37BNKGKz5/OMTUw
	LuLvYuTkkBAwkZh9/RtjFyMXh5DAbkaJF+8PsEEkRCU6LjcCJTiAbGGJw4eLIWreMkqsftzK
	DFLDK+AhsfrtLbB6YYEAiYNd/1hBbDYBdYklbWvZQWwRgZtMEk9OeYPYzAKSEjOnrWYBsVkE
	VCX6H+0Em8MpYCXx6t0sMFtIIEvi7eH9LBD1mhKt23+zQ9jaEssWvgarERWQl2h4eALqBkGJ
	kzOfsExgFJyFpGUWkpZZSMoWMDKvYpRMLSjOTc9NNiwwzEst1ytOzC0uzUvXS87P3cQIjhct
	jR2M9+b/0zvEyMTBeIhRgoNZSYS33+5emhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFewxmzU4QE
	0hNLUrNTUwtSi2CyTBycUg1MxdfWPVXrPHw15MLOF7zXzV9EqJctU9I4nOvNFHU4L6d4wpIl
	O1r/qMl+/Bk86e0ZGWnt6E+qhpuy5FyFJ8SwrzXa5tr923jOwcrQ/P+b7V9uEcn2uzd78uHt
	OpF757vfXKP9NmLawiwZzteb9rWe2WNx4faGGPko/03Mza/8c/z8ZdbG+QbdDzFcZytmYXG3
	yKHzyKHyrzrx/wIW3N1Qcy2qfmWRXQVnvcsNz8WuLWa3t/36qSa7innJBHuP8IW3Vs1w4vXv
	teNlux0250mrkNaDg0GlzhdvN8149mLhg56Hv7KZmL1T13sqJZxbXpox32S3TcLUwzOsfoh3
	LHVilvCM0G07dTklidvM9L+AEktxRqKhFnNRcSIA+vnSEAYDAAA=
X-CMS-MailID: 20240909094327epcas1p4bd962fc01182a76c07888e9222572917
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240909094327epcas1p4bd962fc01182a76c07888e9222572917
References: <20240909084222.3209-1-towinchenmi@gmail.com>
	<20240909084222.3209-4-towinchenmi@gmail.com>
	<CGME20240909094327epcas1p4bd962fc01182a76c07888e9222572917@epcas1p4.samsung.com>

On Mon, 2024-09-09 at 16:37 +0800, Nick Chan wrote:
> Apple's older A7-A9 SoCs seems to use bit 3 in UTRSTAT as RXTO, which is
> enabled by bit 11 in UCON.
>=20
> Access these bits in addition to the original RXTO and RXTO enable bits,
> to allow serial rx to function on A7-A9 SoCs. This change does not
> appear to affect the A10 SoC and up.
>=20
> Signed-off-by: Nick Chan <towinchenmi=40gmail.com>
>=20

=5Bsnip=5D

> diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
> index 1e8686695487..964a4fbf2626 100644
> --- a/include/linux/serial_s3c.h
> +++ b/include/linux/serial_s3c.h
> =40=40 -246,24 +246,28 =40=40
>  				 S5PV210_UFCON_TXTRIG4 =7C	=5C
>  				 S5PV210_UFCON_RXTRIG4)
> =20
> -=23define APPLE_S5L_UCON_RXTO_ENA		9
> -=23define APPLE_S5L_UCON_RXTHRESH_ENA	12
> -=23define APPLE_S5L_UCON_TXTHRESH_ENA	13
> -=23define APPLE_S5L_UCON_RXTO_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO_ENA)
> -=23define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_RXTHRESH_EN=
A)
> -=23define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_TXTHRESH_EN=
A)
> +=23define APPLE_S5L_UCON_RXTO_ENA			9
> +=23define APPLE_S5L_UCON_RXTO_LEGACY_ENA		11
> +=23define APPLE_S5L_UCON_RXTHRESH_ENA		12
> +=23define APPLE_S5L_UCON_TXTHRESH_ENA		13
> +=23define APPLE_S5L_UCON_RXTO_ENA_MSK		BIT(APPLE_S5L_UCON_RXTO_ENA)
> +=23define APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO_LEG=
ACY_ENA)
> +=23define APPLE_S5L_UCON_RXTHRESH_ENA_MSK		BIT(APPLE_S5L_UCON_RXTHRESH_E=
NA)
> +=23define APPLE_S5L_UCON_TXTHRESH_ENA_MSK		BIT(APPLE_S5L_UCON_TXTHRESH_E=
NA)

Small thing, but other diff is not needed except
APPLE_S5L_UCON_RXTO_LEGACY_ENA.

Kwang.

> =20
>  =23define APPLE_S5L_UCON_DEFAULT		(S3C2410_UCON_TXIRQMODE =7C =5C
>  					 S3C2410_UCON_RXIRQMODE =7C =5C
>  					 S3C2410_UCON_RXFIFO_TOI)
>  =23define APPLE_S5L_UCON_MASK		(APPLE_S5L_UCON_RXTO_ENA_MSK =7C =5C
> +					 APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK =7C =5C
>  					 APPLE_S5L_UCON_RXTHRESH_ENA_MSK =7C =5C
>  					 APPLE_S5L_UCON_TXTHRESH_ENA_MSK)
> =20
> +=23define APPLE_S5L_UTRSTAT_RXTO_LEGACY	BIT(3)
>  =23define APPLE_S5L_UTRSTAT_RXTHRESH	BIT(4)
>  =23define APPLE_S5L_UTRSTAT_TXTHRESH	BIT(5)
>  =23define APPLE_S5L_UTRSTAT_RXTO		BIT(9)
> -=23define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f0)
> +=23define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f8)
> =20
>  =23ifndef __ASSEMBLY__
> =20

