Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE5A34DCC7
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444532; cv=none; b=fn3AY8U/RCjsse0dG1gRfofy6Ld1O9+rbtQ1pJe4UqmpgpQdEjTOzz7snSs+m271b4CgX1L3hrWbAxNVToSZItdnnqKkZNlEjyC8h+dVejW9zV8qilI0mRQZeayLwXP7HzlB+1UVno/6O6dbymu0A7Iy570mtdFU0aIJJIn1wME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444532; c=relaxed/simple;
	bh=D/yRdA1C2cFH0myYAFjysTILADePI+oU86faFJ60M4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RFA2gLWhGabK1lnLb0Gj+87ynJuVP0OypejVclHlXXwCcK2yqdFy/9Yqc5on0drIVhK9oO3kvpc4GKEfBDu5wl80M6rQlBPXbR9CSQY5PYfXz/XLr62jzhPg74c/kZvU5ERkcWlQs9irIBV6y9CpAUnAzE6Ur+VtcNBRQSSx2rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIQILTln; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIQILTln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835131F000FF;
	Sat, 26 Sep 2026 17:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790444530;
	bh=D/yRdA1C2cFH0myYAFjysTILADePI+oU86faFJ60M4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iIQILTlnLuCmRMowGwKFG9lZ4g6pw1d53svc3BrugXcljq1SOZQyHfocgbmO/quGV
	 Dg76az45BwOlkqyRTnajEoAG/3XkhTgqqpyjfFZmH84YztXoztj+DptCq3mYbDV/Di
	 7EZgZapqJ8xIPWS4PT4ct1eVtgsaF0Wx/s6XAYff/ulexZdIzG40QlsKdi7SQ5e4Gv
	 M8ZJ+WCZGFTrnv+VTX75PaLPhwcxJgkV2tPqPPiCXPUtt0zziiFwpBPAj7qYXG01QX
	 o698TrDWkf0XLdsQkxuexv8c1sJpfDsHHBHKU11AqBeE8F9sGitn1MoMOQXMPCNw8T
	 Pi+hkrfTUyqeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] rust: serdev: use DropGuard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: gary@garyguo.net, linux-serial@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260926173315.56772-5-mohamed.osama189110@gmail.com>
References: <20260926173315.56772-1-mohamed.osama189110@gmail.com>
 <20260926173315.56772-5-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 17:42:10 +0000
Message-Id: <20260926174210.835131F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Replace the ScopeGuard usage in the serial device bus implementation
> with DropGuard.
>=20
> Use DropGuard::dismiss() when ownership of the private data needs to be
> transferred without running the cleanup callback.
>=20
> Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926173315.5677=
2-1-mohamed.osama189110@gmail.com?part=3D4

