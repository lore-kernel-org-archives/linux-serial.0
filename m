Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721391;
	b=qoV9xjh709MVejF17NWmWxWsE++uMd0BtzLneA6YBW7XTroqkt3WtuHDschvRk5eIOVu
	 i2ngtMCsMqfxioYbHfBPZgIlRHVY8LWcv1EdYrJ5SxJHrdkDXVCrDMypXf4Ftb4j4Orub
	 v4WTke7qkts/W48ZOXr/Kd2LqciCDTcpkXkVE8W7mhMnXOe1vL27XlCSZ5IpEgyj1IQiB
	 M+75wl4qfuf8eBMURyMkdWCS12eWSwMqiF5m1O9NXFgSTnMnc33Df0uPKs+DRoieZOCkd
	 wGtqIVnzsJ8Iz2PcYp1babQziRkHFutY/EikL4YzUQS/z4gtRrVtt/5r259yx5yRfOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721391;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GRIvEc53bYOBdRIcqHHzxvkWodoImvqIEm6mnwvH+/U=;
	b=PuBNEzJrVIXxyH9YcN/KwzISvdlsvnBC9Yymi01Y35PxyOlNzYYNg9MuYwoxqQgsVP+s
	 o68NMNjgY/eqduOyJVhqEUkxs0G7bkuVYY/bNNGzVV8ei5GTF46vIZBuqlH0sUXF2RDW2
	 AI+rElUROFKfL9iwoEt9uXk/sbhgruwc4NeTNU31+gu3/tDzXGYC3eA4SznmQRKlqb2ab
	 XwKGnEuWiY4ZYxk241NZ9uAZVfK8a8S/l1AmP51oP9iA87BN+l9BhyfCmj2Q3h9oslnW3
	 OKxRIEhT14pnziQS9oE/ywcgS1fmA4JuTd0czEZkTtXr06gkewac2b04OIO4Lfx34Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsgMWxlF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83817606EE9B
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsgMWxlF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7231F00A1B;
	Tue,  3 Nov 2026 15:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793721391;
	bh=GRIvEc53bYOBdRIcqHHzxvkWodoImvqIEm6mnwvH+/U=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FsgMWxlFXJSOTF5X+rg5Xkd/t9bZbBgeDUezqeoocPU034Y6JHE8/EWwKybTo97l1
	 YpHk69xBCz2Ag2EfQ1pTCVdSqormBvXK2uHtQAGiu95Q97P+fKwqJRSW1a7pgg418x
	 yJD79xf8gAwLzK4DWnz16HMDMB0yTMPa+og7Kjqa00dYZEBWUJVJAXtjMcKHbAXgtW
	 wCv2glzkVJbzaeo1VWM9NAHZPWjBGoy4fgoZ5RwijEUeuvdnlkPmvvx4KnbFx3Pfsv
	 0EOh3SJhKF+zc2MgL0iGUC3i3i0O2ehtn5/FV3B5bwY8T9eSux82QbOETt+e3UaBHK
	 5QBlZxglcGRjA==
Message-ID: <sashiko-outbox-195666@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: serial: fsl-lpuart: Allow
 wakeup-source
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefano Radaelli" <stefano.radaelli21@gmail.com>, linux-serial@vger.kernel.org
In-Reply-To: <51b4d26521bf708d7f74f0ccb49fbe515d673ae6.1793719239.git.stefano.r@variscite.com>
References: <cover.1793719239.git.stefano.r@variscite.com>
 <51b4d26521bf708d7f74f0ccb49fbe515d673ae6.1793719239.git.stefano.r@variscite.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:56:30 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Stefano Radaelli <stefano.r@variscite.com>
>=20
> LPUART supports waking the system on receive activity. Allow the
> wakeup-source property to describe ports intended for system wakeup.
>=20
> Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793719239.gi=
t.stefano.r@variscite.com?part=3D1

