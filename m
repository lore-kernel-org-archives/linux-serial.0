Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F647ECD8;
	Mon, 12 Oct 2026 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826474; cv=none; b=bmtJ+Px+wZ01n35zp3X9dHneqR2FI7Oj0rvSf1i1r0tWc6xITi1LRYBGru8HVJhMkJW2ULVbixBqx3Q8csGXLM0ZyjaMGOFADtVjBspqS93vDHjQyOckvGlmRUPjDxgw8gSxAAdPPLu5JKWCF1QPxjHQfaqcC44vzgKC5oHWopY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826474; c=relaxed/simple;
	bh=FyF6UoL+HiLsjf3rI64wL3irUpaNEssNUdyESBNqLMI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AyWcUWSphp9HyBZ+k7Slh8Y1+PRJfUoDiTHoOr47HekR3BRLgJuMVR6qW7TKqw2jc6xnY8pmlzQoyg5unyKwp5G799MGUUhGvraR8lHZSnRVc0uL+1kWeHtndbtqpKhBNdQA8LhKL3RhkeVYXTWZupVC9yrFc37SS6AgQ5d0vmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajUsa97G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajUsa97G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEAE1F0089B;
	Mon, 12 Oct 2026 17:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791826473;
	bh=FyF6UoL+HiLsjf3rI64wL3irUpaNEssNUdyESBNqLMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ajUsa97G/veIpQt8D7lteIbO+ChQxcennwZMaCdbM35ErXZp2wiKWVz+xcddl4Gwy
	 VKEqpUgBsd0c4dkrbdXsTy2oz5GaRLD2kPiOXIPgt0mVo5YV1x8lEjmq8S7AMLLxOt
	 C3r8bJx69I4YhDCPNULogZgtQ+1PCok2ZpGcy0s8qOliz3nz9JYu7OqWKlOWvdVwb2
	 TxdRlr1Dq233i66ruqMnBgSUDjSkoHCE2mqTdAf+3b3qamyEtrg1/FfeObYxdO6nAf
	 1pltXSqMLycFn0UEUr0OCQAlqycPKrm9hRyB7AEQO2w4JvFj3Mo/gGuz2XwbnU8x8T
	 xOxJIoyVUvslQ==
Message-ID: <sashiko-outbox-168463@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/10] dt-bindings: arm: cpus: Add Cortina Systems
 CS7542 enable method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: conor+dt@kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261012-b4-cs75xx-v4-3-df250d903682@gmail.com>
References: <20261012-b4-cs75xx-v4-0-df250d903682@gmail.com>
 <20261012-b4-cs75xx-v4-3-df250d903682@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:34:32 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> On the CS7542 the bootloader parks the secondary Cortex-A9 core in a loop
> that waits for an event and then jumps to the address found in a global
> software register. Add the "cortina,cs7542-smp" enable method for it and,
> as with the other release-address based methods, require cpu-release-addr
> to point at that register.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
v4-0-df250d903682@gmail.com?part=3D3

