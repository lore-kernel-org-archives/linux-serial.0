Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599764;
	b=a+Fh/YOHfa22UajhX15bEAE4sfvX53m8IpTuQiwoZVYU26EOTLs/9GGRLAGOVMZmWKRv
	 ROzu5kUojXk3vAF94olJkpSVhBwhcIyK5M81YVAYoFkubwy0V5ds5XS+rm9vC55xPJjlS
	 diHNzQD50XAHjDU1IQ7LUWOfA1Rt0JV2A0vxDIdHjcxqe/YQLDU8VwxzpXiuycY6/Cx0K
	 VEcGa6R9JJrdvtPfW/SIIwHs14eun+SidCH2M5z0OLckJzu2075enrn+XSB9+teHQF21+
	 AOPL97Xd3XYjPCbDF9v/vGdSPZoKGjGmwsga4GlJnsvBSyNVcVtKEdEFBtTdC5JR2oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599764;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gRwoaPfKjoIi4G5wzSwuNT9dEFSNSiFxi50PQTjjnJM=;
	b=feQO1fHhXxY3oikYIE1Px5s3CH8W7uoIOESSGtC6vPE2YWnGGjDQWXrua6FWWe3yXh5C
	 tpigO2lO36/myMgS7EmG9bLdnZlFnP0Di0V9KtU1QosGfN0YeTildOgObfiYhMXQ+Z+Wk
	 htRoD4laIVxy59/jbqpFuHZPr9cYWbaje/AwaS6ZEbHcnZYWFv7iZ1A4m+GmBDyi/lnsF
	 6hz00ame3K1T0/bITAVzqu7gT8/MoR+WnHojE4BZpXDe9lNkUX89aVxjqJwgYaFXI4CtW
	 ciL38OxC2ykmrwn+OB3yJhx8r/ImyV1trxhxYRJdsTPoJlOObdUpoGw6yd+2OB2o9+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kxlnC4UV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812D606A881
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kxlnC4UV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6B11F000C4;
	Fri, 13 Nov 2026 19:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599764;
	bh=gRwoaPfKjoIi4G5wzSwuNT9dEFSNSiFxi50PQTjjnJM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kxlnC4UVpz4OH6fo3fRO5MEH9U+iGz4MLrHozyJbQmJjG+NNlJ3U9hKn1jARdRc9K
	 TNBBr8+dcaBgliGQ1Kf5M6cfSVJmRpQY8xDMtZyvrgEOo6985033kINe/GTdmeDC08
	 7wybpgBdqw8XsxtdmEJXrUwXqpNRjtetja/bYsv8V3zCpahmyqy3l+a0KnPSfhq/gx
	 SukncPxkoJRFl/IdVpHJDNcJnVrIKNU8wcbMki7t3KYSVtdekGS4w4Pn8kT3H2xVUi
	 6KB5gZhFVu1kpJaJuyclhI35edvZTJTz2Q6He7Q3xjqjd8vplRJZgLaixt1q3YuoSG
	 MF90nwuqw6kNw==
Message-ID: <sashiko-outbox-213591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/7] serial: sh-sci: Toggle TE when restoring SCSCR
 in console write on SCI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo.sx@renesas.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-g2ul_sci-v4-6-6815e41d90c5@renesas.com>
References: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
 <20261113-g2ul_sci-v4-6-6815e41d90c5@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:56:03 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Au Dang <au.dang.jx@renesas.com>
>=20
> When SCI0 (PORT_SCI) is the system console on RZ/G2UL, the board can
> hang at the serial console output stage during boot.
>=20
> ftrace shows the following sequence:
>=20
> 1. sci_transmit_chars() is draining the TX kfifo through TXI
>    interrupts with SCSCR=3D0xf0 (TE=3D1, TIE=3D1, RE=3D1, RIE=3D1).
>=20
> 2. serial_console_write() runs in the middle of that drain. It saves
>    SCSCR=3D0xf0, switches to polling by writing SCSCR=3D0x30 (TE=3D1, TIE=
=3D0)
>    and outputs the characters with sci_poll_put_char().
>=20
> 3. It then restores SCSCR=3D0xf0 in a single write. TE is 1 both before
> [ ... ]
> resumes.
>=20
> Signed-off-by: Au Dang <au.dang.jx@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-g2ul_sci-v=
4-0-6815e41d90c5@renesas.com?part=3D6

