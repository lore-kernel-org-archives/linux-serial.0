Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F4D194091
	for <linux-serial@vger.kernel.org>; Tue, 10 Sep 2024 04:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941768; cv=none; b=mvhh5jkeoQ45+d9ejirH32Ck0mpKL8894Cun0Z/R/jXPC6RIWnFIZG4lqEakEnnP5xWcq/z9O5kRpO4fvJ4AeSBoBUlKWYWi8M/tGF/qu9BSBw5oJvlBBE/Yc+haWRYYNVx5ZcAbNwxXV2RRXyXRydNGKdfxYYpNb8zLnme59J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941768; c=relaxed/simple;
	bh=tcxBgkcCaXUcDBC4KrHxwVcyFaoBS1riB2Kf1/7ImYM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:MIME-Version:
	 Content-Type:References; b=JIZOSntbP7aKtifPuKJ9+PpDiTIs+E1UPjy1yrnVSxt3ZT2h3/ZTCAvW5lIdi6+jtnFFrw7xu5eh9+iKBfcFqoHK02C5iijg6G5MAVe6mVblyOuYXHbHkq0BQ03L9l2doSmJPf8ZaeIKBbjcFlFGMuTGFoMe93oe7Z5cQJFnrV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XajzF1Ij; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XajzF1Ij"
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240910041556epoutp013babc4dbf0a92f220fffee5d3c91d534~zxuIYKV_40144801448epoutp01-
	for <linux-serial@vger.kernel.org>; Tue, 10 Sep 2024 04:15:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240910041556epoutp013babc4dbf0a92f220fffee5d3c91d534~zxuIYKV_40144801448epoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725941756;
	bh=Eh8dnpLhwVBM/rSsgZrH8h1HoL7FGTJHcy8qgVipwW8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XajzF1IjhVk5VrsslYrHobsMadAVKnrgWsJj0xc8KPu6Dn4pH0WGIP1hukrD0zyab
	 Lh65uLMKOxS4gZPirEVXWsRPAtoCeF12Ki4xvwNFZH9yjM404FyMeaLKdTMzIWj298
	 KKIdKhXxvhBRzv08374CE4a3dwX6ZpYD0B2AkJkY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240910041556epcas1p32fd43bc48a96c75e171b1036ff396990~zxuH-0PtN0154601546epcas1p3M;
	Tue, 10 Sep 2024 04:15:56 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.232]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4X2r3Z58msz4x9QJ; Tue, 10 Sep
	2024 04:15:54 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	EA.09.08992.AF7CFD66; Tue, 10 Sep 2024 13:15:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240910041554epcas1p28b549d1a3d6696b19cdc3c6e4201bf99~zxuGGSlSO2158221582epcas1p2x;
	Tue, 10 Sep 2024 04:15:54 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240910041554epsmtrp2b5e32118bb68f5e7770275a3d29955a5~zxuGFhmTN0681406814epsmtrp2N;
	Tue, 10 Sep 2024 04:15:54 +0000 (GMT)
X-AuditID: b6c32a33-96dfa70000002320-8c-66dfc7fa0170
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	CB.D1.19367.9F7CFD66; Tue, 10 Sep 2024 13:15:54 +0900 (KST)
Received: from [10.113.111.204] (unknown [10.113.111.204]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240910041553epsmtip102da6529d0d1ca065e67cb589c29be12~zxuF3ukmU0608006080epsmtip1F;
	Tue, 10 Sep 2024 04:15:53 +0000 (GMT)
Message-ID: <fcfdef6d00e1f5084c85191ffa43e9756ddc0325.camel@samsung.com>
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
Date: Tue, 10 Sep 2024 13:15:52 +0900
In-Reply-To: <866d51a6-1eae-4dc6-8298-df2d608d2507@gmail.com>
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmnu6v4/fTDA4+VLV4MG8bm8XPq3wW
	zYvXs1m8mytjcf78BnaLTY+vsVpc3jWHzWLG+X1MFmcW97Jb7F/ay+jA5bFz1l12j02rOtk8
	9s9dw+6xeUm9x4vNMxk9+rasYvT4vEkugD0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzA
	UNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6DglhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFK
	ToFpgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGrfPn2AsOalbs3TqbqYFxp2IXIyeHhICJxNrp
	W5i6GLk4hAR2MEq0T/3NCuF8YpT4tOYiI5xz+8sVRpiW0+sXskEkdjJK7H/dC9X/nlHiw5Ye
	oH4ODl4BD4n1yzNAGoQFAiQOdv1jBbHZBNQllrStZQexRQRuMkmsfmwDYjMLSErMnLaaBcRm
	EVCV+DhzHhuIzSlgK/H48GImiBptiWULXzOD2KIC8hIND0+A2bwCghInZz5hAblBQmAmh8TL
	n1fYIC51kTi/8SwrhC0s8er4FnYIW0ri87u9UDXZEkc/wtglEtdnLYKqN5bYv3QyE8gvzAKa
	Eut36UPcwCfx7ivEixICvBIdbUIQprzErc5yiEZRiTNPP0IN9JD4u/MTMyR0FjJLbJt1l2UC
	o/wsJN/MQvLBLIRlCxiZVzGKpRYU56anJhsWGMIjNTk/dxMjOH1qGe9gvDz/n94hRiYOxkOM
	EhzMSiK8/Xb30oR4UxIrq1KL8uOLSnNSiw8xmgLDdCKzlGhyPjCB55XEG5pYGpiYGRmbWBia
	GSqJ8565UpYqJJCeWJKanZpakFoE08fEwSnVwKQmIXhrciT/ulSXQqmzqhm82rvuVRTem7Fc
	NODaccUCq4//5O+05Mg/f7bl/96ct+mNKwQ/+QkKKQvVbNwzXcH44eoE1YzI0ByLhkOOgpw/
	eeccvu03czmb55UDnm/vpU69wmu/98KZFKvZp+POKr0Qv8hx/G79pysX5k85/3rL3lnnN108
	HH3qEeerWzL6fY9+2PGIr9jguPvLiqDl+9Xk7isqqtzZydPv3iA9N1Jcp/vr9K2Lrir/SFhf
	obt80pw9E112n5NjUk1/bCiqGV/S9GTRgU/u2rckfOQSit5t6eu/w5AY+VX4GnfwHy278xUT
	3sYoHHrzcGpUWf6VNceP50w7dH1hyRaBR8IWpnt/KLEUZyQaajEXFScCAKLqFnooBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSnO6v4/fTDC5fY7R4MG8bm8XPq3wW
	zYvXs1m8mytjcf78BnaLTY+vsVpc3jWHzWLG+X1MFmcW97Jb7F/ay+jA5bFz1l12j02rOtk8
	9s9dw+6xeUm9x4vNMxk9+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK+PHir+MBes0KiZu82xg
	3KLQxcjJISFgInF6/UK2LkYuDiGB7YwS3w+uZYZIiEp0XG5k7GLkALKFJQ4fLoaoecso8Xvj
	HhaQOK+Ah8T65Rkg5cICARIHu/6xgthsAuoSS9rWsoPYIgI3mSSenPIGsZkFJCVmTlvNAmKz
	CKhKfJw5jw3E5hSwlXh8eDETxPzlzBIzd09nhmjQlGjd/psdwtaWWLbwNVhcVEBeouHhCTCb
	V0BQ4uTMJywTGAVnIWmZhaRlFpKyBYzMqxhFUwuKc9NzkwsM9YoTc4tL89L1kvNzNzGC40Qr
	aAfjsvV/9Q4xMnEwHmKU4GBWEuHtt7uXJsSbklhZlVqUH19UmpNafIhRmoNFSZxXOaczRUgg
	PbEkNTs1tSC1CCbLxMEp1cDEpb1+8ds7a713/Er+1L9oRfCdadV/OabsWNn2XzJTjbdSmeNx
	t+nq0rLa1ctNWYsdjl6s/rb87o3LL31mf1+4/Um1202/I9vP262MiTn3uDE+y3nDdolYL/6N
	PfM0FttEXTPtk+J4VC1z3eD2F8aTadlt27/oPVn7e5nVvSeyu1OOhT5fuqiqdzXbmm8XXcvW
	31D8enFp5pJ3f61kyrh7LdPfCzCkiHsuyGRb6yuYvfn+vKBz3OsdJwuFiSrI7Z+Zc6o6XZLh
	179PYk27Jsnc94wunyaxISlhS0Xyhz3vn02ass35S0lKxoaPzi/PKeXPvrKlLvhQyvQ8uRiX
	S3cf2RXViM88ekqWT4x7z6HHGUosxRmJhlrMRcWJAI+LKeICAwAA
X-CMS-MailID: 20240910041554epcas1p28b549d1a3d6696b19cdc3c6e4201bf99
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
	<36a7a634b001bf23ef41daa1b8d7644c6aab133f.camel@samsung.com>
	<866d51a6-1eae-4dc6-8298-df2d608d2507@gmail.com>

On Tue, 2024-09-10 at 10:59 +0800, Nick Chan wrote:
>=20
> On 10/9/2024 09:59, Kwanghoon Son wrote:
> > On Mon, 2024-09-09 at 17:51 +0800, Nick Chan wrote:
> > >=20
> > > On 9/9/2024 17:43, Kwanghoon Son wrote:
> > > > On Mon, 2024-09-09 at 16:37 +0800, Nick Chan wrote:
> > > > > Apple's older A7-A9 SoCs seems to use bit 3 in UTRSTAT as RXTO, w=
hich is
> > > > > enabled by bit 11 in UCON.
> > > > >=20
> > > > > Access these bits in addition to the original RXTO and RXTO enabl=
e bits,
> > > > > to allow serial rx to function on A7-A9 SoCs. This change does no=
t
> > > > > appear to affect the A10 SoC and up.
> > > > >=20
> > > > > Signed-off-by: Nick Chan <towinchenmi=40gmail.com>
> > > > >=20
> > > >=20
> > > > =5Bsnip=5D
> > > >=20
> > > > > diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3=
c.h
> > > > > index 1e8686695487..964a4fbf2626 100644
> > > > > --- a/include/linux/serial_s3c.h
> > > > > +++ b/include/linux/serial_s3c.h
> > > > > =40=40 -246,24 +246,28 =40=40
> > > > >  				 S5PV210_UFCON_TXTRIG4 =7C	=5C
> > > > >  				 S5PV210_UFCON_RXTRIG4)
> > > > > =20
> > > > > -=23define APPLE_S5L_UCON_RXTO_ENA		9
> > > > > -=23define APPLE_S5L_UCON_RXTHRESH_ENA	12
> > > > > -=23define APPLE_S5L_UCON_TXTHRESH_ENA	13
> > > > > -=23define APPLE_S5L_UCON_RXTO_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO_EN=
A)
> > > > > -=23define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_RXT=
HRESH_ENA)
> > > > > -=23define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_TXT=
HRESH_ENA)
> > > > > +=23define APPLE_S5L_UCON_RXTO_ENA			9
> > > > > +=23define APPLE_S5L_UCON_RXTO_LEGACY_ENA		11
> > > > > +=23define APPLE_S5L_UCON_RXTHRESH_ENA		12
> > > > > +=23define APPLE_S5L_UCON_TXTHRESH_ENA		13
> > > > > +=23define APPLE_S5L_UCON_RXTO_ENA_MSK		BIT(APPLE_S5L_UCON_RXTO_E=
NA)
> > > > > +=23define APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK	BIT(APPLE_S5L_UCON_=
RXTO_LEGACY_ENA)
> > > > > +=23define APPLE_S5L_UCON_RXTHRESH_ENA_MSK		BIT(APPLE_S5L_UCON_RX=
THRESH_ENA)
> > > > > +=23define APPLE_S5L_UCON_TXTHRESH_ENA_MSK		BIT(APPLE_S5L_UCON_TX=
THRESH_ENA)
> > > >=20
> > > > Small thing, but other diff is not needed except
> > > > APPLE_S5L_UCON_RXTO_LEGACY_ENA.
> > > >=20
> > > > Kwang.
> > > The other diffs are there to keep everything aligned, it looks like a
> > > jumbled mess here in the email, but in an editor like nano it is all
> > > aligned, before or after this series.
> >=20
> > I know why you did. But still there is way keep aligned and only one
> > line added.=20
> >=20
> > you just added one more tab to other lines.
> > If one tab with APPLE_S5L_UCON_RXTO_LEGACY_ENA, then everything will
> > fine.
> >=20
> > I think less changes better when see git show or blame.
> While as you said, APPLE_S5L_UCON_RXTO_LEGACY_ENA would be fine,
> APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK is too long for that to be aligned, se=
e
> below without +, - or > distorting everything.
>=20
> Before:
> =23define APPLE_S5L_UCON_RXTO_ENA		9
> =23define APPLE_S5L_UCON_RXTHRESH_ENA	12
> =23define APPLE_S5L_UCON_TXTHRESH_ENA	13
> =23define APPLE_S5L_UCON_RXTO_ENA_MSK	(1 << APPLE_S5L_UCON_RXTO_ENA)
> =23define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_RXTHRESH_E=
NA)
> =23define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_TXTHRESH_E=
NA)
>=20
> Patch 1:
> =23define APPLE_S5L_UCON_RXTO_ENA		9
> =23define APPLE_S5L_UCON_RXTHRESH_ENA	12
> =23define APPLE_S5L_UCON_TXTHRESH_ENA	13
> =23define APPLE_S5L_UCON_RXTO_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO_ENA)
> =23define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_RXTHRESH_ENA=
)
> =23define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_TXTHRESH_ENA=
)
>=20
> After:
> =23define APPLE_S5L_UCON_RXTO_ENA			9
> =23define APPLE_S5L_UCON_RXTO_LEGACY_ENA		11
> =23define APPLE_S5L_UCON_RXTHRESH_ENA		12
> =23define APPLE_S5L_UCON_TXTHRESH_ENA		13
> =23define APPLE_S5L_UCON_RXTO_ENA_MSK		BIT(APPLE_S5L_UCON_RXTO_ENA)
> =23define APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK
> BIT(APPLE_S5L_UCON_RXTO_LEGACY_ENA)
> =23define APPLE_S5L_UCON_RXTHRESH_ENA_MSK		BIT(APPLE_S5L_UCON_RXTHRESH_EN=
A)
> =23define APPLE_S5L_UCON_TXTHRESH_ENA_MSK		BIT(APPLE_S5L_UCON_TXTHRESH_EN=
A)
>=20

Okay I got it.
Thanks for check=21

Kwang.

> >=20
> > Best regards,
> > Kwang.
> >=20
> > >=20
> > > >=20
> > > > > =20
> > > > >  =23define APPLE_S5L_UCON_DEFAULT		(S3C2410_UCON_TXIRQMODE =7C =
=5C
> > > > >  					 S3C2410_UCON_RXIRQMODE =7C =5C
> > > > >  					 S3C2410_UCON_RXFIFO_TOI)
> > > > >  =23define APPLE_S5L_UCON_MASK		(APPLE_S5L_UCON_RXTO_ENA_MSK =7C =
=5C
> > > > > +					 APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK =7C =5C
> > > > >  					 APPLE_S5L_UCON_RXTHRESH_ENA_MSK =7C =5C
> > > > >  					 APPLE_S5L_UCON_TXTHRESH_ENA_MSK)
> > > > > =20
> > > > > +=23define APPLE_S5L_UTRSTAT_RXTO_LEGACY	BIT(3)
> > > > >  =23define APPLE_S5L_UTRSTAT_RXTHRESH	BIT(4)
> > > > >  =23define APPLE_S5L_UTRSTAT_TXTHRESH	BIT(5)
> > > > >  =23define APPLE_S5L_UTRSTAT_RXTO		BIT(9)
> > > > > -=23define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f0)
> > > > > +=23define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f8)
> > > > > =20
> > > > >  =23ifndef __ASSEMBLY__
> > > > > =20
> > > >=20
> > >=20
> > > Nick Chan
> >=20
>=20
> Nick Chan
>=20

