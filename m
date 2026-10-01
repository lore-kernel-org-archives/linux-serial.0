Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EEE4B95BA;
	Thu,  1 Oct 2026 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859139; cv=none; b=W3vrnJVBy9tyiXy0IMWGa/xC0EFfYo2Xa+7n9Qp1kevRCKUhE2E1PqLrQZy6AVLSTKbVW+DdRdpApLzVbr2Aimp7bv10McXpSucBqnvQ9fZlUdC6xyXu9YyTUmjeSQTqgLB+ALcHnB6LWkdFR0R/zwsdwapH3VJwc9KV5nos1YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859139; c=relaxed/simple;
	bh=wzwl3gw5e+db5oZR4+r5voy+RDCC4J5Putz8q+zjj7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJ1/5uFKqrly3P6vCPG0lfN737p3GSN7zppJoLgTjkZuvJUIuayYOXXa/uB2TrPQac2tRhMoOJFbo5OaRaNMeIAziONOMhFzjwCN/tXYv3HP3ha1SnatqQWT19Hgf2ZGx82CpiiAkeNU26JDVnZSfb0Z+8tVCp4f90o9dcqObok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K2poqIT9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K2poqIT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D3E1F000FF;
	Thu,  1 Oct 2026 12:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790859135;
	bh=tec5FQuLPRbdVVuUIDCytMknbBana/Hua8s4K23aD0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K2poqIT9ceZq6Ra4TaTezpspNG6viPMERp45zFObidAykvZxZAxoOQIIzK3ssGp/Q
	 CcwazjuaWGcA0ukfuqOP8DNdB4JdI9P43/U/uh6t4wGs5l1U5D3VfcJsaZHbxjZUgv
	 I1xPQL6NDREljq3owZtVIHgwzvv9UWf6XJUC1uWY=
Date: Thu, 1 Oct 2026 14:52:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: longzhao@ambarella.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>,
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 13/15] serial: 8250_dw: add Ambarella CV75 quirks
Message-ID: <2026100140-overbite-mundane-fc79@gregkh>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-13-486cc289a4b8@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261001-cv75-v5-v9-13-486cc289a4b8@ambarella.com>

On Thu, Oct 01, 2026 at 08:41:02PM +0800, Long Zhao via B4 Relay wrote:
> From: Long Zhao <longzhao@ambarella.com>
> 
> The Ambarella CV75 UART is Ambarella IP, not a Synopsys DesignWare
> licensed block. At the register level it is close enough to DW APB UART
> that a full custom UART driver is unnecessary: reuse 8250_dw with a
> small platform quirk.
> 
> Quirks:
> - keep IER ETOI (bit 5) set for RX timeout behaviour
> - skip set_rate; baud clock is managed outside the UART block
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

When you submit lots of different subsystem patches all in one series,
it's hard, if not impossible, for subsystem maintainers to take them :(

thanks,

greg k-h
