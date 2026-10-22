Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685581;
	b=WMdQhcBWA6udEv4za5P6Pw2Y/R64T9I0mA9//zFiXMXso3p4Kgl/Vgor0px3GvhOlpR+
	 PIelMKu9ZvkbHa9EtKhBB0fAQokTsRa8QEN1VchZg8mutuk73N35Sx8Mne2R0NszXnP+w
	 mTSB5uwZImuRvp4UhUEya95BKJSt1YRomuFsRMPWmmkMH1us/W69eLKommNnJgFRXOICF
	 c4RrgX2DERd2JEcxk+ykuAtbrCxZI0+NuGnP15RHk11lfOauDnsC3TGnMBFSRtSDnpBHh
	 coUIN8H6HPyNUM3J7h+XU8hqXmD+AGOpi4s00Q+AqeqEgSyunlC71tPvzNb5QP4HZTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685581;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3V9v0pYatQ7CZVbfXltOYihhtE393aDidZC4VG7Mx7o=;
	b=o5q1dHzIeeIQ7rRW+PjZ9uptQV7r9L4CQ51wMT59zy6Kd+uh2PWXaRIp5hC06UxVk0cJ
	 sooudUV8NnUCIl4casBZBOuOGtvuNS0o0UKgY8E4HmcM5x2r4krEE7SnDGt3QIBkVpqob
	 Biy6IQY2IjX8rwgGJjUMW/HjKqlluEdAIhC+nigIIhPPRxJwMl6jaL/vYaSEcQeQpdChL
	 gZ+v86uq5qZuAj+ug4NU17/DGCFiI0CKJ4ovpi2TIpR4wRzrG/z9few+if7Fmb2/FeB2N
	 I/3jBuPF40BKprpT8ZfAfFCcRkRNOA2XDiZZsvKJSyK5bD04zIkqlizpmsX8ETLVmwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MOzAdqYe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FEC606A31F;
	Thu, 22 Oct 2026 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MOzAdqYe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7041F01825;
	Thu, 22 Oct 2026 16:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685580;
	bh=3V9v0pYatQ7CZVbfXltOYihhtE393aDidZC4VG7Mx7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MOzAdqYe134y1T3K/cgJTZvxWuGAsdYWr7dx+XJNfwG/HK97u7gN6sUF7jMDtGhsi
	 8X+vj6J+uY8U2KDFXrd0h6Dqo1mf4DO5sk2sLIbEpFxDhjrP02AIwvQDnNirkUE5Hy
	 tej2H7wl4QHPCMK6EOhu3fUBQJTzinr5Ag+rLsbUr1uMxTNtWBayduIGAqfoajxTb3
	 mZEYvZqc5YHraaHyu8KjA4JQ8opIpbCg9TwShIkHRE1emBDbg9fgFPmrnn27Uwu5z9
	 uLgyX6+WESSHltkxtfP8rVCp10D7yRSgFaWEKW2pLPauQ1OWq0Bd1RXGTmgeR2yEqU
	 P5ZrxDtAL4ySA==
Message-ID: <sashiko-outbox-181767@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/27] dt-bindings: soc: rockchip: Add RK3572 PMU and
 GRF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-3-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-3-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:12:59 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Cunhao Lu <1579567540@qq.com>
>=20
> The RK3572 PMU and GRF blocks are system controllers shared with the
> clock, power-domain, and USB PHY drivers.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D3

