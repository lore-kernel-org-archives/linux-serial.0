Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742534;
	b=yG+ciRC4t3ZDTfSpa+EUz7Ljk/Qh80SvyQjkQ1kQwFHNDRwRSrqIR8iB1vBgbDqcBg3X
	 F7tOiP6RVCgOEHTT9FZZRwuFW8yaHArf5f1ADwbuAZb5kGQEO3jeNxHMomsjpnUKw2CB5
	 XjlBm8tJUg9thwhlIesNHdFLRcy1chNa16tjL82jX3Sb1aj1f3vDjNxG6Rq8MDimrikp0
	 y5dH9MYwlugQ+sjAyIFM8oEvIW2enh8alzOtMmdnEJkh6DsHsfpDM3kncODYatsFQitDB
	 oC/rJqUtfLumwRGXRYQqFUQYO1tjdsA+O3Zdv3vGT5vAofXl8BzP6sU5IhRg7PJg1qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742534;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PVkEZRCoPCHn5j5IP5BBrvjnYsvmEYLOAXYnOI/hFVU=;
	b=vPuhQbVvAbWYj4r5Vbi7mehp/aTG1miSLb2OaA5AFckp3uZc/ujeSTsERzuwYm3UGORG
	 NHgsUiR8Dk2Qo9o6XGaV9do7xk9opgjlQv6Yak+od1BxwzV0EjWHMr1LtKQgnNxFEswi9
	 y4oZO0n9fXZEHauS9ZTN7TrR+ZdRHf0AyR+z6DhoEcVBRnl6PT5j9wm0m4ikDWASlrW6J
	 DBLXRyaHaDyz/7OPEQRfQZnmKtb3NR4cvKYTuu7wkPwi2RaEXwcHubDC1k6z5WIgcY2YB
	 srIv7+XCZ656nnGSqwbMh7WbubUjbmU3z6N2sXumENuOz+bI+5cSkulTxUjf7VxECqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMB+wOnv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB725606A31B
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMB+wOnv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB531F000C1;
	Tue,  3 Nov 2026 21:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742533;
	bh=PVkEZRCoPCHn5j5IP5BBrvjnYsvmEYLOAXYnOI/hFVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VMB+wOnvkEFYS0UXXCPjBUd4wto7Cqu0zqkz+Ua48P4DnNtlD46EWhfXVI+0O9UPj
	 5pMTNlEgzpQrKGSP4sNi8GvFF2NU/Vt03F3w/JUC7ozsC49/2rEvmzivc3rdQgf3FY
	 o8lNFxAn+PBndb1Xevuh95pvoQy4rg6XrJv203W8i2KgzPZLRkIojHmdpqdo+lEVDg
	 H5vbrnSo26boIlca5Lf1KqZ4aC1ori4/DKFsz9M9GKzoYc9/gACKQBIR11OJHnMGEc
	 VOTadk2GBivPFBVr7r5GXp8h9HWHlwbpteKcXONM+Hbga+51U+Fu0ThWn1+bSNV4KM
	 anTn9lDKtOd+w==
Message-ID: <sashiko-outbox-196081@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/12] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-6-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
 <20261103-submit-h616-uart-fifo-v1-v7-6-c9e248d685c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 21:48:52 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWare
> component parameter register does not report the FIFO depth. Its optional
> register layout also differs from the generic DesignWare integration.
>=20
> Add a specific compatible to identify this fixed configuration, retaining
> snps,dw-apb-uart as a fallback.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-h61=
6-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com?part=3D6

