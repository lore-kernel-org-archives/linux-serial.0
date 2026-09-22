Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0D4DA9A6;
	Tue, 22 Sep 2026 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071612; cv=none; b=gtDZ/SIFaC+ycIbe30C/05Sv2xY9aw15JUNJnSSb/oMFytWnObmB40zpAvSZAKJefH7cfH8qKlmbI1QtHHJHhEg9w7ZPwPSax/dQ5ID4lnsbsCjt/j/UQTjeOVnBODaNs+bFeMX7GDNWjuSUrNTgdozkDrvOGS6oEap+VUoh9lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071612; c=relaxed/simple;
	bh=VC1esom8RDRLDq9tgV2tY3D23BM/Ab4+BZ0C09dIKyU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PgjLvYv48hSO1yg80PJvIazhMpk7BfXUAM9N+EzO9I2ouwzmHmG/Lv5mcj+D+7DhBUb8lr7PEPkEXBzL4w+ghFO4xDv4j2mKwdLxafwR+LDuvkRz0gqyGfvsI4t7QkIiebS5/ZMWFVItFMzyTFHXSm+keQcUao99lw6ecaedyUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOQPD14l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOQPD14l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D77F1F000FF;
	Tue, 22 Sep 2026 10:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790071611;
	bh=VC1esom8RDRLDq9tgV2tY3D23BM/Ab4+BZ0C09dIKyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dOQPD14ls2c3lveri1yATgoyWIPbWySQGWW/KjQwN8xVr55P3uDuUHDuHCuvflylE
	 bDTGCgTCgQzklRykksYyokUYwsBk2xaQuVIO8jevvlepJMgfm3LT/pOOBFMoDYKtEf
	 P0k6kpVphgT3xWTlqAurLhU9W5nxtswRoAT8XwjF0OXnqUo8wDuAeH0pyQRTG1Nd6t
	 V+w8g9WQ9GlCujDZyJPjALg1hn3InTa9Ioq7EBxCNh6yMSnd1TaWuGI2bNSi35ZynK
	 +0Nx1kdsCkJzU8Ws7PXbp3egYQV3HdNpi5yED7gDEwML1x1T0gWQlZQc0/ZU5oXCvq
	 /6YpZsOBjgINQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: renesas,hscif: Increase number
 of DMA channels to 6
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <0fac2fa211f591d91c6e59fa16bc98791afc6559.1790071098.git.geert+renesas@glider.be>
References: <0fac2fa211f591d91c6e59fa16bc98791afc6559.1790071098.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 10:06:50 +0000
Message-Id: <20260922100651.0D77F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> On R-Car X5H, HSCIF serial interfaces are wired to three DMACs, hence
> referring to up to six DMA channels.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0fac2fa211f591d91c6=
e59fa16bc98791afc6559.1790071098.git.geert+renesas@glider.be?part=3D1

