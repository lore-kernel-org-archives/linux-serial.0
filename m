Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF8137C0FE
	for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2026 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586235; cv=none; b=WFHEM64zOjmjJBGSqJ1D1ClU1eu1WetH5Ab4KBSweL4VDZYl6OHpGROHrmZjWLeLZy/1vuIZ2e8vBQLHrN1pOoy5jTaO/UyOJaUQs23p8oJZoy2wzehAKF1Q3rO4vJfU6rc2T+71gutJNYjP3pCOvFe9sXWbUKd/XZgtjC8RSJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586235; c=relaxed/simple;
	bh=sjuNU8/nN1UM22m2rgYHjnqMLe1ahYmjPQoYWahYF+g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ERc81FEM/kfxBcPLR8+lycm6kH3qWbBPbMCq3/ywYDfEZHL26wpgAZF1vkK6FT0j0OicK+IEK45L8sO82Zy3Lz7WKdbkfS7XWB7Pk6Whdx4VZDQmJoEWwxX8MZFcmE92mLk/5GebVyrwOtaSgQzpV0mIB8uPISS+uXzVV/4Jwc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFj4A3p+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFj4A3p+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A32C1F000FF;
	Mon, 28 Sep 2026 09:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790586233;
	bh=sjuNU8/nN1UM22m2rgYHjnqMLe1ahYmjPQoYWahYF+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eFj4A3p+GcPXUsWNmw3sSGBOzYF7GKd/CIQfzWz/iL2N3SKIY4/GP9FqmAbyjmWIy
	 f9ZxRa9BpuPy9CFPtM4AMCahBZvmNb4WW2wYAjzhPu1JRgqkAqsyZr5JDfBi6gXbyx
	 bo3pTeCgMG1N1nIUdglJwS+cOfz1EtLXO5BdClcL8NlSVwF4Wf8FpzQLODSVeNP31D
	 4vh1XKe/hj21jEatBm3jLLB7BXnhMF34kUh5G8Al34gg5iDFLnkfGEI3vXYV0yFoif
	 Da0e1d7LTt2TePJaGM5hGO6i35+LtM7Og1r1MGthIPkpR99HJmPyG0+WYVFywDG2/P
	 MH6G018Zo895Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 RESEND] serial: sc16is7xx: fix TX gap caused by kfifo
 circular buffer wrap-around
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Mbewe" <paultyson.mbewe@ziehl-abegg.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260928085559.3341419-1-paultyson.mbewe@ziehl-abegg.de>
References: <20260928085559.3341419-1-paultyson.mbewe@ziehl-abegg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:03:53 +0000
Message-Id: <20260928090353.8A32C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> kfifo_out_linear_ptr() returns only one contiguous linear segment of the
> xmit kfifo. When transmit data wraps around the end of the kfifo, only
> the first segment up to the buffer end is sent. The remaining data at
> the start of the kfifo is not sent until the next TX interrupt fires,
> resulting in a visible mid-frame TX gap on the wire.
>=20
> The resulting gap is unintended: data remains queued in the xmit kfifo,
> but the hardware TX FIFO drains empty before the remaining segment is
> sent. Such gaps can break timing-sensitive serial protocols such as
> Modbus RTU.
>=20
> Modbus RTU requires a message to be transmitted as a continuous stream.
> For baud rates above 19200, the Modbus Serial Line guide recommends a
> fixed 750 us inter-character timeout. On the tested 115200-baud system,
> oscilloscope measurements showed mid-frame gaps exceeding that value.
> [ ... ]
> Cc: stable@vger.kernel.org
> Reported-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
> Reviewed-by: Joachim Knorr <joachim.knorr@ziehl-abegg.de>
> Link: https://lore.kernel.org/linux-serial/20260623112225.82386-2-paultys=
on.mbewe@ziehl-abegg.de/
> Signed-off-by: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928085559.3341=
419-1-paultyson.mbewe@ziehl-abegg.de?part=3D1

