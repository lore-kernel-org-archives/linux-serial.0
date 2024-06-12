Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978E180A99;
	Wed, 12 Jun 2024 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215744; cv=none; b=W/EfMoUbgp6nf8eEjd5x5cUiGgBs9iVM48GpQJ5vRrL0NvTR4mobiKSSwhmgrOnUtcGSkuxCz0QCtkLzMiv+UocI4oxlKVRKRKFbelFTqD18iJkvc4ftytgq4XU251a5Twr94F7Z/Pj0orXEgE4En6lRkJXg1j3XDdwUJhjcnak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215744; c=relaxed/simple;
	bh=RRNxGY9uc2EaF8nuRd/G8iHqK8yIo4zN2MQ/fl1O4h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUqXCHUWSzVzzBpep/PDmHqy2fQMLsmXElax52eYejHNK1MMSIHFEeYrBQdYhD43zRipe5P2RLlUe+fgI2fRripymlQXWcR+IK+TDIwN+Z26W/KwoqrmDth99omO4u0OZrFKMc90aWNyXcawHqObioGSC5yoYYONSN7T6tdsISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYZykKJa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYZykKJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA22AC116B1;
	Wed, 12 Jun 2024 18:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718215743;
	bh=RRNxGY9uc2EaF8nuRd/G8iHqK8yIo4zN2MQ/fl1O4h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYZykKJaJUs5tzXCUsQOfoxqW+JUR2S/UzJLs6cCRNQD9xiLMGO+Jq1UNwZGw2HAH
	 yUuw4jXmI597oiKjz/CoOqRb5bWTkFovTkdYjNHKu/6JMimpMHF739Tm4PsWHM7xvY
	 yUc1eBXI47+OiaXjvGXaMUWfBfp7uPtAMNPSxs15CZtanSvyrMKd/03wkY+hAwS4oj
	 /YqUKJFzXl3hLEG9mVzwTO+w/r9tTAfzaofWTaGf8eHDfTIFPWgTKEfjBm28mLveA/
	 GEFKIrXSrE0e8H2pJqHEzEqH+Ateqq5fG/xnsWPSRF+N75OLMq9hTaJbxLfJEaVDmi
	 yx9aSCOf7Fulg==
Date: Wed, 12 Jun 2024 12:09:02 -0600
From: Rob Herring <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: nxp,sc16is7xx: Add missing child
 node
Message-ID: <20240612180902.GA3178463-robh@kernel.org>
References: <20240612165457.103575-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612165457.103575-1-animeshagarwal28@gmail.com>

On Wed, Jun 12, 2024 at 10:24:55PM +0530, Animesh Agarwal wrote:
> Add missing child node property clock-sc16is7xx to nxp,sc16is7xx.yaml. This
> fixes the following warning upon running make dtbs_check:
> 
> ./arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: serial@0:
> Unevaluated properties are not allowed ('clock-sc16is7xx' was unexpected)
> from schema $id: http://devicetree.org/schemas/serial/nxp,sc16is7xx.yaml#

That's a pretty odd case. Lots of devices can a crystal and this is not 
how we describe it. I think the clock node should just be moved out of 
this node to the top level to fix this.

Ideally, when the schema was converted, the warnings from it were looked 
at and were either fixed in the schema on conversion (with notes in 
commit msg) or the warnings were left as to be fixed in the .dts files. 

BTW, dtbs_check is run on every schema patch for the schema in the 
patch. Results are here[1].

Rob

[1] https://patchwork.ozlabs.org/project/devicetree-bindings/list/
