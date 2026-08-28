Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8A0394E8A
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787940400; cv=none; b=Ba2BoRmmm9Aazl9Wb2Ua3qjL0qpMp+uxZSJU7B1Jic5+NFfTJ8DAe+w661t33x38ANZE+MNVDkCKgMX8pDgAAtZbkJAcX0TUfFNYr2+q041e8RVqpvFSIOcwcmwCxhL/5aXkw5exvWqiTct2EziVL4DLypbK5CAFKBp3UNL3TQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787940400; c=relaxed/simple;
	bh=F9gIiLMX8ysFHB+bdXURjhiJn9dvVCV0HpXdvntjL3o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jMIfuGCTDpm7CzWmpzbTnZ+EgOGaz/DfBepHqiEUAdiYrI8Z9CbvhJMmhe91fa5LzXA1QLoHtGv9Y34D69YGmv2ziehNkKTJsHhHbI5HhE6HVaoassAU32y9fTti8QoPfLj5GOMr96NSNLEDSyCbukT+7jk6TRGGSK9mRHxsrWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xh/8348N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xh/8348N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DD71F000E9;
	Fri, 28 Aug 2026 18:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787940399;
	bh=F9gIiLMX8ysFHB+bdXURjhiJn9dvVCV0HpXdvntjL3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xh/8348NVcyGgToS4sSn5BPewn9kOZdd36OmpM+gjpk+pu21+g/219y/VKVpwUHQb
	 NIclNtazbqvksfvAEat49ReNs+u4/sgrl7X7stLpCkguQN+iIP3CsGdyvPzac6pSds
	 LS0w3nGQqU0WC8a0cCva6XdzIJhimUKIZvA2+lGg0cgvTSQgrAc4guu2LigGbQwFPg
	 F15cm0bOBQvIk89LcXhz42IdOIsk3bN87meArfEuQCYr+K/DGzdfWCuMzP6Hd1DTz9
	 MNeK0cX6AbcfgOH6lgZ4hupGPpGUi31bvRF2VczLMceMpDRKGvt2fa0/wwnLUtVRsB
	 1ABua9rF0GsCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] serial: 8250: export and rename wait_for_xmitr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tate Whiteberg" <whiteberg@arista.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260828175733.1650267-2-whiteberg@arista.com>
References: <20260828175733.1650267-1-whiteberg@arista.com>
 <20260828175733.1650267-2-whiteberg@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 18:06:38 +0000
Message-Id: <20260828180639.65DD71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Export wait_for_xmitr() and rename it to follow naming convention.
>=20
> Signed-off-by: Tate Whiteberg <whiteberg@arista.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828175733.1650=
267-1-whiteberg@arista.com?part=3D1

