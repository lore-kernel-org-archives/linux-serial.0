Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7687F485513
	for <linux-serial@vger.kernel.org>; Wed, 14 Oct 2026 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988520; cv=none; b=ko0Czf07rF09jDSY009hx0e2QDyjJ0YvvKqDnR0h5K/IwU7WZtSzpZ2g3+t84T+ifTN9I+HVaGBJ4qFHPe1i/O6lCQUcQ1AWXefZu6Jj7aJd8igwnXlNmdd7hCunBnI1NmKWMhILpXx7dQlIV2ADCld1jCLE037N4LTau3GY3uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988520; c=relaxed/simple;
	bh=HFzCTw/Xe2VHYPs4rsmwcVws3YhbGbnB1gWtULyhgeU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JzmhXtzF27EJupGIkaK0j1XrODpdSYqmikr1GvvFQmFH8XN3/3tDtwXQ+TqMBDL2B5wc8Z5d/+NokFvdAtARef4Vt8YkeOXAxCXnYmv3pGSytv7c2nRDuevAU68gr/K3ean0/1V1fuou032EinMXWQpp8oIBpE+SnrIeMEzBgcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2URaoAZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2URaoAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41671F000C4;
	Wed, 14 Oct 2026 14:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791988519;
	bh=HFzCTw/Xe2VHYPs4rsmwcVws3YhbGbnB1gWtULyhgeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S2URaoAZbOgG8+k60LE5Js6vZ7Wp7xSsPjnOrsd1khcEmDFY7SU20MJOmZnqG2M71
	 KZcOgTth+McHWJtvqNe0auFL1bdPLEkTPYbvTY5eT09rTggakQ1lD14lHyZx3ZpWDH
	 nHh4C0rwIL9dj9TvFbOhr/AkK49BCuIagH6uyLPfpN3hS/1aIrOFyHVb+xGHSjy9mN
	 fPwGoKQaAftbCipAAMlVsOKKrQdj0wLOeLUkQm+3W/HFX4svMjFyK0TGPCqvSCdZjS
	 7l739N9YblRgvzVtbkWD+APu3za6QOtDjI0xRyhVkPa/GxZ/yoH51HRmry/nyH4OPL
	 nfw5q6g4pJvgQ==
Message-ID: <sashiko-outbox-171435@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] serial: core: Use isdigit() in uart_parse_options()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261014143034.104950-3-blum@kernel.org>
References: <20261014143034.104950-3-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 14:35:18 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Use isdigit() to replace the open-coded implementation.
>=20
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014143034.1049=
50-3-blum@kernel.org?part=3D1

