Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733999;
	b=EjFeEFhjfTkhEtXGZXFG+CS6AC/bWMj7/P9b9P9k7+Wi9k8lWUVytzBRWSJ2YX6nG8wH
	 jU31snyvkJitmed1ZQz6j4bVZrpjdZ92S3gR8fccgsvP+5uZGVe/1ImLL7G33Vztk7YT9
	 2Zrjupv49rcd4MOUCJYmqaKskaPwXW2L8A2JY9BOq3DjagCt9rDopFo55Mus5ivZxO52U
	 ZpDpBrmvfLfVBkh8pmhuX307G+BYyRdRqo7iyyxkTB7+HP7i+XGr1tChYYGyYbWn7JSMV
	 KuvhBoGTWbiev07ISKIsu/oEYHnal65u3X0nWi+hyhuW1GoUaWCyht8Au6yIpucCoQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733999;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0KQIeJASQrnk5cMqp/oSViX2yaA/sON6eLAVdQ7AyWQ=;
	b=M6pZjrzpu8xkf1bO023cvo/8V6r4Tjxs4wwW3KUWaEwmpe5LM4BoH/xNXfujY/6glNTY
	 7KH0/0xgJgJstQtZKFv+klA+88J80YVU2XDETZKizTlXObTIZWXFfwUm4II+YUIppv6A8
	 leLDR1TRIL4+FHP/7A/qqjLUX/j18xZxXLS9I237FzsdhrTVceU5hbk0JikBpSFhQe8MG
	 5PIcd+IkpKh0qSWT0+lP5YMEFXgUD4e5zQ4teHJYGENL7KQOOn3nzBs1Ul1sNFln6bShD
	 9SQUro6HljZgMTfXVDoYCBvkj54cU5t2VWB/RXwQQ3BKJ4gHE7RurCSEejB6z9cZfQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkxlYKqz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CA6606A31A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 05:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkxlYKqz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E621F01825;
	Fri, 23 Oct 2026 05:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792733998;
	bh=0KQIeJASQrnk5cMqp/oSViX2yaA/sON6eLAVdQ7AyWQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IkxlYKqzca03ZDCeaJEA+LbpSkICcWPmYOlNPjM1XuNBKidgpV3YxW8NLHJJBt4i9
	 CAXx3A/OQAwmmV+yX3nitu/7grcwX0n6Jm1XCpJ09swyJZ7B1DW13UcEkYqz3HAaJH
	 E49KCXDRMBD76+IThz8ivs2cbu9daZqOqv4HkO3OpmUZ+MdmveagaPG1LgOSOL/Ytk
	 fHOB1j69B7vv1BoUrEUa+2I+ECODyCuUn9ex75cGzYOTdRPT7lEsrHOzF7Tjk0uy7z
	 9lRIPd9sFZJHDGU7dLGXPrFGLJmy/LtXyaYsi0ZMqq+TPgvDZEkYwKKFFEQtYZjY21
	 NyAbvxNk27zzQ==
Message-ID: <sashiko-outbox-182325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] platform/x86:
 lenovo-yoga-tab2-pro-1380-fastcharger: Bind through normal serdev matching
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>, linux-serial@vger.kernel.org
In-Reply-To: <20261023052717.2577234-4-an.wu@canonical.com>
References: <20261023052717.2577234-1-an.wu@canonical.com>
 <20261023052717.2577234-4-an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 05:39:57 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The software-node-backed serdev client cannot be matched through ACPI or
> device tree and is force-attached to its driver.
>=20
> Set the modalias of the client before adding it and give the serdev
> driver a matching id_table, so that the serdev core binds the two
> through normal matching. Deferred probing is then handled by the driver
> core, so the -EAGAIN translation is no longer needed.
>=20
> A failing serdev probe no longer propagates out of the platform probe;
> as for any other bus, the client is simply left unbound.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023052717.2577=
234-1-an.wu@canonical.com?part=3D3

