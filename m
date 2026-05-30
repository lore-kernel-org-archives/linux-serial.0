Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C1D3A8743;
	Sat, 30 May 2026 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780140417; cv=none; b=G+qspKQ4tO+IdL4qhlYLJecr/3OZ+f2dr3/iHAus+olOmgOCwu7r0A1Sdkvy0Nf9qsZzz4Y6TTAhSwzD1KG6zdyCDmCsbhoQ0E7c3G8IvbftuiA71kgfdUhPS5ZUmRfcm9N4GUTQg8Hp9M6TDVmFAO8a0qlo6UseCoVrT7K+lRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780140417; c=relaxed/simple;
	bh=KCbFhJAEk8KcQO9/73KPnfZwTp341BcjN9sfnu2ZngI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0AcX0CbgRdudolv+rpNhWeNW58eIXm1VPI9ZTpuVJdVKr0Y0l1nBS8Hh71afHK7R0sQJNRLDDQXCQ+2822YeGaEaS+B5Bah5yatEJ9SNXevzfULFKtybAMp4t3wFARHfpxIVXNnfIo8EJ6R1UiMALyCrLXJ0t+H2+NhEas9/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lam4DaPK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lam4DaPK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381301F00893;
	Sat, 30 May 2026 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780140415;
	bh=IVwpw2eRABk9+ylDgRtDjSZqliuoEKt3Edcy4orUwLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lam4DaPKN35I/BQOfL0hrgXSXs0gSfS8hbmtvHTfbxS8EN3M9iGT8lPhebJm6LWaM
	 wdMEUp+JQpYnU43nvQLMskXcAqX0xelbJzAZ4v8IzuNIJaUfSJlMyQWhPbdUieHAzO
	 8TilAR++psJ4jDXjpZrjKu0WBl36lpeU8sOx12t5SGX1cWVsBPOMB1B5RERmmFyOfF
	 GuQYL7+fS6zgQp4iFOTUyLTPyLBAwKZjdNm6EKo5mnzCBBXYlQTcNVzLsWTEfcDuPd
	 ZTmFxrWrFErfJZFjKzOQ0UR6bQJScwk0s5HM1+HAvoeUt367q8SIsHQoTWiQUpWWc4
	 sixny9plr6otw==
Date: Sat, 30 May 2026 13:26:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: serial: maxim,max310x: allow per-port
 subnodes for rs485
Message-ID: <20260530-witty-snail-of-correction-a0a6f3@quoll>
References: <20260525-b4-max310x-rs485-dt-v1-0-e6c19b4d5592@vaisala.com>
 <20260525-b4-max310x-rs485-dt-v1-2-e6c19b4d5592@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260525-b4-max310x-rs485-dt-v1-2-e6c19b4d5592@vaisala.com>

On Mon, May 25, 2026 at 09:43:38AM +0000, Tapio Reijonen wrote:
> The MAX310x is a multi-port UART (up to four ports). The existing
> binding pulls in /schemas/serial/rs485.yaml at the top level, which
> only describes a single port - sufficient for max3107 but ambiguous
> for max14830 where each port can have its own RS485 wiring.
> 
> Add a "port@N" pattern (N = 0..3) carrying rs485 properties on a
> per-port basis. When port@N subnodes are present, the chip node also
> needs #address-cells = <1> and #size-cells = <0>; allow both. Top-
> level rs485 properties remain accepted for compatibility.
> 
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> ---
>  .../devicetree/bindings/serial/maxim,max310x.yaml  | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)

That's a total mess now in the binding.
1. maxim,max3107 does not have ports, but you add there. You need to
constrain (see writing bindings) or split.
2. So where do you place serial devices? Did you validate any of this?

Best regards,
Krzysztof

