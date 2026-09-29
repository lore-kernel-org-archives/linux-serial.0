Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50772437107;
	Tue, 29 Sep 2026 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664172; cv=none; b=MHpWJL2W4+ja8YGJTKvEj8TgLlaYFDRXq5lU5EFiu9uu+xTs1tAiwZRbpH5Qqki0XyQ8jDfhkQt2PQiQoNljAIALbT0rZMJd4KHuchAMrwBDL7LjEpKZpAcoKF89wDXqdAlhdXhnAlVUqfHrBw5R26j1RHykM0cd2pNTqsLSXPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664172; c=relaxed/simple;
	bh=C8w3D/ONQyXLmDyhMj9j8JGLs4K1lo/jaR0Psozmq8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PGdgDINfJ7/HL1Z7ATsI7OVDUBqq8e5lS0BAU49AkOUGLmR7WRSwQUz4aT8DozYwTxqRxFNuD9q7R0fLBwlSPty061+Sa62oh3hxXHUw2tyRuwqzQIdsfPDtxErshPqsxmKqA5CXoWgznbRgSbe7lrsqRVYpyPhyiIzpNy/PrJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXncRjIX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXncRjIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A691F00893;
	Tue, 29 Sep 2026 06:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664171;
	bh=C8w3D/ONQyXLmDyhMj9j8JGLs4K1lo/jaR0Psozmq8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jXncRjIXnWkyxlrS+6PIH+3pnIxi4lhEm4roMNoTAGxOlL9vJ0D4Lgj5vEMNwVzNy
	 EddmfCIM8HzdeVrX94vyRluq+ED8re3LNefwoLhaVLfD0SFuajdOZ9NEJBW1NMswad
	 gzKFFPtVKHadaNIeKzp/ceKiOcq8tp8+kH4wqwodxq4Scix5s1qKQaZ+50RYFVB9hK
	 h3wMVmAtkljR7TJONYeRe0sjuYripoFYeQdm7qr2u7E4GzCXLiaPvNb5uaksXraNsw
	 tETC+41AwZjKEGglkF8zKZA9YxSOFTMRpORoUWh7KGCZRn3tQclqkJnkEcoK/CY4HS
	 azXO0o5sQp9cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/20] pinctrl: berlin: use u16 instead of u8 for the
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: lee@kernel.org, linux-serial@vger.kernel.org, Frank.Li@kernel.org, mfd@lists.linux.dev, linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260929061417.20733-11-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-11-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:42:49 +0000
Message-Id: <20260929064250.67A691F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The u8 may not be enough for newer Synaptics SoCs.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D10

