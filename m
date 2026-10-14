Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628A71A9F90
	for <linux-serial@vger.kernel.org>; Wed, 14 Oct 2026 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977494; cv=none; b=NW1EanHY27rDXc/sfJKx49pirAR7EswWe5Dsp/aF0BqsKb4lx0xP8kNNsp7kvhRFtli1HAgyVP1EZPMpfUwVJS1cbH9ZCd6ZdByXGgKkfal/+JvKsAsIReZ22qxfzElNswgErSdrDFVszd/OUvu+dtpEyEE+CN4JfHOulh8Stng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977494; c=relaxed/simple;
	bh=i08m4l3H3n+cZ0q5i+naoJDX0+j6I3TP714aColDXTE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oawDeXJL/+8dYpOz206Y4e3z0LUqzomuxVeGSU8JqY5sKRI9tyJ+IxuMU5FC+k8DVVytXn64SxtX6gFcSLfQ+69Wyb14dVrSIV1ot9OqiGmBXR8oy63aDIcEy6iJA4zTMgY8Oiv260kCSlf1TfYf49iWoEP9jnu4R+liOqlMEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbVewxor; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbVewxor"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38691F000FF;
	Wed, 14 Oct 2026 11:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791977492;
	bh=i08m4l3H3n+cZ0q5i+naoJDX0+j6I3TP714aColDXTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BbVewxor3vFVPam7icMYKfrMWp67pfqppc0ktNNosAk5dTNeDZgZ/zHnyXqy0mrub
	 kmt4ce8hCesZ7dvZXUbB6rF+fHJHeTUnlWH/KUKZcP1l9iHQd+i6K1E8Ldfn9NC22B
	 6ObyoYqvpot5rdtVMvF/aG6V1o9T68x/ZHZYbCDzPvaHxzNyaZ5TRbDBNpYbYGJIky
	 WcrlBtc5kdgaWX4BjC0t0NeeWIdbbYO02gxlk9tHGVNTvpCT+BN1GHDQLt/TQFkYAE
	 YFp7X7AeBLcZJ/3CnWolU+l4SRkGKZSTxR8BPB+5cQOtkiFlLaJA78zoM2+LgGHE+1
	 K71c1Jk5LCswQ==
Message-ID: <sashiko-outbox-171201@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] dt-bindings: serial: snps-dw-apb-uart: Add Synaptics
 sl2610 uart
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261014110546.415-1-jszhang@kernel.org>
References: <20261014110546.415-1-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 11:31:31 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Add the compatible for the UARTs of the Synaptics SL2610, which are
> compatible with the Synopsys DesignWare APB UART.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014110546.415-=
1-jszhang@kernel.org?part=3D1

