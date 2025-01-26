Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1666325A62A;
	Sun, 26 Jan 2025 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737919893; cv=none; b=Dut0v+zl/OCW4ybo9PIR9PnXdaUARfoUFvaVaFfteDNc12gAzeC7iK2MzAmRofogB6p9U5tanenhNx0N/mgRsV25pcK7eCJxY0K3auaRtFml6B3DanpB9I8oY9i9PnE/W2mQwTcDuY7jQTKv9gC4JYCWppfIK/u7xxDqSn4blIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737919893; c=relaxed/simple;
	bh=1iAO+jzSnVF6/1NK8R2MU0at+dfDAm9CCfGOwjm9DYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/+VCxb6LzrhnM1Jiw1LsrKh8OYBMoDk/1h/g8tKBlKVmq0KU0FS33bQT5NFN/7keJOx33t5Q5SrbdJ+pdvU/Uen9HmcupNET0NZVvpM0LmxlEZJoAOXxZgyWe67gWSfgKHOdrFsIIKIx0uXPFS0GOV3wQXw4IrzF4rWoTJttSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nYDW7LAC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nYDW7LAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014D4C4CED3;
	Sun, 26 Jan 2025 19:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737919892;
	bh=1iAO+jzSnVF6/1NK8R2MU0at+dfDAm9CCfGOwjm9DYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYDW7LAC6eEKFH2HccapPWAcIAuDXD9Ab7iRWypXb9DhAltWIiX6X7s4mCbjgc0H4
	 5ezJHjsMKperNmRsd6ifuk9QILuLDXPHFRakDPBJKs0r8LTiKayP5u++3QFgm/e9to
	 aiw+PzNt7Q16JxX55Kw3yOJRVclPWPV5Vq1Es/io=
Date: Sun, 26 Jan 2025 20:30:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] serial: pic32: Fix build warning when CONFIG_OF is
 disabled
Message-ID: <2025012604-undamaged-earring-d16c@gregkh>
References: <20250126163115.3200308-1-eleanor15x@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250126163115.3200308-1-eleanor15x@gmail.com>

On Mon, Jan 27, 2025 at 12:31:15AM +0800, Yu-Chun Lin wrote:
> As reported by the kernel test robot, the following warning occurs:
> 
> >> drivers/tty/serial/pic32_uart.c:904:34: warning: 'pic32_serial_dt_ids' defined but not used [-Wunused-const-variable=]
>      904 | static const struct of_device_id pic32_serial_dt_ids[] = {
>          |                                  ^~~~~~~~~~~~~~~~~~~
> 
> The 'pic32_serial_dt_ids' array is only used when CONFIG_OF is enabled.
> Wrapping its definition and 'MODULE_DEVICE_TABLE' in '#ifdef CONFIG_OF'
> prevents a compiler warning when OF is disabled.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501260006.ecUsBidz-lkp@intel.com/
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> ---
>  drivers/tty/serial/pic32_uart.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
> index 14d50bd7f1bd..a228a55102c6 100644
> --- a/drivers/tty/serial/pic32_uart.c
> +++ b/drivers/tty/serial/pic32_uart.c
> @@ -948,11 +948,13 @@ static void pic32_uart_remove(struct platform_device *pdev)
>  	pic32_sports[sport->idx] = NULL;
>  }
>  
> +#ifdef CONFIG_OF
>  static const struct of_device_id pic32_serial_dt_ids[] = {
>  	{ .compatible = "microchip,pic32mzda-uart" },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, pic32_serial_dt_ids);
> +#endif

That should not be needed, no other bus requires this, please fix up the
use of the OF macros instead.

thanks,

greg k-h
