Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336C44195A3;
	Wed, 23 Sep 2026 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166168; cv=none; b=LCyizs/LonWHMEx9RHrQDqKFBTy5w51ZDZiCN2bvheoGts7BUaW5ltYjAf8uziMKajxBIeOR+Hcn9rGSLHQvu1ZeIbLLW9LdefQYjMbT/7J7WShGSP1+F584fw1JM8BOSsbzpcK3t500p1TvAo3z71T0BuARq9Jy4R1BsR/LlIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166168; c=relaxed/simple;
	bh=Ynz8n82cKb8qNOjYgtw5wea9AeNPweqav6JbeUeKc74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUN0i0I5IYw9WGoRb+uT8YCb+Se6GkEuGCP9i9kozX/QSlDO68FRZ90ST+Il3RLgubstlP3FfZRVEprUPYhQ/NpJgTgZn6xBszy7wO9Gh9ZVLfYyRyBr22WMb1ZYA49Bxk/JgOLI00sdDuv/bgokg+72DqYn00dE/ajjRttDjNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y5I705bN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y5I705bN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0457F1F000FF;
	Wed, 23 Sep 2026 12:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790166166;
	bh=S53TA+TJV/I4n6krgJsgFimWrl/5skEuuayyK3dEQ4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=y5I705bNGJh6fklcWyRnmqveoHsSDKSD3/YFFkoe4LQ+zHD9oQAlJjKFCMNE7Aevn
	 WId6MCTEk7bb5LlJnLRCXMHHjLwYJtzQC5IsiieZ089NC/ZQ1dWwc33UFF4yJsf+qK
	 0XHm7Won+htUNFKRb/DuusPjCezTQwqy+lPLlmug=
Date: Wed, 23 Sep 2026 14:22:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Add Armada 38x earlycon support
Message-ID: <2026092326-python-dugout-7b05@gregkh>
References: <20260902221709.340393-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902221709.340393-1-rosenp@gmail.com>

On Wed, Sep 02, 2026 at 03:17:09PM -0700, Rosen Penev wrote:
> Register the Armada 38x UART compatible with the built-in 8250
> earlycon implementation so stdout-path can enable an early console
> without adding a generic ns16550a compatible to the device tree.
> 
> Keeping the vendor-specific compatible avoids exposing the UART to the
> generic OF 8250 runtime driver while preserving the DesignWare driver
> Armada-specific runtime handling.
> 
> Assisted-by: Codex:GPT-5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_early.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> index 44ec209f37c4..265d49850e15 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -175,6 +175,7 @@ EARLYCON_DECLARE(uart8250, early_serial8250_setup);
>  EARLYCON_DECLARE(uart, early_serial8250_setup);
>  OF_EARLYCON_DECLARE(ns16550, "ns16550", early_serial8250_setup);
>  OF_EARLYCON_DECLARE(ns16550a, "ns16550a", early_serial8250_setup);
> +OF_EARLYCON_DECLARE(uart, "marvell,armada-38x-uart", early_serial8250_setup);
>  OF_EARLYCON_DECLARE(uart, "nvidia,tegra20-uart", early_serial8250_setup);
>  OF_EARLYCON_DECLARE(uart, "snps,dw-apb-uart", early_serial8250_setup);
>  
> -- 
> 2.55.0
> 

How was this tested?

thanks,

greg k-h
