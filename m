Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597129;
	b=mYBi6UdNSY0osQ4QeEV4MTCFCBwSVGdUbgzwhOIM6NUXNlzwHbtJMPsqUHF50/Ivd0Z7
	 UeTrx2t4VF1V8dfKNwKjNo7cyU4yl1OoQYQH8VJi9jL+559WUQWZOqx5/viLr5iSGgunV
	 wl7cBGKjsAIezMml4F8GV9ItcwLZsuBQ8IsAK8HI5lQv6Ca4QoQ5UaLn1a0B0p/2oUelw
	 GUdrIxLdSmZdlHP5pt4kMWti942HXlBveXlqiZJ+nBSnQXOHxmYJSzwFxZx44fvRnP9FO
	 SQRtQb8kEQkvDgorA/q1/rmS08BGGfw63NbXTKPJawupyNgKvXUUdrDyZpmuYrUCZ+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597129;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z8ymY+DnrdH8PffcmFWe3tcAS3hA9oq5aytjoQfD1SM=;
	b=RjcFjUCnLu1nxYRFRd1CDAiPSBSlYkBC90Nfszofq7kdtiXv4jA9Od9xnfOtlZbqc9va
	 cO+iWuCPJHophIk2hncVdL8F+S8aEl5CBHd0lIIszi4HpywjDsOui4rDQUyFFtY31qbev
	 xO0QMOrHWJSRMQjxlvI6gTgz4hE7VLUahBdwuVQ/58Q6xXxdBNZA/N0ighDXXZ/cCDq91
	 KZ2WXQlwrUMi1ZxSEc1pqyP3dRSGTVjfRcAAavkLDLoTq/ZwdmD7cbSQEImIUZB4NJ3WL
	 OKZ1iW12ytutWP4795+WxNPCf4TmJsF89anjd9pw+dx7KhQTUEJar2jWGlO4/0kpp4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZygEvrDG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22973606A330
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZygEvrDG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680AB1F000C4;
	Fri, 13 Nov 2026 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597128;
	bh=Z8ymY+DnrdH8PffcmFWe3tcAS3hA9oq5aytjoQfD1SM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZygEvrDG9pCz8AraENF4HIjfbWzqxId5B2EXEAAroyokGFeI4HY0yaJhnzPxSYWTq
	 wBNygBA7pk44EXxQfSEM3c8OVMS/t1k8J+EtT1i2Vf4HXrDZppX7YFHieV4kUQb/No
	 N6hJtzKaV4kb+QZpPjbjrBC81XCNYtZeCX6hMZWDNMG6hd8LLc2YuMcKIOX9FqVjdD
	 sQVmjyRrzjPP1Z6GjjQd1J2GAeSURAOuXvvQlgUgMTs9thUQxNHyYkw79rFBRWhdSb
	 7+02wodVdfy2cMn6f5+urHj6KxWHkZl6Bak27dJG3hqwq4xuMXdrmDa//dwCHU7w+H
	 ELLFrWeM6Lwyg==
Message-ID: <sashiko-outbox-213520@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/9] watchdog: mediatek: Add support for MT6895
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Letuchiy" <asalde.le1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-initial-mt6895-v2-4-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
 <20261113-initial-mt6895-v2-4-4ab0aa9fa391@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:12:08 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add the compatible for the watchdog of the MediaTek MT6895 (Dimensity
> 8000/8100) SoC. Its watchdog registers are the same as on the other
> supported SoCs.
>=20
> The TOPRGU reset layout of MT6895 is not known yet, so the entry has no
> match data and no reset controller is registered.
>=20
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-initial-mt=
6895-v2-0-4ab0aa9fa391@gmail.com?part=3D4

