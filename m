Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649687;
	b=RyY/S9hg1NM7/Tu5fxbJqDNg7o2yUFLFlwUNrl9/O0fPLNNKBIp1msYd1ksh850KmmIl
	 qLTrh6oFBh1K2yM2dU9YmpaNKJIwSVnJMFRK1ZDhdGJG3KFvaKpSJkoNXesq5+UBxVao5
	 z/tCtUEsQrUKmr9jfkNPgX4S1GTo8GofvNlSSE1KFJPhT2AqnrWpxCFxSOTLTH14o6xmz
	 yxe4YjX5IBqDS/Tx2oqg2+cm7yOOX2Bp7B2R6Rx2wURtZgWgnkP+tyl6Ouz8fUdBl1I5w
	 zQbS3KYIklz53hFd+i5+0j62ZMzFvKJjwOmMLZepC+niiSiIfW/ewBqnJewF4jcpNww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649687;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wxGVRIy7WGTlTjZqdT1bofsf3hKligdSkuVo0A+3ABo=;
	b=Zxxjq8s67sN/1fdmGI1t+yBcUxV9FLt0E8YEcBsiZS/VXxkGejc8AgHAwF1LsKmIIMU2
	 ROiqvOPpAUFnSp10cyH3HfB8UGb2L0xvzsf1X5oslxqkaTqogf+S4RmgfgWcYoro794sy
	 x7Jfb50S9z+ZkUQrXFxv3rto9QcP/HayOfU9iF8xIy6YxcX2J94PMZhFgdEMAv21wxFkt
	 57CFYt/fX2r1W6G2+z45T+Et9E6Uofzmrg10j04fMhpB2dCphQyjjO3KBW/vpSlBx24ew
	 LRk2+5dweaFDRIIgI4dgGa1Zoxi+IGcGd+kU1lyrpAFdC9JHE2pKIRhpS/g8BiXfuKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zc+3YZ/s";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA26606A326
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zc+3YZ/s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0DE1F00A16;
	Mon,  2 Nov 2026 20:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649686;
	bh=wxGVRIy7WGTlTjZqdT1bofsf3hKligdSkuVo0A+3ABo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zc+3YZ/s+WwR9j2Rono56aci4H92EQ/NGqwyu6lTY2SHfp6/PyZp4PAUdI0qy1X0l
	 6VI0bO7NbBesYOf43R5wZSOixqIPW70uUytp0/6KPC+pWazeFMdFnUR4W2bg+kCVKB
	 NTuHPfLcnF3nKr6uCW8FIqTH9OG2LvDdgW39ltPGhDPgFb9IHuk+iCgpoDUiwY3Hxp
	 l0HdV/2ccKMdQpFMeFIrR3l3LGoPV6+F9gF8WXkghNU5l1E4xuuF0Q7A1mRRSQFnz1
	 ueTnVEiSw6yBjKyg9yKoD5BZMo2iZIP2oVGg9479tRBmnBVJfZ2UfgROQJYJMC2Q6j
	 BmApvE7u1MT0w==
Message-ID: <sashiko-outbox-194046@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 08/17] dt-bindings: interrupt-controller: add
 Zhihe A210 PLIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-a210-scmi-v3-8-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-8-ee6b31580808@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:01:25 +0000
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
> Add the A210 PLIC compatible with the thead,c900-plic fallback.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-a210-scmi-=
v3-0-ee6b31580808@iscas.ac.cn?part=3D8

