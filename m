Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018522;
	b=heNghP2e1G+1pLlRnKXedyrnSDZ6lLSYBDe4MPZhOKvm+ajz9eTLLMirXkWZ+QZpz00H
	 FJOqCMCDrLDBqxSLDxpQRkC1BLBT0UaB1xFUN/mEsu29wYQLDMiVcohmdqlTtzEJW5ecY
	 uclWKl7f8W0GDAXTOmtoGMJH9cTcSyWUZBNe94fzuJyShUkXUr+Nsm1RYSESPjRZOJE44
	 5E0SmzSgb5QdjtIEcTr1OP7eSX5EBlPD042BG1ic0KHoytwVI0H19Xa1ALWZtMRNZY7Gt
	 i/rq1+XruVXzteHFcjFnTkxVe1Ysi+fPpmajKcMCnjsirYyt2woiAEPBNGlK6lJYY+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018522;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=q4DrdJJRRrnbbaIu1y8kPEGaNazn8SCmoYhDGakBFNk=;
	b=LC2z7wXcLFF6+ko+lMnnsyKJRvHlVbCkIrZ84b3O+53HrN+Ci843UVB3kvlalb0gKZYD
	 XpA+MYp3MJuT6CSxN1Snfs90hNXAeamo99+zW2J4RY1DXZ/ts1JFyiRyKaHwzjbgT/lT4
	 4DeCaTkCaTTyS2GxZ51frxhbMqGJ8BbuDQC6kMcRz6KpnNHmcB1AXCb7KgdjKmcex7znf
	 kkCenFawj6RTCaOCsXz2bMgdhGR60yCIUoXdFoIcUPxsNZW67kdd/hPsddsIeGrkkzYxQ
	 2cEWQrg3zc3nc8qKm7RTwY91jsa2VHjpYkOgcwiLLcEj7lYNZAudXKIfEYujxnHE1Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhB0Gs6E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91086606A31E;
	Mon, 26 Oct 2026 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhB0Gs6E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D101F01825;
	Mon, 26 Oct 2026 12:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793018522;
	bh=q4DrdJJRRrnbbaIu1y8kPEGaNazn8SCmoYhDGakBFNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WhB0Gs6Ewe/Qp0iSOWVho7uNFG9eKTqINm1HmuI3tQdrowXfozftpHzXALNCiTuq1
	 eEaSgzkwMOAZ+zSpH9wIHFQvy6SV1S13lvwuHMtx0SwhyaHEK4QYMj2qV/GuooBMUf
	 SXOomLN2LYrGj6/XMaQ/n2eeoJ+cdUsWKEo/M+rQyv0k2WQjgFWkqo5BzqTDrL34sl
	 r0vAYUWXTcz9zQXvcet9eso1/7UPBvWDpUV9tTrA3l8cPIPH3fFfvm3B4PH4XKUJZ4
	 v3MypTuW19/GR/5gkNrMOqTMPEwNrga8h+tRFAJh03A9SyOTR8qO+AbiW93Okwa42H
	 Zrr9i/ClbUewQ==
Date: Mon, 26 Oct 2026 13:41:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Paul Cercueil <paul@crapouillou.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "H . Nikolaus Schaller" <hns@goldelico.com>, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: ingenic: Add the X1600
Message-ID: <20261026-impressive-olivine-wombat-e1eb96@quoll>
References: <20261024220712.23250-1-olivier@mgcrea.io>
 <20261024220712.23250-2-olivier@mgcrea.io>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261024220712.23250-2-olivier@mgcrea.io>

On Sun, Oct 25, 2026 at 12:07:11AM +0200, Olivier Louvignes wrote:
> The X1600's UARTs have the X1000's registers. Add ingenic,x1600-uart,
> with the X1000's as fallback.
> 
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
>  Documentation/devicetree/bindings/serial/ingenic,uart.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Please slow down. You sent multiple patchsets, multiple versions, all
during the merge window.

I reviewed some and then found out there is a newer version...

Best regards,
Krzysztof

