Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281794;
	b=GOOORaBehIsq66TVK40VKlZ0qFhzm4sokdG4C1t8Ex8sVnRqYmkosuDBvj+tasFUxGsK
	 Pd03mWumJbZz+WcGUgI5Rz9v2qsdRoycpPL7VVlw5fpOoTcQq3WZebt4YEb9JEOKD98i/
	 wokTeDSBuJvoWtNzrrpS/L3QZgDbffTbqHHcWauig8uSES8SFPfZd/G0WBaQGN3wbizaz
	 PuvoGb3e7755cUjyTTsACKwLxr9H1p5PIa+wgXzv1+qUtDA+zHt22Q0dKk5RqRflTbe8x
	 wI/PU047iQaVx76HKTnRt9D7EQVtJS/qak87EMNWPw+uyBMYcLLPbyzOf2nYgcpHX8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281794;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fcPFTiQXzvhXH/OHGrDr/VboUqPj177Njh5i67Q+qME=;
	b=db1BrtFFr0KYOGlQMa182SfKvC47J1IapjYoCkIx9I04co3zZx8yOJtZp1SBwgi6pSqD
	 wzzfKieYYoIsJu80ZKbrRdAiFqYCsGL82a/e4xXrCy/gc+LGdh80kuQHH7rXV4Ckt1cQM
	 4DsFS3yQyw3Bnh+qvHaurdUyoneTlkoAoYFpz1m6ZjICIKTtbCaSK1fasGFQ+aaAx4tg7
	 rkAUKOWcPnC4FGJgLNx+aY6rUgQ33DYDos6Hd4kJu5flIakB4fxdov6sBaWfupL+IRNqz
	 739CXM9tqv8UBofBp7yfQeMYIyXQsQdo12jQjVRigh5GEaAX7cYJTBts1NlKsjGXRFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNyD2Lvk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42828606A31C
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNyD2Lvk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD131F008BF;
	Tue, 10 Nov 2026 03:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794281793;
	bh=fcPFTiQXzvhXH/OHGrDr/VboUqPj177Njh5i67Q+qME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bNyD2LvkoBS/twtBdduHlZSwWflw2ndsjhxdYdTu0w9NJ85qV66QY6eXZrPncXfOH
	 7cWMJPzBgdA1Ssqnj9PntpZNFk3TzFq0yAWAYN2eYYcsJv/4i572bEDy+LC6AVWxfN
	 burYco77mob7oVtoBoMut7+brrkzn/4Kpa8eHdfYYWmEKvFgkv6Mh4X7bP0Y3i2LnH
	 plaRPkvwXzPRhNdAo9f/BykmNdeAwSXTBx/Dsp0tikTAZBZ5wXl3/423KZz7HJh8Q3
	 4VD+NqhcffG8tL94qv0lYsiPA6/Q6w/GWSDZD7z4F8mvycIXSrPEmEWEc2pvcWkve0
	 9L9irnqJWHY8A==
Message-ID: <sashiko-outbox-206127@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/11] serial: 8250_dw: derive RX trigger thresholds
 from the FIFO depth
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-h616-uart-fifo-v1-v9-6-3f03961dae8a@gmail.com>
References: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
 <20261109-submit-h616-uart-fifo-v1-v9-6-3f03961dae8a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:36:33 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> DW_apb_uart uses receive thresholds of one byte, one quarter full,
> one half full and two bytes below full. The generic 16550A table describes
> these encodings only for a 16-byte FIFO. For example, the half-full setti=
ng
> on a 64-byte DW FIFO is reported as eight bytes instead of 32, and a sysfs
> request for 32 bytes selects the 62-byte encoding.
>=20
> Build a per-port threshold table from the discovered FIFO depth in dwlib
> and install receive-trigger callbacks for CPR-described FIFOs, including
> LPSS ports. Keep the setup helper available to integrations which obtain
> the depth without probing the optional DW registers. Validate that each
> threshold is positive and representable before constructing the table.
>=20
> Serialize FCR updates with termios and the port lock, acquire a runtime PM
> reference before accessing the device, and propagate resume errors without
> changing the shadow or hardware. Update only the trigger field so changing
> the threshold preserves the FIFO contents.
>=20
> The FCR mapping is documented in the DW_apb_uart databook, section 6,
> FIFO Control Register. The existing default FCR encoding is unchanged.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-h61=
6-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com?part=3D6

