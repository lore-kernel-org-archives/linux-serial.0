Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115839;
	b=Ni++ITPAFWQnU4/IF4uLaYOqZesBN7xeJVG4F8tPOlYt1h4U0cb1+E3uwerw4bGce/6f
	 9cQStM1ZbkN8cFFM6bE8PfuJiLJD+L/x7NBeK2pZqEZiXIdsi4FOQZ9PiTziv128hSAqT
	 1v4Vr9fY+cWvWTm6ZdAFgUXAXB5EpgDjf0WIJxJw2z0turWPu/a0CYGMgGrKCev0T2iSU
	 C5lFHsGle+iIJ3WaLkH2y76xXFCXbzrH5tnxdzwGTGb4AWPRFI/Q9e7xRoMtqPfZqsjJ/
	 RpDIgMsda/luz3HwSkTIVSAhzd32TC/KDKwCAAkow4FPRlcWFijavvpJbUXFXyp2ahw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115839;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+ZxlcoYtuvg9XJsxGMKCG+ddJq18dVncIeQJP7zYLwk=;
	b=xpGGY+cr52k0LLmKZvl8lcQ0aK/PricpCePfLND1bpNttHWgRZsW56wAvF1pFsGl3Kvm
	 SawI8zbw5FZj9Cgv4/iB6pMmPFb3B0kx/yVKU6NQsjBO5AzlQ1uSSzrez07JP6QrW8mR6
	 kq+RXxgySyddgk4/DXlVS3AJFABFC2Qz9+A8zEP1QxHiP+hNUUORXTZxSUlOF7X3Xz4Or
	 rCEjCZPx45sMvcb4Onq0BQhYqSEoiB+8lQhK74cIb4K9ZEpbJndu0gzuXywqwg3ayx1bk
	 ig9R668ec7HJWd8QPqDrYyBZB24cnVjAArhbUlybxTM6cbnEE373pwAXE9C373R6Cag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDc836CD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28768606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDc836CD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE511F01825;
	Tue, 27 Oct 2026 15:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115839;
	bh=+ZxlcoYtuvg9XJsxGMKCG+ddJq18dVncIeQJP7zYLwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XDc836CD9SeHJc8XBH6u6UAtNLIICkmzG/eIEgVa/cSd2gZa6Ghd8zIvUHlITaBMr
	 2sLMWPTbwdDr+Pw1ov8XYBwFYP3Xyw1i+mXYUhxlqhe0c6JjwBNptWsfcpMYMM7jct
	 E2WBto3ix8Vibm6wvnG2OKCNwae4VYX0nNii0SPOhWQ83tgjW/9z9/xAQV0bN4ElcE
	 ic333yhxPtQNlwqr/33PxTp1McCsuKh6P+12z6bC9WV8L6YylcI4O+nDjgIMVBIeGo
	 +d525f5A7zJ8SSfcI1REBc06+8XqXR8BiDFqFtwiTG+bxFyYi3icRtpGDEeToh9C4r
	 dxMV4AEGSJAeA==
Message-ID: <sashiko-outbox-186863@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 05/18] mailbox: add A210 AP to E902 doorbell support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-a210-scmi-v1-5-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-5-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:43:58 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Add the AP doorbell transport. Allow firmware to retain endpoint clocks
> so that SCMI can provide clocks without depending on itself.
>=20
> E902 completions and notifications share one interrupt. When the E902
> to AP data bank is described, firmware tags each doorbell in INFO0 or
> INFO1 and the driver exposes notifications as receive-only channel 1.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-a210-scmi-=
v1-0-74d58ce85bd8@iscas.ac.cn?part=3D5

