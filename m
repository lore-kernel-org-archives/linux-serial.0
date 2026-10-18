Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864EC46EF92
	for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331560; cv=none; b=pWIy61JfhljUjGGMn3peW9/cO+wZ9B4TVsnGy9rvtJA8Dmfxxf4NrZ4DJsn3CtWw9XVQis1aYcIFjRiSpmtdqaUpgENRSSVH9BQRfVy+G0yvimtQVWd3TNB5zKY1rXowWqJ2xEiLm/d1DubZ8DLItJUh+y7c8aR8FLSpJ3vfdjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331560; c=relaxed/simple;
	bh=DBnAN4QKtNPvwGSion6PdibbOYuTn4tuIWXkSbvChps=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=U6ib8Pl4Tde3ruhpn07ZG5cmV2rF9aGInqyNNO79WtL7e6lUP3Rt4el6HoM/S5lj1iZVGl9cItRotbrm2AY8j35qK0HicopsJHGB67TmvWOz7J/TcbfR66+ANFwYMzWS/4CNmnKJMu3ZHLdU+vFZo+QyjR0mveBBlz0wvlPGAQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/ZFV80u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/ZFV80u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1013F1F000C4;
	Sun, 18 Oct 2026 13:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792331559;
	bh=DBnAN4QKtNPvwGSion6PdibbOYuTn4tuIWXkSbvChps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S/ZFV80uC39gPJ4IT/0TitqNxHwD2GWC3DAr9ewQneOCJoMmNXJUwBhe/c3L1FksE
	 Wf7tazJ4TCBx3ww4uC6rjb+ARJ1p+VvvOfjQITVbAiEtAuCEg1HVXFt9oxjB2zptnK
	 dTi59SKmwuFc9uQUo+214m1HpgTMKrLF8RjixoMqm4WpP4GEUqdrtydfQ1rXQTQgMq
	 T4jQEeWGcmrCyV91UdLdKNVW1hHXtnJMEV8aNQAR46sQ4Z5K6kAQfDW7jZcuLBbABE
	 7v9J/+MVk8cvTBYG1BCOq7cFfY79Gv6RdtHePdfuN+bwr03xvqM3FjSU4FfY8mDKCT
	 hUTX8IGkhNQnQ==
Message-ID: <sashiko-outbox-176164@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/10] sparc64: validate Fire register properties
 before initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261018134738.1016106-6-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
 <20261018134738.1016106-6-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:52:38 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The Fire interrupt translator reads one reg entry, and PCI PBM setup
> reads two, without checking that the firmware supplied enough data.
>=20
> Check the property before allocating the translator or changing PBM
> state. Halt early translation on invalid firmware data rather than leave
> raw interrupt numbers untranslated. Return an error from PBM setup so
> probe can release its allocations.
>=20
> Fixes: 861fe90656b8 ("[SPARC64]: SUN4U PCI-E controller support.")
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018134738.1016=
106-1-linmag7@gmail.com?part=3D5

