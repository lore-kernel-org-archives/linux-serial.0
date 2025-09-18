Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4D31F4181
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758166121; cv=none; b=J+wiycFF3v4WJMrfA3KS7muMIUG1IouYOa5UNGFQM8+iVGRwC+vr3tusZPhAxvAtGKZ2EHHJDykyJntgencoT+oiQHpcOAulzPo0PmNvd5gc9kxZVYuxprcb6gG/6MV63QibgJ89zyOvz/YdtrYQbQ+isxSWWfq3phebvE4fY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758166121; c=relaxed/simple;
	bh=N3ZmTGMcSSq/6QGVACVv9kCpWsrnxcm7fKU5AfEgJuw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=JQ+8ryhB1eMcSqaeIWDKgOTqWcQ6dE8qajl6S0thoO/a2Qd9kxpCS8/PwXURixNe9q5mUeODjw3UGcOJH7ZLgFcj1oV2ZGFUYYAR7ddIyMZ1LFqCBx+g5ahxRaNBOv6s+6+jkkbIGg6tyXDZmQSsQB5yopAWeCavw4+mMsUl32o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=X3w+Yg5y; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X3w+Yg5y"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250918032837epoutp04501b091649304ce83773730b5059279f~mQsTgXww42967329673epoutp04d
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 03:28:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250918032837epoutp04501b091649304ce83773730b5059279f~mQsTgXww42967329673epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758166117;
	bh=rTNuw+n5RGk1DTVfzYopBfIbJwDKtoViWsxtrOrAToU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=X3w+Yg5yVi2+Z1iUcW7DKXPL90zW18CYsNGvTqNz7Ufh9DhyQoQfOQSv3wutOzGC1
	 VG8CXbnqZDWsD7h1osW5V1KIjRQ+6yoW1gwMpzH3QOHdRycS2Y/rIx9gf64NrikQUi
	 xODkls841wnufjCag/d2OXWn4eB9k2XqNqPnW/d4=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250918032837epcas5p1aa3d81403f5f328df2db44bbe90da504~mQsS5qOzh2666626666epcas5p1_;
	Thu, 18 Sep 2025 03:28:37 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.94]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cS1Lr1rnKz3hhT7; Thu, 18 Sep
	2025 03:28:36 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250918032835epcas5p1329113d69cefd819d3e73bd4006221c0~mQsRgvKYV1540215402epcas5p1C;
	Thu, 18 Sep 2025 03:28:35 +0000 (GMT)
Received: from FDSFTE411 (unknown [107.122.81.184]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250918032831epsmtip1938be8e411ac7d34b899de3217c2f983~mQsNL5kH_1919919199epsmtip1S;
	Thu, 18 Sep 2025 03:28:30 +0000 (GMT)
From: "Ravi Patel" <ravi.patel@samsung.com>
To: "'Conor Dooley'" <conor@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <krzk@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <ksk4725@coasia.com>, <pjsin865@coasia.com>,
	<gwk1013@coasia.com>, <bread@coasia.com>, <jspark@coasia.com>,
	<limjh0823@coasia.com>, <lightwise@coasia.com>, <hgkim05@coasia.com>,
	<mingyoungbo@coasia.com>, <smn1196@coasia.com>, <shradha.t@samsung.com>,
	<swathi.ks@samsung.com>, <kenkim@coasia.com>
In-Reply-To: <20250917-tweezers-selective-15358e9b4a4d@spud>
Subject: RE: [PATCH] dt-bindings: serial: samsung: Add compatible for
 ARTPEC-9 SoC
Date: Thu, 18 Sep 2025 08:58:29 +0530
Message-ID: <020701dc284c$50f807d0$f2e81770$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHFz/XbbkP3TCPcVtXmfhfRzVufLwIbHbkSAUynB1G0qbpGIA==
Content-Language: en-in
X-CMS-MailID: 20250918032835epcas5p1329113d69cefd819d3e73bd4006221c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250917071350epcas5p339e015f976f63e2df03544679ad6e6cb
References: <CGME20250917071350epcas5p339e015f976f63e2df03544679ad6e6cb@epcas5p3.samsung.com>
	<20250917071342.5637-1-ravi.patel@samsung.com>
	<20250917-tweezers-selective-15358e9b4a4d@spud>



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: 18 September 2025 00:59
> To: Ravi Patel <ravi.patel@samsung.com>
> Cc: gregkh@linuxfoundation.org; jirislaby@kernel.org; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; krzk@kernel.org;
> linux-kernel@vger.kernel.org; linux-serial@vger.kernel.org; devicetree@vger.kernel.org; ksk4725@coasia.com; pjsin865@coasia.com;
> gwk1013@coasia.com; bread@coasia.com; jspark@coasia.com; limjh0823@coasia.com; lightwise@coasia.com; hgkim05@coasia.com;
> mingyoungbo@coasia.com; smn1196@coasia.com; shradha.t@samsung.com; swathi.ks@samsung.com; kenkim@coasia.com
> Subject: Re: [PATCH] dt-bindings: serial: samsung: Add compatible for ARTPEC-9 SoC
> 
> On Wed, Sep 17, 2025 at 12:43:42PM +0530, Ravi Patel wrote:
> > Add Axis ARTPEC-9 uart compatible to the bindings documentation.
> > It is similar to the older samsung,exynos8895-uart design.
> >
> > Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
> > ---
> >  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > index 1a1f991d5364..3895049c954c 100644
> > --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > @@ -48,6 +48,7 @@ properties:
> >            - const: samsung,exynos850-uart
> >        - items:
> >            - enum:
> > +              - axis,artpec9-uart
> >                - samsung,exynos7870-uart
> >            - const: samsung,exynos8895-uart
> 
> > @@ -168,6 +169,7 @@ allOf:
> >          compatible:
> >            contains:
> >              enum:
> > +              - axis,artpec9-uart
> 
> This hunk is not needed, any compatible property that contains artpec9 must
> contain exynos8895.

Thanks for review, I have updated in v2 patch.

Thanks,
Ravi

> 
> >                - google,gs101-uart
> >                - samsung,exynos8895-uart
> >      then:
> > --
> > 2.17.1
> >

