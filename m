Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648873;
	b=rKOQRltZQG/wfKu5bpI30rZw7lri3362jiLEBnjYnTwZfJK4PJVI1h5plbnUm5S0Fxx6
	 1q0gVHiLT54y327srAT9GVEgctkfMgkDFSg1Z0/kTXTlDAP8pdRflIrm6ahKieqSEVO7n
	 VbQiGLngHumZChzBtIdLGDexej6yQb4ugO5Zzn51NJ+122ojirtWNscG5fQ05CUNOrt/o
	 o0p4xxXQYjAVEHJ4wqrjm6aBRjPLPU4daV5+UhIK58ZmMWq7AUhRc2f4L3lzHomEVj0+K
	 1QVlWNRvBz05L2AX36nPZMr8+H633ff5vfbwGwDA6iKpjoih4GRQ+DEmERMic9Rvzzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648873;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9XGv8tfPQ1fh6eN4wtGe7cx2RIoTXLg2wLbHtQgthnM=;
	b=ULZ4F8FS+0Xh/D5JWC7aiug0XJAkP9ZHwjjq8Fc1eGf5R5RKWLHJ4HmaNFo9n1BrrRJt
	 3HU/6mz+Zlp+3Fhg8QstUw2OPPadn/R4cFpExMzxJJG7ZyeBKI5EZq019YNZhtCp8Fal3
	 ei/jrWrjE/KZuQ7Ks7NZrieP5CLzmDskU2kt5MroxDEPvgGCXPlutYObjshkMBts1PzyB
	 0pRGBJSc7tc59KsX7RrCaXZICkms3K0S4NtDEbMCvBC6WKR+Nj2BV4L7PxtTj9KSZrbSv
	 TiHZGmZ4cu/0FYdtEowLS99Q1GUgulzUInjxEYh72AEy5J0B10BbWkWHmkoeFwFsOVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RgdcWmqE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B93E606EE8B
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RgdcWmqE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7D01F00A17;
	Mon,  2 Nov 2026 19:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648872;
	bh=9XGv8tfPQ1fh6eN4wtGe7cx2RIoTXLg2wLbHtQgthnM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RgdcWmqEE6yhRjydMJc/01L8cnQHMklFvxdGcPeSxPYxCeO0d8sn5VZhEaMglgkX9
	 yJ/uNMQzkHrp7Bb1m0px4rwT9QnRRyIIxA3WUvLB+VhesrrLGLljve87UrJqTGZcVV
	 DISb17ZBLbJdLcYypeB0rRQPsVilVQU0VmlugmNUdBTslv1wht8IlO5yS0Hg/8CxSv
	 265njuArv+ssH1fyv3rxBsWBQKQXXONXc+UgLEkYf3mn+lE/7AUV6VAYbZ9QVz6CT4
	 OiFBi/6wC98oQicJsB1wvKOPfVFw923MXZWKslZpSKIVV+wiGwEt2oitF0jWauR8ml
	 SzPXjwQ02OWhA==
Message-ID: <sashiko-outbox-194020@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 02/17] dt-bindings: vendor-prefixes: add Zhihe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-a210-scmi-v3-2-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-2-ee6b31580808@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:47:51 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
>=20
> Add the vendor prefix for Zhihe Computing.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-a210-scmi-=
v3-0-ee6b31580808@iscas.ac.cn?part=3D2

