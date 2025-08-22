Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8928AB1E
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864700; cv=none; b=uRbzanfWQRwie8hjWpkwPB7Z9U/+H+US81ypvLYGlrH4467Z+Uh1YpKxetcBZRljkQ/YVmVN8OPngaBGPXeuhhBf2Sh1Pn+dGkHXk0SNnBircgBgK8RSJCGBWbhP9/I+uB7s+sat7tzYG1SwabpfY4va1I/auBIZ5nfZQ8acj9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864700; c=relaxed/simple;
	bh=Ddvo9fUrdYmxigcDhHoyWm5kSBOkj+OthkG1en6DMlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRfcYa6XO6FaiOpulFMS5Zi7oo1DEQpL23Xuz3nUZDTGIwINmwIws9RC2NXN7i+cQnwzW5AnBI6s/d27FfGnUER0ZFB2riwBfC8FGs2fLnakMoDCwrMZSXDPI9Z/hnmUL4aObS/0DjRgvfcHqmrxt6a9AL8484OaY5nhnjlm19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WMZpa0qy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WMZpa0qy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8E5C4CEED;
	Fri, 22 Aug 2025 12:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755864699;
	bh=Ddvo9fUrdYmxigcDhHoyWm5kSBOkj+OthkG1en6DMlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMZpa0qyVLDveJLRO+hynBCGtBLib6e+aiD9bOY/buBI9UO/hIx7GIw0Gd7Uz+twn
	 cHu+nonbicR5iowJCTaX2I6p8HoaMSprGHcwr03QZjDn8t3FfVOyEg/gYV2+BOE0lL
	 RKopDyKOpaVo13o5e1wwGTNFYe2IW2QlKy1NzQqs=
Date: Fri, 22 Aug 2025 14:11:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zong Jiang <quic_zongjian@quicinc.com>
Cc: linux-serial@vger.kernel.org, dan.carpenter@linaro.org,
	quic_ztu@quicinc.com, quic_msavaliy@quicinc.com,
	quic_vdadhani@quicinc.com, quic_anupkulk@quicinc.com,
	quic_haixcui@quicinc.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] serial: qcom-geni: Fix off-by-one error in
 ida_alloc_range()
Message-ID: <2025082221-impish-carwash-bb4d@gregkh>
References: <20250822120524.4169865-1-quic_zongjian@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822120524.4169865-1-quic_zongjian@quicinc.com>

On Fri, Aug 22, 2025 at 08:05:24PM +0800, Zong Jiang wrote:
> The ida_alloc_range() function expects an inclusive range, meaning both
> the start and end values are valid allocation targets. Passing nr_ports
> as the upper bound allows allocation of an ID equal to nr_ports, which
> is out of bounds when used as an index into the port array.
> 
> Fix this by subtracting 1 from nr_ports in both calls to ida_alloc_range(),
> ensuring the allocated ID stays within the valid range
> [start, nr_ports - 1].
> 
> This prevents potential out-of-bounds access when the allocated ID is used
> as an index.
> 
> Fixes: 9391ab1ed9b3 ("serial: qcom-geni: Make UART port count configurable via Kconfig")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202508180815.R2nDyajs-lkp@intel.com/
> Signed-off-by: Zong Jiang <quic_zongjian@quicinc.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 9c7b1cea7cfe..0b474d349531 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -271,9 +271,11 @@ static struct qcom_geni_serial_port *get_port_from_line(int line, bool console,
>  		int max_alias_num = of_alias_get_highest_id("serial");
>  
>  		if (line < 0 || line >= nr_ports)
> -			line = ida_alloc_range(&port_ida, max_alias_num + 1, nr_ports, GFP_KERNEL);
> +			line = ida_alloc_range(&port_ida, max_alias_num + 1,
> +					       nr_ports - 1, GFP_KERNEL);
>  		else
> -			line = ida_alloc_range(&port_ida, line, nr_ports, GFP_KERNEL);
> +			line = ida_alloc_range(&port_ida, line,
> +					       nr_ports - 1, GFP_KERNEL);
>  
>  		if (line < 0)
>  			return ERR_PTR(-ENXIO);
> -- 
> 2.34.1
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
