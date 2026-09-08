Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42392346769;
	Tue,  8 Sep 2026 05:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846971; cv=none; b=KQ6TORlttJav9xUxA/vRvDWQRbQB5h/SS7TBtKKEKBUMbRmcUpHUfltod8M88pt04BGQSgfHk84ab+uvX2sa6gUAcfkNg4y4WGBeQXfU14Lhtzphhep2zScTcVB+C+Nc2LEumL7VcwEP7uyglSoxAWwYR9JxEt5fa/DV5LZLoPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846971; c=relaxed/simple;
	bh=Tdo6ekz6e+Hy8TaJC0ze8t9sX4IytA9mQb3Y9+b5mEo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZtSW1RTEAFTdQ8yCemhNhASfS+OIjlEBBQeHR0ndW1kIMH3GqYz6UbE4EZp6fRHK0V4KMO84CADq//S7M+mUUPW9ynSYZJU1gh/YSZjTmbU/3v7l83aBgqooiJtXEH8TywQ6p+FaaB1SSz28OUCBKfVA2qE/S3traswq9m6UO6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNfmkvHD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNfmkvHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BE51F00A3A;
	Tue,  8 Sep 2026 05:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788846969;
	bh=40BfJElDlfm+ZpJvteFgMJw1Xqm1HwTOzqsUlksQqsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QNfmkvHD33u37q+dc1xbnPvh8OHq9mv5b7zevZrn68n1QHA5nGlTk6CS6GcvYhCQK
	 uPM+8lx2/q2NYyl5z4p7jA4FUNqZ86/H9rD3U1nghdt1fym/mUPzl/KWMGjk49VMvQ
	 PxN77lLT+EONU/zkGeMYPSpgiukAODgl6wmXczKVhAGWtkUvtr/POIttjVF7wQxriE
	 s4GNi2LquIMqWsU6r28fkl7Yl5UZ4sEg/IUpbF/RtJz081goNeHJg7EXrtnRAsWmrh
	 HWQ6ROCpn4KItrDLI3fwIkcswPV0xsrKOjh0KbpBd3mzd4N1ifjD0tlQSgxK2f5Ni2
	 ip9zMLudAGGbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] powerpc: fix typos in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: linux-serial@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260908055133.16469-2-hemanth.selam@gmail.com>
References: <20260908055133.16469-1-hemanth.selam@gmail.com>
 <20260908055133.16469-2-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 05:56:09 +0000
Message-Id: <20260908055609.87BE51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908055133.1646=
9-1-hemanth.selam@gmail.com?part=3D1

