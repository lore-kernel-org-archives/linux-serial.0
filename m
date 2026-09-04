Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8043411A16;
	Fri,  4 Sep 2026 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504166; cv=none; b=dT+JzccwLk1aoW8vgBia/0h1xDXdYFOXPgIQwTh+R8mdMOYC0oLh9wYSMC9ItAc1mCZuurM5eEeHFArA/KI5vt+NpxiVnhw1ktuW1pUKNgNW18niKGcaF4r5bxcvRvEZmTTLnILgpJwHDbfRaK8bCetUwuY+FfZEKI0jCLK7ro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504166; c=relaxed/simple;
	bh=05BEqMKEe5bdkVHVF84i0jgTBqoQKCD620dSd8olNZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=duTBu5STb+MiauXAdOrD77mDnIUqe5x+dAyFQT5F7JpwvHUtbDc30XzBT7O4ZM+bs2EmgNwPMj/VSwrPC1RoMdCZk75Cp8S+N9RGBOjaHfVCasrapFby+gx03beOBsklf63yEDRHdIJFuqP2Wp1XbMw5nKXcs6J9yWUZSrVpmmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcCdy7Zl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcCdy7Zl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F731F00A3D;
	Fri,  4 Sep 2026 06:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788504164;
	bh=05BEqMKEe5bdkVHVF84i0jgTBqoQKCD620dSd8olNZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jcCdy7ZlNfLo8sePfqDrmkreY1DNmKgCqSTy/4PB0AzkYzHGAkh8tORhQ54PlW82R
	 17jDfaJB7csZQyr6xPqeazgIYG4rgpxrxREm2uSfF4eXPmkI8ZKklBE68Y6h5wXZcr
	 KAW4Z6LL096hgW/XwFOod/n8nbqPZuV2pVbAmiR6RE0SlLNhCXFTmmy9u7/29vzmZZ
	 lJsg5v9Y0RhPPQQ9whMHjqA+IXwh0S/bmAG2fnm89vd7j/u0TfQCRnOY5YBpq7+U7H
	 pCB1zVa+e/xYR/H4imYdNhy0DU5+Loml/RUX+7u3WIVqG5KHwyYOmGRoNZBn7k/s3N
	 x/T4BWT/lB8nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/13] dt-bindings: serial: snps-dw-apb-uart: add
 ambarella,cv75-uart
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: linux-clk@vger.kernel.org, mfd@lists.linux.dev, lee@kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260904-cv75-v5-v6-6-e918514cb3b1@ambarella.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-6-e918514cb3b1@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:42:43 +0000
Message-Id: <20260904064243.80F731F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Add the Ambarella CV75 compatible string to the Synopsys DW APB UART
> binding. The block is Ambarella IP with a DW-like register map, so it
> is described as a DW APB UART variant.
>=20
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-cv75-v5-v6=
-0-e918514cb3b1@ambarella.com?part=3D6

