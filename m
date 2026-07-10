Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D3D3CB907;
	Fri, 10 Jul 2026 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671599; cv=none; b=kgh6lrGOduDxbtlnAxl9+iJ7nLYwrky7H0Dk6XjLiiZTl0ONtXDqaOOvX0ps/563PpbIdOXAq0F1IZHlhfaT1/yjsREVf4bWKkYwvGjkrOfIevx/I3jzia+SlmyxaNRDUqcOMUMaZH4oY4ynZsCbRNABdcfab6n/D27DMeeNMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671599; c=relaxed/simple;
	bh=Q9e7mqixsLLOGhm6cscuonEBHgxSw6utmXoQtuoEMBw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BV+MKdKC1VoR7mWHovdOBODx8nsM3Fiz2nts8Z1OJ5siuzG63/ZF1lxAafBklrgaefzxg+o2fcBWi6OKl3uFCv1s87enPCGdtk58E9TLAb7KTkZPvkO1ggnOgwEfO/uExSHDVxQeF9NWOzmZQc5bXVJRzO5jF+URswlQYv0ECaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFqaNAaY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFqaNAaY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783671598; x=1815207598;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q9e7mqixsLLOGhm6cscuonEBHgxSw6utmXoQtuoEMBw=;
  b=SFqaNAaYlIPTCYj/TxMWksFz0t6J6Ss9XKfJbyGB/EoHF5JGWs4nSfLh
   sBZeS3two7zXxNMp0e1+Pbww2AdJ1iAybLUT2HN0j8Tp+499q1XlbUafw
   nBILHK/VpAAQSJP5RUX0QkQ7uGmVKlycQ52QvaQKP14MPKj94Ol7B67Jv
   k/jT8yO4Yb0Pae67Etlur4Zx++fqWArtse+FqYs166YaWXuIxR2xvrYvc
   kHwrw1QNiTcsAVzUu9fWqHOkRXURdVX+gzhovMzSqSn/Niyx75z1M/dH5
   dvCbGr16MkN/tc3gKSMn2F33LNXlAqb1XwIpextgt8ILK/luM3dbSpHjY
   Q==;
X-CSE-ConnectionGUID: PZLKHi58Sx63jgLqhTfJ7g==
X-CSE-MsgGUID: LY7oDH/nQ8KRFVc1oW7sLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88052300"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88052300"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:19:51 -0700
X-CSE-ConnectionGUID: P9BM3yqaTaKoiZYP8nQwiA==
X-CSE-MsgGUID: T1iFFTLTR4q7oYwpCO+/vg==
X-ExtLoop1: 1
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.169])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:19:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Jul 2026 11:19:38 +0300 (EEST)
To: Christian Marangi <ansuelsmth@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Benjamin Larsson <benjamin.larsson@genexis.eu>, 
    John Ogness <john.ogness@linutronix.de>, 
    Marco Felsch <m.felsch@pengutronix.de>, Gerhard Engleder <eg@keba.com>, 
    Jiaxun Yang <jiaxun.yang@flygoat.com>, 
    Randy Dunlap <rdunlap@infradead.org>, Binbin Zhou <zhoubinbin@loongson.cn>, 
    Rong Zhang <rongrong@oss.cipunited.com>, Lukas Wunner <lukas@wunner.de>, 
    Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 2/4] serial: 8250: export serial8250_get_baud_rate()
In-Reply-To: <20260709205656.319531-3-ansuelsmth@gmail.com>
Message-ID: <25725cc4-f3c9-8153-b400-c36a5099340a@linux.intel.com>
References: <20260709205656.319531-1-ansuelsmth@gmail.com> <20260709205656.319531-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 9 Jul 2026, Christian Marangi wrote:

> Some driver might need to access the current baud rate to correctly
> configure it.
> 
> Export the serial8250_get_baud_rate() function to limit code duplication.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 7 ++++---
>  include/linux/serial_8250.h         | 4 ++++
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 630deb7dd344..033d8fb8bb23 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2560,9 +2560,9 @@ static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
>  		serial8250_do_set_divisor(port, baud, quot);
>  }
>  
> -static unsigned int serial8250_get_baud_rate(struct uart_port *port,
> -					     struct ktermios *termios,
> -					     const struct ktermios *old)
> +unsigned int serial8250_get_baud_rate(struct uart_port *port,
> +				      struct ktermios *termios,
> +				      const struct ktermios *old)
>  {
>  	unsigned int tolerance = port->uartclk / 100;
>  	unsigned int min;
> @@ -2589,6 +2589,7 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
>  	 */
>  	return uart_get_baud_rate(port, termios, old, min, max);
>  }
> +EXPORT_SYMBOL_GPL(serial8250_get_baud_rate);

Please put newly exported things into SERIAL_8250 namespace.

-- 
 i.

