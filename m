Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649798;
	b=aemvexd+F/wLGoBom+H5WqPrCJOpMbynvCUUcMUXds7OZhmtPnijewRNw4NpfUbhKDI/
	 AjnR+rDbMglluBRisCVqX6MR//a/eiWm1pVdPwvlowjdNc0vk1zpOm361mMtzGCjqKp34
	 2oO97ay19rCNYb2sLsJj1t0GXjlN0aFvFD/3yRffLR6W/uwJl6zlQ5MG/SKRZFChGpOL+
	 F2Ykb6gaBF7UXuY6r6GiKYqXuiZr2duHC9hccPKRln1d4Zb0rk09Ew1M8Mj6uahAKg8BZ
	 7iZDlyq7Bdoq5TAj1HN4uk3Q94ogRuRqeVO6lV2sLPeqS84ND3msBHJLqV8X3BtRe3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649798;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Hyp8+rljSXdQs1ER/LzKYvKo25DKUPM8AdAgWjwTQeU=;
	b=4d6WDSUcs/Df8k67EaG1ofZlMtqlhprUW0ob2egUjQmIRgoksoqtvSxxJ5U+WiPEw9fu
	 E8/KRZftayuwgVp/hEh4WbaxxDW7JcTeLTym++leXV/9+AjH59EEoGb4I+lKIPE72tpBf
	 fZPLDF3jXWBi/7qUfgvsDrs3WpS0ahpCdsqcGe/FQ4lZ0ViqLfoBCf4FH3MZtAbWGxN+W
	 7jOdbvNGn8vNa+kOsaWtEw1T6YWZSyzx5cfzoNoL+3qu1En/P1yqDnXQ2Acc3ceIdKumm
	 VvA60I0vDhfCsFoEUOCwsPwPqsMM9nE6zSHfCCE97H575oTaZjFpZVCxMkSzkBkr9sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sm47B42y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462C606A329
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sm47B42y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C128A1F00A18;
	Mon,  2 Nov 2026 20:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649797;
	bh=Hyp8+rljSXdQs1ER/LzKYvKo25DKUPM8AdAgWjwTQeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sm47B42yo6NPUi85c1N1LJxRMnarbinVWiaPq+V4xXfFmxi1iciruPxf0+cn/9UDs
	 feAYWTvAmhqMQfP8FWI5svNdmoHVQpD6MrAr0bDgSu8IN2gzW2UyZUVHPISyf2TojU
	 jwMRIlR8ad68XZzREivdqiNYhiorxItZlpI84NMOeQ7P06IOq61XwqcHP60+z0zF2o
	 lMtLBAzVTPzjSn+As2U64SXoLo0lxdrfFO9IRt4FXLx1q23OcRNWxUR6OwxpbGcnDf
	 9fyNsUvSpAnVICU1K7jr24IJON9ALiMXAKGOL30kD4EFW8m5FdWdcXaOiV1PHi1wAs
	 XdXGGcDg8vq5g==
Message-ID: <sashiko-outbox-194047@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 09/17] dt-bindings: riscv: add Melon Pi V1 and V2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-a210-scmi-v3-9-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-9-ee6b31580808@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:03:17 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
>=20
> Add bindings for Melon Pi V1 and V2 with the A210 module. V3 uses the
> same board compatible as V2.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Co-developed-by: Han Gao <gaohan@iscas.ac.cn>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-a210-scmi-=
v3-0-ee6b31580808@iscas.ac.cn?part=3D9

