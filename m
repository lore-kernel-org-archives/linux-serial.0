Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663978;
	b=v04fdcRA2XBMRN8j6cafRtseWi9p1MKPAWutcjhu072P6fvLwoB/c1BH3vqPcMj57GTZ
	 RGnBGWyhfq7lzmV5KvfuLzYAnmbm5oRIDIxsgLu9PgxB2Flfr+vU02l9rZxfgsd1YCsWb
	 J5GQqAikPlqNZslzB6AgAAyl0QFDU7nf6O5SL99g5JzJIz7NtFFNw6Q2MckNgazHqrsTr
	 fR+/gQXVdh0huxSmnrk/TiTSm59rwxbgGCrVvBjac7O4xQp5PgICMWqczNkoPRtyCbCgs
	 o1fEQiVdVW7+JBppYIw0a+OiwTcuWXEMlFsprIH5A032nM1ri9xuniggN2p5l4bJmMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663978;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BcXfxBox/jFn063DHhRBx/7LrsbzQNGPR8YpzOhNMn0=;
	b=3XpL3BHFtlED8VJVU2VBpQtpMlMtLsdQ7YWdQSqIqStLzG4UmT/UhTOtBEnVYk6FNihs
	 R42VgsAXgGZvXGaiawfvrF0BjeMtCGT5uLoc1kW1LZTHnTZX33v9w+nch7B9O4FD8QMVs
	 q21NnHPvkyHe8vxbu+DYUCPuSgXxhgxxWkCYKKOAu+OYUUFdjPSt5vT8bxQUaH3wc8Ry/
	 72EFv2yOt38mPBUmoU2c08ovpjyxXObdhD0mdZ/VCFjlWc0motikK+tq3Sgpa1AVWgQRc
	 vTWz2rm1OjSZKywxYzkjiS1mTfz8HuTF1ESVyqti1LbOYABXMfn6K78nN4BEsRVmQuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRMA4u9Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E351606A330
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRMA4u9Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEAC1F000C4;
	Sat, 14 Nov 2026 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794663977;
	bh=BcXfxBox/jFn063DHhRBx/7LrsbzQNGPR8YpzOhNMn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cRMA4u9Yhkjz5H4aQoJgUwGauK9DEHh9EgQ8ZYqCJv7o7khUcgLCnOfYfRn9LjZ14
	 cTU+06XVfBenJp5mvay3P+PcZt3Psgu1ILWJe27vTp9dZWWV0iFE6s92n5ixV3HKK7
	 wil02q/6thibFfYIQPHPqQ7pdn90EaxOyXgAA6t+pmXBnHB8bhns2BS2pQJel1A54b
	 LRgbB3Y26PL37EDgUb7LCerqxDE6ZWorPC+GplK2HbxOkyYd/1jUgO6NswBgwbTR+S
	 gDv0agaUMUfh85rbdnC49B69+qutjMZr5mrj/1Q3fsMNk6BWM+48G1FFo8FVWdw3X3
	 uRv91N9qhwr4A==
Message-ID: <sashiko-outbox-214588@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/10] dt-bindings: serial: Add Cortina Systems
 CS7542 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114-b4-cs75xx-v7-6-8f17f38821b4@gmail.com>
References: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
 <20261114-b4-cs75xx-v7-6-8f17f38821b4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:46:17 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add the binding for the UART found in the Cortina Systems CS75xx
> (Goldengate G2) SoCs such as the CS7542.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-cs75xx-=
v7-0-8f17f38821b4@gmail.com?part=3D6

