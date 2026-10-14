Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72DC4D179C;
	Wed, 14 Oct 2026 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974907; cv=none; b=V6RxTTzG/rrQzUoq6Rt0e0sMsLZw58HL36zW8via3BKbqIUOQEvs1+Kb7qbhc1uukfCEYo/bI2Qo550L/nSbzkYzYpEWBJ2SzaGjLPsbieVp9DHkK+pnPLd9tj4WAkwWNvyMnnZpoq6RGuQxDjPRj2SRdTswtDglRNkIguSGaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974907; c=relaxed/simple;
	bh=hWAKTPLEbuKsY/6R0U0SrZvhh7j6plorTg+S+sLNz2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/YCUg4o5qcnswU8SNYezzxL3oUbdyDkmGUXU8SUcf1tn7fC1DQFKSPDz8qPKmWzOU2N+DFbADAUZqfR8WuwjS1tCOVsJ+kM+k7/dLkbSketcXKBwrvriz8JJkM4pXT/roUPdvOc+0nf+LBVtKed+bZIVZkrZjsn21FmC86s48Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNHuwjdQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNHuwjdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE2A1F000FF;
	Wed, 14 Oct 2026 10:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791974904;
	bh=Dgzbxv5LgP6yrWflVEmO9CW6B2XNNqetxCLAu9JfhLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZNHuwjdQK+UqOji54CT96pYb8N/B20UgGYZr+66mT1M5+06Ah2qiIS9mK0jrKqW2R
	 nOmtzwSF8B0TbNLKbUj+1HDMl+YyE2LchBMD+4NGiigsvf/XP2Sj3DaIZfNXULDJnM
	 x/K9PlwyBzHnBgjlof/BOi6DFA57I2UWZCEbf3mRXZibxwUWOmJT9D+uhK1D8V5ODz
	 fX9RBw3Iy6pLWkfGZttKsp3gjuYOWaAZFk2Qw/1lljDj4phBG0aPs+V2GX/SSZfhpR
	 lLstCE6tJSKPhtMMyW4NiOUeLjLx2QTn6vgjblgKJ3wmQpRlPRjdCh6+zpdSlpk+sU
	 muh6TbpB+Xw/g==
Date: Wed, 14 Oct 2026 12:48:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fil Dunsky <filipp.dunsky@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Drew Fustini <fustini@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Jason Li <jason.li@cortina-access.com>
Subject: Re: [PATCH v6 06/10] dt-bindings: serial: Add Cortina Systems CS7542
 UART
Message-ID: <20261014-grumpy-ant-of-satiation-f72b39@quoll>
References: <20261013-b4-cs75xx-v6-0-37e8f3969b7c@gmail.com>
 <20261013-b4-cs75xx-v6-6-37e8f3969b7c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013-b4-cs75xx-v6-6-37e8f3969b7c@gmail.com>

On Tue, Oct 13, 2026 at 09:06:07AM +0300, Fil Dunsky wrote:
> Add the binding for the UART found in the Cortina Systems CS75xx
> (Goldengate G2) SoCs such as the CS7542.
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
> ---
>  .../bindings/serial/cortina,cs7542-uart.yaml       | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 

This depends on the first patch, so should not be taken independently
via serial tree.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

