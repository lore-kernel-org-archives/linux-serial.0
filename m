Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC68374A1D;
	Tue,  1 Sep 2026 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223744; cv=none; b=g99Uf5IjuS2x5GfKRjuAIwbJsiEnw9B1YLrLOTKKXI0a3LGYVYJjXj4MHZpULDvcn5xRAFCjj7dy/3EsX6l45vKufearXxjOqJkNvJizPIfJVEVIyeQjBgh3OwG5gTNr20Dbwda/mqaq8JdfHj1zGGOn1KFNrx34avJUEBvugY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223744; c=relaxed/simple;
	bh=NGYmOqHiFMn7IT35I4dVsDxsgSDMMhbDHXSA0nHsPkw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EHA8qsivCO0KooyIZgadii5UI3DOOQUkvFsdRWIzRmUCHd2o2sOogL+wguhjuMhTOyVq19ZBWYDzcF1YDjgSh/df1Ct8uJxCmL9nMMSSOIF1qaLk6Uom41tFsiPWnPBm9wjJlznSmdz+2KgP2q2pErUDh4bEVT04vzqt/zm+f40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnLAK+BY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnLAK+BY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0F21F00A3F;
	Tue,  1 Sep 2026 00:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223743;
	bh=f4omws4o8WYed3bUyawmlUTtQSYHBH84OaCjspaaQq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hnLAK+BY/XcgwB/5H2vn9w+Qw9/uj7c30xxMngyXEcU+GtQcr+GGBzjbHaguCoMNw
	 nqAPFy1MFMdpP4k5jG2mL5kEFJWs6Pi6YvN+A9pn2yjRDY4M+2EJeLuLftERTG6UKa
	 gPqKTWbjq0Bf16k4ix/3jg4r2/8rnlDq/4mBkL6ceqJskzxxP6tyRd8TVRps5uqpua
	 43Wnj8gz+ibR9Kq+lojPXhZ3WD/VHRjROrg0NEmiKc7Wk+hkgw6FaOwxRAZglkGKZ2
	 VYMD7tL3tnwmxYFKba79AdyrNuFS9XmRYa0a3PEQYZkuZDpGaIb1E13BxLhiPXehhB
	 ENDt8fJsLk3gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: serial: 8250: add marvell,armada-38x-uart
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: conor+dt@kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260901004203.49686-1-rosenp@gmail.com>
References: <20260901004203.49686-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:49:02 +0000
Message-Id: <20260901004902.CB0F21F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The Armada 38x and 98DX3236 SoCs use this compatible, either paired
> with "ns16550a" (armada-38x.dtsi) or on its own
> (armada-xp-98dx3236.dtsi). Neither form is covered by the 8250
> binding, so dtbs_check reports:
>=20
>   serial@12000: failed to match any schema with compatible:
>   ['marvell,armada-38x-uart', 'ns16550a']
>=20
> Add a standalone const entry and a two-string variant paired with
> "ns16550a".
>=20
> Validated with make dt_binding_check (8250.yaml) and dt-validate on
> armada-38x and armada-xp 98DX3236 boards: the UART schema errors are
> gone.
>=20
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901004203.4968=
6-1-rosenp@gmail.com?part=3D1

