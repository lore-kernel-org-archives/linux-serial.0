Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35902309F08;
	Mon,  7 Sep 2026 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764187; cv=none; b=EEkG4O35G6CIM+ev8xbh+egtI/TBNQm/sNFgx0QE/EVyWLFvQ4zFCC91k215034eY0922R4cWcgUHsUexwgoiLqnqFuabNFoOU32rc+DZiiJsIbaQq3Jolz8UMo166RKfQMKHu5/mEmXjGxkDmFYrm4+aR0izZ2trp9B1iwMiP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764187; c=relaxed/simple;
	bh=REe3RJOmm1LUAzs0E1vCjBkYfcFDcp1SlCeFZ5SIrvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MyHHlWkXs0/e3abyovN7Ams/7zQLPKpnUvJXEoykFDevuS3clm6n3jGTCSv4nn0+4wLqtm8BO/f7tGF3cQ8jGK3qNlWK5v3kalsn/ctInfzT2yruzcLPxqb0lQqBEZIb0R80UKAirQndlFZzNkuFXgrrgr+bRJWM7ZpJyRUnsbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgcRD1Fh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgcRD1Fh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6B91F00A3A;
	Mon,  7 Sep 2026 06:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788764185;
	bh=Xi/sjPDzQCn9iXoNNamq2IWTHuDMtBW8ch5cUVaRWwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WgcRD1FhKgJRirbnqMMaam5U5IRay69ab4R/FNGEpVDcASxTdFn2Bu4wd46C0ohAS
	 LthCoCu/3QcQIP9AjRycnTEzCCXeUGipSl7M39ezXFxDSM1jyKNeqgVchStvHaGZIe
	 vFSf1SUDKS2K/A/GHH3AxIqnZ36yIswZdqorH7s/wzzDfY4CTHGjz3uQ78uCKw+6Nn
	 /tgu9h9JpoxejmenJ3hZtLldUO8SzB6F68KQnS9Z3q1i69Nxzt3mheTmkUjhL/YCd8
	 dcvzmjA7K4hz4lWrDZl1iWqikvm/PTP0wBjpLxc+SPshBEdkZ62lbPKdzkBPAuozfg
	 hjYgEebjX7mXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] powerpc: fix repeated words in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: linux-serial@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260907065153.33578-3-hemanth.selam@gmail.com>
References: <20260907065153.33578-1-hemanth.selam@gmail.com>
 <20260907065153.33578-3-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 06:56:25 +0000
Message-Id: <20260907065625.AF6B91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Drop words accidentally written twice, reported by checkpatch.pl as a
> possible repeated word.  Only touches comments, no code changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907065153.3357=
8-1-hemanth.selam@gmail.com?part=3D2

