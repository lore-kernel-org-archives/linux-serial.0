Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286BD1FF1C8;
	Fri, 25 Jul 2025 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753482580; cv=none; b=edo8pOdVGFMi3dsb8IE+qmIafCgjRT0c6eyAnhdIvIpd8vCBcCeCnhGgiNT7ln+RTDX9HiAgxMuYKiZSCMKWT55d2ux1wKkk6vCFM18EGjWCYTZGZMhfbWxqr/ys/Bd/J2gDNBJThBfspoAcixG4SYiCQwLJS8NVLYPZgwBK8f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753482580; c=relaxed/simple;
	bh=gABZbOMCUDaNPWraAqPJ08OxTPzW8PQCbw7+hnKqXco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3GeyM8thL2ezdDRffU9/znOyDNFFC89vcDguCjr1/EADpkZlXoijU7m14ujkDPMD8X7AwAhUC8NBwyW84fg+pFQWvXdIErexPz6Yz0I6iJwkExqKU2fDzsekEZx6H6VEc3Kupje8O6kGHLksKgROB1cfOIAJn+2dyAE2Aecmb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LddgLhr7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LddgLhr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79510C4CEE7;
	Fri, 25 Jul 2025 22:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753482575;
	bh=gABZbOMCUDaNPWraAqPJ08OxTPzW8PQCbw7+hnKqXco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LddgLhr7mgQ2rM9G+mB/U9CkbT6mANQs+5CbAQP7pTUMOMzNDpwHhc/Qji0XwYEh4
	 ktYR3KOhO7SNEK1T+X0+coi698Mo5cSLgPb4CzHWIix7J76Qa92KEdBPISYiiYCZ2H
	 Dt/HIhA2f+c/wDyqp6EKON9KGzdO/PejNviuuIthT6CwinkE6Dwwx/W0bcZWitqtcl
	 csjUULRCxzcHCeEOsWK5Ir7gxoQxfmiVSyFl6iMe7Ir3av0imnSkpNO+3/RYCNSqF7
	 1pH0wU53Hd4DZZ4i39giAIZwcORG7TRTNnNKyxs+ru0fhtJYcyvQUz0ehV4IEnkGsl
	 MsAfHRQCMrHlg==
Date: Fri, 25 Jul 2025 17:29:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor@kernel.org>, linux-serial@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>, devicetree@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC 04/10] dt-bindings: timer: Add Anlogic DR1V90 CLINT
Message-ID: <175348257391.1950049.10218208547185479319.robh@kernel.org>
References: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
 <20250721-dr1v90-basic-dt-v1-4-5740c5199c47@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-dr1v90-basic-dt-v1-4-5740c5199c47@pigmoral.tech>


On Mon, 21 Jul 2025 23:46:10 +0800, Junhui Liu wrote:
> Add CLINT support for Anlogic DR1V90.
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

