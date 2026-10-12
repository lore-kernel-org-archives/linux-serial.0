Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3683D3B0AF3
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831308; cv=none; b=ebD5OUlokdEDEFsVUx5uRSIBWkN+YqnZgCj/wSJFozQCHwLwHs0+iDiOXA7i7RsSgGn9z9Luj5ru2CJJeesTZt2tsj98VeIdhX364uwi2geXbatN2sqzkNdoJjljO0phJ20DCrU8XYsxFqB0/LQ7fYAcjj7CEiQiueMaCfCO/OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831308; c=relaxed/simple;
	bh=G0jIbCu9r30K5dhIXBXEcOsDBs2UCApx7Q17+sanw7U=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mYgdCExeF5PpyLD/1Va3fUZIJ7ndowAGEmH58F3mYj5SGqb/vUlQ7IWdYM2s5R5ETGknUniacHvfTa3qkVyIVIQ74Svn5VDNe9wT2JBKlYXEF8xApmsazYQS1JStT0wAmAsB0XZTLgSBJC751j/0SbNPMw+Hxv+XbOemvYTICvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZdJRsit; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZdJRsit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42CC1F008A1;
	Mon, 12 Oct 2026 18:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831307;
	bh=G0jIbCu9r30K5dhIXBXEcOsDBs2UCApx7Q17+sanw7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IZdJRsit319Q6YwVhpYIIRM1+23so7vZ5Ium2biYv+uKZNgUQ0Z4yjYY3YaMAk02C
	 PPVavvpi0e77R0poQzXOXBZbOoSDnPtCZoMidWrr6TGSdXXG+xYiOIxjhhOqmC7ARb
	 aKbvrbeA2x1yDtr/t9hbC/tKXWgqLZmzdHfv+Eo1WSGsOijR32FCJkiR9WrpX8RNz2
	 er09Y7yQwPuT++hsZybw4BWZI9hPMT2CidAZ+Zz7az4VLiyze+R3ap2DHmVsv3lczd
	 c+oDllz5V0A/uee3IW7WOMtw3a5KCV9oYrBdWIl3BUDIjtJ73kKBvbolgZaYarjthK
	 uXDUomGtUAmXA==
Message-ID: <sashiko-outbox-168557@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/8] sparc64: return from the generic clear_page
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261012184826.986050-2-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
 <20261012184826.986050-2-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 18:55:06 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> GENclear_page falls through into generic_patch_pageops after clearing
> its page. The patcher then rewrites kernel text on each invocation.
> Return to the caller once the clear loop completes, as GENcopy_page does.
> This affects processors using the generic page-operation fallback.
>=20
> Fixes: 6c70b6fc7b6f ("[SPARC64]: Do not assume sun4v chips have load-twin=
/store-init support.")
> Cc: stable@vger.kernel.org
>=20
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012184826.9860=
50-1-linmag7@gmail.com?part=3D1

