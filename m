Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6B2F5491;
	Fri, 22 Aug 2025 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870344; cv=none; b=bXxsGn4RF40rrNkh3I6solfW8iEzX/kqaT8hxaAHu2ps6c3vm1Pp/dJ8hK0PT4CVJoLa5sZGHQlHYO9zG2MvYVY5DPY/7qsUoUgxfHtY1y860850vHuybh3Ecz0kSE4iyPZpIJYlGHlQA0HUNrEQr03XwYaIz9ZTPZlgisoy5wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870344; c=relaxed/simple;
	bh=HlBthYh+hP49U3XrAXfxw/UemL2h0PKIINNsuGTDpKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcKvb5jmigGHYboXKmZt1D5AKuMcr7i5YcD6t3kNUM6iZ/C3NhWj/Na1UhGqNFRY81IDulct5OhVCS3896dxl6JdSiZJJKA/bvHQ+lJrD2JRmaXK9znrfdfFIdEIoF7iiJ1m1YBE6qHdTQa8L0dbd41tgK9BXJvr283rM2fdI3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SgWcGcEk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SgWcGcEk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A22C4CEED;
	Fri, 22 Aug 2025 13:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755870344;
	bh=HlBthYh+hP49U3XrAXfxw/UemL2h0PKIINNsuGTDpKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgWcGcEkXCOvaRMJfRLqncE7uDSGPhQ6fVD2s7s5fX/m/ghAn8G/HR47g2FEPUcym
	 pcJqo2BBrMZo8Ba+q6qu/XbQJ+rxMX2+Iswewo48TqxPrvcu+NVuVSDMi3JqFhwHtc
	 cPVDtzjXrVOVvdeJ/isAWrRmD2GDoCJOp4OExu94=
Date: Fri, 22 Aug 2025 15:45:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Douglas Anderson <dianders@chromium.org>,
	Zong Jiang <quic_zongjian@quicinc.com>,
	Robert Marko <robert.marko@sartura.hr>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	Kartik Rajput <kkartik@nvidia.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: stm32: allow selecting console when the driver
 is module
Message-ID: <2025082200-roamer-evasive-33ea@gregkh>
References: <20250822133753.54300-1-raphael.gallais-pou@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822133753.54300-1-raphael.gallais-pou@foss.st.com>

On Fri, Aug 22, 2025 at 03:37:53PM +0200, Raphael Gallais-Pou wrote:
> Console can be enabled on the UART compile as module.
> Change dependency to allow console mode when the driver is built as module.
> 
> Fixes: 48a6092fb41fa ("serial: stm32-usart: Add STM32 USART Driver")
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index e661f5951f558..1e27a822c1cba 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1420,7 +1420,7 @@ config SERIAL_STM32
>  
>  config SERIAL_STM32_CONSOLE
>  	bool "Support for console on STM32"
> -	depends on SERIAL_STM32=y
> +	depends on SERIAL_STM32
>  	select SERIAL_CORE_CONSOLE
>  	select SERIAL_EARLYCON
>  
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
