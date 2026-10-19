Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93144401A3B
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792381034; cv=none; b=Hm6Nzd6LEVzBkukBM0SPqNis97XMXB2Us8gghRn0gAvz4p5lu66vXfKotZfTd7aPkM8vSLfBg+YZtZBbiLkI9oObwRFIPx3wIL9BeNKDd84VB1p/YOJ9OcacbxbxoGRN/b83JTn+/UaJU7N41DOT80AfiI56IY85NPEIJXH7koA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792381034; c=relaxed/simple;
	bh=fPtZtFxA1MQ3BPiYYOEKpJW23b30NxJJVLvpXsaqfHs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=U6hIB5W+KrLsE7yMoAKknxBiheuZ4NOIjzkG0AyQ0Au37RH2D90IBA/0Zz+zOK9FJ7iSRrzgQJDMevETgsy7A4SzrHkZnBwuptt7oZ9zNc4hasazcO7gn4dACJKqaLAjsQ4rKiS7dS+DhK6rd3bt7/7Jxz+9ULyUaMlMAhlISes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZOfg2wV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZOfg2wV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059E51F000C4;
	Mon, 19 Oct 2026 03:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792381033;
	bh=fPtZtFxA1MQ3BPiYYOEKpJW23b30NxJJVLvpXsaqfHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gZOfg2wV2Ddx52tZOtg6dc2mrPloRIe3rK+Jl5oKkKeExgRez8ymqNxjzyGE19gVt
	 xWUne49pmpRXN5LcevNJY8bTXx8Le3lf9X4NKEzpXIE86Do/ibF4WXHQjuNSjT+bIO
	 sloLS50VSx+sxE1DPbSAEyfi396I+cI0PapvUm4W/wiiDrIbdPnqU+o8rZuVdnvj4f
	 iMdbqo0NCYoefxwdZQCe7Fq0nBfQds3fNaGkebT83kPg/bRPDJp6d6jictgELcHhEH
	 E+vG8lwKzVZ9E1AtAhFzZciMEidWV1PfpmbXIhdwNu7RgbWQMETbn4fmYWfqE5MFFw
	 dluqkXbmI32cw==
Message-ID: <sashiko-outbox-176577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: qcom-geni: Add tracepoints for SE reg dump
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019-add-tracepoints-for-se-reg-dump-uart-v1-1-1fb47b1605b9@oss.qualcomm.com>
References: <20261019-add-tracepoints-for-se-reg-dump-uart-v1-1-1fb47b1605b9@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 03:37:12 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The GENI serial driver reports various transfer failures such as
> M_CMD abort/cancel timeouts, DMA TX/RX FSM reset timeouts, RX FIFO
> write errors, illegal command interrupts, and DMA parity errors.
> However, diagnosing the root cause of these failures is difficult as
> the hardware state is not captured when the error occurs.
>=20
> Add trace_geni_se_regs() calls at critical serial error handling paths
> to automatically capture GENI serial engine debug registers when
> failures are detected. This includes:
>=20
> - M_CMD abort/cancel timeout
> - DMA TX/RX FSM reset timeout
> - Unexpected zero-byte RX DMA completion
> - RX FIFO write error and illegal command interrupt status
> - RX DMA parity error
>=20
> Dumping the SE debug registers at the time of failure provides
> additional hardware context and significantly improves post-mortem
> analysis of serial transfer issues without affecting normal
> operation.
>=20
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-add-tracep=
oints-for-se-reg-dump-uart-v1-1-1fb47b1605b9@oss.qualcomm.com?part=3D1

