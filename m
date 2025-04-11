Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A06527CCC7
	for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744352895; cv=none; b=W4B01nVOX8Cbsuv9bdpNJeG3TTCFG021KFIHA8f0p9Pa5W2F9p2lgs8P6a7Aa3XV+VI6pFVlHugSZd1/++NrUJOkmEA/bufNugXqIkkHWf/m3HceY32RDSBmirrpnHZ2kWk7I+gb5AqNxjeX6P416tNWZF6PYsKw+aLjxSdoxXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744352895; c=relaxed/simple;
	bh=NuArtcv0yvrbxm8h5eZX3ZhdCgwnnBc1d2QdkHpQhEY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=LOVIMLXZL1zF9MXSvS/+I7AYPvFEcE8bi+GacoIWbSvFXYQQ44MX6UHZZ/2EFnGAt/GDw2XtFRFUeBLGZOrV04CFihCWVZCTUL74Pn+124hLRKOG3GreOet2GHlrA8RDjpzOb/IL7TwsHOKMOfzcgLdjGXSwtTdwU3d9/LmRNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=N/8txkv+; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N/8txkv+"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250411062805epoutp03788b05323b9633894282ad62ab6349ff~1L7UKuGR21401614016epoutp03H
	for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 06:28:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250411062805epoutp03788b05323b9633894282ad62ab6349ff~1L7UKuGR21401614016epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744352885;
	bh=NuArtcv0yvrbxm8h5eZX3ZhdCgwnnBc1d2QdkHpQhEY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=N/8txkv+5pzo/upg++obqz4WsH5nNTKaBRSOiMkl/8gx3FcpSrz/uyh5NiTfgsRxA
	 8mC82wCybM3QDObV83XrQHX0cL+OifNp4sICGHxL03p6elt3R0p/Cv48O81zL4vNfX
	 WFV64K1r4fe6MGiJc3KPxvLSRdaMli3ItUmvEsEM=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250411062804epcas5p3d31ce10848709a9ac85ac4557bbae885~1L7TmDIBW2518725187epcas5p3X;
	Fri, 11 Apr 2025 06:28:04 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4ZYmvk1M62z2SSKX; Fri, 11 Apr
	2025 06:28:02 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BB.DA.10173.276B8F76; Fri, 11 Apr 2025 15:28:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250411062357epcas5p24091330994395616ad24998eed97044a~1L3s7jSrw1768217682epcas5p2z;
	Fri, 11 Apr 2025 06:23:57 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250411062356epsmtrp23c04c9ff80cea2ef861f5e351af0f225~1L3swZmYf3232932329epsmtrp2K;
	Fri, 11 Apr 2025 06:23:56 +0000 (GMT)
X-AuditID: b6c32a44-8b5fb700000027bd-bc-67f8b672bb8d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	34.9E.08805.C75B8F76; Fri, 11 Apr 2025 15:23:56 +0900 (KST)
Received: from INBRO000519 (unknown [107.122.1.150]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250411062355epsmtip1a9da26eb2195619c4c24d1029a803ea3~1L3rMyBMT0874008740epsmtip1H;
	Fri, 11 Apr 2025 06:23:55 +0000 (GMT)
From: "Faraz Ata" <faraz.ata@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, <alim.akhtar@samsung.com>,
	<krzk+dt@kernel.org>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <rosa.pila@samsung.com>,
	<dev.tailor@samsung.com>
In-Reply-To: <9970c307-eba6-4c2d-98de-1a0f846efcd4@kernel.org>
Subject: RE: [PATCH v2] tty: serial: samsung_tty: support 18 uart ports
Date: Fri, 11 Apr 2025 11:53:44 +0530
Message-ID: <03cc01dbaaaa$4dea13f0$e9be3bd0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE/iintFYLILbr1Km3BNZJiCnEHnQEG7k++AhEV2Ou0vXbOMA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmlm7Rth/pBgdfsVs8mLeNzeLejmXs
	Fs2L17NZvJsrY/Fy1j02i/PnN7BbbHp8jdXi8q45bBYzzu9jsjizuJfd4svPB8wO3B6bVnWy
	eeyfu4bdY/OSeo++LasYPT5vkgtgjcq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0
	MFdSyEvMTbVVcvEJ0HXLzAE6TEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKg
	V5yYW1yal66Xl1piZWhgYGQKVJiQnfF61wSWgl72ij+dvA2MZ1m7GDk5JARMJPZees3UxcjF
	ISSwm1Fi0ZHLzBDOJ0aJM3c2sEA43xgl5i6fyQbT8mzPLHaIxF5Gif+z57NCOC8ZJXobOhlB
	qtgENCXufH4KNlhEYBqjxN/DN8EGMwucYJS482cGC0gVp4CdxLVX/WAdwgLuEs/6r7GD2CwC
	qhLTtvSC1fAKWErsWzqZGcIWlDg58wlYnFlAW2LZwtfMEDcpSPx8ugzsJREBJ4lT33oYIWrE
	JV4ePQJ2q4TAWg6Ja/0LWSAaXCS+tfRD2cISr45vYYewpSQ+v9sL9aiPxOSj34AGcQDZGRJ3
	1opAhO0lVi84wwoSZgb6cv0ufYiwrMTUU+uYINbySfT+fsIEEeeV2DEPxlaWOLlnDzTkJSUO
	3X7BOoFRaRaSz2Yh+WwWkg9mIWxbwMiyilEytaA4Nz012bTAMC+1HB7jyfm5mxjBCVfLZQfj
	jfn/9A4xMnEwHmKU4GBWEuFtD/6RLsSbklhZlVqUH19UmpNafIjRFBjcE5mlRJPzgSk/ryTe
	0MTSwMTMzMzE0tjMUEmct3lnS7qQQHpiSWp2ampBahFMHxMHp1QDk8qq4vUT+H5cVUjw3/ly
	ufmLGTe67mbfX+X/jvWUb4hxqNX2vHmT/uZ/jWyN5TBhf5VdlXm92PLkHu5PG25EsfmHpeVf
	nyJyP8EysmPPrIgpQQVrPxv3i2yaZW/2x9DAYolVZMb0pA8tyeby8VvDE16pLO1ecZnBn7nH
	x50pKFP52suZx4Vkn00TYlqtP43pZ13I1hpeW9fXax58O6MRz8a1i3dd2nGFBavfuiy6H7JF
	9ufqGJkFL0tnykifF3p8Y4/JsmUfOmV7y76UtL/q2f7x2Ynw5aFsPbLSPpobAtv/sH36+vzP
	l6unv8ve78/yV+j98vqtlsL5T7r3KjSjrfcmzbC46sTk7eC6XuI+sxJLcUaioRZzUXEiAHXf
	QVVBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnG7N1h/pBi2NOhYP5m1js7i3Yxm7
	RfPi9WwW7+bKWLycdY/N4vz5DewWmx5fY7W4vGsOm8WM8/uYLM4s7mW3+PLzAbMDt8emVZ1s
	HvvnrmH32Lyk3qNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyLr89yFLQwV7ROP8zUwPjMdYu
	Rk4OCQETiWd7ZrF3MXJxCAnsZpS49XEPO0RCUuLw07tQRcISK/89hyp6zijx//FaNpAEm4Cm
	xJ3PT5lAEiICcxglrv7vZQNxmAXOMEo8fPQfquUAo8T779PB5nIK2Elce9XPCGILC7hLPOu/
	BhZnEVCVmLallwXE5hWwlNi3dDIzhC0ocXLmE7A4s4C2xNObT+HsZQtfM0PcpyDx8+kysFtF
	BJwkTn3rYYSoEZd4efQI+wRG4VlIRs1CMmoWklGzkLQsYGRZxSiZWlCcm55bbFhglJdarlec
	mFtcmpeul5yfu4kRHHlaWjsY96z6oHeIkYmD8RCjBAezkghve/CPdCHelMTKqtSi/Pii0pzU
	4kOM0hwsSuK83173pggJpCeWpGanphakFsFkmTg4pRqYDs7Wt9iU9vX3C647ys0LdCdO2pe2
	K/RIs3nWxj2vvzvZmLCvitvwt1ZL4tAO4c/xi0QXvM88Y75ZaNeS7CMZWzmreJaoTf05ZdGB
	tubkzbsaK26an7+hx/asOf/ZSze1K2vbdz/Zdt5L3EzjuLJIToRV9u5Oqb0bzx5lC09lN36+
	1FOt1iGx8Fr7UdevLGvn73vM3r+T05pHeetvi1ndW1K7/ToeZ3EHfg7V62K6OnOz6OSOFhv+
	NgfTI59cXt3Z92TPl5pgkVqdY7PShb8xX25ckHyiYMbudO24xTMq84QtQ+/fuvx7/WHp2il7
	5f7NSUi99WLtr7mSxR0xqWd4ZogELJQ23P0+NlOLfd91JiWW4oxEQy3mouJEAPquNo8rAwAA
X-CMS-MailID: 20250411062357epcas5p24091330994395616ad24998eed97044a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250404134131epcas5p4794f2b1e5d289e1faa142c9093ea45e5
References: <CGME20250404134131epcas5p4794f2b1e5d289e1faa142c9093ea45e5@epcas5p4.samsung.com>
	<20250404135006.1263827-1-faraz.ata@samsung.com>
	<9970c307-eba6-4c2d-98de-1a0f846efcd4@kernel.org>

Hello Krzysztof

> Subject: Re: =5BPATCH v2=5D tty: serial: samsung_tty: support 18 uart por=
ts
>=20
> On 04/04/2025 15:50, Faraz Ata wrote:
> > Exynos Auto v920 SoC supports up to 18 UART ports.
> > Hence changing the value of UART_NR to 18.
> > ---
>=20
> How v2, without changelog, is even worse than v1? It goes to wrong
> direction.
>=20
> Please run scripts/checkpatch.pl and fix reported warnings. After that, r=
un
> also =60scripts/checkpatch.pl --strict=60 and (probably) fix more warning=
s. Some
> warnings can be ignored, especially from --strict run, but the code here =
looks
> like it needs a fix. Feel free to get in touch if the warning is not clea=
r.
>=20
>
Thanks for your review and sorry for the noise,
 that was not intentional, got posted by mistake, will takecare about it.
Will send another version with change-log.
> ...
> Best regards,
> Krzysztof

