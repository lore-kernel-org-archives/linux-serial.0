Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E0337692;
	Mon, 12 Jan 2026 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209947; cv=none; b=fOSK/RBO1Z9ExowFRYHTS6U3W+NCmjgvzKp4SS3GfhbHJl6CzIcMLdHeiIpdCZP46wnWqJuICkx4Y+NmlFgP3SE+7S43KFvICdEw91D+n7bdsydqSj3kRu7FmH6O5wYq0DwKHNljKMxtKVU5LoV7TU2T/a4d+mGHI2BNFSALp1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209947; c=relaxed/simple;
	bh=pmUNcnmU22/O7mw740x5Q6qEG3VlNWVyknuIw49QbD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkiIwaUjXPeDTN8RKt2Axscs3lMs0siITXWKd9cdfgM1fRSzKoa1Q27LPdu70VneB+jxWceewHHmimd7vmNGukRW8FzTXIEKv5CTnzAmUDrRVTghWkIAg7kfY9N4hs47G2uDN0kPYA0dpq900j4FwpFLdSgnQw9JoVPT6PBUWGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWd6EsT3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWd6EsT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01BFC116D0;
	Mon, 12 Jan 2026 09:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768209947;
	bh=pmUNcnmU22/O7mw740x5Q6qEG3VlNWVyknuIw49QbD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZWd6EsT3ObLtYkB5k/QvLchJz+soOBsQn7gakjGexqU8DMzM3BMIUzqvgSZS5VpRU
	 tmeK6vyJQFLAw+zNbbk5hnWE+Ed0BZxRp59inHHJrwYp0ckljn4i7m5QqVZanVV/TU
	 PelznLQCTX1fUgUfmOJMG2RHTyL7+IMevQwx1P1DXTq79aE7c5mVu2n85Swj5lInKk
	 9gJR7xWZEJIsRPt3BsIjulvb55+vvO4j/xIUmHlNpFU4NX4mNY1Pn+20sdqFE8IJ0M
	 MzvNT1K1XU2dBMNkboOrNAquLXh2DcWy99Qbh/Um8lGM3fQNPJF/K5qgedw5dLawAp
	 UU/q7T3in9QIA==
Date: Mon, 12 Jan 2026 10:25:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: 8250: Explicitly make LPC32xx
 UARTs compatible with 16550A
Message-ID: <20260112-hopeful-spiffy-antelope-334765@quoll>
References: <20260110024647.3389345-1-vz@mleia.com>
 <20260110024647.3389345-2-vz@mleia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260110024647.3389345-2-vz@mleia.com>

On Sat, Jan 10, 2026 at 04:46:46AM +0200, Vladimir Zapolskiy wrote:
> NXP LPC32xx SoC has 4 16550A compatible UARTs with 64 byte TX and RX FIFO
> sizes, and the platform UART hardware is well supported as a standard
> 16550A UART.

Driver uses dedicated driver/match data, so some context here about
compatibility would be useful.

Best regards,
Krzysztof

