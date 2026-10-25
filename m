Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894333;
	b=nHQPSnobNXDHODdrY86gwMsfpYCy9hMpSu0ANkmoyYPJqcuOdbRQb0i3X4EWZQbDpNK4
	 QUUsV69YZJyG5HRdKScOIvDrOvJuoRzzNZn60yFgcZMrHpoz8UUdm3EOaMwNcx4KOTJzX
	 /3OWKrHVqhfxX4gjttLOymCZHt7xsuMOKe/ecUoJ7+jMGDdBM3mxu1IRgCYMob7RANHoK
	 +F7iCTVHDRRN3HD4LRQJrdXhahespp1oaEIhFYuNiy04LEfLBe3byoxIVoyb35sxarKSD
	 XhGeC8uU6qokjcZLpMe5csF9im2vLauRa4AtHHC37Uq7COa+IFrGYu/TW6qY3K5Wcdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894333;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wqcb5eGRYzUQwdH2A5ceNlU+q296IPPyOuRgh2NrvcA=;
	b=BBvWCprAxxg8z8Kq3JOQalNXiq8m2m7z9WHmwGkJhOZ535C2JOUDYynwYG3OgiHrYMJ8
	 0RU/2saC+KjxtDk8S8TzcDVDbX+ZrjxxeIj+R+C2aKId06/RDG8d4kjY57ULbIoiEvARB
	 ddhRPyZd55GNOzWrpmYDZ6t/3Xxb1vfbf7lMIyOIIqXrs+qAgVnbsaZQSl94euctUOobC
	 hIKvZTkSA+hRN6RDtt782AoyCVCRoiQof/usPvGCARXjz1/upLcLK5Y0dSFspwZsdRtD2
	 7W2uGeJ2NfZohw76QMUiS5X0LQDcX1VbwXx10vJn3aLkJ5nHrtAU0q86laK9wOD/MnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rr5A9tLf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7E8606A31B
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rr5A9tLf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB761F01825;
	Sun, 25 Oct 2026 02:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792894333;
	bh=wqcb5eGRYzUQwdH2A5ceNlU+q296IPPyOuRgh2NrvcA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Rr5A9tLfO7vMlxLraE3i/Ae+I5chri+96XbTOYH31cqw0NAwNEPxkP9drk8T0Qeox
	 NeqFIkyVX1EZFQW8CbZMljTW9Ufb0n7CPmKcB5DEqdLnCMU0OJOpwyHZdHQxy+gHAE
	 JwwADrf22U2EBf6Uh6X09c5DFY41fES78kPi4boyhtjVPyECYfaSU9Bo5ctzJpd0zD
	 wPYDS0SnSmX3WAX2oZZU25PlpDNB31usZ2j00WAiip61LxJq+erXey6xWSMwj/gOq/
	 SaM6loxZwkJJYQn+JSGi4+EKDjuOY9+oranf7+zzkbDII7VES6FmCUZ4hoADm1XKjP
	 RSw1zhbAk9quw==
Message-ID: <sashiko-outbox-183980@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] platform/x86: dell-uart-backlight: Bind through
 normal serdev matching
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>, linux-serial@vger.kernel.org
In-Reply-To: <50556466ff036ece9b73f7088deaece5faf4e59b.1792856688.git.an.wu@canonical.com>
References: <cover.1792856688.git.an.wu@canonical.com>
 <50556466ff036ece9b73f7088deaece5faf4e59b.1792856688.git.an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 02:12:12 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The driver creates a serdev client without firmware metadata and
> force-attaches its driver to it.
>=20
> Pass the modalias to serdev_device_add() and give the serdev driver a
> matching id_table, so that the serdev core binds the two through normal
> matching, then drop the manual attachment.
>=20
> The client now also reports a "serial:dell_uart_backlight" modalias to
> userspace instead of failing with -ENODEV. A failing serdev probe no
> longer propagates out of the platform probe; as for any other bus, the
> client is simply left unbound.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792856688.gi=
t.an.wu@canonical.com?part=3D2

