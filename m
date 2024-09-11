Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1076D7DA84;
	Wed, 11 Sep 2024 06:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037880; cv=none; b=WIdiXd/rJnLvLHqGB9Ir8gBrBis473WbwKYbXc2d3ozNPsLltx4ZKu011dlAQuKdD2XUEu7goU+1KjN0Q/z0aP+yefd0f665UVilJiuFGpVC2vF573T2U/GhdgUQfqEtmQHg01wzdXTi4hYCmZ561IR0tlTwlxaAw/+GTdPjeFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037880; c=relaxed/simple;
	bh=l9sUgYMANLnORXpVuqTC7B1ZQ1lCHLIR24BDxoGYxcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbhnZkD7/FEjCmAhMu+ckreY6gGYRKTjFpYsFT3Qm6lQUFAeMudhGLAiEQnxgdLzlFDzz5ZgmH2qOf0oMcHPB8jc9U6DhXyLEzKd8wShvIdyxhSsuVyw8v2R5HRCshCfaQHlU2wiat/NFwGtEXksgRH9HPWb4EP8CX3XOrrkJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edyyAZwZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edyyAZwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E971C4CEC5;
	Wed, 11 Sep 2024 06:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726037879;
	bh=l9sUgYMANLnORXpVuqTC7B1ZQ1lCHLIR24BDxoGYxcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edyyAZwZmq38zmA3mieVEXmqTMpySw38ds4H75uj+0ZtnJiMj0DdrVEBoisroS9mI
	 1iSLbNqL26pPgIcvvfsQ6lcq+853rycBSbr6ZAkRQMWYA+kQpqZ+iFw2JDGzO2C0jU
	 dV77z9bcZ1JRTHdMROR1QdnNMBOG0O0s3BOyQw1q90V3ZLtZU47UODG6tHaCzBDKH0
	 ew8TObAlQJQkbZVH+u/ZR+G8WB49v+0Wxt1H+Bkc8HGgLpp2LZNktl2yuFEOrLyWxx
	 5j+1Fnm6+muiKCrnzGtBtshyOpMuVBpTn8NdhAkdP2vT5zWanAFR2JhX1eReSz4ZSv
	 LNPt9Eev2/Srw==
Date: Wed, 11 Sep 2024 08:57:55 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	asahi@lists.linux.dev, Neal Gompa <neal@gompa.dev>, Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v5 2/3] tty: serial: samsung: Fix A7-A11 serial earlycon
 SError
Message-ID: <qjlxidd4e7smbr65ebl5mg2pcwv64itz7mgbshxrccp62svfqv@daa3u33m6xx7>
References: <20240911050741.14477-1-towinchenmi@gmail.com>
 <20240911050741.14477-3-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911050741.14477-3-towinchenmi@gmail.com>

Hi Nick,

On Wed, Sep 11, 2024 at 01:02:12PM GMT, Nick Chan wrote:
> Apple's earlier SoCs, like A7-A11, requires 32-bit writes for the serial
> port. Otherwise, a SError happens when writing to UTXH (+0x20). This only
> manifested in earlycon as reg-io-width in the device tree is consulted
> for normal serial writes.
> 
> Change the iotype of the port to UPIO_MEM32, to allow the serial port to
> function on A7-A11 SoCs. This change does not appear to affect Apple M1 and
> above.
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Tested-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Andi
