Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A343CE58;
	Mon, 12 Oct 2026 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788472; cv=none; b=EZLx6aY2LlRfa+dlQ15zDqFPQAEql7xW/tfbVi5O8PYwszbLs9W3O+8IjGh0f+FfjbpjIMSwal5JUObXvj5ue9h/j61yzieL/KFugwSGjgr/k53rJdDUrYjeeAkBVOF9Wy9pneuWRu5wFRZe92fYUBqrG5JpP09H8KAWeSwtyyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788472; c=relaxed/simple;
	bh=iScvNgNGJBgcIYLI60zRRIJe/FDUMnSNznKDPqFtfTI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JxzFazhdtMr5vQxldpt5jLHpR6IgqbJOxB8wFVE7vzp/Bfge0Emc9GqzFX5IM+9t2BoFS9DJLtxIP5MWriVLu4T+KInIw3iqjwEI0hMEn18rhIL/q0XHXi6rcq6tpNBJ5jn5WoQJFQQiv2y78E3iSrsVbomjE0lcswFJaRrYBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvFVdKIj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvFVdKIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE45C1F0089B;
	Mon, 12 Oct 2026 07:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791788471;
	bh=iScvNgNGJBgcIYLI60zRRIJe/FDUMnSNznKDPqFtfTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UvFVdKIjIRUeONgLLLzBhguKJblfnOYDnFcj1JhBXW0DxOlK7WDQdBt+HAhDstsuD
	 TIh4pbgIs9+YxiGPWv65y23dtswFi5AZ49sm17G4iOrJ+9Nj3PyNRWBRgJpa6Brrgp
	 NHjf22uaZyGKbYbjMRSwW0Khn04siaj0McaXQFW1OOuEE2iurfyyW/Rkt/D96l1Fpg
	 S4E8lPM08MgzAJkYzYtXALruvrpWtyqTvSS4i/yjvhMxncHKEg74kaQKIEposjO+o6
	 /vFCyWN+blUIco/l6wZ8VMZOiTKJQ54DgAD2bvz3ZlmIqVW/6SggloHch6Bzd6ip+M
	 Ni6/czOnnUx4A==
Message-ID: <sashiko-outbox-167766@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 03/10] dt-bindings: arm: cpus: Add Cortina
 Systems CS7542 enable method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261012-b4-cs75xx-v3-3-0e0d17a098cf@gmail.com>
References: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
 <20261012-b4-cs75xx-v3-3-0e0d17a098cf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 07:01:10 +0000
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
v3-0-0e0d17a098cf@gmail.com?part=3D3

