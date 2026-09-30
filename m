Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7F93C3459;
	Wed, 30 Sep 2026 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751742; cv=none; b=EHx+AfoCtTOnCg+jErIIiy3P7IdU6KPcxksIl6oZsR+IBeBnKWLrVS3SmgXof/6X29JPEJh+3fELMG6Q6PdWjdBRIjzMMqOAdMiBV9KDp6LiFJ1d40HlnijGnaTWYBXMKETJjlAh9Z6Uf3RW5B3TA7JhQyhRVj20tcvGHB+D86A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751742; c=relaxed/simple;
	bh=JZkXiRDqpDESTB8VjPMA4groSF4mUfejFjgg88XU2LI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m4MPXhhcA1aRrFjDrinHWWg14sXWSLjyeO1T1slpiFMDu/EmGzJPNJGe05Z3guvzsldvjn21OUM/Lp3vXZn+O+I2/Uv/GbXAUMrfqvahurYs2+aNFRp+bhXIGGXyhoIZO5nt7K152DwIGofV9GanFKtDJCQXIvmb11vco1ypIu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jfg/l0kg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jfg/l0kg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79981F00893;
	Wed, 30 Sep 2026 07:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751727;
	bh=JZkXiRDqpDESTB8VjPMA4groSF4mUfejFjgg88XU2LI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jfg/l0kgJ933DpI48z5GOUk14ed1ZbfPLVlNi0tLSdrk0dc6ZRkWmvwlTipwt5xa+
	 HVQv5+UOoYBfYt7I5YJeCVLIDRKLie1vmfqF2SS4+CsBgFFju9C6N5kvsIZAt1wu/h
	 qHPZUb/5FSapq7KAB4DiUZjBwWwYup3NZ2XkNSqCwwVCUNxNJFS2fzbRr5xUQ7bM0T
	 7xtPCKG78lRsJ59LqKaeSd7YspGUdXuqSBGR4m8dxQFp38J5hHj6JbchUAAMsKMYPk
	 eFFDzy0Bx7SGPJLppp6phQ6F2d2Z81B0MH1DS0O5v9Yu9Ofr6Xez/jR2fN3FKGCStJ
	 0drLDL8kxDR0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/10] dt-bindings: vendor-prefixes: Add Securifi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260930-b4-cs75xx-v1-1-4617c4463529@gmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-1-4617c4463529@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:02:06 +0000
Message-Id: <20260930070206.E79981F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Securifi Ltd. makes the Almond series of touchscreen Wi-Fi routers.
> Add a vendor prefix for it.
>=20
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-b4-cs75xx-=
v1-0-4617c4463529@gmail.com?part=3D1

