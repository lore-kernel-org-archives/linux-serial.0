Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55305314D1F;
	Tue, 22 Sep 2026 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084516; cv=none; b=lhghbITxvN5UZJ5/DEbH8nhnQdFzDwcPS864xPN4S9aTUKQLluttb7n4vb4rjqTdHYflTcBOLoYQwEQ/S3nt+iLv6yxBX6q3ZJJnn0ja4sH73B7KNELGS0F1UVDD4ZEAlKP73G0+ATQp8e2yH2XJ4ofcJ4d8B4RAt5dZ8MEqhM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084516; c=relaxed/simple;
	bh=ILA5v9L32uI+8ck5fK7HD/3c37VVSiX06f80Px9fkH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AmpRvhtjSDVIQV0Ar/9+VOzZgBhMGdSz/B+KZMkfQ2cWLtNAOyE9GIcor6xmj9azPr1bVOPDUUbzlmT7zfhMXQYgQjya3wW8x8MG5ooi2hBbUorPET+OH0o68MihlJde8qB8gC22bvwgVs0/Zfo8fowRAvYR03u0Gkh0J+GyBiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVbyo82C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVbyo82C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC0B1F00898;
	Tue, 22 Sep 2026 13:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084515;
	bh=ILA5v9L32uI+8ck5fK7HD/3c37VVSiX06f80Px9fkH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MVbyo82ClgfUhwSMC+AelL7s2H8ljc7ku5Hb5xJXGqvfJjrCbXz+ZvnOkpCxBjWPi
	 ryLMt3NyKZY0sOY2KG1Dn+3olv760W4cC8/nqGaCYmBUQYQY30Aa/a5s0+7htLGDUF
	 RrYZxIpKyiAJDaYSUfXPFmFvp2S10lOXJpR197QIIW5R42t45IyBnAWXqTTg8lR10V
	 wJuKXktgbUYo98SuNNI3HE+Pf0Y11V/aI4FaFlhtXoQzfJrw7+w6/Z9jS88GPMjVfN
	 dVy0OrrgxDxYjdRrA/3wInfpkxlZNhBK56GhJY63bfcMMZRdmdOx5Ag5pNvKiPEO/G
	 0ux8JQs3vExcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drivers: Replace __MODULE_STRING() with
 __stringify()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-serial@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260922-module-string-v1-2-c18766690185@suse.com>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-2-c18766690185@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 13:41:54 +0000
Message-Id: <20260922134154.ACC0B1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
>=20
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
>=20
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-module-str=
ing-v1-0-c18766690185@suse.com?part=3D2

