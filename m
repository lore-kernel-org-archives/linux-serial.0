Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D829A2940F
	for <linux-serial@vger.kernel.org>; Tue, 10 Sep 2024 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725933562; cv=none; b=gX8sMFeOVzSWnlNJerS+I5Qg0Gi0CK3FDg4CyhJs0Xy82YiXdlJRXhzkxLkBhh1ItOxcF+Oz0USOw+uELGS9YRM1n9FvlcanxfcWZs9fZBRlLq9S/rwBgyijU1zERP0Ep/+bFOipq6CpaDCPI1zoiZXI3AdeCfKuNsbzgAzLXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725933562; c=relaxed/simple;
	bh=+vgXJu3DmQSYac25zzMvTnwAxbBwm0mx6zHzINC8nYs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Z3hHg5LiGvDm29Yu/R9S29DiYDLu2d5CueDhofk3jyMZ3gsuw3dr77USY/67BDEgHb6w36+F1rMuNhXypPv24UTGUA2dzE5iRw9TR/6ATu5ZpPWTngl9kBxvWeZkVsKJCCsD7JgZew6Y+xrFZg+Ugi9PZwmet7OafqRqSxsYXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IiFH/Sb8; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IiFH/Sb8"
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240910015917epoutp03df800fc27a8076b8dbf8b38de855c879~zv20kvyQR2307223072epoutp03U
	for <linux-serial@vger.kernel.org>; Tue, 10 Sep 2024 01:59:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240910015917epoutp03df800fc27a8076b8dbf8b38de855c879~zv20kvyQR2307223072epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725933557;
	bh=luxmpxMeSG3l4LijUSMrKLkxeqIHwXkHJoseFVInBHY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IiFH/Sb82AIjKC4JWidTvWfGTZfAGi6IeH/4VNprXPQZ+EQdL32L4PBrTdqhknAnZ
	 bG+pBlpy8dl9JV/fugexDTko7sDbv+44qJ9aqepcnMADl9D4x3fYmNFev2GAYIrLR1
	 m9EOtw3IpcP+VNiHCoB0LhAjbd3OlfV4YAZ6RaVk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240910015917epcas1p416862ecee5c7bff57d2a7df499e86220~zv20JtS2R2930729307epcas1p4P;
	Tue, 10 Sep 2024 01:59:17 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.136]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4X2n1v4lY1z4x9Q9; Tue, 10 Sep
	2024 01:59:15 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	13.15.09734.3F7AFD66; Tue, 10 Sep 2024 10:59:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240910015915epcas1p1c33f805f78ae16985460f322ca0c0e51~zv2yTJ2AO2438624386epcas1p1Z;
	Tue, 10 Sep 2024 01:59:15 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240910015915epsmtrp1c40bc184785f5908c85feaa8bd142c29~zv2ySYfhW3125331253epsmtrp1I;
	Tue, 10 Sep 2024 01:59:15 +0000 (GMT)
X-AuditID: b6c32a35-babff70000002606-c7-66dfa7f3db1e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	44.75.19367.3F7AFD66; Tue, 10 Sep 2024 10:59:15 +0900 (KST)
Received: from [10.113.111.204] (unknown [10.113.111.204]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240910015914epsmtip2f7dd3e9bb73c1292d6009a8b9514345a~zv2x7lGGw1601816018epsmtip2m;
	Tue, 10 Sep 2024 01:59:14 +0000 (GMT)
Message-ID: <36a7a634b001bf23ef41daa1b8d7644c6aab133f.camel@samsung.com>
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
Date: Tue, 10 Sep 2024 10:59:14 +0900
In-Reply-To: <1a318d4f-8883-490f-a537-d641cf845a7c@gmail.com>
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmru7n5ffTDNZcVbR4MG8bm8XPq3wW
	zYvXs1m8mytjcf78BnaLTY+vsVpc3jWHzWLG+X1MFmcW97Jb7F/ay+jA5bFz1l12j02rOtk8
	9s9dw+6xeUm9x4vNMxk9+rasYvT4vEkugD0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzA
	UNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6DglhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFK
	ToFpgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGy6frWQuuS1Ycbm1lbWB8INLFyMkhIWAi8WLr
	I9YuRi4OIYEdjBJf385nhnA+MUr0df5kh3N2Pt3LDtPyp2chG0RiJ6PEy2kNjBDOe0aJf7dB
	MpwcvAIeEvOWvGIBsYUFAiQOdv1jBbHZBNQllrStBZskInCTSWL1YxsQm1lAUmLmtNVg9SwC
	qhJXZ64Eq+EUsJVYs7efDaJGW2LZwtfMILaogLxEw8MTzBC7BCVOznzCAnKEhMBEDonPk/8C
	JTiAHBeJn9sMIK4Wlnh1fAvUB1ISL/vboOxsiaMf97JB2CUS12ctYoWwjSX2L53MBDKGWUBT
	Yv0ufYgT+CTefe1hhZjOK9HRJgRhykvc6iyHaBSVOPP0I9RAD4m/Oz9BA3Q9k8SD7wfZJjDK
	z0LyzCwkD8xCWLaAkXkVo1hqQXFuemqxYYEhPFKT83M3MYLTp5bpDsaJbz/oHWJk4mA8xCjB
	wawkwttvdy9NiDclsbIqtSg/vqg0J7X4EKMpMEgnMkuJJucDE3heSbyhiaWBiZmRsYmFoZmh
	kjjvmStlqUIC6YklqdmpqQWpRTB9TBycUg1MB0JXMnt53gjRqFZqOuoae9THW6k83rHK4C6L
	0E1OYXu2B0cCCufOvaCjppoRM2lhRYXorNLsHdJa71iUa1c4PObb184R78kW9PWZSq/gRhdx
	kWLBS6tYVNnL+OZ9ib1ov0DlBwvzuy9BAZZhc8JZl9ntP8w/gctpj+jsqaVs1SHC0S5zxP7v
	vbZcWm/j/t0hCbOTazgKv05+4vfnyB2ZDKbNibZ3KzLctfmLl79sDbd7Ljzlsl/Bt48HlGNN
	NVqeNK3ZuzDgrfnLK9xWnOvtNLzeK9l4xrUH7xPju2r89sdMvTfPd/2/uLdJ85xiaO/uz9uv
	/LPqO+JyZcWjdhXT+9H6sxlc9BxSrs8v+6jEUpyRaKjFXFScCACucYA7KAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvO7n5ffTDJ7+YbV4MG8bm8XPq3wW
	zYvXs1m8mytjcf78BnaLTY+vsVpc3jWHzWLG+X1MFmcW97Jb7F/ay+jA5bFz1l12j02rOtk8
	9s9dw+6xeUm9x4vNMxk9+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK+P/xBdMBc2SFVta77A3
	MPaIdDFyckgImEj86VnI1sXIxSEksJ1R4sWNiYwQCVGJjsuNQDYHkC0scfhwMUTNW0aJr+2T
	wGp4BTwk5i15xQJiCwsESBzs+scKYrMJqEssaVvLDmKLCNxkknhyyhvEZhaQlJg5bTVYPYuA
	qsTVmSvBajgFbCXW7O2HOmIzk8Sn7VPZIRo0JVq3/4aytSWWLXzNDGKLCshLNDw8wQxxhKDE
	yZlPWCYwCs5C0jILScssJGULGJlXMYqmFhTnpucmFxjqFSfmFpfmpesl5+duYgTHilbQDsZl
	6//qHWJk4mA8xCjBwawkwttvdy9NiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9yTmeKkEB6Yklq
	dmpqQWoRTJaJg1OqgUkrQSGd5WvPursi26pSdXtk1xde08lK+HN4c7nIXZXXj5niLwZGib1P
	CqlJ9DDenMpnYDFrl3/emRVTdj7awZGXvMZOUvxeYNjPM9zXLf2NilVUi7XkWebOYdt6a5uM
	bPw6r4shjw81WymwczpFlKlvjJzqKMI/91uNblqu17Jv3ks9dTwCD7n05ASu6FA8YdoyTcvV
	ctGeOsPZOueY73GrJL2853w2xW/DwajQ9a2S69+oO099ZLg+fOckhVluVuFMnOUNCs3isgFt
	PSU/77ZFhxftsjmoH9TCnPNyNjubcIf+lMWufuFR1R2qNzm3m63S+zXh7lQTNv2qwrIWA4c6
	K86400Fzznnuz1ViKc5INNRiLipOBADpwRBZBAMAAA==
X-CMS-MailID: 20240910015915epcas1p1c33f805f78ae16985460f322ca0c0e51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240909094327epcas1p4bd962fc01182a76c07888e9222572917
References: <20240909084222.3209-1-towinchenmi@gmail.com>
	<20240909084222.3209-4-towinchenmi@gmail.com>
	<CGME20240909094327epcas1p4bd962fc01182a76c07888e9222572917@epcas1p4.samsung.com>
	<c73a59634ed8eeb099f4d5cb746f3b3e770391f5.camel@samsung.com>
	<1a318d4f-8883-490f-a537-d641cf845a7c@gmail.com>

On Mon, 2024-09-09 at 17:51 +0800, Nick Chan wrote:
>=20
> On 9/9/2024 17:43, Kwanghoon Son wrote:
> > On Mon, 2024-09-09 at 16:37 +0800, Nick Chan wrote:
> > > Apple's older A7-A9 SoCs seems to use bit 3 in UTRSTAT as RXTO, which=
 is
> > > enabled by bit 11 in UCON.
> > >=20
> > > Access these bits in addition to the original RXTO and RXTO enable bi=
ts,
> > > to allow serial rx to function on A7-A9 SoCs. This change does not
> > > appear to affect the A10 SoC and up.
> > >=20
> > > Signed-off-by: Nick Chan <towinchenmi=40gmail.com>
> > >=20
> >=20
> > =5Bsnip=5D
> >=20
> > > diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
> > > index 1e8686695487..964a4fbf2626 100644
> > > --- a/include/linux/serial_s3c.h
> > > +++ b/include/linux/serial_s3c.h
> > > =40=40 -246,24 +246,28 =40=40
> > >  				 S5PV210_UFCON_TXTRIG4 =7C	=5C
> > >  				 S5PV210_UFCON_RXTRIG4)
> > > =20
> > > -=23define APPLE_S5L_UCON_RXTO_ENA		9
> > > -=23define APPLE_S5L_UCON_RXTHRESH_ENA	12
> > > -=23define APPLE_S5L_UCON_TXTHRESH_ENA	13
> > > -=23define APPLE_S5L_UCON_RXTO_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO_ENA)
> > > -=23define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_RXTHRES=
H_ENA)
> > > -=23define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_TXTHRES=
H_ENA)
> > > +=23define APPLE_S5L_UCON_RXTO_ENA			9
> > > +=23define APPLE_S5L_UCON_RXTO_LEGACY_ENA		11
> > > +=23define APPLE_S5L_UCON_RXTHRESH_ENA		12
> > > +=23define APPLE_S5L_UCON_TXTHRESH_ENA		13
> > > +=23define APPLE_S5L_UCON_RXTO_ENA_MSK		BIT(APPLE_S5L_UCON_RXTO_ENA)
> > > +=23define APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO=
_LEGACY_ENA)
> > > +=23define APPLE_S5L_UCON_RXTHRESH_ENA_MSK		BIT(APPLE_S5L_UCON_RXTHRE=
SH_ENA)
> > > +=23define APPLE_S5L_UCON_TXTHRESH_ENA_MSK		BIT(APPLE_S5L_UCON_TXTHRE=
SH_ENA)
> >=20
> > Small thing, but other diff is not needed except
> > APPLE_S5L_UCON_RXTO_LEGACY_ENA.
> >=20
> > Kwang.
> The other diffs are there to keep everything aligned, it looks like a
> jumbled mess here in the email, but in an editor like nano it is all
> aligned, before or after this series.

I know why you did. But still there is way keep aligned and only one
line added.=20

you just added one more tab to other lines.
If one tab with APPLE_S5L_UCON_RXTO_LEGACY_ENA, then everything will
fine.

I think less changes better when see git show or blame.

Best regards,
Kwang.

>=20
> >=20
> > > =20
> > >  =23define APPLE_S5L_UCON_DEFAULT		(S3C2410_UCON_TXIRQMODE =7C =5C
> > >  					 S3C2410_UCON_RXIRQMODE =7C =5C
> > >  					 S3C2410_UCON_RXFIFO_TOI)
> > >  =23define APPLE_S5L_UCON_MASK		(APPLE_S5L_UCON_RXTO_ENA_MSK =7C =5C
> > > +					 APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK =7C =5C
> > >  					 APPLE_S5L_UCON_RXTHRESH_ENA_MSK =7C =5C
> > >  					 APPLE_S5L_UCON_TXTHRESH_ENA_MSK)
> > > =20
> > > +=23define APPLE_S5L_UTRSTAT_RXTO_LEGACY	BIT(3)
> > >  =23define APPLE_S5L_UTRSTAT_RXTHRESH	BIT(4)
> > >  =23define APPLE_S5L_UTRSTAT_TXTHRESH	BIT(5)
> > >  =23define APPLE_S5L_UTRSTAT_RXTO		BIT(9)
> > > -=23define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f0)
> > > +=23define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f8)
> > > =20
> > >  =23ifndef __ASSEMBLY__
> > > =20
> >=20
>=20
> Nick Chan

