Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202471;
	b=BPW8244Bsc2j8Pbxja+uU/j55qasV/wOJLofYvtmBbAdJdjGcG0rObLimOTHSVjB4Duv
	 NS/H2TV/AUqJT1FqbyeCh0dW9TFiXQbgiywJ+VzxatrVY3rWP28oL0TOd3DsyDPxXxwGC
	 G0gSSBH1REg0WOXPk5tbzEQXK9MmYg15M4G8qlJ4WzV35gcLI+50C8QXsxzRltceCgqel
	 snu3jnSITuBjzumuNWM3zliVgPDODEpNfc4zc6yTjs4Ml5J2TFWn4MlpnE1yDbf4OMkMd
	 kw3tI7DrpxmNYZIb4jbHQNv/x/k1Pti8mk3snytlTqJ9G4n1MOyH3gkLGvdpt046/hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202471;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=goCMnhDHCCYXHfMg4gjECY6nxsPGv5fQ/JtYJdOLSgE=;
	b=UNoYQQURrefCRfinX2NWdRQJpIHLfprvuRMCjswq3ZX5mavGo5O7XNHCzJxAAmv21Ft4
	 d7AJUIdoRVR0ax72GlmVZJ1j/NplHHHkoi0KXevQLhXK69Iy8d0SC5NGDl3/IgFj0e5qB
	 JB5RNsaCxmQjeOir8HgIT6hAGvBhU+aEzq9sBxFryo0erl7Cg7Eq18ngxQ1bwiPTAyxPY
	 I8F8ZsZ8uQzckf7Kr1TBI8hSTO8YXraR31jRlsmxqgHAwdFedERmgbPWI7kHauPKQe+ah
	 Abui8hJEA/h0JSUnwceQwlGLI3Z6WsmILPS3PhWASLB8rm5hr/dN/Ln8ujXKy/rlgSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYiE6+e6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B0606A32C
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYiE6+e6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988931F00A00;
	Fri, 20 Nov 2026 19:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202470;
	bh=goCMnhDHCCYXHfMg4gjECY6nxsPGv5fQ/JtYJdOLSgE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LYiE6+e64l6B8P2ryCnN0/R4BiHMVXlmpy2GeG6jq09IOtQ3/8rbb0VKEdl0CUVdp
	 hZ+Ypo5tqYdF5Bs8bQYddFmZOGAq9sPBOwAL6VYAD6XX5tURhib0tznmV7fMYm48xl
	 aRdXK00KDVsDE6YZlEkFDgSweIPdahLrn0EDq+FWCaLvalKn2LvEXqQk/8PFDzGo0M
	 bZ3Qyb8nzLnIXU8mMxXLzON9HvEPANL9saGkb55GEEtenViDLeLDDGwRScPVM+OETB
	 gbjQstNugoVlERa7YK3z8mbZ+j+nJSCMtqAnykxzcmX/6G+9sQD6JxsIutPiKJONsn
	 E6gDdUpv9vUsA==
Message-ID: <sashiko-outbox-225916@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/13] riscv: dts: zhihe: add A210 core support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261121-a210-scmi-v4-8-4a795a0a9fc9@iscas.ac.cn>
References: <20261121-a210-scmi-v4-0-4a795a0a9fc9@iscas.ac.cn>
 <20261121-a210-scmi-v4-8-4a795a0a9fc9@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:21:10 +0000
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
> Describe the CPU clusters, interrupt controllers and pad controllers.
> Use SCMI clock and reset services through the E902 mailbox, with a
> second mailbox channel for firmware notifications.
>=20
> The SCMI clock and reset IDs are assigned by the E902 firmware, so they
> live in headers next to the DTS rather than in dt-bindings.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-a210-scmi-=
v4-0-4a795a0a9fc9@iscas.ac.cn?part=3D8

