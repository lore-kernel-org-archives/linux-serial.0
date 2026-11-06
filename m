Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793970262;
	b=OMJ8/MKtEkyvhh+r577xSAupL3z1qYxnqYbc/h+9JiZPKnaU+ayVUcxsKYWfqjiqiEuU
	 lZZy10TYPm2x5f1tLdVT4sAzOC/za9+ju+yw33FYIPDSuem8G49cCrAXyfPS1N5wdcfB6
	 pEfWyLaQY9O8OHi7gj31MG7t67gZ/H8Uw8Z1HC+GdyTcZ3IFm5L8S+3lFFYS4JK5ZWcVR
	 pTUoi3xF85R1F5BcoX3F5blNKtrcV3ZkwYFIiZSrrpTkdSSLsnLZjdn3Ac9wV79Lc+fD/
	 U6xkJgjvXciaindWNBJB+jRPSqexPwLjgwWCO8fmXOt1vD7C72PyM1B3FqoIPRnftVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793970262;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ME2X2oedXhydVPPNVsakRcZ2pjykO1SLtyex8ETN3D8=;
	b=LjzGTQdonzm4HFEIfc4ujS/44qYEAA/dmMMrahgUbBo1XQkP5GTLjBKZ9Xj8EIVpucE9
	 U4mSouirBoGHmHOS7NhxSXa4XNEu+kaJd+51AC8kaSbLBBmmcJGip5eDdxR3nbcQLZvQB
	 nk7Tayfv1okZSJcZGTtyqEXysCx7JyLpf+u28TlM6bzeudfM0Ts85PcQ2mcICfH01VV9T
	 FMpsTLhCr7Z9irN56SVFZK6QVw4IRs4CmTiKxWn/kssq5KjIZHJc/aGvTBNRKFHOPN/ZX
	 zSxsLyZ7uqHw+H/P5116je7GH1KPASRpGZ17dxyR3HPA7+GvHr3yu8GujlRML7Ehjmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FmILPruh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F854606A326;
	Fri,  6 Nov 2026 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FmILPruh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1841F008A1;
	Fri,  6 Nov 2026 13:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793970261;
	bh=ME2X2oedXhydVPPNVsakRcZ2pjykO1SLtyex8ETN3D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FmILPruhutiEAkEf0NHC1dlpTsUc4vh1kIRd9lKcwU5jkS0UzH/tW/VP9dbDjN4xR
	 PoDrYUP2Y4w97+Zdd6F3svicIiJxsCdGvmzmluDJLARsbo084G8MSXf75PdEOTc31C
	 Qsr8SFnSW81CVBJm4SuiObvfH1vcN+O53jA81FOk71YggHooXNllHK5XJkcQuPqufY
	 yI7bcZZ4ANQOf3YSUMySxCrCKRW3yL4xI69YPVI/HwIDEDwNv0k5d1+/fUWWNLGUT+
	 uDrvSVwFG00ezFoaHG7h5R/bYybTaprgeNUbRTJS8vJAfyC4bSfoccbO2R5RkKH8dK
	 zaRrmL7z9gFAQ==
Date: Fri, 6 Nov 2026 14:04:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: 8250: Allow unconnected interrupts
Message-ID: <20261106-lumpy-just-mosquito-8ef62e@quoll>
References: <20261103224409.865130-1-robh@kernel.org>
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
In-Reply-To: <20261103224409.865130-1-robh@kernel.org>

On Tue, Nov 03, 2026 at 04:44:09PM -0600, Rob Herring (Arm) wrote:
> 8250-compatible UARTs can operate without a connected interrupt, using
> polling. Requiring interrupts rejects valid descriptions such as the
> HIP06 LPC UART.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

