Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EA21E515;
	Wed,  7 Aug 2024 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028995; cv=none; b=iISw6bPh8nrpfUM14cNKxZb2UeypucLSp6tV+RKmOAMb+aL4OZpViAH5HXMBUz/vGapiAv5EZMKrPQr/Gq1wEmx7g8Int8IWqG7zHqTBzX5xnok+Sa6GVtUawpQp0hW87JHV9nTL1SRPKn2NcHbitzTtZbSgtBHVmmrpwJKOL0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028995; c=relaxed/simple;
	bh=uq7KVb7mBK3tb5wST8u9PxVjIXdhkXdG2GGoihOhfWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/0e59YMlQnKasEPTnaEGXD0PMXPxO9INTbgX4DucD2Q2jJp9StqBPrlQNpRA5+A7NgfPFmOTQPaJcop6DP5LTrLDrF56s9OFuMDSf3tORRTl1x6g/44HDLVBWY8EmKwwHvn+vVWOwYFqKs24sqEbF3F+YDlqRXUIyP/0NAfnug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k0pGSXgg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k0pGSXgg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3228C32782;
	Wed,  7 Aug 2024 11:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723028995;
	bh=uq7KVb7mBK3tb5wST8u9PxVjIXdhkXdG2GGoihOhfWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0pGSXggjSioooBfCXmp1pBZ67mX/Bhxx9Fw4EjPdCl8LwdCUr8oF3K+GnOpbbitu
	 GnnQToQoKPZpay77e1SbkAWl7NoRi1WutxF+3IZB0etbJ9YZXnzZRDDPhQuSD/U4wR
	 ldLD9S411g6GsDvbRQ9aA9Chp++ekJ81RZaVUaco=
Date: Wed, 7 Aug 2024 13:09:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/2] tty: serial: samsung_tty: simple cleanups
Message-ID: <2024080714-spongy-wannabe-7a9e@gregkh>
References: <20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org>

On Tue, Aug 06, 2024 at 04:29:44PM +0100, André Draszik wrote:
> While looking through the samsung tty driver, I've spotted a few things that
> can be simplified by removing unused function arguments and by avoiding some
> duplicated variables and casting.
> 
> There are no functional changes here.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
> André Draszik (2):
>       tty: serial: samsung_tty: drop unused argument to irq handlers
>       tty: serial: samsung_tty: cast the interrupt's void *id just once

This series blows up the build for me, are you sure you tested it?

drivers/tty/serial/samsung_tty.c: In function ‘s3c64xx_serial_handle_irq’:
drivers/tty/serial/samsung_tty.c:948:45: error: passing argument 1 of ‘s3c24xx_serial_rx_irq’ discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  948 |                 ret = s3c24xx_serial_rx_irq(ourport);
      |                                             ^~~~~~~
drivers/tty/serial/samsung_tty.c:856:68: note: expected ‘struct s3c24xx_uart_port *’ but argument is of type ‘const struct s3c24xx_uart_port *’

And so on...



