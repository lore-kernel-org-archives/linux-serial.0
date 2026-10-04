Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E240B672
	for <linux-serial@vger.kernel.org>; Sun,  4 Oct 2026 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116740; cv=none; b=Z/jmiBqP49wJE88bpm/d54K/KYr92+/y2P3KbqoBjHyHYSj2deu58RqIh6GfPxE/BhkQ/qq45xljjSXBBahaimMRJA8iKMG9cgPnk/AKvlISF2+DukIilTE3m+u8vV3cKnOiDXnTlojGqId18kwDx5st3FGS2nKyGUYlhiYNxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116740; c=relaxed/simple;
	bh=s8lBhiiLWw3vyqraGO/ERVzatCRRKz1x9YVtMl61yLw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Veuh25n5QVyWI9ruSEPkntJfPtvcTYPYe7WZZbHgbvBQnLJZHfO0ViQ52PDjnt0ne0R5XmBQHs+dyEJ+KXsOlvriAp3Uo+SSaqInusbvY0y5y+KpxPctfVn037w8FcT53KnFX4nOt+nWJN8eCGgpYmfiRJSIIzIjaAEfUoKE+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WItYKLOK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WItYKLOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1771F000FF;
	Sun,  4 Oct 2026 12:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791116739;
	bh=s8lBhiiLWw3vyqraGO/ERVzatCRRKz1x9YVtMl61yLw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WItYKLOK66lcJAxCzSMOktwBwemRjaUBMtk13AN2Up2KpOFKLc1qqBsq2e8cW3blr
	 FCHpL6DnRjgzZsTPTemv9wixQ5v3JuDlepx+yWbqzamYrNUw3iEY0+TdQYNl7Rrxnn
	 O1YmWwZ1CrYjhNEoApCG94PasUk1VdGUHVmSbxN6jxNUJXofvKIuYrY43fcQFNceUd
	 nJ2B3usdhu13l3MBAwUcGKinbnfW6ASGACcRhm73UVsVUwK4/wU+7z4mh5yn9JSUV7
	 5/Kb+AOkCjcHp0y8xz3lTqXnP4YcrzSWUt9GDBhxbzzLMM1sxG95dlCSpnMjc3il6N
	 rziG58Qqngfsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/9] serial: max310x: support active-low RTS on the
 hardware path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-6-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
 <20261004-max310x-rs485-sw-delay-v6-6-3a0ef13ed9e3@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:25:38 +0000
Message-Id: <20261004122539.2E1771F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The chip's auto-RTS engine asserts the RTS_ pin high while data is
> shifting out, so a transceiver with an active-low driver-enable could
> not use the hardware RS485 path at all: SER_RS485_RTS_AFTER_SEND is
> not in the supported flags and the core normalizes it away with
> "invalid RTS setting, using RTS_ON_SEND instead".
>=20
> The output stage is invertible: program IRDA.RTSINVERT when the
> requested polarity is active-low and advertise SER_RS485_RTS_AFTER_SEND
> in rs485_supported. A break already drives break_state onto the RTS
> bit unadjusted, which remains correct because RTSINVERT inverts the
> output stage itself, not the register value.
>=20
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-max310x-rs=
485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com?part=3D6

