Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631513;
	b=RgNT5mneAQDUzb5Cd0GtWY8MCJZMtwDGn2XbOsrRKt5BdwhC66YcNItQINqOdQa8C9Rp
	 VytnFMIfMo6D5RNcGSzWNDoq/5/T3107dnJMOF8N/3S+ccKPxpGwYXZ+cZxQAsOkzWmvT
	 WOdgC9WUuR+vuNxZ5vE7U52SXBhlAxbPxf7CNUQe+dUH/iCd363SGQJNYe1877NVfdNMe
	 ++FUQmSrifD+lVq5eUaH/9TU3kyAerJEdW+M1OI2R5Mv7E40JR2eD4tJX+bVbmSSKtzbX
	 SNSZWg6v4LywvyOY1Jaajm930z9f7Ee09Bk5eSDbVo8KtieAYZttazdq0nHocNMFncw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631513;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xecuadecoOAY097t+gFyQ0Q15kr/OSRQ39/jpp4LP+s=;
	b=mGyWTfE7DWt/dnX4fSBHpgHNw1/yEihFmCy4YGDOWHqQaMjlHIhBm1Ex+ogA1BTvysbn
	 +Fu5BTR14ZaLoOoMFIVlwh148UpCJxw+UyHXMRZyTlM6foWpgl/A7z8mZU4TTSpat9E/1
	 CwFRtjeS2TN6MXhl0Rd7rgLKOg7nqZ0HOrpmktBrzJ2DqV+7nGdL0mDBhPr8faFXXbn+i
	 bSulQuOjdrCVvpWBReoPebTNxFchw5j0hMneT5rn0l3kRlfC3eWagB3O+GWyYkW7W3Tcx
	 PKQRgpdKFS3denRm2p/HgQFz4T+sUFMCyppAOiSw/r2KWEElAjKVQkjg5MQgBTenlIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WivZoX8r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4F3606A327
	for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WivZoX8r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754171F000C0;
	Wed, 25 Nov 2026 18:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631513;
	bh=xecuadecoOAY097t+gFyQ0Q15kr/OSRQ39/jpp4LP+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WivZoX8r3VXnfBc+uyKHSzLiiFBz3gPSyYVRErPkxNlN5DyR5GpA1aZanEmZxpWjE
	 EQe13kh71j3mI/DI5IXrUuPZkpa/dl05ff1yk7Kee9yUpYghr7hWWipalkMWA8hdl5
	 STbM48RbPMD8cT2ZGxsv5yNMVZOZpya9H8Q0XgMicdCZbHkTLCF+dVsTqCPBLceuVZ
	 jjjMqsE26SF1+GkRzVW5HcTB8aU/kyfLVXBYwHgXotZ2FmFt4azrTNKZG4ne4Y90gW
	 qWksqjgKPIaHuNjc58c+2mkoZM040SssS+X5lPnhyvvQ36MaHPBDGqiVBIeVa1ZUzS
	 PehU2cJJ2UVuA==
Message-ID: <sashiko-outbox-234000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vt: Escape the CUR_ prefix in the cursor kernel-doc
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261125182903.2396749-1-takano32@gmail.com>
References: <20261125182903.2396749-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:31:53 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> A trailing underscore is how reST writes a link to a target, so `CUR_`
> in the prose is read as a reference to a target named "cur" and the
> build fails for the three cursor helpers:
>=20
>   drivers/tty/vt/vt.c:276: ERROR: Unknown target name: "cur"
>=20
> The same line appears in vc_cursor_start() and vc_cursor_end().  Wrap
> the prefix in double backticks, which is how the rest of the kernel
> marks a literal, and all three render without an error.
>=20
> Verification: before the change, each of
>=20
>   $ ./scripts/kernel-doc -rst -function vc_cursor_valid_size \
>         drivers/tty/vt/vt.c > x.rst
>   $ rst2pseudoxml x.rst
>=20
> reports "Unknown target name: \"cur\"" once, and vc_cursor_start and
> vc_cursor_end do the same; after it, none of the three reports anything.
> kernel-doc -none on the file is silent both ways.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125182903.2396=
749-1-takano32@gmail.com?part=3D1
