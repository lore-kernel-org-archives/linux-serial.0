Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202345;
	b=2eo6AcMbz98fjmEnR6rM7uUeoguSxI0x0MWwIdXKHxtoq06mi088UB5vJMQPQHz/wt8/
	 DG4QatrwINBT9DlX5JI356yPKf82PjqWPMJl/dEeBgkdImUHSjPgS+RDm7DOoQnDPHTQ8
	 bem9lRXUGB8jGazaShIYwa6D3cbTvs794aFYbshKvBucMUC8EwmVmITrqH1AQBGXAQ8eS
	 BrMljZaS68iuSZaGoAog2L+Qq25ok6ApPHuNAGWqFHJQNqXSNnWud14qxJs3F3c5qqskN
	 25w3Q3NnUzh8rc8T1upT+od1nasE8+OWDHgNxX9dpyPLY8AaJE8hvUL0WwWOUXYPqcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202345;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YaVgaxtyT+IjZUuV97C1el2hz1yVbwZtJ+0fgiL3xm0=;
	b=xFl93V4/E6Bh+LaZ05gV2C0+71sfnzxujZZFbsaSVFlGMru6nUV5vF0Uj05NpDvfeXiB
	 pBYuiqviKwt7QsUQgJ47rlM17qzhiunqpvF9LW7jKws4z+nEnZEikzBBTXyarrTN+P3R/
	 3/ZKc3uePnC109mv6vRGeJH1vExmtj9p6XqvkK2x2glp4aXPdiJB7eBbN3SwcP203e4MD
	 Z7ccTGZARHK7TpUh5i2rK7yltaSi7m+kaBzRLl4WtWwmKUeJGaasgs5Kgs92I/9iZYGL5
	 LozYhZZ+bNZ1jW9PzodB6WjP+RgCDwrs8PQTwNFqJqJDTKg4vabKHe1vfzOnnIkNaRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hRr3/5pI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D7606A6C9
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRr3/5pI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FFE1F000C4;
	Fri, 20 Nov 2026 19:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202344;
	bh=YaVgaxtyT+IjZUuV97C1el2hz1yVbwZtJ+0fgiL3xm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hRr3/5pIr//V82I7rFv/xK7mVtsveLj+gnJ6wSAKTrSLmpsFM7qd36lvjhKNKwhq6
	 QWB2o/ciJ61dWsDfRfEN1CT4f28V+gJiJ729vf7cr3XvXWGSDHFjGBbOWNl6h7oXvz
	 lOHyGBkbHwIiDe8TF/yJD6Of36Rh1/XoGQOY/qliREuoLpZ2qZ91T11JhnPbAkS4Kn
	 f0vxHJMTWsjs8WA4m4uzfi2oEciKyvzPsIKG/73hAa5Hd4VekEAFK3g+RmyPcy/y0y
	 vJ2y9nogRmYcRl7VnZTUM6maQLtjh9TPjXdqgj8HJKD0zKWJJayBkmK9ssB69oFSHB
	 9lU3utBs/yEoQ==
Message-ID: <sashiko-outbox-225906@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/13] dt-bindings: riscv: add Melon Pi V1 and V2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261121-a210-scmi-v4-5-4a795a0a9fc9@iscas.ac.cn>
References: <20261121-a210-scmi-v4-0-4a795a0a9fc9@iscas.ac.cn>
 <20261121-a210-scmi-v4-5-4a795a0a9fc9@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:19:03 +0000
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
> Add bindings for Melon Pi V1 and V2 with the A210 module. V3 uses the
> same board compatible as V2.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Co-developed-by: Han Gao <gaohan@iscas.ac.cn>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-a210-scmi-=
v4-0-4a795a0a9fc9@iscas.ac.cn?part=3D5

