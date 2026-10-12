Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A724BE438;
	Mon, 12 Oct 2026 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826443; cv=none; b=p60JnSu7ggMdJikCugAlrrh0/OyQlfl2Dv5wfLwlnzzjckw90hZYrOoGJGt7U5tjFBGwJ7VFRBzUE2e28MJQOWAR/wi9tFyKnts0xjk3Cf86ARoRR0r3Sy301MJDLPxbaH8o8LzPnPxRmN1F8R7SECKk0ro2aL2FqJXXmqLaf1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826443; c=relaxed/simple;
	bh=1nSfmm9N0Z+H9y3FTSeViqfDnJJc63zQ1XA4HVN2Haw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hOh/CWz9rV1+jbn0msz6lS6jNjb82fhYuqYUoziEcvSEDHzUTFPMryihHsE1hu1suTYKVgs3/hmjcnlsGYtBH1kbIqRPpn+g5f3QofkFNj/7pglTnGydlWVoIpj5DEyXBmFlkrlLLW5dgOSCCZYZqmafX1KoL1WOsEBFi40XC0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mULL1bX0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mULL1bX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F251A1F0089B;
	Mon, 12 Oct 2026 17:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791826442;
	bh=1nSfmm9N0Z+H9y3FTSeViqfDnJJc63zQ1XA4HVN2Haw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mULL1bX0wPWqXXynm2E8QSS3sZGZjStSFsl63WNA1q1Nff7aD9ZVdpFZfYb1CXEpV
	 FtXHwa3TCJV+C578eklHt2YYgFqnf04rkVkXmr1/8ZawQf9meknaSLvTJX9f8LUNZm
	 zBua+LTMf1nCo/bXi9Ap7CfFmKDgLezbAn1B6j1fbarknY5VO1Y+JiZ9WOQDjEwHfW
	 WETFyEY9wMkCUvf+b+Q+HCsIW9kzSYtK6+0uS5P+wpzRvp58pC/ZOjbRsj2ckXmalv
	 Rkd9K6eeRfVzEV72hRK28P7+jMz29TYx+wJ3hJKu2g8Nkp5b9I9sYgENiyMxqalmEp
	 4eCEHunem3Fnw==
Message-ID: <sashiko-outbox-168462@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/10] dt-bindings: serial: Add Cortina Systems
 CS7542 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261012-b4-cs75xx-v4-6-df250d903682@gmail.com>
References: <20261012-b4-cs75xx-v4-0-df250d903682@gmail.com>
 <20261012-b4-cs75xx-v4-6-df250d903682@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:34:01 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add the binding for the UART found in the Cortina Systems CS75xx
> (Goldengate G2) SoCs such as the CS7542.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
v4-0-df250d903682@gmail.com?part=3D6

