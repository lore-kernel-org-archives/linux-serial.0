Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD153E9C36;
	Tue,  6 Oct 2026 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791311117; cv=none; b=eSmb2fHZakFZEZXOOfwmtqa65RnUMkzdVuch3YUi8v58Xp56nRod1dkdOCcJLDmfUHtyweYRhSaf/zOhpTQz/y2wMb/10JQQ5Zrt/uAmf5Ne86Jc36H4R2Z5r6q1Iie+9oK8FD6wejPCV+J5cyCyZ137cLadF+jvkCZL++2THy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791311117; c=relaxed/simple;
	bh=+A73LMqtKFJVtV7m4R1MuqLF7+MECQIkyJSGEzcu2OM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=D4rlWzgLYvTtayU/oGmJ1LCF9RA+5eSsxWTi7D8jw3Gwi5O4Tf7sWo92fafi05VNI62qMb5zz3d4eqE/jKrv1NndNJZvllxOX3BLpE+wczJHF2GG5kNiYBq2NJ/AwQdE8upEeA/d/SrCShF8Dd781fUmk/SwVePxdJmQnESupg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K94zBqzn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K94zBqzn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807641F0089B;
	Tue,  6 Oct 2026 18:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791311115;
	bh=+A73LMqtKFJVtV7m4R1MuqLF7+MECQIkyJSGEzcu2OM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K94zBqznEgIr0zH+nlig54UelqMy0o2FLrMOp4SmSTp18wm5jw3pbE9HFII5csYnh
	 Dp6V16fd4+QP14Htzdkx6TDJHn1NET6ZMsINWqN189zjHhPqC44U+KUWnphym5uhSb
	 PhHP+p23s/ruherts1ts8AWT6XWdxyrdJgxQuHqcIUKx2Ba1GXWFRSytETis9LBsd0
	 oNOeivumXTJN4LbBPJHjMYc8CHJcLylR22517iCf+wpUsgk6PqAHz1XZ1gCL+E6Q/U
	 LqqOfUQOs2wolK62x2+iOCA3HmONaUsFd1zd0q8FKBxQ3bST0xjenqxQYHXByM0asL
	 37da8IS3xABgQ==
Message-ID: <sashiko-outbox-162339@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 05/10] ARM: debug: Add Cortina Systems CS75xx
 UART0 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261006-b4-cs75xx-v2-5-b7d6e1e24d44@gmail.com>
References: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com>
 <20261006-b4-cs75xx-v2-5-b7d6e1e24d44@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 18:25:15 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add low-level debug output through UART0 of the Cortina Systems CS75xx
> SoCs. The UART is mapped at a fixed virtual address by the generic
> debug_ll_io_init(), so no platform map_io is needed.
>=20
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-b4-cs75xx-=
v2-0-b7d6e1e24d44@gmail.com?part=3D5

