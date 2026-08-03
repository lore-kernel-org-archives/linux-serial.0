Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A41402443;
	Mon,  3 Aug 2026 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763396; cv=none; b=k5/Wn4is9Uy/0YTwXmXwq9J413IuQ0Eg+et0zUXSJdsuKpO3DESvj69OExYBintTmb2+ZEPQcnumaTCWOH/YTCpRxrEfBHFf6fea7o7bqf/fOufHD8fZe4vIaiZlxn4gYHITkZtEWJoghY7ql3QZ85VeIOQtdPTwJ+7lHHUL9mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763396; c=relaxed/simple;
	bh=Lr3OyC/HZgFuOIcUvbWBJFAaZRluUNKhaC5ZzYyW1c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okMpmoP6x2toKdbXRJH1GfKTLCzt1Ik9iN48VWh94b7aPcMnWsfc2vw3Wm05yPhuJAh3ZCu/ahJggP3TM3ipvLVYuokvID8RPK+Bz7DABvIZ1L1xOQ5NCF/T1KhQM0OL0nTcDaCB2kjLZteOYjWw3OFHCk4TtRghsBW0vGvy75M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqzmsRRq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqzmsRRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810641F000E9;
	Mon,  3 Aug 2026 13:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785763388;
	bh=bz8SgM4BG0+WSGkNrgBnB/bkcDhyqp3qGnY0xAuanGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oqzmsRRqXOulFxMQvF5fNjacQaf92fdo8SCOdBiEu8zRfok4yNYY5GW8G9kmM3geK
	 Kxl8JrbT9AKNQyTYQQ7lgmrQSyipTjBLxM1XdHYcIeBCoGQcUPdjfhakOjyu2z1OKt
	 zgjjhrS+xIZXlWhw0S/mlcOWn+4uYlLsD0BriepfMfWjpoc+YZ1PPZFOTC5stlIYxj
	 d/TExiAbhv2Muv7VWdifPMebKMScA4bzqkzFWxN3sj6M0R5UjmnQhXnORnM0K75Pme
	 PeVK4t17vjlMwcL9ANxLdXqZTnVkeVwfQuMCAdMy9D4XUOCuysmLUiEVgi1pJ8HVMt
	 glOGzyJD2+Cww==
Date: Mon, 3 Aug 2026 08:23:07 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lubomir Rintel <lkundrak@v3.sk>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: 8250: Add Aspeed AST2600 and
 AST2700 uart compatible
Message-ID: <178576338736.3095458.59419877773354816.robh@kernel.org>
References: <20260721-upstream-ast2700-vuart-support-v1-1-b4ed612b1aa2@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721-upstream-ast2700-vuart-support-v1-1-b4ed612b1aa2@aspeedtech.com>


On Tue, 21 Jul 2026 09:44:23 +0800, Yu-Che Hsieh wrote:
> The AST2600 and AST2700 VUART controllers are identical to the AST2500
> VUART controller.
> 
> Add the "aspeed,ast2600-vuart" and "aspeed,ast2700-vuart" compatible
> strings and fall back to "aspeed,ast2500-vuart" for compatibility with
> the existing driver.
> 
> Signed-off-by: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

