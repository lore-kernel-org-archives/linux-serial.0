Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980AF2EEE63;
	Thu,  1 Oct 2026 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844124; cv=none; b=CZwCztOazrizaKiBTOcnLAEQkNXgEJ5IYQxRT/I9tCzY7taeF5G2/H/Fjs89TPXoqSbo3DMOjLZ+VTYMZ2bfMADM6nJ2C+pegmhv5WSP5pf284bcm51O6zcgIIgkL/LmwuB+/YXFsVwB+U9HwjgfDl7MtOPWah0blpGzrDpiJ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844124; c=relaxed/simple;
	bh=hUFRT69a6OTBWB3/YM4aqQSHzThOzG39MKESDBK1x/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ne1HfyacBG+gYBDZAR/qKY/I9/Ov89IMxEylJcaAxMp6QPx6opmrbZZ+y94mhIVP2Ujw6V4Ma5HpYBefwo6Kl/IVWrBG72pFQGSKos+X9FHr3FoDnTUyXrO9lkQA7eJkCnrlzF0N0ghSCn/VGJCnAD2zjB+d5GaQFSM8viME//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G+0lvHbL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G+0lvHbL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A3F1F00898;
	Thu,  1 Oct 2026 08:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790844122;
	bh=sLIWiigL5qWkQhHyN5vS0UWUMaLMgvl0mWkBnAFMRsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G+0lvHbLcFxKT0ugHqD6AlK9Gls4ZhylEh9mf7J/TlAmiElBtW+AFkgOt39e8KCWe
	 a4AcA4Iw2D/dF/uGlkq51D41Rc291FEYxM7nAzSNgtccCnzc9YGeyeDSsKzvNODz31
	 DPmOqeetYahY1mfms1B5rkDyGZTa7fPL+qRsIkrI=
Date: Thu, 1 Oct 2026 10:41:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, jirislaby@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH] serial: ma35d1: unmap MMIO on remove
Message-ID: <2026100146-salvaging-scouts-1f4d@gregkh>
References: <20260924110400.1556396-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924110400.1556396-1-lgs201920130244@gmail.com>

On Thu, Sep 24, 2026 at 07:04:00PM +0800, Guangshuo Li wrote:
> ma35d1serial_probe() maps up->port.membase with ioremap(), but
> ma35d1serial_remove() does not perform the matching iounmap(). The probe
> error path already releases this mapping after disabling the clock.
> 
> Add iounmap() to the remove path after clk_disable_unprepare() to match
> the resource cleanup order used by ma35d1serial_probe().
> 
> Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/tty/serial/ma35d1_serial.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
> index 920fe7ff5083..e5eaaf154911 100644
> --- a/drivers/tty/serial/ma35d1_serial.c
> +++ b/drivers/tty/serial/ma35d1_serial.c
> @@ -770,6 +770,7 @@ static void ma35d1serial_remove(struct platform_device *dev)
>  
>  	uart_remove_one_port(&ma35d1serial_reg, port);
>  	clk_disable_unprepare(up->clk);
> +	iounmap(up->port.membase);
>  }
>  
>  static int ma35d1serial_suspend(struct platform_device *dev, pm_message_t state)
> 
> base-commit: f03c39de3a1307371a4032757cd1732e91087c7d
> -- 
> 2.43.0
> 

Did you forget an Assisted-by: tag?

thanks,

greg k-h
