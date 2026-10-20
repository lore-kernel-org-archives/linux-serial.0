Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522146;
	b=orGfyCx/TGtFdb4Wt1CP+5RsF6fiPUcIvAMpk2UcLHx1n059cdIzZ8FA88oREK9uN2P8
	 wDTDu5QZH7UY/nR05WkRP7Ig66gwwM62XNIukEzEVYRDWV+ABv/MW8BnsGVKAZNq/rQFT
	 ZueNql9wYnpjV01o2h7CIGPU5UX3AdE1wthQ2n7ViO/7MwwvwgRnZtZM7tbqaGV1uHveh
	 sl7FaSsfH5m96pmqqtD/W4nCrB4B7K5iDy7L/umTDKjMA+O6ocBEvewSFhdHnHeNtrAeT
	 4EMJR7L69320keTFFqJFvmZrD4DJ/nI1gZ+TK/lZVIza9ZRHc3yFQLtF/Z89IAORqKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522146;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LHF+fQP22v4n95DcJS3E1mVFCGbWT5xp0P+9DmGc53E=;
	b=Vho3Q6s4xUG7vVDuu1GFpY9ce3mDQhpamjtTqbmVZ1DuLSotpNxgbi88Jpi0k7S6WIqO
	 mDR79XUZhgkSsBYThl9YOgFkwGMAdtaIFl8ud2/COO/tipMsVq296Es2P5agoE3LXpWwi
	 ngFQkkJiPpmox0a+o8VF+xDP4P60dt2Q5Cn3WpmqV1g0XTsvYXqdOjTndqiqRiYDmw61z
	 fnevbfoER8hpsAfO6F4jqWoEGyyJQ8fPX3DUolm5pzj0Pg12HBjvfyYLG7V9TksO1XAWH
	 D4mlvorA0NlkbaXKJm6KZfipOHNzc2QPLYTCcCFjkqYvkykwydl+SY1dnLVgNUdqp0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYd0Ztdk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6A1606A31D
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYd0Ztdk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586141F000CF;
	Tue, 20 Oct 2026 18:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522145;
	bh=LHF+fQP22v4n95DcJS3E1mVFCGbWT5xp0P+9DmGc53E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AYd0ZtdkBZmgwOiuDLw+LEDaQ+B/Fg/FGxvu7g7OWO5nSv4INR1FR7YVyxPvWcXBF
	 cAyqnDCK5kayCWnXeQDt4Olw8joe/R39x1uqKA4VwHTHhgZ2Hu/7x4DL/tKIzEWq4P
	 +JLLWmMtS46l3ZbByvhmSfDe2KCU5BDoc844zDnTm4VKDfBDbvdT/GBfLb+deJKSIc
	 a3K5t8B3qVhODwAVjXiUzEMo6IMZejQVWP2ojon6MF8W9+xex7s5LsVbYfT4wbxg06
	 hV9/zZz8MwtousC5POlHM7o7XkVc4vtATZmlLNbLt4gPp1GgYPBO5Zz/CATNdyK4vK
	 5w5hRZ570iHdg==
Message-ID: <sashiko-outbox-179494@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] serial: core: clip out-of-range baud rate to
 min/max, not min+1/max-1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hugo Villeneuve" <hugo@hugovil.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261020184131.2893575-3-hugo@hugovil.com>
References: <20261020184131.2893575-1-hugo@hugovil.com>
 <20261020184131.2893575-3-hugo@hugovil.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:49:04 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> min and max values are valid baud rates, as the existing code in
> uart_get_baud_rate() already checks:
>=20
>     if (baud >=3D min && baud <=3D max)
>         return baud;
>=20
> I couldn't find any explanation in commit 16ae2a877bf4 ("serial: Fix crash
> if the minimum rate of the device is > 9600 baud") as to why this is
> clipped to min+1/max-1.
>=20
> Also, Sashiko identified a potential problem where clipping to min+1/max-1
> will be out of range when min =3D=3D max. This would result in the loop e=
xiting
> and returning a zero baud rate, triggering a Division by zero fault.
>=20
> Fix by clipping to min/max.
>=20
> Fixes: 16ae2a877bf4 ("serial: Fix crash if the minimum rate of the device=
 is > 9600 baud")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020184131.2893=
575-1-hugo@hugovil.com?part=3D2

