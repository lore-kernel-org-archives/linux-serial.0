Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649025;
	b=SCC2UtsGzZDBIPNiN4yBtSo9L4H2WuXzKvLMS+Koq8WUtZ+JuTH2h5FhoNpRYnKE35p6
	 YFaRrWeXFA3uer0E5UySMek5XSQuZX58O8ftLYq6owiBl+8nspqrm3EzN029boAVMksvU
	 KbWBFG8kXbmL3yWHujkTdtjlV+PpPXjZMy98QI6XcieoFQYBuV7T3R5jKUyCgOxXpCJD9
	 70IC90J83doAqvsa8NfH0PQQqGYpAwvOi3APxdGVlekT8wZH0axDC+fqgocWPJAab0+lD
	 3kpcuC0qmVTmGSQrebTe4sUA3cNeNJfiyCWF6661/J0y/UuMPy8KU1waCipEFWv9KpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649025;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MwOnWGoUrxgwl68rKU8CCyY9r7lv7QKJuXhsdrSZIZs=;
	b=JWfWbNWeUALVIqEdVQUyDsPMAkF0fZrnOGWNa+zMG1CBqF4AWX69RG0Hb6LH5KYYjPdZ
	 5kg55TC2TC/7NbvnSVzdo6nKRX1++kYmT1TdIQJGEwrfXw4WIaQhUUopgVb5KX1K9uT3g
	 ljjhA3Mbs4d1DrIxxXDEjbrh680JrfBJxgjxsDa2Rr+SAfVERwovvnL+eYChhvQ8lO/c4
	 yl7sDNElqsEU4WFHlNifjnOivVP7oej0oEuuXGQmo9/1As6oXsNzx1sjdIXvHJJUMZunk
	 kqulfJo33FYaV71vDhhsp2n/QQaHm/RmXbZzBUkgWdvie5CYzlGr18U/Y9zgIlkH4tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FO5PYJbL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2D606A329
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FO5PYJbL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58DC1F00A1A;
	Mon,  2 Nov 2026 19:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649024;
	bh=MwOnWGoUrxgwl68rKU8CCyY9r7lv7QKJuXhsdrSZIZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FO5PYJbL5HJ1wO/XbE85oHR04CxkNanAakjFvfB4neiHsXh6fo6kf8gvV6777oMz9
	 1XF41RAvQakApUg79YmibUhP0fwt79CDlE4WtERMthljV5yXlwgbvGQWBJa16tAFH+
	 Gwghvgd6ddpHXU7HhUMjBxeftd9+eFeVYs7zqNGlEMtM9U6lNfC7tQrNkrobzcfbsp
	 dmVKyUEU/LU5wzg0v4ZD7UeetBVvhkbNzNeD2dYZwwyWF/YJJvjzeqepcbipN2DbdT
	 kbG8dzu0XGbQUPLkvMCyykT77BNeAjuVTCa901veK9qU2Vu6csv9qW1g01NOEDWscM
	 pVmdr0HKDdj+g==
Message-ID: <sashiko-outbox-194025@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 03/17] riscv: add Zhihe A210 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-a210-scmi-v3-3-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-3-ee6b31580808@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:50:24 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-a210-scmi-=
v3-0-ee6b31580808@iscas.ac.cn?part=3D3

