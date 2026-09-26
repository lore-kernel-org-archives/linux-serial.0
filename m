Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6019C3803FD
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440883; cv=none; b=REFT85vYCJIWjPWBXIuZT9h7oDjJ1mFWo+AqhMGe5knj0nwH2qlP5Eluew451Ah19sM7tKC7w+Uax6fkSJ4ELM0qlX4nGPIxY5QcdZqXGYU6qjr5V1ZMOITE7rl0n7QpaDn6/NHtu+QvAFpEENlCBl1jPLlL197HyJ6ngHEp9ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440883; c=relaxed/simple;
	bh=pU9vpi1RhFxwGHt2PtA/NHa9z2QQCqtIogBhyWtOGw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tYRFNLceYFku0w3GdgJ/m0qyBi54es0rEM/oM+mBQsHgbWIQK/GxkajtjKkAxZ3v6m47XtPfaIbfzpUwxOMo2q3pR6bbpDXU0EbABeWlkSfIOaxS2tb8JRbzqTmXlMQkblWN88vmx9uvCYXqY72uT/9SXJHygvhEQ5bWVO8jpAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yl2inK/c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yl2inK/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90E41F000FF;
	Sat, 26 Sep 2026 16:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790440878;
	bh=pU9vpi1RhFxwGHt2PtA/NHa9z2QQCqtIogBhyWtOGw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yl2inK/cldiKTpmuqgebN6k0rX7ZPUUVZwTkmB8ozNvSvzVNRXI8J+FkY/Phj99MG
	 tdRnzp0tEsBIr+rY+fQA6r26f44JhK4T1eK7jyAgIS/UzLH+a5DBXsmPqjGnISN8As
	 YyQSRHLxERFNABhgu4hokAgq2O9Tc2NX1qAJIEbhgCj49GEz4gAqKGtIMVzQiqyOdk
	 OLSWPCUhjXT07AfbJOcms8P5lGqacGl19o8uBIbJKgiMnbstxIwn4jx73UbRYiZEBU
	 460LCEd+rsuAJ0eWPi+pBmdJ0iLc0SdCp3zmvkkH391a0Vc2mxw46KyFqs0mPM11if
	 cHVsfxWKe7+pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] rust: add DropGuard KUnit test configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: gary@garyguo.net, linux-serial@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260926163551.52371-2-mohamed.osama189110@gmail.com>
References: <20260926163551.52371-1-mohamed.osama189110@gmail.com>
 <20260926163551.52371-2-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 16:41:17 +0000
Message-Id: <20260926164117.C90E41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Add a KUnit configuration option for testing the Rust DropGuard API.
>=20
> The option follows the existing Rust KUnit test configuration pattern and
> defaults to KUNIT_ALL_TESTS.
>=20
> Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926163551.5237=
1-1-mohamed.osama189110@gmail.com?part=3D1

