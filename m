Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CACB499F0D
	for <linux-serial@vger.kernel.org>; Thu, 17 Sep 2026 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680090; cv=none; b=qqxINZeabY5cnYnPaYcXfn0cbQt1dgqAVVDDbIHHT2/lFwhUzK41YQf7tLesj3fko7E1tgz74GnhOk1ftaXhzFxjJzws07ObxE5ALYztpUADvGYP68/U62IV9qbpZzAyx4ipJG5yrulUf043eSo2BedtvZQzgB+7RGmaq6NXN6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680090; c=relaxed/simple;
	bh=i7OUiryO/Q6hWcIQ1dRduNWwyvdkK8iznImPgf+LqfQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m8x6IU8zWnbwfU45bVxEblEaG1JQlXFjBZDTNTFp1T5eK6018eNzpDJyDKeaEDAQcmY018nFSu297ppCiIC/UsKY2U87qGCV9BYs+dxfZka839xenyHQyseE8txMOXLA5k2JQBCct6ohoZ+3Df/CGyR1jvuCyToVxV6Zqds0c7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY0h0noX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY0h0noX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0451F000FF;
	Thu, 17 Sep 2026 21:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680087;
	bh=i7OUiryO/Q6hWcIQ1dRduNWwyvdkK8iznImPgf+LqfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dY0h0noX85IOA/lRabb9rjicidgky7bbVEjhVX1z1miRj3bS3uGmeOUvb/yrqzspf
	 5s7JEebaeX/jNPY66OJ2FLUhGViw6KiYVYdy8rkbsbH7FORWVN7GbAZ1SyGI4OY1Iu
	 dahIzDBJ7LE+3zANu+ufPUrXarwjKvaqlP/ksIf5WjYSDUnrBY0k7b1E9hK7HBaL+N
	 0A1IwoS02q0HvMNmoXqH4H7iPMZDpPQ9kIUWBjOXP0bj7U45i8Mz6h+crO7hfrkfcR
	 4c7EdgT9b0vamejdjf7ScNL9/YT8EEvf/V+2JI8oMdbBKOD6eZPUT8RpGRMVZnUeZR
	 L/KBfNOY//R/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vt: keyboard: Allocate new_map with ARRAY_SIZE()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kees Cook" <kees@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260917211539.i.636-kees@kernel.org>
References: <20260917211539.i.636-kees@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 21:21:27 +0000
Message-Id: <20260917212127.9D0451F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Kees Cook <kees+treewide@kernel.org>
>=20
> In preparation for converting the kmalloc family of allocators to the
> type-aware kmalloc_obj family, we need to make sure that the returned
> type from the allocation matches the type of the variable being
> assigned. (The kmalloc family returns "void *", which can be implicitly
> cast to any pointer type.)
>=20
> The new key map has as many entries as plain_map, but the size was taken
> from the whole array, which would make the allocation type a pointer to
> the array rather than the "unsigned short *" being assigned. Allocate
> ARRAY_SIZE-many entries instead. The resulting allocation size is the
> same.
>=20
> Build tested ARCH=3Dx86_64 allmodconfig with GCC 16.2.0:
> drivers/tty/vt/keyboard.o
>=20
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917211539.i.63=
6-kees@kernel.org?part=3D1

