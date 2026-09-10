Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686D848B37D
	for <linux-serial@vger.kernel.org>; Thu, 10 Sep 2026 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046174; cv=none; b=hQGE8tR8lmDGuUXNjrFRNgB8bFDvJ5rNZ0KUyQU8ONjhdHcWSycRr0CzEseuMa/SxiGKYMUrbpQOhZokY8Y1kjz3ELprR5+6kSK7up2bXvuOsvOJnHqCjeLlVGSyj4MWTAFoWXJYTAVWU3jesC7K1V17P8Rl6HtCJEtvnAw3BYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046174; c=relaxed/simple;
	bh=EhTicyKf8G93Zt4d1ERrU9nXpeN+zfInj40kTh/4u50=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BeMeS0E3wD9DhDRNRdjEoHL7cyC8wNv+q4X/RvFknvvGo56qe6IZJuNRSyV0+8X1yX6RtgRl8nIFZHtmnJ9k3Crx+K4GzZ7YuFpPltczhEOnKDpTVdsyPGd19gt/ihVs2lFrW6FuGtT+4XY99c/Xw1IDUVacX/RvyaZDorPaNh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1VlS/Wm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1VlS/Wm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF2B1F00893;
	Thu, 10 Sep 2026 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789046173;
	bh=2QgqTBuyehCEBb2oDD2aslzScHamSR/EHEoz7liH+DY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X1VlS/Wmdz/amEj2aEGXtu5RHc1zx4/451t3++8Wnc5LzTNHHBDRUDIS7qd1C27Fa
	 bSkCv6gWV6YLklo453I1ryeGzvwiTjGSKtVM40WOWRLdo5pVe+W7pfHgMWXWJUfhzb
	 oKFxw7gOV7OfF8FXodJ3q1XSfMOARbZbrd8enoyS1ZmnfGB589iDHW2ruKXK/D18r1
	 5/sFHHSHRS39IC76enBHua57rS986kH6s4dWse5j3ffWWLXunanfgtWR3KoKHOAWp3
	 HefAbyDmi+x/3hcjreMSETA8UiElxLk537LB+NGnCJ00sR2rK2ncbp2PKYKccCsJSy
	 fgPHYB02AUHTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] serial: revert guards in
 uart_wait_modem_status()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260910130816.642699-2-johan@kernel.org>
References: <20260910130816.642699-1-johan@kernel.org>
 <20260910130816.642699-2-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 13:16:12 +0000
Message-Id: <20260910131613.1FF2B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Mixing scope-based and regular cleanup is discouraged and
> uart_port_deref() used by uart_wait_modem_status() falls in the latter
> category.
>=20
> Revert the guard conversion in preparation for fixing a hangup race.
>=20
> Fixes: 56609c050051 ("serial: serial_core: use guard()s")
> Cc: stable@vger.kernel.org	# 6.18
> Cc: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910130816.6426=
99-1-johan@kernel.org?part=3D1

