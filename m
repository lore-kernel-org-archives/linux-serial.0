Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7FE442138;
	Tue, 29 Sep 2026 06:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664017; cv=none; b=TNJ1wW5edVJKTc11g+IQVvq48LmHZqKaGXWVGuPmG09Gi2bKugxMyiPtCFA4G4/4Spc3pA5voJf4u8ded9EE0CDoDYmCWY9Z4QSPv6STJvXVLfwHLlUkD5IxW2mdsNjvWD5ZPBUiR2j009KgecsHg5EI+sZZTvcQEcb5QeZzAe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664017; c=relaxed/simple;
	bh=zjN1d6dtttPlAYmI0x+g48c72lkKBuMRCk+KaGCMxY0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JVq5o7AxW0jnpRCkThS/S1TJGu+NxmC5LhhQBv4n36vmLvEPY4J7tTc03rwZ59gnCI1odSNeVb2d4jujik2e3Deuk2DlWTALutDxxWhuGqy04jwgRdcYgtjQt4reU0WmuYV6Xc4lOJn0byBlkbCAl7X/PMT8zyLrxEYmLH9bpsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hno/16St; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hno/16St"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB341F00893;
	Tue, 29 Sep 2026 06:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664015;
	bh=zjN1d6dtttPlAYmI0x+g48c72lkKBuMRCk+KaGCMxY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hno/16StrrEKs05bLoCBCRY3JJBCjtd5PhoxE/cIk4z7RFfvpPF3eM3cvauJp8DMm
	 be8D2eDacHq3VsaK+dOXEbrujcU6/iKxLc4mChftWqdyX4uMaN1GVG9GNc/fBwogvS
	 J8uqH9zZUQfJZMyI4YmLkOIqr80WyDXQmQjHmJR7HdyK1k4pyOLuJNv9Vx3j5aOLAq
	 d8vQ1sbHND5rIYySqapkY/oqav7eMq+FE1LAP8iQOPCN4NNNvrFg591HvE7tLlmili
	 ywCO2WBhg/IU5WOBUVXJE4bY+HbyGH8gT39CYKFNwOyhgYiuqe6kX3h7Y2lhZXzMLN
	 Gt8ux1++U1aiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/20] regulator: dt-bindings: sy8827n: support standard
 properties
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: linux-clk@vger.kernel.org, Frank.Li@kernel.org, mfd@lists.linux.dev, linux-i3c@lists.infradead.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, lee@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260929061417.20733-19-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-19-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:40:14 +0000
Message-Id: <20260929064014.8FB341F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Support standard properties regulator.yaml, such as
> regulator-active-discharge', 'regulator-always-on',
> 'regulator-boot-on', 'regulator-max-microvolt',
> 'regulator-min-microvolt', 'regulator-name' and on.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D18

