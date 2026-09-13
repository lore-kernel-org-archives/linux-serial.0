Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4C39A4CF;
	Sun, 13 Sep 2026 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789290294; cv=none; b=cNNcKRLNJmMAMF2Zmr2n2yKSxhiVlUbc2vzvvf6rYQwRtfPCqAYzktm5Up2RUnLLX+rIBKjNczTx3B6+VyEkx7qEpzl0EJXho+4MykZhzLO+rE49i3hF18UKVqty7om6BYv3xNtTuAsZR3cxj6xyQJg5OoNN+694aVAPVoPMZjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789290294; c=relaxed/simple;
	bh=Z0XRbOlMwGXNPq5M4kimc6MychwhZoEOrw0GLsG0xdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu4uNQRG4bPrGYOMPLWej6OlrP5FcpN2TSXeLBMQ47A9w9MRwKqcPph8bO7L+p3xYSOkfTQjBAP66fnfNeRUaQWOsFoNt5fVH+VBacINkPOccqMZ+r1H/R9ORFaGjSjK9yAPSl+8Po2m8witBDGpmb9OpSojq3i+3aKHs7g9aI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1xwedU/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1xwedU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1D31F000FF;
	Sun, 13 Sep 2026 09:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789290288;
	bh=MJFfy+JjI0S1NdzpmtfuvPqm0ncivIpnRhlNZlFmPxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G1xwedU/EMRSOdWqrZq+Y9EZmsbPM3Aw4beUE7ZnW11aOCjZKjXYhSSLg2mQ/tN/y
	 VmSlln/TNK/H2QyyLp8JxqKEeErvDwWNa8dXlR41M3bEdDr354Ah882i1O0zNy9Chu
	 IL/rygrPSfr6ER4tH4rCmfqwixq8kCe4tSb7shNS9eb2W7exDMeXpcXckXmv/M/Uyz
	 kam9+t8y29t42nGVAShjvkCrNr6Mpu3xHxz6jTCYpJ4Y38yl4WsN612YF5PWCEmn4s
	 AM8nDsuKjaTFKnCZrHcaRKDZyrTwkgrv7iGO1vKriMANVx9YuYa0IngDowe6hi9dcd
	 qKJ4ce6QXrGPw==
Date: Sun, 13 Sep 2026 11:04:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Moteen Shah <m-shah@ti.com>
Cc: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org, 
	krzk+dt@kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jirislaby@kernel.org, devicetree@vger.kernel.org, u-kumar1@ti.com, 
	gehariprasath@ti.com, vigneshr@ti.com, nm@ti.com, a-limaye@ti.com, 
	y-abhilashchandra@ti.com
Subject: Re: [PATCH 1/2] dt-bindings: serial: snps-dw-apb-uart: Add
 ti,tda54-uart
Message-ID: <20260913-unbiased-kickass-shrew-baa5ae@quoll>
References: <20260911092529.306082-1-m-shah@ti.com>
 <20260911092529.306082-2-m-shah@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260911092529.306082-2-m-shah@ti.com>

On Fri, Sep 11, 2026 at 02:55:28PM +0530, Moteen Shah wrote:
> The TDA54 UART is compatible with the existing DesignWare APB UART
> binding. Add the ti,tda54-uart compatible string.
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

