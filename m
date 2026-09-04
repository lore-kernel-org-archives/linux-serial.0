Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25614425898;
	Fri,  4 Sep 2026 06:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504426; cv=none; b=JuGgPGMFH8rhTUXmpKt5n+oRdLo5daL+IRdPRxUzJuPjYr2EvzhhgNMF4PoDGcvw5iXNVLUYyRm9XbwSIlxDJg7NH+FiiKc0to605taCZ1cyyMR1R45MlcRu1rGnAz6PMoqqofSFdxemSAimSfLSnUUdaBPL/RcTO3onFZSQUx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504426; c=relaxed/simple;
	bh=vsHZRHNecP52Nqxt48e0dJ2Zx5OQ2M+t/SztFQT1LnQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U3WbeTzssMfPmkJ3i2KPaGbPr5N4QfTRudLhfXGTSpwg6KqiHihlkPB65yejm4zLSPKpX6GxVnwV9Uvsxt1megQOtAj6U0g1NWenWNRcs83/fIC9JghRvKzFl10X8kFEzNCPqaBnsXnqJRDdII/1XFhyZE1svj1aD/4S6qRBb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arOgsD3V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arOgsD3V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D07D1F00A3F;
	Fri,  4 Sep 2026 06:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788504425;
	bh=vsHZRHNecP52Nqxt48e0dJ2Zx5OQ2M+t/SztFQT1LnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=arOgsD3VC+F0lefQ/VRPyxSACXA4NkNNOH3jLltIcTnEyCVXT5W4+tPOXQ7J2wpO7
	 n6BTy2lthjB3RYiUPrw8Jo2lb/6e6ygUX3bPnm1/7r8+5yf2ljLzs07zPGGUItmJKr
	 buZ5GLPkJrAXf85MKKs1Szwe/EBYPZLVwn40/TFUuBKgcHWryldxQDwCPlVGW6850n
	 6lNTgonM8wHY2Meyd5lZ4SnM8MHWEoFlrFnQ0Ga6tuglPPrrc7gmniKHPr3lbjbvjh
	 eKcqY1+52oViXaVuwd6SHkn0gP3Kxrek2+j6VVAnhTgcN4O+86AFZWkLWpiHY50np4
	 1z75UJVoi+GRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/13] dt-bindings: gpio: pl061: add Ambarella CV75
 variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, lee@kernel.org
In-Reply-To: <20260904-cv75-v5-v6-5-e918514cb3b1@ambarella.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-5-e918514cb3b1@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:47:04 +0000
Message-Id: <20260904064704.8D07D1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Document the Ambarella CV75 GPIO bank compatible and the synthetic
> arm,primecell-periphid used with the PL061 binding.
>=20
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-cv75-v5-v6=
-0-e918514cb3b1@ambarella.com?part=3D5

