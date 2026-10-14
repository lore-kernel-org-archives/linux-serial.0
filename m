Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B67488223
	for <linux-serial@vger.kernel.org>; Wed, 14 Oct 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988499; cv=none; b=Qa6pJ3O0TNXLqodbniO325HqEAYW95fQKRNhHnbHtFEs7emPKi+NzUYMfSKNM5LK3qfwU19pQNKpcAhXRWbNI1yiJ1m3C9IGp3Qll52n8h2kiXrsTLOCTHfFuTUJSQ2TJ+iK/KeA8LYvcwRgC22eC0jvAou4P1HN7HsLnWCaU28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988499; c=relaxed/simple;
	bh=zw9p4oDbtxVzNd16uVyGS4eYPqAguKezzesSNaIDtPo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=p+g3rPx4z3yzf0kDOILFmFGTDRBOWw8wLV7wBYBv6VlIMcqg6R3fesIijtbmZ5im7JTnvQTe+Ci/YUdytF7zLVSDgOX/+AdEJJYDUfdVipjWHaH4gSnGli4dH+f7pCpobZsLVpvTQgB2hR52KJ1ZrI/LcdwFTJrhB2UsZ1Z8K8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScmZ4dxX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScmZ4dxX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FD51F000C5;
	Wed, 14 Oct 2026 14:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791988498;
	bh=zw9p4oDbtxVzNd16uVyGS4eYPqAguKezzesSNaIDtPo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ScmZ4dxXdTuDh7HmqjnVYavX2fXoLEJ0kkzLHcNd4B3KdjpLvTiLbls8sgy3m0W3W
	 SX0krFIG0dof/Y1G4NFAm3K61ABiaiNecaj2p3uigpUpE26LD+XAxtl8MEnPShXBKk
	 HdjH4hZFj09pAohc+Aw3UgiihR07mMsIYm4ZGpowFkYKzkdlYafXxMRRrEfvDrOX9C
	 e7zSWYgSuUdF0YfXiDB4xdQFI6NUUu94ycTucwz9AUXY3SjZB2WvlHZfS5I0NFxqo3
	 M9KqayWbAvKENgkkWKoD348stORU/Mkw+D7GlpMmq5HQhxjfojC9pUVoYh5RCdxNM3
	 33YbQAVjUAS0Q==
Message-ID: <sashiko-outbox-171434@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] serial: earlycon: Use isdigit() in earlycon_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261014143034.104950-4-blum@kernel.org>
References: <20261014143034.104950-3-blum@kernel.org>
 <20261014143034.104950-4-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 14:34:57 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Use isdigit() and a while loop to simplify the backward scan.
>=20
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014143034.1049=
50-3-blum@kernel.org?part=3D2

