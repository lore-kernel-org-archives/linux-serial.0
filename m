Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280609;
	b=q5BFBAu+6G0kSYANUUI2KjnMfo1SdHmLJusaId43l5GiI4CMYituQc9tDlSvQvy5LsDQ
	 BAjMg+xQc3KD0n87zxWbTCjlElArWC1lfaHD/IISKS8q8cGhGAEiwx7MD0UONof5foH97
	 b0BwhpBC/njsS77bv143QUkWeQQjN2CvEBr36w3cRyxjy35peC1kL/LJUGEDZo6EeZUZ5
	 IBAJ5rUiQJKfH5zLvpWP8pBr8AvyOYAsESl/6RG+mWbBTDALVVgnUn3Y4CpIERI/a5LQz
	 HkLLa08m/EZhUnCMWdd1RZQf3ZuEC4IytfnjdWo5UDoicBXWKJkOdTf8p1UEgDLT9Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280609;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xnVnHH5tH3B4SOffD/JDTmmsX0ybDEU5EO0NxxGXd4M=;
	b=j+TlJ3zUwkvOEyyMzha91ezL1CEPlJWQb3uN3BcvgIcJDgohFaEdl0LSPae4g70hUZ1l
	 B7oRleqlpAwFAy607MdiCOJ0y3rdeeHO46FWGdAZHMB8EeWiQeohTSbTZ1OMEw+YyrxKw
	 xT7QR4zzNXITYOyrn33DlhmnSVL7yz+Dm8Bwm7JdvIYLswUf5bFljWjD3WMJbqUbmBrVy
	 XFOe88Ix2q/ydzaQmKxzBYOsuMGgV9gQNIgXX4cc6VeNpeoWY7iYzbeZUISJN8p6MhpvY
	 AbnRk+JkmQRLrOXqVWCVGA20s33w1x2Bf+2Xmf5aJa5SZsBY/Vj5P30JZ8o1vr7Q99Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5eD2zDk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A319D606A31C
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5eD2zDk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E101F008A2;
	Tue, 10 Nov 2026 03:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280609;
	bh=xnVnHH5tH3B4SOffD/JDTmmsX0ybDEU5EO0NxxGXd4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T5eD2zDknh1R55pF+FjzwUsk3WbF+bFrjOaZAyrx1OOpE1gBd3sANmR8rr2ZqSnzl
	 ohSDeFFmGXO4osm7pB97f/u3wnJQVOvMgEQFiNE/lWqUW1r6cKGooZzdIoUBZBq3vP
	 F1gnPgGak5ybCnK4i3IKe5Ga30U0+NrrjPvZVFjR17fuS6WS2QnLz52d9XqrlFYPr1
	 RiDQQ+uFEyEMBWIeVoHaST9YiaRlF8dqCVwqNHyMOONmUx1MnUaabgcCnzNNKh/kWO
	 a/jK7Ci8keFI7sQUqhyBQA/cGrGU7eOk1Mco6ouczDBIS4R2gk0ZTfgeIR8HJ8Erj3
	 U4CBE1iZJcg+g==
Message-ID: <sashiko-outbox-206100@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/11] serial: 8250: share the RX trigger conversion
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-h616-uart-fifo-v1-v9-4-3f03961dae8a@gmail.com>
References: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
 <20261109-submit-h616-uart-fifo-v1-v9-4-3f03961dae8a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:16:48 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-h61=
6-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com?part=3D4

