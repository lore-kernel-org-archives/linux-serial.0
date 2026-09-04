Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C41447B43A
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524456; cv=none; b=D5z3P1TZte6WSiFNADLQ3+GgLaWxjhPueIe2ErRHj3T8LnSMVPvGT7FfLVWjcyGJG7pluwFWe5AVv620oEIUpmH7lnirks4N366bnCbpffZMv+fvFArVoS6bpkxIC3oKzkPiMrginQzqe5uyO6COY0HSzPe4RL2BHiSmLPY9dGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524456; c=relaxed/simple;
	bh=aMgTXBvWiloJR3QIlVCrziappJ+W5qupdsJcWhAA9J0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bdS2myLpfVhzf4v237QdaoQk+ew8iK7jM7e9Cj1V9adxyh/ZrHiG5oQqGIXCWe160AqvmVqBXnGOhXpd/bEwVlpGMaOC4aUnY5rMHx96+co7Yv0N+RWmEu+6Z7Kt7JGtTOyNrywz1nvIbxD5VrqHLUuWkiTFIm83E1XsohF+EGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H15uk591; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H15uk591"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C561F00A3D;
	Fri,  4 Sep 2026 12:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788524455;
	bh=DL4jt12F5g7D5g/o9F2SWMuyGR+ovzDYXUeIKCqqPTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H15uk5913UuXAdxn6Rn2250O+tXaWhEnfPTBuwggwS5ckMA49PiEfTyPzWUjAcwWZ
	 zlnigwOA7du+yuW6PFwudsm7ojD14PEuVFNtBa1YXVVk3NkARLROYPyIfOOA+KRccP
	 G3/KRpQpTTQDsIqESHUAgREQMwNGckRA/aF/ejU9mCn02zyu0UCZUilI81wuTd/ThF
	 UwQbMUT3UdHu8/r/xNxgGqjQF5BZIvDYXm3gXp+UYpkYAGe1q6cNSYO4SMO8BI72uX
	 mPPU+QrnZRtC4gj0AJTXfshqxZvd8++sCqcIuODQjrnE3aE5w4ImTzHbq+ocAeiQZl
	 at4E22SfB5vHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: serial: fix typo "inteface" in comment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260904121909.27377-1-hemanth.selam@gmail.com>
References: <20260904121909.27377-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 12:20:54 +0000
Message-Id: <20260904122054.D6C561F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Correct "inteface" to "interface", reported by scripts/checkpatch.pl using
> the misspelling list in scripts/spelling.txt.  Only touches comments, no
> code changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904121909.2737=
7-1-hemanth.selam@gmail.com?part=3D1

