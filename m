Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1077E393DE2;
	Fri,  4 Sep 2026 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504344; cv=none; b=oR5CYkDgjEbHY2cPCEvF1l50WVPwl9tjK7g1tt0hp4Mf2Q09TBaNpEOF4XTlYXV9Lp05hDp+8EA0bj9M1kc5wC5AfX/HFsrNU8ADcpkGCbqr32GfqxwzoS4Jk51x2zMjhHrhJ7cdrbr7pKOm3qc9i1iCvDhoFs/HTO8SARBEd/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504344; c=relaxed/simple;
	bh=noNebFZGG5ULi1Nh2dkf9z2dc5kARfWy2YMh9KGXuw0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dx+Gxqy2ORgY1cYuP6+qsuACjkQhSsuVRaNV9vQZKiBkUvpeSx3GWzPnumKYKwA26zcz2TbDHUZ/LTM1taNmRDnIV7E+1CTcExSHaZapeawShiKh7t7lJy+bcSjNPO4akAUvAaUsuqcS902Jxx+AjNRAu0WAbjCV2RRLPsOydro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuZpk7hn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuZpk7hn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D31B1F00A3F;
	Fri,  4 Sep 2026 06:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788504342;
	bh=ldvAfRECcnUFTrQSzeWw94hkNvO0j+orgbb1RtQTuos=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZuZpk7hn00K65S0PTznT6pZkpsXbUttDYz/qfcQrjo0qFqGEhHJHMNi3foEGUpsF8
	 Ufxk3uYt6GtU3hSBrWOLTqnW6EsWeSiV++9fgThRLVGK3dlDgOfDgXrh/xT8GRPtVL
	 uCL8VDvBs3cFpusyom955o0xL1iAXn+qEZi3wHk+ODcCv26oDF6bTTpCUlrdnhnlvJ
	 4Ms33NQkaFY+GleFgsHH918yZODJWgquq/HrQ6CWT2JHkqye0+42vMbiYr4jTD8Ysi
	 8Yuhn75CFwd2om+N8GPrBkuDqsU7PyLrc1+1rcO981TGjl36h/8Avxlfp59Xfe20C/
	 NooPu8nAGT+TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/13] dt-bindings: mfd: syscon: add Ambarella CV75
 secure scratchpad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: linux-serial@vger.kernel.org, linux-clk@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, lee@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260904-cv75-v5-v6-2-e918514cb3b1@ambarella.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-2-e918514cb3b1@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:45:42 +0000
Message-Id: <20260904064542.7D31B1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The newly added compatible string 'ambarella,cv75-sec-scratchpad' i=
s omitted from the schema's `select` block.
- [Low] The commit message description is not capitalized, violating MFD su=
bsystem guidelines.
--

commit 76aff96b4864d15974efdf2aaee9ee5e0a165b88
Author: Long Zhao <longzhao@ambarella.com>

dt-bindings: mfd: syscon: add Ambarella CV75 secure scratchpad
   =20
Allow ambarella,cv75-sec-scratchpad as a syscon for the shared secure
scratchpad registers on CV75.

> dt-bindings: mfd: syscon: add Ambarella CV75 secure scratchpad

[Severity: Low]
This isn't a bug, but should the commit message description be capitalized
("Add Ambarella CV75...") to adhere to MFD subsystem guidelines?

> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Document=
ation/devicetree/bindings/mfd/syscon.yaml
> index e228670880631..05c7f59aba5de 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -148,6 +148,7 @@ properties:
>                - allwinner,sun50i-a64-system-controller
>                - altr,l3regs
>                - altr,sdr-ctl
> +              - ambarella,cv75-sec-scratchpad

[Severity: Low]
Does this compatible string also need to be added to the select block at the
beginning of the file?

Documentation/devicetree/bindings/mfd/syscon.yaml:select:properties:compati=
ble:contains:enum
          - altr,l3regs
          - altr,sdr-ctl
          - ambarella,cv75-sec-scratchpad
          - amd,pensando-elba-syscon

Without this addition, older versions of dtschema (<2024.02) will silently =
skip
schema validation for nodes using this compatible string.

>                - amd,pensando-elba-syscon
>                - amlogic,meson-mx-assist
>                - amlogic,meson-mx-bootrom

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-cv75-v5-v6=
-0-e918514cb3b1@ambarella.com?part=3D2
