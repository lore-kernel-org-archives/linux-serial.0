Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202413;
	b=W5dQhEG01M82ypRrr6Lm1RPC/dcD7DtTwXBnrdJ1zLzPIiB8O+Z6vT3LcqWUGGJW/5nv
	 hfLpWyXm2k2Ol2oGbU659j8MjcOFMf3wc2st0G7xRtW2sGJ4Udr+A/guHaYzXNzJHT+Ay
	 lHA0WjiqU3JljGL5yK8JTcN0TaUR8B8pAjEDmGX6/eC7THYRjmz4o+ZXHOoAigmQfX7Ea
	 KvB9nmMfVc+mcKcymH2vmbchTgYdHynW5ZDm8TsuBSrH1Gnfnek+jhOHRZNtebOjOepz1
	 SHNXQNOZmhIUpBwYo2ym8RSNM2JURtgA5E1evlP85u3yDkhYildVdeNNm0kH3e7bEwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202413;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sUgsp0OZtXT7GwkUBRxM5lQOIahGLGHJOqDHHUNH0VA=;
	b=gK5Bmj92TLId1f4mUsk1eOPBb5g+vzK4f0iAagWJOf/RAgcTrH4ndGplGrkILWmGzRro
	 1S76r/ofWMiJPkdvb3xEGxtA6uORn4B1Omzp2+bbFcW/I9sFpqqogU6atVhw0YBepZ+mI
	 3OziUdVyTkMjE1M98fPmdwbW2WvGZg3uGk8Rgzazo1kGG3xNxDQD0TscO04aEq0boq714
	 sC/FfLi6X98jqyGwduXDWzHlKc3G8p8wO4ycb2mvs8o5oDT4GEVtujvzFAuXde5uxmCdy
	 Nk/oK2tpu8uJOyPV/YVNhi/eEhOk0sSTcnQUbCYUZEHq8f6teoYLy2nVNGeMhGeyb3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Gtyu+/ug";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7E5606A6E2
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gtyu+/ug
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F412A1F000D3;
	Fri, 20 Nov 2026 19:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202413;
	bh=sUgsp0OZtXT7GwkUBRxM5lQOIahGLGHJOqDHHUNH0VA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gtyu+/ugLCxM+ZmDPf//0g9xW+REONXEA3PvzfHym/oWKA7+a0auFOlE4D84/HiRt
	 hLYapzKAQo83r1yZHYnib3KSUj1gUc0W/vC1wLrXHmZov58nKn7c7gMA50fI1ak+2O
	 86yfvD+3K24hjc/th9TQn5OVa8NZ3l+E0JutvplJYA5oIQdzS5ZtQfmNmfLBTxcH9J
	 hYAXV7TzXFTJVduag7Eh5JTEYolEdZmiKUlPJrXMrNqIP0OpNHEl2985QiZvaLtLZI
	 7ZK62e1XSC0FuE+4RwZVredsRj6PcXuYR77r2cPUCQuO7D5Q9njCafMciRy44xmC8f
	 sydWN8uMK+LQg==
Message-ID: <sashiko-outbox-225911@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/13] riscv: add Zhihe A210 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261121-a210-scmi-v4-1-4a795a0a9fc9@iscas.ac.cn>
References: <20261121-a210-scmi-v4-0-4a795a0a9fc9@iscas.ac.cn>
 <20261121-a210-scmi-v4-1-4a795a0a9fc9@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:20:12 +0000
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
> Add the ARCH_ZHIHE option for the Zhihe A210 SoC.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Co-developed-by: Han Gao <gaohan@iscas.ac.cn>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-a210-scmi-=
v4-0-4a795a0a9fc9@iscas.ac.cn?part=3D1

