Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116032;
	b=1DSQOZ6N57EKJ8Do4Yv0mRD+XT8v1m5l34ZsePtmV24DFAekMVfZJ0EXJgYlJ/1+AaF1
	 ReXohh9QicpJGGrTpDGHVapePmdY+UffMhNqUnGl2mE21btOGtPWUM+BNthUOnfJy7lBz
	 qybPH5fBWz1pSiTwYnHmxMJR/fhlAultAdVxRau7zY3X/QfwHZIozPuqJfNqx9tZoiYt3
	 tCzI+InkDmuYkAa9/S4OdvuL8yBs5gYM94ToNEeM/ZOqHqj5PSChqE0rLujfRKd622hjF
	 AY7pxvqWtttp9GXeWQw5KlnqM1QBs1eSsgixqyoTARhqp+MfwF+nFtp4gIC9/NgszwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116032;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Lx1QzhL8oSAjTBMk18zFvS+L8M2dmvxDmLt+JDG8SDs=;
	b=MLVLUSoSLG30uOj3eyQ02eKQahmS4r37K5tPKSqGgPvAuR5F3vquqtwztINzMrQfsGa1
	 eVTAzmRgv66Rd8O382J1q79dc/sO0BC5p9nPApJGeneowzQBeGQBwT2LkmvWeMOBjoVOY
	 BIYe5SzwSGw5XaQmuukX9k3d755TUwze9cc7SXAcXhF/0O43oCAJaHvvgoqgghQBIeb2a
	 R48Ew1cmiFFXrTk5G/G7rGG50qF1jPRAM+NlIOy9cA1huQ+YQg2e+kSMnNaEtPomwORYE
	 IKYbyZgSR5+APo1kr9gTFW0oRkCaDXvnY0lLNgB8f9un6irJ5iDvesZ62xYqkmgSJyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ib7K+W/0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCFF606C82A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ib7K+W/0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DF41F01178;
	Tue, 27 Oct 2026 15:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793116031;
	bh=Lx1QzhL8oSAjTBMk18zFvS+L8M2dmvxDmLt+JDG8SDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ib7K+W/0/FQ1o6xhPk+zQrYYQb+jIIgnX8V4POElvZJAYanb9RxAVHG24gJ3Bia3A
	 xchH8H8CZmeXFkjyiJo49GUkZ6dwFdcVi4h2VA5AtyTUn0mMpzByFjOdI649QqfvU0
	 jTbFVFPNMN68ORwhwxCDeWV4Zce0Z97r+iBAiNfPHoTUeKdaFb5QYG7NoQv47njxGP
	 xexy6yXPQUznAAs9jbL8xNBazpWVSU8Qtr3aBurVDjv4rL32HlUcbet6Vx6mtnYCmI
	 zqyj4N5D7lmcpuAe2UtnwrNQFuFVdn7ZvHKEQaKJ1ou1P0Px0QkZboSZih2a8kbtgx
	 IlhoKNGJIz5bw==
Message-ID: <sashiko-outbox-186867@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 07/18] pinctrl: zhihe: add A210 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-a210-scmi-v1-7-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-7-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:47:11 +0000
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
> Add mux and pin configuration support for the four A210 pad controllers,
> including the shared PERI3 SDIO mux and suspend-state restoration.
> Release the optional pad controller reset at probe.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Co-developed-by: Han Gao <gaohan@iscas.ac.cn>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-a210-scmi-=
v1-0-74d58ce85bd8@iscas.ac.cn?part=3D7

