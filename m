Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC04530E00
	for <linux-serial@vger.kernel.org>; Tue,  8 Sep 2026 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867880; cv=none; b=T1tKniWq5xbzbKxe1BxmtATW8nxSyKHVo4MFVfGyoqOLNN+gZV+zWR4dfl2J1vqCVtQdx4Ep/OrSJnJcftv4T63m/s5Dr6TTg/QK7gE6NFhzZaZQmIhsA9iWjjXkuJoMnutfQtaySQ8NTTmO1CuMSHtBAcydBYSG/hFfz7lGF3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867880; c=relaxed/simple;
	bh=wqdGnwiDnA30maOqjGnn/RPB/LV01lgODppkMtoO8lQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eH+lAfQFdaXmSK/H7/IFeb2b1dSD/1Tc/lh5UuZJItv+2czMFZVqv+6UKLdpmenO/n8JHp0W7msHiWkLpulML/xlGEtQDYQ+Tf06jLfG7k/CZBLs7UWPiWyHvOZ8uixBcUXi61Sg+2W6r1S0FHGv28DUk8oV3eouFgS4jpGR/q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1vip90C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1vip90C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5870B1F00A3A;
	Tue,  8 Sep 2026 11:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788867871;
	bh=wqdGnwiDnA30maOqjGnn/RPB/LV01lgODppkMtoO8lQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i1vip90C8VR8P92Y7cnDk76DsmI2XccveERBnryFs9pPGZGj/hz/tilSlAsefigbV
	 FJTSd1hPOk/ABJM/s4wPEQ6tIwS0rr3PmIKksoRpQruZji06bXYUkPQIFTZWRLgk1Z
	 WmDywVAD/WfgGDMdVRgFCRynkgMoQmvMfLCy+MR/Q42QY/cUBRGydgSWb1jZRh3Kuo
	 a8IBIqYsW6ZS5sIEdgIBykOjY0ROLAZG4t04IMh4FGrfI/qPHjMJUiryuMFE08QUyw
	 ljVudhOmZcaV/6+O6Q0+QsXxLWfgj2FAhPF3Zs+bKy3PE4lBFhgRp4YDlvW0qAvFiC
	 g24LoAEX1gzmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: atmel: Replace SIMPLE_DEV_PM_OPS with
 DEFINE_SIMPLE_DEV_PM_OPS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Jun" <lijun01@kylinos.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260908113719.4078979-1-lijun01@kylinos.cn>
References: <20260908113719.4078979-1-lijun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 11:44:30 +0000
Message-Id: <20260908114431.5870B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Replace the deprecated SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS.
> This also drops the __maybe_unused annotations on the suspend/resume
> callbacks, since pm_sleep_ptr() inside the new macro already handles
> the case where CONFIG_PM_SLEEP is disabled.
> When CONFIG_PM=3Dy but CONFIG_PM_SLEEP=3Dn (a valid configuration that
> enables runtime PM but disables system suspend/hibernation), this
> keeps a completely empty dev_pm_ops structure -- all callbacks are
> NULL -- as dead code in the object file.Modify pm_ptr to pm_sleep_ptr.
>=20
> Signed-off-by: Li Jun <lijun01@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908113719.4078=
979-1-lijun01@kylinos.cn?part=3D1

