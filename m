Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D8E2E7165
	for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329557; cv=none; b=EhWZDVb+gGAZUyQlKcv5a/hZtG/rqk/fmRv9BQsZAzjS03XiI6v08R9q/IwlMHYX0UFBdfJtkxD5xEEfqU4FSENzMMQ3RD0S1nVQQ1Aly1Fhifl5zYxSobmV73wg7wD2sfMvAUeOsdzTprpnTrh+wOgGyZKiHLS/l9Z+6L7rz24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329557; c=relaxed/simple;
	bh=7C3EjK+3Rl9OCfBZDMSn22ob2GIslKxqtjwm7GGIjao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q/BjHjoU8spURb6Q9HjuKeQigDZmlYZfYBbw5zcBUL09C9gxUQIJl0Eo9/N0ZOEEmlzdRXGRgBPgnzOjwZHqBtBHB6VI9pbuseEKnS+QHcFAUohc15sXckImZRMcujt4NLQV/VlrhbgUz6zqduiP5oS4dUKcvTvKF7LBCNj1KD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq44g37p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq44g37p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514A11F000FF;
	Fri, 25 Sep 2026 09:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790329556;
	bh=7C3EjK+3Rl9OCfBZDMSn22ob2GIslKxqtjwm7GGIjao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uq44g37pcWWyYEcLuY1Zpos8ARuxBPkVc36T0bpcIDhdzjFNaNUTmvdRgf2/2pLkT
	 hhWQnHYkZUtB2O30rClZ/Yh8Z5Pjob+en0AjP5hm5HTPINEKUKRKm8IpXVqz0bMWhF
	 Y6Za+ipswNFqPyw8JT+b/C6nC2anspB4CfLIs3TVJOZIpsZlcHzpZSEZzHrYxNQ5ge
	 b2H2mPCfexRzeHZA7VWVBrEkFCilGVUYEWxSA9w2lMxOtv+4PjbTJjiYei9p8OxCTS
	 VzNe8qNgfKrHm7p0t+nal61eTKjtiJP4bJpfh4ne1IkwfVJeorAVFHthA8dV9gywI2
	 HU7x6qN9bjYeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: add break_wait kernel-doc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260925094222.18303-1-johan@kernel.org>
References: <20260925094222.18303-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 09:45:55 +0000
Message-Id: <20260925094556.514A11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Add the missing kernel-doc description for the new break_wait field in
> struct tty_struct.
>=20
> Fixes: c7e9bff9b4b3 ("tty: abort break signalling on hangup")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/20d75a7a-2e7a-484f-a267-c21db82dd922@infrad=
ead.org
> Signed-off-by: Johan Hovold <johan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925094222.1830=
3-1-johan@kernel.org?part=3D1

