Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795289176;
	b=e19BOzsO1nmlxbDN4Ro6XWzDWAZkRXBG2Nm3giqkTS6FLQWAcLkhOl2wRxsvfT1PHCB6
	 08Ixx5T+VP2L5toURv/z003gTiEH88Bd+1zvWk2ZC2WQ7JmidIt/7bf29zd54f2PceVsC
	 QP4Pe5r7yh8kuw9c2mA/VoHopE8Kw+dGxWNWPcaUrnJUBRHWlJ8qqJwd7jFkA3L5Dx/Ip
	 BBbqTZO7SajftfpQEXarbINU9xD6O/UF6ZzQ9kPIb6Z9WXbdQKk0AdvpkRklT5jtOu/q0
	 ++49ygUKYX3NRaaCRWythS/Ynfk4HSUTxzSBgUCIwjjZ4OcK5ALNLD8W6qSB4fu/x0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795289176;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4OuzXrJplElyzc0a0riK0TI9m2PBskZNW2rBmUVGaAM=;
	b=o3tO+MBXoLQr8ZIKNhTjFmh0dJjb8FB1Mz3BTApGVM3uYce6LI9Aozf2+HF0iwRLbziI
	 PY5i3kjekHtG5o+8LgclGJVvmJ595hLGzbKaOGLgOWZA+UIDgifVfOdHcsIlsiHW7CWIZ
	 mg1M1qI1ruAbENQcHYcri/b1biC4CNC4nTh3mXycQHINiQfdSUMoLLPNaueEeJpx4V3xB
	 uelXjjqcllvnUdxELPLJiMMaxzh83+0Qe9rZDfb8TbH+K0dP/kOyaqrHBzl6Mev/tUcqu
	 IRWjLyyFO0U/SFvj/smsP9hvKt5zA95MbZBbq+i6cHo46xEbDkjEQZW6MvAs5DIwJHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CpvN2SFj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A933B606A331
	for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CpvN2SFj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F621F000C4;
	Sat, 21 Nov 2026 19:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795289176;
	bh=4OuzXrJplElyzc0a0riK0TI9m2PBskZNW2rBmUVGaAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CpvN2SFjvVT02RYswUBERm7DqoUSG9aMn3aLdd5br5olIVXJSvFgacC5xvjyL/av7
	 /BJWuDtuSi3rL5XIf65y+8ym1xoeIjuiMRcdGnzPSKRM7GVPqYdcH90Zko1ebz1NRJ
	 JsrifBw6kaab1kTlpALi5sk4T8k6Rgz8lpD7EeZUPLnQ3kjzS6LwS5/7WdeHcooH3t
	 8tkFkHqi6n5ZJj46GrPZIB2s0+OuwhTuxLi0yFh014kTXo4cNdJyTMvvDG+o8G/ixl
	 jqnMUCJoFzsWTPGKlBopiixmDdJ1jNf0QeDAw6FSFKt0vg8Y7TALsFACP3Qd/aIoJ4
	 AD0Wn3ETsjtQg==
Message-ID: <sashiko-outbox-227303@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: serial: samsung_tty: fix -Wformat-overflow
 warnings for clk_name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bramuel Barack" <bramwelbarack89@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261121192158.44872-1-bramwelbarack89@gmail.com>
References: <20261121192158.44872-1-bramwelbarack89@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 19:26:15 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> MAX_CLK_NAME_LENGTH is currently 15, which only leaves room for a
> single-digit index after the 13-character "clk_uart_baud" prefix and
> terminating NUL byte. Because the clock indices (cnt, clk_num, clk_sel)
> are u8 values (0-255), building with W=3D1 triggers -Werror=3Dformat-over=
flow
> warnings at the sprintf() call sites.
>=20
> Increase MAX_CLK_NAME_LENGTH to 17 to accommodate the full u8 range and
> replace the three sprintf() calls with snprintf().
>=20
> Signed-off-by: Bramuel Barack <bramwelbarack89@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121192158.4487=
2-1-bramwelbarack89@gmail.com?part=3D1
