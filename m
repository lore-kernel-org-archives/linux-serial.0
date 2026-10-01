Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683903264D2;
	Thu,  1 Oct 2026 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859263; cv=none; b=Ku2Bh3PobH61vWEAl1jEuoCd0dLB7JgvKKKiSDp7C3HcgaCelZa2dBhNpXLXD7FO2lRCWe4iYkTOywIsRxyenXrrXS95cj4DI6+Oo4sD5yDcLNSzKRcEXLCPJYr4dg/51kreKdKU9UPYswyal6Ncn4qDWyC89S2TVoNrvvPrm/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859263; c=relaxed/simple;
	bh=0chf5BseA2GCj2D1XZaAKjb+MeMq05bFDLGxqN5qpoM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vALoopQ9oqa7M7Eck7q2oBbaiMHSpcgZgN2632BOhOdSNKqBweabcRZo9frB1i4OBN3FLK6SMpd+yTdU+uohNzYmuA7bocyvb0MTccneP/GEvNRRwbQplWGqzyM/SHlBbe6QlMWHtd97AoL8JmCHHBp0NnkntAEGChZiYWcKH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBcDhn4/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBcDhn4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946901F00898;
	Thu,  1 Oct 2026 12:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790859262;
	bh=0chf5BseA2GCj2D1XZaAKjb+MeMq05bFDLGxqN5qpoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NBcDhn4/2ltvY6lpXiz0ALo9yYV5dLIeYmdWpl6Di4d6NdsKkw9PqHau2lQknSTyR
	 zYWGPb2D7hJ1vGko46JaWwH6EOE4fdx5Sc146smJyOs3erO7Du5OOqU9tbvsdxOj3v
	 iqpdiG7icyuwCkGO3LbPBPW9OLXc79ExKYfOWuli5GdYMDxHnIVSC+dcEytoGEbb8q
	 hF9hyKil4BAxIe+oSo8IZ9fx1zzyTae2OSUkCVmw6EksSBltvOtUE+j9Fq6VKRJbHR
	 tdEF/60HLXvqg1uk8xaFVvEUwLaAiI3zE+ziygTFTzLJdQECla8FwvWR+OLii3cfvg
	 qmKPb7KgF3C2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 14/15] arm64: ambarella: add ARCH_AMBARELLA and CV75
 EVK DT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: linux-clk@vger.kernel.org, robh@kernel.org, mfd@lists.linux.dev, lee@kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261001-cv75-v5-v9-14-486cc289a4b8@ambarella.com>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-14-486cc289a4b8@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:54:21 +0000
Message-Id: <20261001125421.946901F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Enable ARCH_AMBARELLA and add a minimal CV75 SoC / EVK device tree for
> console bring-up with the RCT clocks, UART, pinctrl and GPIO banks.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-cv75-v5-v9=
-0-486cc289a4b8@ambarella.com?part=3D14

