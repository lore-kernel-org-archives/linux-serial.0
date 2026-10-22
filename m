Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670379;
	b=NfOULk0rURmNjLp3oyr/pResyes/4u+JYEXqLyp5kkzn6WtwoF+Xw8sz6DNDrXYlEq7i
	 juidJUAk497kyOEeFwEEOCjfWPU6icQOiAnc4TPP62Ht0om8V+rzwyveVTQv8zG94tjPv
	 I8KiFqAuSYSeLNFAq0OBmK+IfSmkgPuOTX10WYGFixVDGKNBiCFWoVGxQeeYGU88r0cuv
	 XZoC0En8B2EyRmLmC7kD/JhO6QrCF1K82xV6UifY9s/H14x1wrA2Z0mBtOoMXxP9aha5a
	 eb9UZPiVryCerbXP6cLG0/ByRK0KRBoevlpFQC9bfyIwp0TFfx49xiOTdXNjG7yjKEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670379;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RlENRMPW7db/xau3NrgjQWw/I0UA9aUijJawT4VQQsM=;
	b=AXOZ2xxvfJtXglHPFMNKsvBb996du6FPd9G7WGU+DeQVM0noqWciUr8S6qh71fgddbFX
	 sv8CUUGrbQn3sO4rbpRE8bL3BLm5a453OvO9UoRh83wzl5VbFCAuY4wFxBpwKPUWGv0Xv
	 YqylH75w3lUZbA/7YdQhxlS+Mo+68aSr65gtQg2gBUWkw96oO7s8uKvHmffSIgclDOqzZ
	 jywghAVgYdRoXQAe/UL1S3gAGvavRJa3QBkGb/Qrk+qNZsz1jmnmTtHmKC8S1SEQoO1dl
	 nQ2OiFFXpDK1zE7IbNVTlTzWfLRvAlkqRnqSKoyCJKhrm5gXzUXZE8JAkhcHzCBHCHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWbJiv02;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F32606A31D
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWbJiv02
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F4D1F000C3;
	Thu, 22 Oct 2026 11:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792670378;
	bh=RlENRMPW7db/xau3NrgjQWw/I0UA9aUijJawT4VQQsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hWbJiv02Qx45KprnTgcbdzkKM3j4t7nWhg95rjUjAKaBpRpKKK5cwJ95LuFcsoUok
	 r6nfVKMtCt0cBR6CbAuAUphIcaAfuptrlUkUvdFvZcyKigHMYMby1k9rgKQc0Bm+dc
	 jJJhl2uQwDVj0zg03KUnstNZQMQIlAzX/GIIY387CiL5Hdas8VmmvTBWQmo+fg5RPG
	 NHXkYnfPkHIzzKAs+4rXoy/8U2pc0K97mSMMU8bUjKvd9wFYoOsnqzTVC6ZXAVYmD9
	 2ossUZ/EXtD9OAhvx2+xe72+y/+aG5ejXPvGp1evYFdBUTw4inKWoGLJp8Y8hXxLoz
	 fLKmN+wZ0adEQ==
Message-ID: <sashiko-outbox-181406@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] tty: serdev: Export functions to pause
 receive_buf callback calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261022-rust_serdev_probe_refactor-v5-2-a27d862a415a@posteo.de>
References: <20261022-rust_serdev_probe_refactor-v5-0-a27d862a415a@posteo.de>
 <20261022-rust_serdev_probe_refactor-v5-2-a27d862a415a@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 11:59:37 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> These functions will be used to simply the serdev rust abstraction. It
> also contributes to the fixing of 2 race conditions in the serdev rust
> abstraction.
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-rust_serde=
v_probe_refactor-v5-0-a27d862a415a@posteo.de?part=3D2

