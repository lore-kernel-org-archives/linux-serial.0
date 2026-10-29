Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250644;
	b=1AfybB94nmwIYqcYfAmbTX3qhKdoQzDeuB6iEZjYed7o4AlcaMzKNztmBI3gAsoApIHh
	 5QD9TTKcUemNt5c/smgDTBJYdDLTVNw5KkkI27+UuqdWi/iNb0R/TkVjDz/8LEKZqlrI9
	 ZvWQiYioyZPw+cyHEdbELiHBzGnLVNkdXL1rTF4H59CLnYbR/bhJV0eyDq9vj6jrzPtau
	 TDIePsM+4KoaCjk038CzmxG2oFE1QposE+pWvxslguQ4Tfnn6caPqaYwRyZrahw+eFSYu
	 0PHjpa1NoDuqrdOImYZlCziexwdOogQfvq2j1GGeWfTjY3q/92DqIzQESYK9hRaOr4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250644;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DUVy6uINXUz6ufNydqTQ7LfpNBl56mDAN/SMYi0bxdY=;
	b=EzZc7T+uryDSC/vlJcrZmkxbFZK7T2i7qtyq/4zTZZNKCjKiU41AIpMeyWlT0EjZrYXX
	 45A0QIk8dFFBBRvXeY4kwhVRG4/+9Sf3/Mw6it0sSWP+69xJ+beyB/LQLzZsL1wr02N7C
	 SWxa1IFTrOQPdrB4eU2JfrdS606fwkp/XhWCbwiA+DIhFsI7aot1jgmOpefk+TUSZhmYL
	 DGVszh9vbscG51kvacvxyNYgLnBd7xbueH/LJarXpVb3pEahM/52ut75AsgCp+sGiQFEh
	 cZFRTOpJ3Elrs2JpQd4X9NuJveJhC9Oxz7A5k50dlQl635syJy1GX4id9+Io40VkbJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cI4bVBZy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F756606A31C
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cI4bVBZy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC271F01825;
	Thu, 29 Oct 2026 05:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250644;
	bh=DUVy6uINXUz6ufNydqTQ7LfpNBl56mDAN/SMYi0bxdY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cI4bVBZySEab7yLTWrgpJ6IMJYYIcpiuof1gYfKdOyR1Ep7AmNVJni53XFc7A+yW6
	 JNAJInEyQ265Q0SJJpf46YU0N8bvcIgNWjYCNxZ0Y3Q8u4j1H6XTs9wHc/yFPV6ZHH
	 aHPYU9D8ZUUNHlVA41EepIqDnxnXwTEu0l/RXcuV9VM0cRiI3u8rcEXNQaHvucI9KR
	 4sKNjyRt4he+LQHlwE2MC04S5i3WcP5+VnXobbaasQ2DUGF4qk8Jo9MgM+5KRTWlQ7
	 6mluKlDh2J6PD0Ex6U2E5nXvFKRLw0Z8FWff1P+g1WXl3I+65/kVAMH96Zd+91PB8D
	 aH9tSavPpQf4w==
Message-ID: <sashiko-outbox-188733@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 10/12] riscv: dts: bouffalolab: Add Sipeed M1s Dock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kwanghoon Son" <asdfkwang@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-rust-bl808-console-v1-10-b736ee920078@gmail.com>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-10-b736ee920078@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:10:43 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add the M1s SoM memory and 40 MHz crystal, and enable UART3 on the Dock
> with a direct stdout path and 115200 8N1 settings.
>=20
> Boot firmware initializes PSRAM, UART pads and shared PLLs. The tested
> firmware configures D0 TIME at 320 MHz / 380, represented as 842105 Hz.
> Firmware using another timer configuration must fix up timebase-
> frequency. The declared 64 MiB PSRAM range must retain firmware
> reservations or be narrowed by firmware when memory is assigned to
> another core.
>=20
> The stdout path selects the native polling printk console; userspace TTY
> I/O is deferred.
>=20
> Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-rust-bl808=
-console-v1-0-b736ee920078@gmail.com?part=3D10

