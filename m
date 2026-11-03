Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742401;
	b=riN+6bSUF5M88YUdh15384aoWfOykj/RsR+Jy3U4TEOiMSweTj00BV+ToQq1MenEZZOm
	 7pYoyCppmGN4h/saFnVjzPQnVKy5rpdNfJAbf3cpd9Hv8rp38reLHq1qJ1hidrUE4rtcj
	 TnkM/2moVYFk5012kkz2SuwwAGUQpmyObvsBcp0M/0u9F8c8nH2h+adkveOKsotQ8CTOf
	 dxc+mJBiRnJ4WmvhKtMulnx6owOIi6Pk3JRU0Lb6jyLhkMg1bdx/6AwDcRycZXJBY+KSk
	 BbBhryLjFPf8JMS8mvCXkdo/Gwi+c/c4IYi2d7Yh1YNeY6u4qKgFBuDm4diWZP1Jb3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742401;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YsFTjGHyMRCD0zo/eJVi1kradPFeQZPUyteekfGY5Ms=;
	b=qCpQYt9wDu8Q8vxQ7Bnl6dfcEKUMQg7Scw7081Tc/iaZU4pEeM9rhZVRZchB6t3OsgUo
	 OcQQxxkgzMVs8IP7AA/rZHx5cR1epE3kJKdFh7+RwVVvhoSzilliL+c03i85LxARomtxG
	 kfg8DS3Iv5Npk284ww/xq9lftzGaot9ofJvt1iicQpOaEW8fXir3YQfXG2YN0jcBgUSsG
	 EV+7yEi8m1XnYYY8dAf1Xkz4Dp+YpW0Rm51QkbgC8SEyK4LTjRHmfRypC9swLR3pgFvK6
	 moCa9fQVJgcyqRZinhwIFcyk73Nr4AWQNfROXlifUj3lYkH6XuCctXlrHNBuuYRyB2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6zvOIIP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C248606A31B
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6zvOIIP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4121D1F000C1;
	Tue,  3 Nov 2026 21:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742401;
	bh=YsFTjGHyMRCD0zo/eJVi1kradPFeQZPUyteekfGY5Ms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S6zvOIIPdGnLw4Hinnbu5xAICfsD9ez9KdM9VbHdkQlAp3DjBjDZKW/wOOi0mYxmF
	 BDk0uCm1DwcI2kGnRcj0TFNaJTwsdV4+rf02F1fS7QkTOdR9zOIzl5c6DcfzD2UhPP
	 aWGAMdmUNd7G81poKgWwz7Pq8K2veKEy2H8Dbog/TWTLo1wrzZRshWzRsQP4WXpguI
	 tgmEtJaYmWZ8XEF92n7qhMpTgle5DfPfVcEIxFPQ94nCdq0di3DU9jFVPYxF1popf2
	 IYqkuj2+VPFeQXTty6z9PIoSMo3ZuzexMfnFkoNe7EOMMvltMiN4DsjZf2siqWYrqQ
	 mDuiSjzvuaEtA==
Message-ID: <sashiko-outbox-196076@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/12] arm64: dts: allwinner: a523: describe the UART
 integration
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-11-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
 <20261103-submit-h616-uart-fifo-v1-v7-11-c9e248d685c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 21:46:40 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Identify the Allwinner UART integration on all eight CPUX controllers.
> The specific compatible selects FIFO-depth discovery through FCC,
> allowing the driver to derive the shared DesignWare receive thresholds
> from each controller's FIFO capacity.
>=20
> Retain snps,dw-apb-uart as a fallback. The common SoC description supplies
> these UART nodes to the A527 and T527 boards as well.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-h61=
6-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com?part=3D11

