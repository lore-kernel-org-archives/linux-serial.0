Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD514772B8;
	Fri,  4 Sep 2026 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522071; cv=none; b=PcdsqfUeR+78Fypu+6vAx6fsMkYdkVOjoFs3Zs+PcbZk/iLZHOZzlGLkLShz3dkvjkHoWS7hI+OBe31w7/FdqdqRai0VpT3O0ly0YU7U1zJccOoR0Tp4UHkPljRlfPtdgzTHD2W6Wxd63DcD93M0OXazjZPCtI6LVfelCG7EH4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522071; c=relaxed/simple;
	bh=uY1ObArPy4QYzjmiHu/vP3Afz3HdB8bZuyH0ryX8uC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l3C+BzY2Iuc+VSeKzpubIwtqO02/IKVaKiPxuXEP6/VbZOscEB8uxKylFSEPFsBuZp1w6TyLKv6iPXPxkOF6Y9c27/MXTBGpFmN0l4PrYdir0B5Pip5rZf0kavENSbfo38PhYtNIkux2di/1MyrnSeibNHDKjI7bu/UXWq9eVdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtFsiELj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtFsiELj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C661F00A3D;
	Fri,  4 Sep 2026 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522069;
	bh=7IV59x/F/dwX+rT3AhulBOG8CokXMwW+wYGxlXUPNck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MtFsiELjiBaUXYeyt0IOBLxshc5MQ5dEZ9M0iEXkt+pQvqlFWjlvbpXvSXiJSq+O1
	 tvweIFQ0ayy0Prg8UKaBfx9BNiIpDz/V4foIBBcGLdXNbPPkzSClIAgJ6LnvhPIhTS
	 2KcIw4qabHwAOss/99lcTHVEZZDxZ04kHoablljy/2ucqLHf0oCcOAuwr+1wcTUrgm
	 65yAvZN0/6S/HSWDhf+rPL4AQhrakNMmp8cZgd7+xss2TBBA+zfG+9ZDJgVlhUbQDD
	 L1prGsKTYJNt0IUj2RXIpQWHhroBEW8yVv4GAQOG3oo9EF6cJmqufmXCqA+gL8yDAJ
	 xKoKAq7HfZ8rA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: fix typos in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, linux-serial@vger.kernel.org
In-Reply-To: <20260904113942.22785-1-hemanth.selam@gmail.com>
References: <20260904113942.22785-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:41:08 +0000
Message-Id: <20260904114109.53C661F00A3D@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904113942.2278=
5-1-hemanth.selam@gmail.com?part=3D1

