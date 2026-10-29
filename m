Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250862;
	b=P1JH4w2nfwFi6tlOMAPMTiKHmI6KolNcbbvMs0d5r/YnIrLTTDKQJtQ913U5npEPlDb0
	 cpqys1OD1y9VOeuhzzaSZuag8oNs6OSBr/SYVyCUpDtHpiAzBIBf8vx+AYJoq/d5wI3+r
	 lqRaDbAVo4mpNnJ2mE7eKFCefK5XznMuktgBqi3BcfU5KKU2rFmqsu/NSF95X8/b/Ccbs
	 IWp83NcLtDiIYXiHnHKXsHpXZHSN7Ci+JIREkMoejtnSOPeb8j50KNGmIeRULvNAoTi2b
	 wKO+4PAmykTYi+EP6iBEBRCf8ss3Y9ebTW8kvgOu51u0bar8pZMNdsf1ohkxuf9BM5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250862;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=omiRTUTlFVjglWv/Io0mr75+Rahowk30lESPXj5/SBM=;
	b=Co/FRYSxK2kFWW5rye0d6CB4WMQ1hfnZlV+ZjgOOcqMedy1BDXqj07h8nUQgllv4zlC/
	 iorebKnRV1pU0Qz4tsjRj+SKvo7ejIoHBRl3CKkdb7TgN6qWBei7q9R4GNieEmgqz7vHq
	 kNPySjvdSk5EkFlho3TyMmFO1MDNz6k+/jnBxSHR4wiqpO3M3NxE9M0g86iXuqhJto2rJ
	 E8v08mLUkEIaWM8vH2gEzGASu1XOm4WTJm+BueNJm5zDVr10sdTBwuHVXyKoeuPX/j79W
	 2HX4+MSmK2URWmHpmT/XS26vRgSd0SJQCsWSTp8LBn9VYKmHwQqZaVx8lTtptm/K08A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oXCtSPmm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9048C606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oXCtSPmm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456081F01825;
	Thu, 29 Oct 2026 05:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250862;
	bh=omiRTUTlFVjglWv/Io0mr75+Rahowk30lESPXj5/SBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oXCtSPmmU5wRnKtCsOBF4A4ojZ+AEg/WFuXWk6C6inCt6VnWEek06cKHt+LVNouHv
	 vfIRba5SMd4K71WTSZ63bz9nU8HqqRzyzstD42+EU8pGFgr3LApKeXer3LPirg7JHY
	 OdHi/JGoejR7xQ1oZ9H71UnfXb7XaAKML8DnmI3MUrM19ELnCYV4dqzoFqbnHCGSC+
	 D8eIX4cwSlYcsTE0IdN+8WkqlEMQ70wJ3yX9wTeZUQNdtSDFArk5KnQtnGoFFEYavV
	 JN4P5IgAs5JsVsu37yftb+xj/t5NFZO+XESqX5soPEFnRfyAbGdG6BeDdpJPvSy6k2
	 FGb2V8rDgTErg==
Message-ID: <sashiko-outbox-188746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 08/12] riscv: Add Bouffalo Lab SoC selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kwanghoon Son" <asdfkwang@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-rust-bl808-console-v1-8-b736ee920078@gmail.com>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-8-b736ee920078@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:14:21 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add a platform selection for the BL808 64-bit D0 processor, including
> the T-HEAD errata and common clock framework used by its UART.
>=20
> Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-rust-bl808=
-console-v1-0-b736ee920078@gmail.com?part=3D8

