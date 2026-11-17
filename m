Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959338;
	b=JmIukOOpqbvAT9eg9hSSohcBnyujGYIHV6raNzNmMJhOp5OW1GMAZ/+A0YPk/4aTEt8C
	 BxvfRuZmfYh2IdJ0sy41fOQhATRRXX3xkN+1qKKI0RQtGzgtrWQKYHYuTgRWWoZ0C4zQN
	 Zn79ugLsoZflYnex15kcp0D6ZpuoqwODX/NW/8vqUvhizSW9lK5t8vPpTEe3CXscqdJrh
	 QnIIHPvLy7CL+Xu3/+ESkMc8xfXDewwxrNsVJz+awe+Z8vPGyE4zdwvAwmP2ts7npUezJ
	 z0CywTJIxiQB1FdldxHtyito1eTDS2SfO63b8QjwspUiXF7Y7SedMsi+sV8VED3Onfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959338;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Mjjnfin8ESoOVivnIaD0reLQ+FOjHbUrfp9chd+m20A=;
	b=KGDqG+bXnLXrRl2+sLdXYMj6K0tSg7VXDshANYMHwR8u6A5wy1yoQenL26RTlR7jxJN3
	 I4WtoKtWtqJrY81/HeYH7GNQ77jnLTpSwot15x6R2g2vNhvTiTtzUjrQ41COrHQmHPs//
	 H2ARINZhEh2PSuPM/mXuf87VSgm7IsmwqDLSTjbzRAb4Ls4pM+/uKwbpnbrXGmp2j0djG
	 6pKFxwAHy0M1y1PNCr6Cq3D3Teqdt5Xz4EPQFpWDi+FfyFya+KHda4LLHpJiN5lJ0PIGn
	 85/3dGD4Zna7ko/CO2MlBl6ob+ykGAPs+f8o51M50+sP69YdXiR6rlHJ4MqutlojtzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZIhA7BZI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA30606A32C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZIhA7BZI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63E21F000CA;
	Tue, 17 Nov 2026 23:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794959337;
	bh=Mjjnfin8ESoOVivnIaD0reLQ+FOjHbUrfp9chd+m20A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZIhA7BZI3yzHHU1h2/Q8Hs+DPSnRyQxe2uROmPSquUh5G48lyFaz7d2JAh+RDRHh3
	 fPRtJMobI5aPhBsBKYTkTAeh1oAZq3LgUfFVCYQe6BaNhAkaUCvTS3dt/xOTtVVJw4
	 GMmusFvVoX1k+zG7cuSC01kO9YxdJrEKWPO7CMHelpB6zJKUobPqy/Cb1FMskb8sep
	 l8837m1nH6OFQI5URSmsWIkN5+a7IvEwMZl1R4Z2giccWOYTZDOlZWPZU9BHduT0UZ
	 uLiCMaBeFEePoVy6gcnQQw3d+SQCEJoXd0nfS67fDaG3GvuKsaVLPR9dYyDqEh4c1a
	 fOu3QpRePLNtQ==
Message-ID: <sashiko-outbox-219813@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/7] serial: sh-sci: Skip TDxE clear when hardware
 clears it automatically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo.sx@renesas.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-g2ul_sci-v5-5-30b58ea18923@renesas.com>
References: <20261117-g2ul_sci-v5-0-30b58ea18923@renesas.com>
 <20261117-g2ul_sci-v5-5-30b58ea18923@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 23:48:57 +0000
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
> On some SCI variants, the TDxE (Transmit Data Empty) flag in SCxSR is
> cleared by hardware when data is written to TDR. Clearing it again from
> software via clear_SCxSR() generates a spurious TXI interrupt, causing
> the last character to be transmitted twice.
>=20
> Add a tdxe_auto_clear flag to struct sci_of_data, propagate it to struct
> sci_port as has_tdxe_auto_clear, and skip the clear_SCxSR() call in
> sci_transmit_chars() and sci_poll_put_char() when it is set. Enable the
> flag for the PORT_SCI (of_sci_sci) variant.
>=20
> Signed-off-by: Au Dang <au.dang.jx@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-g2ul_sci-v=
5-0-30b58ea18923@renesas.com?part=3D5

