Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA8468C3A;
	Thu, 30 Jul 2026 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428433; cv=none; b=ZsMz7ywImwm+pW5ii6KGc1RqMjs/HwoFDOyCT12Uz92O0IrP+WQmptP9KKdEymTj7n5rTbZYQX/UdDIiNPHKB1i6JjMy0POsUTRwdsy+L+WYGXseKg8O731MN+j300V2kFZ4U73Kpbj9Tbu6q1vKz/5oBdwp4nCUUvR9VsbOsmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428433; c=relaxed/simple;
	bh=UllcFxHjL5JUj7P0PKdmlQDx/aw5+TfTF31NO3heFhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqNPyaJOy4SM1sZR3LOUItJ1Ali4fln1uaIkN1t6YNW7CVWtk8QUR1P9feP82OP/9HnaXjEcmcxcW3i7FlkP8UF0yyMW1SpoubY3QDml5UcKbREwTB5f+J2YIxxHY9IfnH8Ua3MNniSv7p9Eg0pNoJH/0/Uov1nALpeC9KQf9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cGQRDIc2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cGQRDIc2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579B21F000E9;
	Thu, 30 Jul 2026 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428432;
	bh=HiCmLZEykQtwo+3aaoochyv6FuW4RAqsOt+hc8VVdd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cGQRDIc2qjLO6l18IrBzXzAzVtWxUeaeOp9uiRxH7q40otPsFXytqPkNW1fLhuRG4
	 hcMUjxXDJ7Yg8ZSnmRTI2TGTzVUT9itOTEmz/jXMDSdt98Y7WWyS/Oz5yCnxKGX7LS
	 VeTn70b0iPfIOCTghuaZbLTqwGg1etI+xr54kBwg=
Date: Thu, 30 Jul 2026 16:54:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Jacques Nilo <jnilo@free.fr>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Gerhard Engleder <eg@keba.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 0/2] serial: 8250: Add AN7581 UART support
Message-ID: <2026073035-bubble-pentagram-3dfe@gregkh>
References: <20260724183007.188172-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724183007.188172-1-ansuelsmth@gmail.com>

On Fri, Jul 24, 2026 at 08:30:04PM +0200, Christian Marangi wrote:
> This is a new version of [1] to support UART driver for
> Airoha SoC.
> 
> One additional function was needed serial8250_get_baud_rate()
> for the driver to work correctly for baud rate calculation.
> 
> While at it also try to clarify a long standing issue with
> new UART driver when adding new ids for uart_config[].
> 
> [1] https://lore.kernel.org/all/20250209210241.2622309-1-benjamin.larsson@genexis.eu/

For your next version, please address the review comments found here:
	https://sashiko.dev/#/patchset/20260724183007.188172-1-ansuelsmth@gmail.com

thanks,

greg k-h
