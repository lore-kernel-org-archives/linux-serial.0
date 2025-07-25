Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151222528FC;
	Fri, 25 Jul 2025 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753482603; cv=none; b=t6tKeEGGb8RB2ZWI3M2vfIyd6zdSvL48i3FbHDIldCCoawNlrof4wUm7KoSbGMbPknR90BajmxsN9ndb38QkQ7vShGn4Imyrt4fUFcCG3+AA8Mpddzf5iUZj1JE7L98n/ZJAsuTW7TE1/HuwM9F/sfmT1CzOXmz7xubOHcB86dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753482603; c=relaxed/simple;
	bh=aTk1baJauPVy9kyysWM7wg/om96SyQAhBaQ0STr1Sns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRcwo+uamNob4XthajK3joRY57uxRElseCj4INto4CQeYX/gLq+jq2lve8olz+acv0DFsVJ8iTiRxKEDIJ+dNBDrbsCib8C88SDV9Gp8DShKsS1CU5K65RKArSGS/LgF2sczCj+L3AZ4MUwBEGnidZIwYK+rzhhN1ix7jNqMAOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3xWzfDn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3xWzfDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A89C4CEE7;
	Fri, 25 Jul 2025 22:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753482602;
	bh=aTk1baJauPVy9kyysWM7wg/om96SyQAhBaQ0STr1Sns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3xWzfDn9oK86XHoFYy9UyG3hyAJhOoD7gpBgz8JWOIfzi5SMFItyHVboQgc1TqKb
	 HFA9ahrgeomwjbtfozFtAxzf8k9rBIq7S7dHYCrl2o3kOddZokqqGVm15pBhGDb8KC
	 PyKLSvG0XNnBoqbHOc5nUBIFfD5MJhgTvoS9UPo+TDjRSTmKeBNyr1ZiD33Mt2jxH+
	 GxM2jGIdGtM6fdved1fHMLkN/V9XiepV1D0GkJu2wp6RiOHg/Xi8fUSfZvp58snyf/
	 QrZOOKdb126BAIus36KplAFd2SZ8t1IlLzsSjd4CpczIqN45ocXONc8wh9lGxQFpyQ
	 k1dMEkCU4oI2w==
Date: Fri, 25 Jul 2025 17:30:01 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-serial@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>, Jiri Slaby <jirislaby@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH RFC 06/10] dt-bindings: serial: snps-dw-apb-uart: Add
 Anlogic DR1V90 uart
Message-ID: <175348260118.1950815.4384320284007344403.robh@kernel.org>
References: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
 <20250721-dr1v90-basic-dt-v1-6-5740c5199c47@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-dr1v90-basic-dt-v1-6-5740c5199c47@pigmoral.tech>


On Mon, 21 Jul 2025 23:46:12 +0800, Junhui Liu wrote:
> The Anlogic DR1V90 SoC integrates a UART controller compatible with
> snps,dw-apb-uart, operating at a 50 MHz clock.
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

