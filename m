Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648645;
	b=ZFIhwEebBDAJw5sAqBxQ3O0lTPoIP9WFAcUmdKFMQMHc+ITy0Qly2qg2lOlOeImfK5Ij
	 gzyDXqdeikXVRiDmOetOw2N3IMD/C0AY/gxY1e0oD9WejHAc5NEVia9XvqMbQ3G9Y11WL
	 JJ0wxzCfE+KBeN3qCXiQp/vLJm9UAXDsQZvQ5yDpTaK4rp/6T7W0uI3nuwdtm3lOaLZ+T
	 P9WDp8baPbHBugrT4BD08378X7+2kUUV+LpWGYmwat+xlhGJ0k8EILDoENLpONAzSdZ2/
	 z7Cda/GstnzoqZYKcCgNoqWlGXt8lY0QMrsb7ZdsD9ChAm1I9klgQMlsI7J7TPTjQKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648645;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dbKAB/WkakE4uNoGrOM/1OcrkOlgtgMz/a0LTj2D4T4=;
	b=3pVVV2M6IvcCumxfVFf1PDf5Td2mOG4DVONafHrZBvVLyb+TwzN0GxJ9XxAFYBKTULPv
	 ksjSjByX5PSGk0WpiexGeI2KJ1fPTM/uEURCVCABf/Oc2upQdSj6Qnnpmu3xQwfjiPomB
	 P8RtEYBzTzzqQZBt9X/R88esUFWj+2S/mzlJHic0S2OiYUy9S7Vy2/DuwitG2n6yXYOk/
	 HuR9ohr5kbnsF+uK3JZ1arMcXZKaqr/vN/QS2LPvZpV1oFzCEBS8fhLsmslWN1dFzEpi6
	 XClfk/kBYZqWEbSwsSZIzJX7Ym1I4x04faWiBAoiizydUKR4nvBEv6dfqy3L6iiSZQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpHMLCBW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED893606A324
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpHMLCBW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D2A1F00A16;
	Mon,  2 Nov 2026 19:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648644;
	bh=dbKAB/WkakE4uNoGrOM/1OcrkOlgtgMz/a0LTj2D4T4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MpHMLCBW5SJDgQoqIP8tnqBu+Srk4pEbH8vtWN06dZtiqML6frr+OxIs9XrACOc6b
	 Ss20hJK6yy3AcMq7D61Yv166PaLHe9KpGbW5CHgsG7oQfDtiygML7uZMLk7s6cSrF4
	 W5N1NKGY98e+yUag9FpXGKNIIfKvBtrxwZX0dLxOdO4ncw5cLIThT/RyviHriCx/1f
	 7BrswLlNsy+vcJ9KoM1PVXP1cEAj5RF3IGEKC1o8x5LwVJY5q1XFDMfbUbQQP+Wws7
	 j8+DqYwG/hdyb/c8jDMWF+gdQZYu9wfkVv49jUfeMQ8dsSQ09TAjzK/MFje0xjo07e
	 Hd3/4ImaupPnQ==
Message-ID: <sashiko-outbox-194016@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/10] dmaengine: dw: calculate residue in the status
 getter
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-5-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
 <20261102-submit-dw-dma-synchronize-v1-v5-5-d3207758fbf9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:44:04 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Serge Semin <fancer.lancer@gmail.com>
>=20
> Calculate hardware-LLP residue while looking up the requested cookie under
> the channel lock. The scanner and the status getter currently take that
> lock separately, allowing a descriptor to start between the scanner's
> residue update and the status query.
>=20
> Have dwc_get_hard_llp_desc_residue() return a local residue value from a
> fresh LLP snapshot. Keep the persistent residue field for software-LLP
> block accounting, subtracting the current block's progress when reporting
> status. The descriptor scanner continues to advance software-LLP blocks
> and complete cookies from RAW.XFER, including for polled transfers.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: retain polled completion and software-LLP progress]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-dw-=
dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com?part=3D5

