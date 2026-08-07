Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B73A3C09E3;
	Fri,  7 Aug 2026 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087421; cv=none; b=pNCGYjl/tOqEI5kbS1bBf1PJXYhy6PQWw2mqi5e4IsPW1iEFI/bK8yRFuilpws2kpgPkMuyJKDW7wY9EfELYESXwVAb8lfSK3upyPNfSGcrtpyM76LS/rLCCzKPDNKa6mdZJ9DLdURvwuDZcAl8AKCw2j4lzDFdDDEv3jnDK2SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087421; c=relaxed/simple;
	bh=GwTvq7hM9tPYGLwJTjP2309Jx4K3X2GgzxZELjlSc5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuhZDzqQih5kA9ElrgSMQedbHDG2s8EWdfeuen09ECHTvrO3kI+Uef52zEWwWoO2yyZuduX2ADzqrtgFsm8T2Y57pqF9j9fpTCQQo5VqNM2JVmUawgvyZwXnQVDgNXaZmQuFSdjXHeYRa1ORnUz5wPB+zIfPzWpDp0VXYIz3b5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLij02BS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLij02BS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EB01F000E9;
	Fri,  7 Aug 2026 07:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786087419;
	bh=AgQPRr6KO6f+5jgx8UafJjTGJrvaC3/Te3NzsCkfesU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CLij02BSdOzAHBhHBATYyrVi9hkxsqlYz4VIYJ+tLIwDOusBpIeEQ6nsvCbMmewrW
	 HzOWWFbkb2ioc+QJoowwcc5Iy/emL5WdxemjWy7NTS9alinUOyAX1FV9XcGtj2+Fm4
	 uOkegAHxaeY8ov8h3m6b5FkotOYK7ZyLC3bY8umE587jIWR07AkjBrEmbXDhUDnkwF
	 phevrPP/W5uqtvfeumb61rtIwEX7Ln7z4IHP2tC4EpfiqEJLE4I664YL5lGDCcyCP+
	 OvX56TuEiitZwE6pduxT7YInlF2VB3wmC8MRxs/FyjKtUjTYq7zjp35U029Rjv6n6f
	 tU12iXfiDJFqw==
Date: Fri, 7 Aug 2026 09:23:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?R3LDqWdvaXJl?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org, 
	andrew@lunn.ch, jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, 
	ninad@linux.ibm.com, anirudhsriniv@gmail.com, tan.siewert@9elements.com, 
	linux-serial@vger.kernel.org, mfd@lists.linux.dev, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: serial: 8250: aspeed: add ast2600
 and aspeed,vuart-over-pci
Message-ID: <20260807-ginger-mushroom-of-reputation-bbb7c8@quoll>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
 <52d5bce1cf8ec3ff0b27e7313655cf7ffa2236b5.1785932211.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <52d5bce1cf8ec3ff0b27e7313655cf7ffa2236b5.1785932211.git.gregoire.layet@9elements.com>

On Wed, Aug 05, 2026 at 02:19:48PM +0200, Gr=C3=A9goire Layet wrote:
> The ASPEED AST2600 has 2 Virtual UARTs accessible over PCI.
> The ASPEED AST2600 can be used as a PCI device.
> 2 Virtual UART can be exposed to the host via this PCI device.
> These are 8250-compatible register sets and can be used to have UART
> communication between the PCI BMC and the host.
>=20
> This boolean can be set to specify if a VUART is used over PCI. A VUART
> over PCI needs a syscon phandle. The syscon gives a regmap to the SCU,
> which is used to set the enable bits of the PCI device.
> On the aspeed's chips, the clocks phandle already points at the SCU node.
> But deriving the regmap from the clock provider would misuse the clocks
> binding. An explicit syscon phandle states the dependency directly.
>=20
> Signed-off-by: Gr=C3=A9goire Layet <gregoire.layet@9elements.com>
> ---
>  .../devicetree/bindings/serial/8250.yaml      | 42 ++++++++++++++++++-
>  1 file changed, 40 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

