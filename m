Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792819182;
	b=esAVyah5SoFGorxHT3D+6YWsDmyiMxSWT6/XJzrYAVIqlPZRJikToB/IqOhCdZJunfWD
	 XLv/1fb36LtD9n7Vayz58tjOZXCpoMkJM168ZG728bX/yLs8uG8zjgMJxAIHHqd2sMuPU
	 5rnCgfD+SAuXuSuSkuCz0r1SlgSpFzLOf+POigBhhPQWri9uRri8u0p25hbouv3Y06RFF
	 AhHwtJ88Vs6NtORjrIdo8E6T2jptMRGwC7MF632kgz3Dibwd4WDiogbREq8klI0iWaIjN
	 RhbinIgMNlRp/d+A9D6nIszvqZM55erVRTDAS8ZzcCcZWniRON/hqemWUDhy47FxZKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792819182;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yx70Gj38fdMsZVV/q0G4vMYnCnRO7TeuOF5PtDlCdSU=;
	b=15NVQvXWiHKEUm8uvjPbilpnQyNrB+elSTLD2D3He1oq1cCnFVkIw4m9LfwKuzIN9bRB
	 l2mjWN1GAwNl5dyjKZm5MgtxQ93/sXJtd8uWbpwhodiL5oO3QpOK2wOnU5/80QYGEv9bP
	 +eaT6zKrLfTlcIol+AWHlbr2TLn4RfaeFvhECf31p9BprF5A+Ww/qkjwHEH+WiFm6Sf8d
	 dhX21+UandH9acnYrPWXYY7MSaWgmMzCbLhULZz1YC0Cqm4MaVu6nVN9ERZcd5gw/jzuN
	 pbqGEabiO5cDYLVcYRWUby6YrDOM+G2wCnDdPEbdOnr0mJqRu8MMQItxKfnUU2T1Bfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EdlT1ZJV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363B606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EdlT1ZJV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF5A1F01828;
	Sat, 24 Oct 2026 05:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792819181;
	bh=yx70Gj38fdMsZVV/q0G4vMYnCnRO7TeuOF5PtDlCdSU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EdlT1ZJVPeQ5z1I0VPQVbSCCCwOmlRmEG0SG5OiD6jifwTZmWbfjgkvOK8Eyz8D58
	 BMelep6GM/VdmYuc0afY8n6HRsxMPpgQKJFIrK5onJcMJhP/F3UqVVNRIMO9xJwc5z
	 CzyEyFZs/AaGzM1cJqjcwjV2VtzZaLsxeU55YmMzdQnxl/6hyiYGAXKU5zdMSxj1iK
	 mYYmMA7Dyd4e7aYqIUudzaj6b8a6DOpj8tZNohCF7q2c0YNnoC4PMtVQaulqf+T+Gh
	 xqu013TPZMazijzAIqGU8jJzz3J9uk7AD7ksMPSIna+ogFTyqzKclU7dEERkydeUvT
	 lM8wVjnOtB0fQ==
Message-ID: <sashiko-outbox-183552@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: ingenic: Add the X1600
Reply-To: sashiko-reviews@lists.linux.dev
To: "Olivier Louvignes" <olivier@mgcrea.io>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024051515.55639-1-olivier@mgcrea.io>
References: <20261024051515.55639-1-olivier@mgcrea.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 05:19:40 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The X1600's UARTs have the X1000's registers as far as the 8250 core
> uses them, but the driver has to tell them apart to set their bit clock
> count. Add ingenic,x1600-uart, with the X1000's as fallback.
>=20
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024051515.5563=
9-1-olivier@mgcrea.io?part=3D1

