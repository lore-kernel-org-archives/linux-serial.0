Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A9344A409;
	Thu, 15 Oct 2026 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094562; cv=none; b=A1Dok13WKKIFuWDiiNK/LnwuqrFP85nK4zzLgmUK287qt/Nkmgr9CZi6CC1y22QSqqnkVR1tgfvd5FsGlp4xRFFCZdxtWL/JwWUlM/b3CeIVMYOBdOnEQQ4lBy5zSMHPKQM5JXL1LTJWZEx60sbdn5xVCGBlBBPQyLKtTUVuz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094562; c=relaxed/simple;
	bh=RpjK9XcQvr293fmfQosZWycmCuDRfWyERj8yvynmDsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xv0XtyjiXocsUJb0capVKa6xDd4Lpt5QJRHLAex+4bgnMad945e6ZpqKGIpPRVU2G1G/K/MPtj4BpvQIxpNf7ycDCtax6tX7qiXx+K1kGjF5zYPiYiWrMhSPlQ241rI4NwS/oNBu635D6dNDhUvlwT+Sq7601le3uGw6GICVbBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc01fAVw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc01fAVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DA61F000C4;
	Thu, 15 Oct 2026 20:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792094559;
	bh=nGxemQzLP7mSaxp2FxA3NW6pQnFC4/3ja+XeKl0+AlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dc01fAVwein07mQywrLDVQwSQDyPdtkuPZkQRajp5lCPoSGGFjns8btldPMB2trf4
	 KgJ/M9jEqWP8ZbNLBCp42E4sxYve0KGfoZfZu5zbsmTPjmEk7djAGqU+lJBkyAIvIo
	 VTk5BnrxCuaZavxMMFYKk73em3LCgblug3zNNm4ye2M1VOVrDF44pxyvGOA42WJHa2
	 /TGev1WgkkJSx8wxgg562/JWkgYmocaElhw3N3/kqlmNWmdGisq7cEos1JEZge1LjJ
	 OukvETxPumDSR6HklCm4NhVGpG6krstf+H9VelOvACqzZsCF+Fdso69V4rgd4uk1Br
	 BDtnPxGCrwRCA==
Date: Thu, 15 Oct 2026 15:02:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fil Dunsky <filipp.dunsky@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Drew Fustini <fustini@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jason Li <jason.li@cortina-access.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 03/10] dt-bindings: arm: cpus: Add Cortina Systems
 CS7542 enable method
Message-ID: <179209455732.2799921.10391094188509474166.robh@kernel.org>
References: <20261013-b4-cs75xx-v6-0-37e8f3969b7c@gmail.com>
 <20261013-b4-cs75xx-v6-3-37e8f3969b7c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-b4-cs75xx-v6-3-37e8f3969b7c@gmail.com>


On Tue, 13 Oct 2026 09:06:04 +0300, Fil Dunsky wrote:
> On the CS7542 the bootloader parks the secondary Cortex-A9 core in a loop
> that waits for an event and then jumps to the address found in a global
> software register. Add the "cortina,cs7542-smp" enable method for it and,
> as with the other release-address based methods, require cpu-release-addr
> to point at that register.
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

