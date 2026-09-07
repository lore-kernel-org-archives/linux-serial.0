Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23F1D7E5C;
	Mon,  7 Sep 2026 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764188; cv=none; b=FblpibfCwVxXyKQLtqh1Eqh8ruwWUVPI32up1u0Oe4YWyu2cvyI+cgTlt4RXfNqkKdJTdJHI9omr+34jiKO6vgJ4PXRabh7Fzk9J4GzFvL0hW+oF4gg/upeN88QJTQn56UdyCFYyrOE09uomjmXLZXrB0rkgRC9b0Z3fnpJsLs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764188; c=relaxed/simple;
	bh=I2NAB5E4EXaBhf0Q/yHXv1fxglDLy9bw0VQyde4xqAU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pW0Ptjr6WrAPbCFde16Lm1KtwT+ZJDYuO/pwMoJfJRcAvXlfMZDa66Ez9P+2Z46Z5Qqw5bCaIB3RQMPaMUyuuPyoDj2EwnKp8bZ96V5GaTBniBeJpGOm48C/+KM37srHHf3KGkbt8SUXLIcgr3UHcCku8DmbPrLe92dtxlTthjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klY6lpDN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klY6lpDN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786B81F00A3D;
	Mon,  7 Sep 2026 06:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788764186;
	bh=sqg8aFlCpjQQIwENfzrdg/IcpA4flrG/ocDhJL1zwIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=klY6lpDNyCCqG/X2FJP6Di9rdLvcsAXl0WPG15qsoyuxBahEIhOniAm6WMUla9jgA
	 mGGUqWFiN6ojwj2TAnTsL8O749Ty9a1ge5OZBrVyR9w/urKG9r9VbFOh1479qoX/lN
	 HXOnY38S0eF/lvGDLsMi3y0DnxeL9GuAt7WXE/jcqeyZi8rxeubOI2myax4lamQl6Y
	 i0ARVxoWN/j1DFuW8yh1E/aBFPKYIQCu+pOmnferYuLurjf/CG+Nx2h+7pixWGyFjX
	 7SxPoqfq+jur1U/pikoujRCLWtiaBt0Y2d9JmSV9evli0wdBKBEPjHFqV6w5kmEQ/r
	 2xdomMsr5fbwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] powerpc: fix typos in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: linux-serial@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260907065153.33578-2-hemanth.selam@gmail.com>
References: <20260907065153.33578-1-hemanth.selam@gmail.com>
 <20260907065153.33578-2-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 06:56:25 +0000
Message-Id: <20260907065626.786B81F00A3D@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907065153.3357=
8-1-hemanth.selam@gmail.com?part=3D1

