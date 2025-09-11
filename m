Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2334AB16
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605952; cv=none; b=nqp+9Agq5tg+HKQA5EHpS1joI896tvIh52OKG42Ya08z/kx7gTFDf6MJDc1bd3RnTENZtuHmDuPpHN84P98X4ubtO6PFblFo224dOnhzyCDRN37TWOUT1WJlU2UP/X6sMfcNrkhyc9vvQXjmQd1djho5uEnnhD0zXv5jKBHym3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605952; c=relaxed/simple;
	bh=kB0PcEHHl5mi05isLvthbmDv7jXVGde9iru/Ft+xJoc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=EXrnrvW3sV6SbRTikcRJggEu7yLJTjs/EaNdb2DycEFVylfAe+TieORJAS8DA3e/HIdnrI172UCKieY3RWH8tRmLjYn6KIU35ki7utC97welni0aYL0cxkcLALcFpPL8/AbYNNXQBQK7c63kS/9nty23RDQa6E0fY7Nn/qMHZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eKLHp68P; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eKLHp68P"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250911155228epoutp0499dbc8549fa02a5f665e0595bcfbc5d8~kRUxDxykQ3062530625epoutp04L
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 15:52:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250911155228epoutp0499dbc8549fa02a5f665e0595bcfbc5d8~kRUxDxykQ3062530625epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757605948;
	bh=PIwqjCKaBtnZ2f92Qn6L1rSKvFT+8xiThxIV5Da48ic=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=eKLHp68PLUqMq6bvZsQ4PrBsti8H1WEeFxtNLK/Yhko+cKVYg91/ohw1rNku5zKdA
	 SHMb0aENu6G3wmM5qQ1LNZj1wPFttrISLvDMlnFtUlKl4fTsriQASb0bZrAqaHQ/UO
	 RxDqUih+H2ssR7BbGrPXk72DI4uueNg6gRxsei/E=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250911155227epcas5p28ffdbdbbc5fb99ede41166173acf4fbf~kRUwMy0ZP1886018860epcas5p2_;
	Thu, 11 Sep 2025 15:52:27 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.87]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cN2BL3vpFz6B9m5; Thu, 11 Sep
	2025 15:52:26 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250911155225epcas5p4f39dd82d8c40e0f51e8a0b2ab33039be~kRUuJaSAC1471514715epcas5p49;
	Thu, 11 Sep 2025 15:52:25 +0000 (GMT)
Received: from FDSFTE411 (unknown [107.122.81.184]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250911155221epsmtip167c1cabfb1160a05e746d1c73091c81d~kRUqyOpq40708107081epsmtip1i;
	Thu, 11 Sep 2025 15:52:21 +0000 (GMT)
From: "Ravi Patel" <ravi.patel@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <jesper.nilsson@axis.com>, <lars.persson@axis.com>,
	<alim.akhtar@samsung.com>, <arnd@kernel.org>
Cc: <andriy.shevchenko@linux.intel.com>, <geert+renesas@glider.be>,
	<thierry.bultel.yh@bp.renesas.com>, <dianders@chromium.org>,
	<robert.marko@sartura.hr>, <schnelle@linux.ibm.com>, <kkartik@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-arm-kernel@axis.com>,
	<ksk4725@coasia.com>, <kenkim@coasia.com>, <smn1196@coasia.com>,
	<pjsin865@coasia.com>, <shradha.t@samsung.com>
In-Reply-To: <b9a2c3cc-49d6-480c-8c57-fffe0cf9d527@kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: serial: samsung: Update
 axis,artpec8-uart to use samsung,uart-fifosize
Date: Thu, 11 Sep 2025 21:22:20 +0530
Message-ID: <000001dc2334$117ae310$3470a930$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHCvJCefXNgXa49SBfbwsspKb9l0wIPxsz+Ajb57S8CO2v7oLSM3O1g
Content-Language: en-in
X-CMS-MailID: 20250911155225epcas5p4f39dd82d8c40e0f51e8a0b2ab33039be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250911141706epcas5p29ba4f0af11e3a95a9754fd6255f7b5a7
References: <20250911141605.13034-1-ravi.patel@samsung.com>
	<CGME20250911141706epcas5p29ba4f0af11e3a95a9754fd6255f7b5a7@epcas5p2.samsung.com>
	<20250911141605.13034-2-ravi.patel@samsung.com>
	<b9a2c3cc-49d6-480c-8c57-fffe0cf9d527@kernel.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: 11 September 2025 20:03
...
> 
> On 11/09/2025 16:16, Ravi Patel wrote:
> > Update the axis,artpec8-uart compatible such that it uses the
> > samsung,uart-fifosize as required property.
> >
> > This is to remove the axis,artpec8-uart specific code (which is
> > kind of duplicated) from the driver and use the other matching
> > exynos8895 uart code for ARTPEC-8.
> >
> > Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
> > ---
> >  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > index 1a1f991d5364..08eceaae2921 100644
> > --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > @@ -152,7 +152,6 @@ allOf:
> >            contains:
> >              enum:
> >                - apple,s5l-uart
> > -              - axis,artpec8-uart
> >                - samsung,exynos4210-uart
> >                - samsung,exynos5433-uart
> 
> You need to start testing patches, because this obviously fails basic
> tests. And toolset would tell you if you bothered.

Oh my bad, somehow I missed it.
Will fix (dtbs_check) in next version

Thanks for pointing out.

Thanks,
Ravi

> 
> This does not fit documented Samsung SoC maintainer rules (because of (1)).
> 
> Best regards,
> Krzysztof

