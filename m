Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115731;
	b=qcVmz8tgAJaNCOGCNjFA9q5uCmKIfVYxnqfXsyMMkrzGbdxZqPnWmcH+v8by/LcBCr+h
	 5EiGa5PsUlOaTQL3197i6KJfiz517wmhDZmlCJHCPe6Z73K2I7xsEJOX8z3Ty6wTF+jM0
	 /tHSFBa5CrjE7ALY+bD4LJPdWIaPmpVp57q2aQRKH8sKoGupFHmpI06/dsQpRWIvDvz2j
	 nq9X/bvsnbbY76ykt1aFm/h+/GOEc/zuePGy1J7dnE36nL6r8kmwmpJXuLQ/uQcfCi39E
	 shAYi6up9OW8rcI7lu4zu5f9HrDYp6rVYBrGj8dXyUWjN9TaWYrvHagHjftBhnoFS1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115731;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Sp3wdgmExItoTy2t0eOE5nIulXeEmzFdEzKBeH72+04=;
	b=oN6B1Ji0fVaWvHhTPrVrEEVQGZCcFHpE6ukNf0t1VZu8LMUL71YbeS6wEmPJiaHGSdk7
	 WXhB2vXLp4eyZELhDuCC0fBqCxgu8gh52CJkzC0jK/X/qvQ4IVHcHsQgTPTBN2ekZZH+D
	 RNzQJByXSiLCMgFNaZir7VRS2ybe0zqz9vZQRPixij9gmnbPLri3hC/mOALcFVRnp7PCV
	 y1je8JxcG2Q/uN3eZ8h/AePzwCFfhrPKB0gJcBqwQIt1I/6wGE8vTw9h6k7NfcNHkzkmh
	 RbN28o2NASE2SKNc0CB+8KQ52olnEWz+S+Ck9+3z0zkSZ1PjF+smr0TVJl/QzNT5Fzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjIfcQyR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE35606A31B
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjIfcQyR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBF51F01825;
	Tue, 27 Oct 2026 15:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115730;
	bh=Sp3wdgmExItoTy2t0eOE5nIulXeEmzFdEzKBeH72+04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XjIfcQyRsxELEbosnt914QRWhfNjREMSLzcR69AYJW4h02msjWDmRZI92BnMjJeJp
	 b4h0qrYu+lprwTehiRZmHII/JYfp6U6w7xTmmb9b/fjyYSaOFzYbZJ0evFzj7nVNKh
	 ea/7RxQUyul/dWWiixkLir483GXAdOA7fb7Mziwi2mJFcH/TRdQrNV+0f2hH31fcrX
	 NSrgzyPI/manznAU+HVRRDcZZqbWXutRFyYGVR1uBni5WfFe6SPG+41DXsnXvyrGEc
	 LHEWbHWsgTWIHSQtBwuyhcvpNUK2fNgZYWFORNacF8PzphAumt7eDjokXMEcqaldL/
	 IIQdAPpZwdkrQ==
Message-ID: <sashiko-outbox-186861@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 11/18] dt-bindings: firmware: add A210 SCMI clock
 and reset IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-a210-scmi-v1-11-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-11-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:42:09 +0000
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
> Define the SCMI clock and reset IDs for the A210 UARTs, pad controllers
> and AON I2C1. Each UART has separate serial and APB reset lines, so
> they get separate reset IDs, numbered like the matching clocks.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-a210-scmi-=
v1-0-74d58ce85bd8@iscas.ac.cn?part=3D11

