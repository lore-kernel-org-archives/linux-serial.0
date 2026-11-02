Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650978;
	b=ndrsYtlOinERAnU/rfLgfQCTwhLSXXhJkp2LDN96Mf+pgaWvFDoOEUBYHO+Xt1x8dv3+
	 r+5xrWuIgvFG0eSCERf3SLwLLvpwCZM012C8Pi2izSi5TTkwLYc7OKoJqiLTDapDsgWt/
	 NbRXcu5zbdPsPzZQ1bgvqHTeedvH8ZOZQ2LEUpK1x4SvLy5dRy5FfqxirjW+UsBIOQaOn
	 KdM4KsYbeiOIvSSPQF9N3iBMyrTTgsXLLGcffKCGm+iJ4KIFEpdHsVpgmbyOniDcFpa0w
	 LYlLkYY4hU/dVcsniALI61OwzsdBEEaLL/njgMnUBM1O1ERNTwwwhUkyXxuAarI7rSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650978;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EHw8Wfce3LO6kQloHD64BxDSiL4wPWKdHKsGQS1SSx4=;
	b=Bb4ubooUpD/buCtQlkvcc7Z9Jbd6B3SbOHDL3XCtRCA6BaKzvmHmbPh3nbF+zLNYNiAG
	 vQOu748Yy3JwpDWaey6BGoux0t4SBXFKZkwLu97Ar5yj65Nay9g7EPEbf/4gUXvYP7S0Z
	 qou7V8QMrHM/xIsO3QpH347wZ5iy9vYbUmFIxonJFxhG4e9AQYMnJW9UF44MImSOvMudI
	 TNYdKltEpgnAeaCFoa6WNpWlsXCZwYonKxeHGtywepT8kjBG59W5ouDaML9GVNC6SzTsV
	 ik+1twM621TGwfMVzNrbLYszNKdxuuThEVScZFe0IsoS60WEzVbI9sboyqMyKZIV2fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81612606A327
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00261F00A16;
	Mon,  2 Nov 2026 20:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793650973;
	bh=EHw8Wfce3LO6kQloHD64BxDSiL4wPWKdHKsGQS1SSx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GhCjOgUuNI4VVB3Edlh0adj3u10gyWjUo1U+HSxQC/lP/sjp7/ACk6og1M6Q1Z873
	 xfo+pNKz4xv0LSYYooYl5fxytgH8xSg6sYqe/rRbfLL5qdX7xW5R0oLazJEL+p5W3J
	 M/U2Nk1D/6twoc1+qPvI6nbv1d9hz9UdeIotN5+F0PnLl+St8nC5/0QB6A+Ubo1+no
	 SUjemEr3jUkq+X6HcSRDCw6KvpRX/oZfFXN5G8EPwsLvDQBCdsIWVM+PzASG1aOWrS
	 rAFjBxtAXDYUUSzrSZjjOkEaa5/h5hA1vuhf8hQQgrmISkVchjaZJxHoLeUbmsi/o/
	 dnWWNIF/HkL3Q==
Message-ID: <sashiko-outbox-194099@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/8] arm64: dts: allwinner: h616: describe the UART
 integration
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-5-25afcb346b0c@gmail.com>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
 <20261102-submit-h616-uart-fifo-v1-v6-5-25afcb346b0c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:22:52 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Identify the H616 UART integration on each of the six controllers. The
> specific compatible describes the fixed FIFO capacity, register layout
> and receive-trigger mapping.
>=20
> Retain snps,dw-apb-uart as the generic fallback. H618 includes this DTSI
> and uses the same UART integration.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-h61=
6-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com?part=3D5

