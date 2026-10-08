Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D571476688
	for <linux-serial@vger.kernel.org>; Thu,  8 Oct 2026 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453604; cv=none; b=H9eFBVjfg8QSLPc/J4ufELwOlZkyicPPlEsCx/2JMfDBSpOMj8Zc19t5oAMC6u2M9hA4iRjlojLaP4b7qE30qNVjVuKAOCgndR/NM3AJw5qhrj16sYbUaEKCsTVlCEFMKbhfmCAHca1aQx9+xG+PxjALoYA8xfMy7vOZhaaa6GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453604; c=relaxed/simple;
	bh=B+P5yrHX9DK6fy1v6W3OTCpiAcnFuqtIqV40zgndZHQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ll4U7DT4M+OjfVVntW4yRm9Xxj2Y1CPUDhgtVUC1/ZJkzmZopsuaASGjJTpx55HJLDBLHE/vRfFfYh2UKecEpQ1ASZa9eOiJ9Kn3p1ZCU4TBqWkzcmB/isG5FhLIUosJ9Jb7b62TMreeh6OcMSr8/yX2V/xDRCJzmKbzp4hFhYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLtsk0eO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLtsk0eO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C959B1F000FF;
	Thu,  8 Oct 2026 10:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791453603;
	bh=B+P5yrHX9DK6fy1v6W3OTCpiAcnFuqtIqV40zgndZHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dLtsk0eOkv7llNEHZIyEHjHLVDXuttVTi1BZf6dkpYbmTMEP23qp+WTHbYEm+/UCb
	 +rHKEoOXA/70WVNIGMlOJBZCG0XbA0Vu2J6Yy43fiUWRgvTyFlWe0/YBrcRq/QwUlU
	 PgHJ0LDk7whfHw9OqMHIde6k/nIxrXX6jCRLakH3Pz1Y1qgjSJCGJ4UcwF2kFcWFQz
	 0pGjOreSADmv7UdjM6pwvinBb+2oymOHnLf3ptd8riGST2PgrmEhK/6loWtasuIxgr
	 yLclH9y5rrTOAUOyGJ2PZtXMq9LuMeieQJo9UBVwF5lNTu/pFJBuOquqpQxKVtEsis
	 m683vBtwBaMjA==
Message-ID: <sashiko-outbox-163976@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/9] serial: max310x: support active-low RTS on the
 hardware path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261008-max310x-rs485-sw-delay-v8-6-6ba881f81e1f@vaisala.com>
References: <20261008-max310x-rs485-sw-delay-v8-0-6ba881f81e1f@vaisala.com>
 <20261008-max310x-rs485-sw-delay-v8-6-6ba881f81e1f@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 10:00:02 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-max310x-rs=
485-sw-delay-v8-0-6ba881f81e1f@vaisala.com?part=3D6

