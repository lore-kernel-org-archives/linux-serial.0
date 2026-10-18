Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0794C8C5A
	for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331534; cv=none; b=loJOIUFK9OeWmVEG6X0AHBRMC00jdEHrpLIEs6A2CVs0L7tx7ot0sk5uxRL93+ZFI5CNg7uu9uMBS8r/EVBe17Ejmms0O0qLP5Xf2GECDuM6QQJFcMhYwok5zSlVHjlGb8Gj+JHtekx5dPDafdW/6IdeEfN1kXgiDDUGKLOSc8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331534; c=relaxed/simple;
	bh=AZJyWqIQkh382c+aSRUEqPeZOhGJCR8Xaj8PHiZ3UHY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HErsUe0kS3ijEOwYZYo3NkHwZrKIYw6CzUVz6Cfm6QUxhtNyclQOrtSxi6+Ib9VHQ6MKdrOEtRcNKR+HFGQjkPLsjgpvef5G5xfbsRigVRxXguFTFc3FOiPXRrLF3mBRd4hokx22sU61rThtSmPLYqaP2LLn01avXOPvj/ZDoH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/ub1c1i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/ub1c1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492271F000C4;
	Sun, 18 Oct 2026 13:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792331531;
	bh=AZJyWqIQkh382c+aSRUEqPeZOhGJCR8Xaj8PHiZ3UHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m/ub1c1iNV5rjGvGgSDfXMKARE7uO+tMZ1Em7fr38U8uz0Ugx5wt/pi9mQ4/rczxo
	 8JJoTA7669qYimk6xlZu/RyVDB8PPK+DjxOOhvMITYpyz+7vK25/eTcna7UeppQ47p
	 928Vope5YEviabXjwKELMI4/rKyznt36k51uOp4Dm/LuPnx2FQRE+5/QlpVD0rnKkt
	 G8nkXkUvP8KsUX8LdaqjpPuUR2RId//zlJh5pkZB/x4aog6l+LzKxTY2TRwupmOCjR
	 cL1f8rKjJVkc6p0MOOqMx2Js4WRVB5e0c/TYxWo5ZiDp4v+BF3/Fx95fpaO3rGbpSY
	 QDTF5ylxktZ8Q==
Message-ID: <sashiko-outbox-176160@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/10] sparc64: return from the generic clear_page
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261018134738.1016106-2-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
 <20261018134738.1016106-2-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:52:10 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> GENclear_page falls through into generic_patch_pageops after clearing
> its page. The patcher then rewrites kernel text on each invocation.
> This executes 45 extra instructions, including six stores and three
> FLUSH instructions, before returning.
>=20
> Return once the clear loop completes, as GENcopy_page does. This affects
> processors using the generic page-operation fallback.
>=20
> Fixes: 6c70b6fc7b6f ("[SPARC64]: Do not assume sun4v chips have load-twin=
/store-init support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018134738.1016=
106-1-linmag7@gmail.com?part=3D1

