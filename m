Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9914B7A3F;
	Thu,  1 Oct 2026 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858718; cv=none; b=eyYhtciF749lZy9xrocMeHWgMMt8J/+aWa1KFqg89Ek6AvCE4bo56lMBX5P9PB+o/HagU2M/q2RJ4G42OtPcmcH8Nbk1tzVnKTDFkN4YBRkc62z8+ktN0lKtVK9qOX/pntvgq+morwOaXDAdzm7kGvfcgPkTvlqz8f9hhMiOPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858718; c=relaxed/simple;
	bh=Ly1wS7IM8H6Q+iD4SOYR0ycm4Sq2XDaEsFWGe8WF5bg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZjaAAMZYaoGahFO19FPNH6XAXr3ySibplMXdgdW6l2q+u5FvdIblJW2K12cBdyepHSlFZsCkdz75y5GqEdgbsboBEg6ImIvMxQUpcbSBnPXfO3nhRSHoljJCOFypqUKsPc+m5Bit7lvqCnnRxz3fUF4YsS6Vw8g2VQTSymj9fcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iND3lfMV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iND3lfMV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BC41F000FF;
	Thu,  1 Oct 2026 12:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790858716;
	bh=Ly1wS7IM8H6Q+iD4SOYR0ycm4Sq2XDaEsFWGe8WF5bg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iND3lfMVt0N/r0W1PhbUQqL1StwgD8FFCddC29HC0SVtp0kKeQgbbyGd+iViRhlM+
	 qOTOAjE6J9hk7hO0RfXkk8QI0l/XEpySYTs4wpWCe2ewFpmCkPGvm6irnDsVqP6SYy
	 1aq2XgCCekjpFD9a0D801q+u9EI/e2YmiPDxAqCkIeDU77ZcB2HZ0NxZPNJ3TeSp/6
	 FQlTJZKQSvtlD7VIyKGv1pj3CZsLmuhtx289qdHwbz7qz5wXGZxUeVl8LXNeO8xpnw
	 NOrTM0PYehVLGbaRWWU5HfiLbOTDBFa87uIDq9xD39DJI7VHRlSODI0dmr6LXyUqI9
	 BVqngSPoVL9wQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/15] dt-bindings: clock: add Ambarella CV75 RCT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, robh@kernel.org, lee@kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20261001-cv75-v5-v9-3-486cc289a4b8@ambarella.com>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-3-486cc289a4b8@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:45:15 +0000
Message-Id: <20261001124516.13BC41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Document the CV75 RCT clock controller and the clock ID header used by
> DT consumers.
>=20
> Document #reset-cells for the RCT reset-provider role. Soft-reset line
> IDs and the reset provider driver are deferred; this series has no
> resets=3D consumers.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-cv75-v5-v9=
-0-486cc289a4b8@ambarella.com?part=3D3

