Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CBD3F7A8C;
	Wed, 30 Sep 2026 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751979; cv=none; b=ss0SMO3xia221Wrogd+Ua3JUApe1UFnxDKgBeax2RrPJ9iwcVSWPKR3CIwJ5iGL+9fmiiv5wpJlqrKJfOSaZckh77vbXMfRRtF/bRhXRdVian5lFYCUa1ZZmoRF0wLhmjXZrYhmKu3tI1Zvy7sd2tGbAYBxhdcvfI0rqrHw2muk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751979; c=relaxed/simple;
	bh=LbAp4oJm8z7Xy1d025fyBRuS1yFZCwIDgS/zQC9tucQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qRqJbVghGlqJhOQ3snWNYlzAtDQfLLRa/rHIfZRka74mGY771kHXMz93f9FRt6jxvBC7ejML+nLXLfZUsETuWAwAW7FUuZ9s6aeaNaznYlTi03X0jaN/WNOy2udn0WHQkUnMsjv93rjT2ICk1cOy0wp8oKp4vMTpZdxA9PNhaJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbeYI2zI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbeYI2zI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23B51F00893;
	Wed, 30 Sep 2026 07:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751971;
	bh=LbAp4oJm8z7Xy1d025fyBRuS1yFZCwIDgS/zQC9tucQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fbeYI2zIyJM0f9mzILhbqivlMDDqoo/kAWHitmG1Dx3UriKuXtLElo2bH1zC3tqQo
	 Sfa4XHLAh16O69O/TlShWSwPZ8FvEOJLX2sO7Si9sr9T5c1kV04MeU4Omec49HU9vf
	 ZTB3+JiD2kbjWRXu6n4CCtMnrwK9cVFfazuKOyBSxXtPgr7ikPd/5mYLWBGMs6QVZX
	 C/DKsxucfGMHthhiMaK0EYFvtgUUFJ5qdhh/PjLue3JdkX99TNciDAN3ViZYVK6zzU
	 +pKHGc2BlARFOR7hMWYvP8W+8t/YWlO+1NKp6F6IMc8ifyfHw3K6iPJb+pSD4la+kR
	 0JcLVdxyYBWJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 02/10] dt-bindings: arm: Add Cortina Systems CS7542
 and Securifi Almond+
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260930-b4-cs75xx-v1-2-4617c4463529@gmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-2-4617c4463529@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:06:10 +0000
Message-Id: <20260930070610.E23B51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add the top-level binding for boards built around the Cortina Systems
> CS7542 ("Goldengate G2") network processor, a dual Cortex-A9 SoC, and
> the first such board, the Securifi Almond+ touchscreen router.
>=20
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-b4-cs75xx-=
v1-0-4617c4463529@gmail.com?part=3D2

