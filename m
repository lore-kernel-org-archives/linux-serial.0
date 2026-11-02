Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793651613;
	b=cx/EuEIoYYktLa3e3gyCmkwUpaFO7aK5o+EJEicj1WnKOc5mLrXdQhlUqo4LJCpUTYb5
	 mw63T2kBGPGXBUTR9WIFD87UEeyi/ReLla8AkYdvjDw1pDgV4HLwFznsvvWcUF5pv1uEr
	 60QUUIe6/+DF/QY+fVCN7PwY0/bFX9mJ+WqMrPgt+WAhtJjZPF5t7PxGiZZEbNv5yCj01
	 q+oxRzn9wsK8pmOLtDSmg3uoz3ejP+ee9tSJWyvb7m4c6MMU81n5dju91gl4GA9QQNZc+
	 PFLY437DvuCcwlZ8tolcpR5H7pIihLxg1cEnMQGjUQmfYIsQ/iRwrPr7YDGf1agJG7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651613;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WuKwFSWV6LvGrExrkqqCtLXO0ADqTGPe8wDTIo8pFzc=;
	b=rgSrMomhb3bNsMn3c+tOvX3mWekWRnORBJSnqVw/Fo4sfiTDh/mgSA1xS05iM9c47QHV
	 x/G+FPosS0Igw3XnW4mwJmub+SfFBkN7w16XBfyfrnAr4MWDDy3WXiT29bdIE4MBJROlG
	 lhnnmD8A5n2zWSWm2MV4fCgEK87o17oCE05D8HeuASHOGAMoO7dTzz6ZxHFQykRYqI5hI
	 ENcApaZV2boOKYuTFE124kMVnJ4gJCpTAslSAS+S7FjoOCDwg+HnFCwsl8gGXJKizDTu3
	 kXGtV01yv8iiB9Tu3aq6miNOpBovQM5CaobaXcrGhuvmLJ73WB2USi1osH51tXXT18A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idopEi1p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E19E606A329
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idopEi1p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AF51F00A16;
	Mon,  2 Nov 2026 20:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793651612;
	bh=WuKwFSWV6LvGrExrkqqCtLXO0ADqTGPe8wDTIo8pFzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=idopEi1pJnorelU9iZj9LU/G+Rl3nTCIk67v80RzgDGcTaqDmZHr0L5/uodGh9R/Y
	 XZzPVvhJ3eFCGMXUe4Cokq1anOjSUUxRee7vwBpH8Arw40DqeqgZJxBQ3yTfqSyx/w
	 kXGWhLWUPyAkEuO4T2qSypWkoJwc3Gj+z21TMkNjSoBhOnA583xh17X4192amqLic0
	 2VUJl+AYGrHczIk+KSQyqVxZKDSvKycW9PtcMfV9NYqaTePux8fmA/adtjEB3QqHYj
	 O+7dq/jebQHBX7HDNYQB69v3LlXXx6eKVVOBfj07npfiDTwRytm36EGMz5ro5o5tnn
	 ld0Dqsl3+5xqg==
Message-ID: <sashiko-outbox-194127@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/8] arm64: dts: allwinner: a523: describe the UART
 integration
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-8-25afcb346b0c@gmail.com>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
 <20261102-submit-h616-uart-fifo-v1-v6-8-25afcb346b0c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:33:32 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Identify the Allwinner UART integration on all eight CPUX controllers.
> The specific compatible selects FIFO-depth discovery through FCC and the
> Allwinner receive-trigger mapping. Each controller supplies its own depth,
> so the same compatible covers the different FIFO capacities.
>=20
> Retain snps,dw-apb-uart as a fallback. The common SoC description supplies
> these UART nodes to the A527 and T527 boards as well.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-h61=
6-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com?part=3D8

