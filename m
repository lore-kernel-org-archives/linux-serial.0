Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912465;
	b=tCgG7RNwGckIFls8O22qW1dOdgJ4nmHnc3IJ49smuLQook6y+jTnfbPD/wiPEaXMBvUa
	 7Q8Lwuqr89dg7JMoKAJAd0ssP94j3Czc5EQw7PtA38ZB3UCq+0uF6Rh8pRyJwF4NLSTEE
	 PTm9dEtw2izFNMLt/uNV8+BjBn4T6L4sQ7l0TsTZmGI1ujd+GkF1QGolvrFvlZmJHXbtu
	 Fvvxx4ciw4CMn8ZsVQs97yrHXwwtkY5lDl7axnpbFtOEMCE/dkHFMa3M0cBLJqCgxaPgQ
	 4kAUn3Ir6EMzKkTwfYMRF/Bi2lFFfTtNGWKcnsyq4LpLqfH6Aotk9BhPOj0zKrElNIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912465;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Pg2Eba7Sb3sZW64FPAa8svXvdXJAL2Bv54PDzO9yvpU=;
	b=HJSQGov8MSwkDVox5pE3U6h1eRG5ZB6UIZdfLD2y5gXWlqIFBokbKzt7k1ldHhM2egJV
	 YMjtTJjOGcgUHYO2jwAe+HvTrP9cc9NAni6XP9XbG4O1BBoF+Z1owd3gKlMz3VVx0Wkb1
	 FTNNWgRz51cw09MiGVnGQFt6vDMmIKTbaIKoYnC2OlU0LiJ8AD2X4WBG9pj/N5oosRZBf
	 p4215AVrpK9WQ5KtYHkxKV0IJ5S0Cd6AuiS+UB5RUOnJVtptabG1Bplzmx/W5f4I1daZT
	 gEh1+7luFxyLyHikZlSL7a6BBqsUeqkPTbQ1s6KzB0ZdToVd4jiaBJILYt+1m24rCaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CbO/xzKI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B20606A326
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbO/xzKI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312401F0089F;
	Thu,  5 Nov 2026 21:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912464;
	bh=Pg2Eba7Sb3sZW64FPAa8svXvdXJAL2Bv54PDzO9yvpU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CbO/xzKICACsYY39k794QRxXP3c+WzCTEZdJfH5taFciPKWF1p2AVt2bL+H6pMxRE
	 ulv/BkzS9TUMvlQmpUBuXw2ZYgRPOJTEVfdxJG4Fl5BTHBvmy8FkqL7co1EGu6yesi
	 FTvPGsA6tjJgpVdbYjZaaJnFsM0hGq57iIDm+yMaO6Ol/+z3N83RvpQoX0I+Y9gnIM
	 edgAHAQd4NR9cjZg/176kH7JbZCNXpDhPio8JTwUi+Uyo7u2wj4RjoLICeuKH1uIaq
	 H2SyZWjd3OtCf0nMN0RbgayRDfgBIBeTOP7AjVNT3aYc24iCl8b3sxEK7FEMIZw9uZ
	 CndxnEj+K67dg==
Message-ID: <sashiko-outbox-200175@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/11] serial: 8250_dw: select port setup through
 platform data
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-2-14024d2b184b@gmail.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
 <20261105-submit-h616-uart-fifo-v1-v8-2-14024d2b184b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:01:03 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Select feature discovery and DMA attachment through a platform-data setup
> callback. The generic callback probes the optional registers and attaches
> DMA when a FIFO size is available. Integrations with a fixed configuration
> can supply their own setup before the port is registered. Allow setup to
> return an error so integrations can reject invalid configuration before
> registration.
>=20
> Replace skip_autocfg with the Octeon setup selection. Octeon is a 64-bit
> platform and continues to skip optional-register probing while preserving
> its existing conditional DMA attachment. Select the DMA setup helper
> directly for this integration. Keep generic setup for devices without
> matched platform data as well.
>=20
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-submit-h61=
6-uart-fifo-v1-v8-0-14024d2b184b@gmail.com?part=3D2

