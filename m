Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114A14A2A41;
	Tue,  6 Oct 2026 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310799; cv=none; b=rEUIvHCE3/VU+8g6fY1tyWS3A3KDJI0wy2HfwkSyF3NAzxhPhl6sfcpjvhGToOh/umqwS86TrmcYvvb5EVnj6Ls7lEfusd1znIe/TmKd2Xm4uWniJ/JEj2APxPmLVz1PZpKRcguyNqTcZWQnaYTupCgXvo2ru42WkGpWDvF/zHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310799; c=relaxed/simple;
	bh=sIUaHXfv2kgVPFBqxCxaKGEA/GsocQ6E9sDvPuWd3XM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cAVAPw7aKqs61izRrXIo3473xQ8sxYWFAcOB/WZBMybKuA3+vCk0BK+Eqied0oxmMg2c4gmgxaz0BFMnKKszGdp5J88YcWyC/i+zl6m5C8FAHap1ngX/p2Zz3cy5/Bcw8p7+LtMM05+x0zW6Tz4oMECOsKUtCHuoDjZuPuXC2kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nViSldHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nViSldHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CB81F0089D;
	Tue,  6 Oct 2026 18:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791310797;
	bh=sIUaHXfv2kgVPFBqxCxaKGEA/GsocQ6E9sDvPuWd3XM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nViSldHlUML67znxz6AkJ8avILSWUPYTCdYTNS4XDTeK9djnDnXWip5K6xAp5bG5F
	 dwAQU5fJSlc6nbieqbMGeFxyICTbjWpHpmNidgpGiYui80xpG+IpeSsyhIOTatfirT
	 md2TyVLffh2HgZVqquUVXfsmZ25fzrX5FgrxM0EcGkkpaGKirTE7Se270hyJphwwvI
	 CwFI8+ALnyWJId/5Y2Mv/3o01jae7CMZNaeVUdp7FaL4AFlE/RWRL8+yEsdJeVy+FC
	 /V8BWUsJkg/SaKUQLCZh2KLC00PoZJNKyZhnFP8BI7dvqy/JqSTMBy+UKLWvO4rxVT
	 76OhWElv4Oxfw==
Message-ID: <sashiko-outbox-162330@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 06/10] dt-bindings: serial: Add Cortina Systems
 CS7542 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261006-b4-cs75xx-v2-6-b7d6e1e24d44@gmail.com>
References: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com>
 <20261006-b4-cs75xx-v2-6-b7d6e1e24d44@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 18:19:57 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add the binding for the UART found in the Cortina Systems CS75xx
> (Goldengate G2) SoCs such as the CS7542.
>=20
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-b4-cs75xx-=
v2-0-b7d6e1e24d44@gmail.com?part=3D6

