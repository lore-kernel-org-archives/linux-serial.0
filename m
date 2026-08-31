Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA033D512
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788204239; cv=none; b=r4U4zEPmd7LV3sS8GbdQ3nM11GQcZoRfgMXoHROvwtwyyyVSnOrdyv118f8021P9NSkX6rNRGt91YtScJZwvfcVA+dhsUGtkaZ9EAx4BZ5YEBekHJVJgrEM++LdnksDPtmq5bCl6RzmDFL/375a1vcXzfZSLXFYQHCwbFt/fHkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788204239; c=relaxed/simple;
	bh=fvfZ+xWaYknTtD7KtZmBtpmreQfoRwhFkVF8kZyywYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aYgFHA4jZNAEJp/Bva1UyvE6/lurMwRZXMMNdwNxSYCY62OffhvIjNx9vtBAWNTWMdka9cFxZuN/UeHg9rLtlMU8KmwzQ4t4k9XyreNE6kIbsT+z+9l6x8AqTKI0cXaajfmvnLfiY0T4Q5Ywgt+bgVkQ8LPpFXqsCDgrX1NDJUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0dGJ4+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0dGJ4+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15221F000E9;
	Mon, 31 Aug 2026 19:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788204238;
	bh=fvfZ+xWaYknTtD7KtZmBtpmreQfoRwhFkVF8kZyywYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A0dGJ4+79RU6ED4ybZd2XgHzvnukNLaJ6E7l+bGFg3XkcvsS6fED0LA2oKABrds0e
	 biVl5+BrGKHBYyn7r2e3zpXODEB+ranVgtEkfuyCm8fbx1VEcaJgt8zDxjOdnT4Lo0
	 Dl4JW9RclcBvd2tzR9ycaMUTaRDTfjzaXI8lpriN/ACbcDK4yBFCOuv0rxqkj73CSl
	 mQrjF82avlPRb8M7IlnP0+YWfLHT8xUdmd9TB8TX5riJ6l01DTmFXzp+HTJUWVpDIx
	 p/X7LeRQdUfvKc7sXVkw4X70hUwgHstwwV43rpDIibGD77JEqQpDfeH2tY+wI7BLY6
	 ItCyoC5VHeDCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] serial: 8250: export and rename wait_for_xmitr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tate Whiteberg" <whiteberg@arista.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260831165911.2029839-2-whiteberg@arista.com>
References: <20260831165911.2029839-1-whiteberg@arista.com>
 <20260831165911.2029839-2-whiteberg@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:23:57 +0000
Message-Id: <20260831192357.E15221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Export wait_for_xmitr() and rename it to follow naming convention.
>=20
> Signed-off-by: Tate Whiteberg <whiteberg@arista.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831165911.2029=
839-1-whiteberg@arista.com?part=3D1

