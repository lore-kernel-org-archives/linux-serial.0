Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD0C566A;
	Mon, 21 Jul 2025 00:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753058388; cv=none; b=m5HAzMvzSK3Aw5/lNsxQMdTh9O5aykaavHHV+6tqtxuMHOfL97B8dJRhT0Egln7C1v04xwarZ7+XN7rjf5J5crUt7kkpaomqlJwF6UUy21+e+2jFNBKwpOsoIfMFL4CrSHdhEc4FAS8RnFc2RlnY6+TP82N/asGvBE46Nfsd8jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753058388; c=relaxed/simple;
	bh=DcAxps/FGdwNvvt1KUL0mg84vdvjjbvyVNUzZyC1NQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuMjVf6yHKBL+bGGf0teo1QhCe6LWStDUqBLODKq1LDpkuPG4hVTUzhJoYNrga0U85mASAJnCYEAOif0am2gLFqRKtW0ak/MFW664YDfxUrgLNpU3puOGBf71tXfOoPTueTPtSwm6pjqXrcVAdAsoJx41LBq68tcyhbFAzucV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVXOMk0o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVXOMk0o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3069AC4CEE7;
	Mon, 21 Jul 2025 00:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753058388;
	bh=DcAxps/FGdwNvvt1KUL0mg84vdvjjbvyVNUzZyC1NQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVXOMk0ouM5Coaraip90bgDOb+w452a4nPgiKLNRQ0k17QLIABHBTRf/Wp9Thtdmw
	 70ozK9bOxCAhB1n80sYSpx/6ptOWUdf+wNnEpvXhyJ1kk/S5WgsHWlaZZykpX1iun+
	 Z7U1d9GlukCtkVEQHvG4eEusM4Nr2V4x6x28ayGUXdCjWxCPD8UP51KIObxY9R7ZRO
	 S9+Fp67BSmq7l/nIhleQrenNVkIdyVaSrbnFL/LaB6Oyl0/vyYYvvNZ7lMH7yG2yS4
	 sZRKdg8RK4Dt/TbmL3jhj3k6wcC9ih6sPxddMSoiD/e61O42/A7ek38r01yrZSQg+h
	 6Md0qotk0QBog==
Date: Sun, 20 Jul 2025 19:39:47 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alex Elder <elder@riscstar.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH] dt-bindings: serial: 8250: spacemit: set clocks property
 as required
Message-ID: <175305838704.3151611.2882961129510039332.robh@kernel.org>
References: <20250718-01-k1-uart-binding-v1-1-a92e1e14c836@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-01-k1-uart-binding-v1-1-a92e1e14c836@gentoo.org>


On Fri, 18 Jul 2025 23:04:37 +0800, Yixun Lan wrote:
> In SpacemiT's K1 SoC, the clocks for UART are mandatory needed, so
> for DT, both clocks and clock-names property should be set as required.
> 
> Fixes: 2c0594f9f062 ("dt-bindings: serial: 8250: support an optional second clock")
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

