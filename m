Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742160;
	b=Sl0N/RLXhW4H+nimrValBHI+kQDqdIVgP1NHMvdMskb1L+0a0IEWmzvt5J3CCBy8bbqt
	 X+BMLMGtfoO6/Na0I85ildHTtnqRUkxGDekSxldnHtBH8GaTV+0v1Pq0eKE4c8Ts3ikoR
	 9F2GoK4pLOhWcRd2zd9qwvsI1saovTw1tqVJfyx/FlUZjh/9Ja2DZW4Qu7+8qI2l3PSuV
	 brrUMz6cCHYSLfO6xT+CwKEsjbuvXCc8AM91GjJv+to8bbKUIZfvyem5QUGg7SfWptZs6
	 Dua5/xoO2ODJrxOVK8LfWEKMtLIT5Hjwz4Fm1++G8UYl6CDcAtoTrfszIpre5eBcbtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742160;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0AqaMnymT+75dPDa+7ziWwA8f5+T0x47R11hWshCZRs=;
	b=OhGKZvnKM0VOCqZHGCP1XF5JWrcyZlbe6CKru10xmyhb7AE3KFrCZyoRJU4cEUDRR7Yi
	 eJWm1r422FXIzwO88rhMFpDEwqdjiDKl9+b0PJvMP7Hktn9C16JDR1B5MMDM20oV+xXaa
	 DoWuEgJCqkTZvJvXEsB85k+b0Q4r73sMLBdPKPKW1YLMA9EGcgKWBCigD6s9lZff6fPdU
	 nYAWuGjMQZKlW+NmDPICF6lZAH3sQdsvN3a0gRLjezIucM6wBELUPbblCWUhvPrTjJasU
	 +LV8ytEkWp3tum+2oQCjD98zNY36JVVwOuwtfAooAhX7PiI3+CZTJVsEbmLCsx2ESuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y25m9oM8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F7606A32C
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y25m9oM8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C591F000C1;
	Tue,  3 Nov 2026 21:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742160;
	bh=0AqaMnymT+75dPDa+7ziWwA8f5+T0x47R11hWshCZRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y25m9oM86KGew9LlM7bFF3Z29yVNaQCzujW1eOjRzd8TGLH0rQx0axGdB9i4uVOVX
	 hOTyPcAivXhQ2qfuTg8XLVOLdruaamwDBwzO8XnG0FSdmJdHUFrgmCfuYgwJH0c5xU
	 /VNfBSouzJercRPyklsrfwyQjo8jzQawfD+aVQXGG7mh6AF6oZYmjJVRJI+GQ5eeZ/
	 DUcX7w2H3JUYtskZR41jnl3y1LKCc0b3ad3jZEdR2FIjzjI+bXUfYJvsD6xqu+nDph
	 YwPrm1Ve+Zt6q9I/4wUP0dYWdcnPCCS9K26qtnIQbGW6D0PGSrOO/UheFFG1bB4dJx
	 qP9JigvRhw4aQ==
Message-ID: <sashiko-outbox-196068@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/12] serial: 8250: share the RX trigger conversion
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-3-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
 <20261103-submit-h616-uart-fifo-v1-v7-3-c9e248d685c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 21:42:39 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Drivers can supply receive-trigger thresholds through the RX trigger
> callbacks without adding a legacy port type to uart_config[]. Extract the
> threshold search into serial8250_bytes_to_fcr() so those drivers can use
> the same conversion as the generic 8250 implementation.
>=20
> Keep the implementation in 8250_port.c and share it within 8250_base.
> Include the unsupported-table check and preserve the existing nearest-low=
er
> selection and highest-encoding fallback.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-h61=
6-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com?part=3D3

