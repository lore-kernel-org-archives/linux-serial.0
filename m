Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793467217;
	b=UUbZiUXapRpb008weQhmkahZymdJOUebn4t+QVsfk1d7eBo/gN/zoUgxeaUkq1LGi9Q8
	 bk9PO2cRI+RF6g+VnQs4/ZawGoqk9Er6UQGEF9FzhC+k9KjX5imJLRFvJot1RvuplXIEh
	 nL38wDFCg8pRZvse73vwT4fBZ0KIxlslCtI1PRXUIJJLiRZXnvdkY7NgUu2yKNjx2EViF
	 hFCSrvMGq3VzrOZ+DD+fBIc9mPFnORrEz08YSycJS6t9RLb3ldXAGG+AhR3GVISeYQBsz
	 938svk0oRkb7n/0AzoHHEKDt+WT/JOkW/4GLSz8DMNvHGZAvQc6yIHu+BE31fcd3lgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793467217;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VhH42fOcn45Nj/T/MoN0NbOJUDkzGhDacK+q87ZMdrY=;
	b=jvEduCgMnrLCftVCQGlQHMnzTB+ktCpMtvSOMAB3FoXajxCFhKoMqakVKTlZHwJEv2wf
	 j62ZFoeOvTNtUGtuEaiwW/IGZuTI0ZbVn8d6GPVRCriewauz7pd9tZ65RkdylyNMe+N/7
	 5sjRTxxRQGDewp1S5cVDORqS5fVo27u4gtDruqBCrD+VcctbpZKoNFX/l926cuEnu/PPM
	 7UDRAZvrlnsG+ZqZOnKm7G6Gah0X5u9NRaaXrIRcgbziP24sAlRenOs4rLSYnnQIpBYqt
	 0lPxDWvU9aGN0w139NBDM2zYM5Mv90SSyjneGYAGXil2EgNUVvNs6MV7339tRozd9fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Lk6/X2Fu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D72B606A31A
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lk6/X2Fu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19FD1F000C1;
	Sat, 31 Oct 2026 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793467216;
	bh=VhH42fOcn45Nj/T/MoN0NbOJUDkzGhDacK+q87ZMdrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lk6/X2Fu9X0K4wOlvTAtCQ62njBdjiLk3llV8mWQjb2YbWKVxnBVNLNMNPOyt64b+
	 7MV8IuInvHKej2Hd6e6WKOiFANW5kxw+9YGBXZPaiKN+5LfFSdr/svPiHw70RvvIHB
	 S0mSxwX8YtS8J3CUD3lyjg7Led7jsQYFZYEEKLwqWE8m8nG9+mnVtrtd/DipTYLAiy
	 blaSBn+pTwRbJ7Bv2QFP7ppgV9o4FmfU2ntjIlJF9PbGH20Ud6K/NjvDaRmprgap7g
	 CO5OAYd+N8PiEA9ny2BTThoBY8RFKtxPVdELm4GVGWi9tpfZ+MBpOcZGl2KB/Vp5EP
	 VfROPaK6AV6sg==
Message-ID: <sashiko-outbox-192062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] serial: xilinx_uartps: remove redundant
 pm_runtime_dont_use_autosuspend() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Crofts" <crofts@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261031-tty-dont-use-autosuspend-removal-v1-3-7bdadcadc4dd@kernel.org>
References: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
 <20261031-tty-dont-use-autosuspend-removal-v1-3-7bdadcadc4dd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 17:20:16 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosus=
pend() on reinit()"),
> driver core is now responsible for undoing any
> pm_runtime_use_autosuspend() calls on driver exit.
>=20
> Remove the redundant function calls.
>=20
> Signed-off-by: Joshua Crofts <crofts@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031-tty-dont-u=
se-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org?part=3D3

