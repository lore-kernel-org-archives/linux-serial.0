Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB20BE4E;
	Thu, 14 Nov 2024 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731616569; cv=none; b=LPswV/u2HtJwSfWmVFqpVTw/n3cJ+Dn/iTXDf3ZTG09wKFmo2ZKu8EZiW6e9H3pwFwq7u3ZLzOGavzpte/LWxZas/Y34PRAIOMnIITTz8u9MkX2ZQFJWfPVwO8zJHoiKL80jC/28I3z9pu0bS1bgg9+5m6ksDOve2WxE0tkUvhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731616569; c=relaxed/simple;
	bh=e4CuMeBuFl8hY3128pbc9WW5lE8Q2llRmDotkDlHzho=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=lbI9OQ+LmpQoegb7fq2Qn09o9YLNz9UUEhIx32xJJTPx3xS6konToANQb5Hgc4gCiXm0owIkkhp0vt/O3DLoH5k9cpBtKxDeSfQ9s04KFSG70iTkA4HtIdJH76aRh/7lseFpCEsXZWiFiT71u/ELW3hIvTpEbI84O136scOWV60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt0jn7J6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt0jn7J6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71522C4CECF;
	Thu, 14 Nov 2024 20:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731616569;
	bh=e4CuMeBuFl8hY3128pbc9WW5lE8Q2llRmDotkDlHzho=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Vt0jn7J65ZBeZSkFV7IzswP1sljgEdr+7BjB+hi68CTHdbYGpfvrbf7LrMmq69fYO
	 g37fBDpL+1g2sHXr3V+8LgMvGk2Jt3WZAthQafLnnoYkvPoWGUzPxIJT1/Fyz7hh5x
	 jLLSN0ALORwjHKypfzTvc6htO/0DhiYL3eH8CnoGJyZuBU1hh1ugH7v7dKdjXYNfw0
	 pHV122hsY3PLrJLDqA138iaM8Uz60wHZgrysQ71vxSJ9ecgcAdKnvuKlr1xHmUcqJX
	 RKgszYaG8hQuETL2uGETmUI0BjCY1nDw4n5LrLFmiMt86rnaN1rY5N1TE+DMZCQJHK
	 bbu+v+wQroScQ==
Message-ID: <35463049ef7cc47172ccfbec487166ec.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241108112355.20251-1-robert.marko@sartura.hr>
References: <20241108112355.20251-1-robert.marko@sartura.hr>
Subject: Re: [PATCH 1/3] clk: lan966x: make it selectable for ARCH_LAN969X
From: Stephen Boyd <sboyd@kernel.org>
Cc: luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
To: Robert Marko <robert.marko@sartura.hr>, gregkh@linuxfoundation.org, jirislaby@kernel.org, lee@kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, mturquette@baylibre.com
Date: Thu, 14 Nov 2024 12:36:07 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Robert Marko (2024-11-08 03:22:34)
> LAN969x uses the same LAN966x clock driver so make it selectable for
> ARCH_LAN969X.
>=20
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---

Applied to clk-next
