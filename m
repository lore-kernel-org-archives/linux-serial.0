Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912286;
	b=AucbZV2omEZ0ytbUrMt1Z7m8FVy/BW2JL3I5gMo6cyBrLURhceeUGHr/qGAc6oxI0Gal
	 Srtf3S5xs46XUbMy43Bz9omTb+5vYzLpVZDpkWvyw+/ernlg8SPvdeGpAgKkLpnCvi4WF
	 0bjOw/8cUv3fNmB/X1h3WR9ntiVdZb5sbC0tIAo3qbxSOvkqQyk6UCX/ukf8NozrELZFJ
	 xXFt4dL742J8e6ypFBFivbi9cFfj/UcD1tW56XjT9MEq+Ck9pJCchdXR2GhYYKBaC+8lp
	 /ZqOpO47PZqf0YYAiooG5GUFPhVgeqKKCSfY4JXw+bXwNRiM8kzsOweAg3pCOBDR9jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912286;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6/pZ1UJ2z0JZg12Ny46GEa2ydgUx8OUO17kwX7WE9vE=;
	b=rcdo4XpZcaU+NG1oDIhljY6kTiOHOrFIXVF4i9iYcpleTGz+Jgt6l2agD7Wd8LhSTm5A
	 jS94S44urYS7PGFCtdoFyNuQlHJuWxtyKqn08FniM2weYbYONbNt8Au4A5SbMqCd62MJf
	 ZK1NGyQ5M6PZJedXV4vxnFVFVLsvfsZTQzvXSNitAGl+nCIuanKq016s4aZHQMUSWFgoU
	 dl7Do60SdWZtlnSIK2dW4asob45X7xkyFumTI19JZr9uPP0YYcmdcG4gMJ7a+ZxSME1UT
	 +YmxRLbD8p6XjH3EmvCOLV/vWXhGvvqp+Tv14corDf75ynXKu3LF/z9BYqlgAnwkOGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPg46+ye;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02C6606A31B
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPg46+ye
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1E51F0089F;
	Thu,  5 Nov 2026 20:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912285;
	bh=6/pZ1UJ2z0JZg12Ny46GEa2ydgUx8OUO17kwX7WE9vE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UPg46+yepS2ybba/QAUBJ9B5sUTgOL59DCodLD8PnTf1IuNCsR1chQvr8PuoKEdf5
	 PJKyX2rwqHrfmpYTNhXrEblwUAXTbLP1GqvdxaVa60P949AjvNt/mKPj9uDUM6aWfx
	 0FxTbqcDT/nDdoZwMrWK6zekoNjjZS1pzQXsGVcInsM2S8ba8k2dGvo8LP9SWeMJSF
	 76CmJvRK1fddGF76o/nguioGykDFfI1puaiI6nkiaogl9diNeTp7FHGwzCDctn5fTC
	 EXrCubKNx2FwmzVrJthiASthE6iy/XMJO7Ykbv0zoeAxmF8zaEq35oIpzrxmm0Ofwx
	 g+Yq3DylYxb9Q==
Message-ID: <sashiko-outbox-200169@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/11] serial: 8250_dw: allow port setup to report
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-1-14024d2b184b@gmail.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
 <20261105-submit-h616-uart-fifo-v1-v8-1-14024d2b184b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:58:04 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Return a status from dw8250_setup_port() and propagate failures through
> the DW and LPSS probe paths before registering the UART. Use the existing
> LPSS cleanup path to release board resources and IRQ vectors on failure.
>=20
> Keep the current setup behavior by returning zero on both successful
> paths. This separates error propagation from the configuration validation
> that will use it.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-submit-h61=
6-uart-fifo-v1-v8-0-14024d2b184b@gmail.com?part=3D1

