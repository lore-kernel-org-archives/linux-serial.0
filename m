Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762745;
	b=TJKsDRINsdoIKk6UwJKHpexZMPE8dWLyW3d6QCs3SlxgTU/1oiHXWcEBj1GUCEFjUJ4n
	 tGS3mZEdwlUyNAmW70Iu/+9gihhS+SldJdtbzOBJqzPANkg5sAWmg64Z1h89HmiiOHDsI
	 RGqcjFIzEPzf9JvX/qR0JLzPeKT+xFCyBOWNXm805OYaJpD02SXFFCMUatJZaCpbzitGr
	 9hcgyZLEFjrLJGFqjaieBnAKvccDbIP5XsZhGsSFwTKDh+hrPOUuaX7DyAQgMs97nBv7S
	 JSB3Zu1Q3IWArwLXFdGmDEIzikOdIhEuR5c6eKf6zU3tUjl2hBDpxAZp5gXcbuEpm8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762745;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/kUUTBuQldpC2oa5mbLn0u3yqeRVF07M8BHK78OwGPY=;
	b=yyiRBBP5IS9AOXDbi1hWirKeRrgMHGlG+kEJgRm0zfGf3u3/YK6ApuTpq5o08KV2JO1V
	 UgiMlH8UPRHQGlCd8+uDDjt2DPx7MVAR0oBPkTrSx1+Y5swtIy8E/x4Gx1htRc9MT/8OG
	 k9Q098A0/XELUXgBvqmtp2ze0h0BlRliHZkiCKXFxOZPIaz4OloJpkZn9ZsbjCu+qN8Jl
	 g5LYii/Q/ImnJN0JverejlN3MLuv1OI8y7CUZ81+74rKyGOovfBgDRXeaLWK1wnS3QLvV
	 dUzfnZqQcx5IPJVyamqchdT+6XNyiyIzoDmkbSDhsZdK6QXaRDWS6kNeb3gkTXy1nEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDaVKpZN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA1606A31A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDaVKpZN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5821F01825;
	Fri, 23 Oct 2026 13:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792762745;
	bh=/kUUTBuQldpC2oa5mbLn0u3yqeRVF07M8BHK78OwGPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VDaVKpZNyNjipzbHnDdVtEdldG5tX/mZBgQU7/akRaE4qvB4NlYEURhoR5LPLFQcC
	 6hDxDM1cDweOat9v5pAQ42xyOr/r3xiXFhAX8iG/cIaBRbRg7+L51wqqOrCfG6Uut/
	 JLOvjLWbAZ0PoQb6HliDWfJkfkPbYFTwdnk7lc7pFhSk0HLVLbhn59RBd3c+FiFIRJ
	 vm4IaB6mwMilDnoQlJiPDpdWQrsSf3dyHHA3AtmOV/EZ423d4hAQ43325TQfitwmvi
	 eu+HWT2FHqxc4imIMrF4agZkq2hjGv7QQt1yVi9BsAv+l3HxAdtlY7RNckcbra7IUl
	 /md10OVy240yA==
Message-ID: <sashiko-outbox-182837@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/7] vgacon: Implement struct consw.con_unblank
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023132448.115747-7-tzimmermann@suse.de>
References: <20261023132448.115747-1-tzimmermann@suse.de>
 <20261023132448.115747-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 13:39:04 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Implement con_unblank from struct consw with the VESA_NO_BLANKING
> case from vgacon_blank(). The new function is called vgacon_unblank().
> Remove the duplicated code from vgacon_blank().
>=20
> v3:
> - take mode_switch from parameter
> - restore vga_is_gfx setting
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023132448.1157=
47-1-tzimmermann@suse.de?part=3D6

