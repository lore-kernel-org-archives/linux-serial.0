Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041AA48E0E9;
	Mon, 19 Oct 2026 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397756; cv=none; b=CqVeKBkGxknMDiig0A52aLnZq3msO39Ho8cJomBwnvnFHBlMTnCWINm63oEJDVF+q5SQHZ2AasFin5ZyQIUzoWXBgDkTMhv3xuTueJBkYY4kTpKg9AwRps6aKslGnDdt7zX3KCCxn9B70bNBLDozaOWeJRcUHpIzxIFQSK8FvK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397756; c=relaxed/simple;
	bh=zRq2k5Q/AAlKFUMsddXx8wtwpGaPh82P9XBAy+HEjDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmCCsAwnabzKpoWa3t3dw1bqjhNb5gK2X14a8U3huqHNIWPcGnW5XfKSE6L3zIAbxdtEQJPKdrxFXntdJiwH0hTS4a8ItMDWAMTpiKdS3i6EI0nRl2B+3n942dY5vfZmh35udS56wpGPYoh8VnDxCHmF6OMtU3lfAFQsOp33u1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjD5A3WP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjD5A3WP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCC91F000C5;
	Mon, 19 Oct 2026 08:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792397754;
	bh=kWLBljJF+g21y6oGGUekme2PmMbMBIzShNS8HAgf7NQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TjD5A3WP2aVkCdsuXF++BwQYPbJESmbfsRs0S22sEQPsOD7ybcLmYNLKy5DpB/wbU
	 5BTd/PNssljD8ejNVaxcFeBTH5N31+7/IQ/ji9R4jRZYy+xCo2HrxpliA1G2G5uH/R
	 U1JC4i6Ow9n5Gu26W17/wp8lt3smPHn0ZeupT5iQa83v5VD53J+7o8vScJki0DVko0
	 QvL8kOfgjnrOyvCm8izdE+x0kO9cZGWnxvIhwH8NoZ/uJ4HT1qVmADng61DvPdUp8E
	 cVAj70FSHSS/EO6HBHcPOSBkWSrRHRE0v1oaEOoPvg77xRuoxTe1kTfCxmsT4QTi0c
	 nL6a4Jrg0j/UA==
Message-ID: <0ec5fddf-f8de-4c82-a42d-6abca1e06091@kernel.org>
Date: Mon, 19 Oct 2026 10:15:50 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tty: serial: remove hub6 multiport support
To: Arnd Bergmann <arnd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev
References: <20261016130328.1037616-1-arnd@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20261016130328.1037616-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16. 10. 26, 14:59, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> hub6 support was added in linux-0.99 and the hardware was already old at
> the time, being discontinued in 1990. The code for it has always been a
> mess since it adds another dimension to the I/O addressing in the driver
> that has leaked into many individual files.
> 
> Hugo and Uwe have attempted several times this year alone to isolate
> the hub6 handling into the 8250_hub6.c file, but I feel that none of
> this has been a real improvement over the original standalone loadable
> module support.
> 
> Any machine that would have used this ISA card in practice is likely
> 30 to 40 years old, and with i486 support now removed, it is clearly
> safe to just kill this all off. The only bit that has to remain
> is the ioctl interface, to ensure the serial_struct field is always
> zero.
> 
> Link: https://mirrors.nycbug.org/pub/The_Unix_Archive/Unix_Usenet/comp.unix.sysv386/1990-December/007174.html
> Fixes: a300273c458c ("serial: 8250: hub6: Add cleanup code")
> Fixes: c526404a4a92 ("serial: 8250: Fix corner case for port matching")
> Fixes: 7ab80d1e7243 ("serial: 8250: fix compile error with hub6_match_port() when compiled as a module")
> Fixes: da7b5fd4e17f ("serial: 8250_hub6: add missing include for hub6_match_port()")
> Fixes: 3d406299d882 ("serial: 8250_hub6: add hub6_match_port()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/tty/serial/8250/8250.h          | 15 -------
>   drivers/tty/serial/8250/8250_core.c     |  2 -
>   drivers/tty/serial/8250/8250_hub6.c     | 60 -------------------------
>   drivers/tty/serial/8250/8250_platform.c | 11 +----
>   drivers/tty/serial/8250/8250_port.c     | 23 ----------
>   drivers/tty/serial/8250/Kconfig         | 15 ++-----
>   drivers/tty/serial/8250/Makefile        |  1 -
>   drivers/tty/serial/atmel_serial.c       |  2 -
>   drivers/tty/serial/fsl_lpuart.c         |  2 -
>   drivers/tty/serial/imx.c                |  2 -
>   drivers/tty/serial/mpc52xx_uart.c       |  3 +-
>   drivers/tty/serial/sa1100.c             |  2 -
>   drivers/tty/serial/serial_core.c        | 18 +++-----
>   drivers/tty/serial/sunsu.c              |  9 ----
>   drivers/tty/serial/xilinx_uartps.c      |  2 -
>   include/linux/serial_8250.h             |  2 -
>   include/linux/serial_core.h             |  2 -
>   17 files changed, 12 insertions(+), 159 deletions(-)
>   delete mode 100644 drivers/tty/serial/8250/8250_hub6.c

Great, you would have saved me a headache if you had sent these long 
time ago ;).

So I will Ack both, once you repost with the reported issues fixed.

thanks,
-- 
js
suse labs
