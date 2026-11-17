Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946325;
	b=fayqBdiXVNF8DSyl1vZwdexTxcirbAuYRvr4gZjhWtbrRxm4FxJG3ZftnEDqTkZarTZK
	 IvCQnUlhXCQ4qloFQTH4Jv/UQYhggs4ASaOdMegnJW+SwQCJujcBubENek4zOuJTS3kNk
	 EB546XGPZjlsGJmv4L2f/P36pjgTIq06oxrcj4oZTpWLsdFvz1gunhjc5br/SUSQARHqG
	 nwRPxTVxaLXVg7BqRxN7HTYM8G5Ola46K2bjyy9B6IJyOwrpy+ALiSHODEqDh7pAKmFgs
	 DUTb0z5QxhHAKgreY9X/peM8lpLrwaUu/spZLt0eNZSoYB0xrNRolxrgBv5ibSoYKwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946325;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5AEUS0KIj1HIKftm8EDZA6lHcH69Po4d/lvh7pXwxvY=;
	b=vgiMgYRHZ40l1e81Vexj92pNuN6CTiDCAwi3TTFtgcrnwD1grsVKMpoyIeQxNX62NfyU
	 3aULVDKXQtBG3NURQSA10gIKSiR3JD8xQtdLzk2PbCsU0cz+rHEzg+o+GHQ8lbogxBS9Q
	 MYZrIg5mZGq4QuZGeOiuxWse5xHmp72ntfUsmj/W0gFB9YpNRZqwKq0uELHA46da7YM6e
	 6pX52dY1e6y+UgDAsHHX5NFOs/Dba1Umlz50cZcTwnFvf5QTaSmAvTGnPfvS4uzw1o0nC
	 /nTqmt9aFAJTKPJC4OcAlmtmPnxX4Mt+2gsYiDza7RUshBjTj3kip9WAvDdpcVNUGVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZfnDJiL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12773606A33D
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZfnDJiL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BFF1F000C5;
	Tue, 17 Nov 2026 20:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946324;
	bh=5AEUS0KIj1HIKftm8EDZA6lHcH69Po4d/lvh7pXwxvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QZfnDJiLQ/59IdgirZSLpirpNHNcltua//1yK3SgUpRZAEALmrYNo6gD0ARY87ifU
	 +AunlTJw7kHtsp1ejAsVnPz7W2HAfl0mzwHCh4OBc6Xulx9Ypr5J7dfDmczIM+r4UD
	 v7iuG1sNQOOTmDXuhe9qoS8IonBZ8SjoSWtMXBPe9z1YdE3quIYwu/R6yj9Eqo0MuP
	 FcPo1tE9O+h58+LENjEO+jlIwBw5CD+ZG7ASh4k7tALOi8FUPmhCf9xYHFd+krxApz
	 NYGOSyEOePoduDgmuEufjOCm2/kOh3RmQNZ5WODclYuzm7ihlpPRENN6kIGykPVjhg
	 QmFoAoBGDANAQ==
Message-ID: <sashiko-outbox-219574@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/16] HID: ft260: fix sysfs store failure notice for
 big numbers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117200423.19561-6-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-6-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:12:04 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> FT260_ATTR_STORE returned the feature-report transfer length from
> ft260_hid_feature_report_set() instead of the sysfs write size. For
> values like 1000, userspace writes more bytes than the HID report
> length, so the VFS retries the remainder and reports "Invalid argument"
> even though the attribute was applied correctly:
>=20
>   $ echo 1000 > .../clock
>   bash: line 1: echo: write error: Invalid argument
>   $ cat .../clock
>   1000
>=20
> Return count when the feature report succeeds, so the full write is
> consumed, and the error when it fails.
>=20
> Parse a 16-bit attribute, such as clock, into a u16 and convert it with
> cpu_to_le16(), because the report field is little endian. Before, the
> value was parsed straight into the __le16 field, which is wrong on a
> big-endian CPU.
>=20
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200423.1956=
1-1-michael.zaidman@gmail.com?part=3D5

