Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550228;
	b=H5WndoED9nMkUTxrQEo1nvzVylAeFLWMLWqP8HMuFjqS8Uz5qHB7nFocwM4qXMiYNcEa
	 LV3hdIOptPbGsji550I8GRjoErDXeFkOyF9iXz+lcPVHaA5/j4VC5rFuhZYzo/ALIhi9x
	 jX33CbtXP97yRdQYSdVLs7Q9VZjjZftxhv+6WT8hxPVpWJOYB2lQLt+GaT2Dh5ctqkEoQ
	 xdovtH8cCgiD1OcssdXTx2NGO7flaG4wFjU7XoI+jY8npcnNp9N/BDhWfJ9aQlLFAo7r4
	 gZ1obrpbRjEy1xARj9x0vpplbjDSwSwjqYKjvSR7hxHpc3K6yEDRS6ZkZvLWisXuDTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550228;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=TRHGsWUwkskS4t6ufJrJoi4yNfFVdpXAPSTFROsXCBE=;
	b=gz0fdrDNFHw7AvbDcp4TROchaJtv+mCkojFeiLo3LhMn3m95QN+OA1pD5T7POH2ulwqt
	 SXENjvBq2OGPmFu0ooPh6F1FOVPuMcu5kqRbTVwxG4oAsgFJLSAfE4aieQ66ynQB+HhBe
	 qnA1Tfl2sj2JlfZilbEzuOAoUwEFrymvt5WiQgykalKnv+B+FqTYSmkKFNBYlxT2cdfPh
	 istRKSR7zHYUWPNXaKlmlMbCWywNljdwYLHW6+qySIqQ/UBiPg6cv47z5BSaKnKM0DAUm
	 seP32EOZqkoQhLYU0k0170fqTxWofRTUINeOz5dfkJWUWzZOA5xED8nLRcR8YX3Gpuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GbEERPZR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DFE606A31E;
	Tue, 24 Nov 2026 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GbEERPZR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0071F000C0;
	Tue, 24 Nov 2026 19:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795550227;
	bh=TRHGsWUwkskS4t6ufJrJoi4yNfFVdpXAPSTFROsXCBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GbEERPZRKJonoWvvipuAMRiOHFSDoWDxOtEY44h8E2+AxZDLcrlIP/LLhG+fbhVUH
	 AfVV5Cuy6mOgsV4iG78DHSnZHhqLHuFmspwiYZK8yeVaQJfwHdZIGZ4xb4/qEqKCTh
	 CCDJoNS20co+GETB+oJd+3EYgX/Pf8EW8LV4/9NCpfRJidwWD0oyx8804xo1xcThda
	 onIHTsgXo3d1ru6YvR3wETEiysHKRCAlnj91e5n+icCNbzEqSVgvYuabYoQPlxtXxK
	 9x6AAuNFStxd/fB0hqUyRhtah9ZaSZuveg/ipnnLDJvsSmK6E5JW+/rTzmvlDf+6Be
	 GdFElckCifjYw==
Date: Tue, 24 Nov 2026 13:57:05 -0600
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Matous Hybl <hyblmatous@gmail.com>,
	Miroslav Ondra <ondra@faster.cz>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: pl011: Reference rs485.yaml
Message-ID: <20261124195705.GA3075022-robh@kernel.org>
References: <20261121-pl011-rs485-v1-1-0d18008f4a12@gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261121-pl011-rs485-v1-1-0d18008f4a12@gmail.com>

On Sat, Nov 21, 2026 at 04:10:33PM +0100, Kryštof Černý wrote:
> The amba-pl011 driver supports RS-485 and parses the generic RS-485
> properties with uart_get_rs485_mode(), but the binding does not allow
> them. Reference rs485.yaml.

Is supporting RS-485 really specific to the UART? Can't pretty much any 
UART support it? Whether a driver does or doesn't doesn't matter. If so, 
then serial.yaml should probably just reference rs485.yaml.

> 
> Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
> 

Drop blank line.

> Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
