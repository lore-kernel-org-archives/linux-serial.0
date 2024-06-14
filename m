Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A81487E9;
	Fri, 14 Jun 2024 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718356053; cv=none; b=Zj0uqZ+vq1otNQ1wQcNQoo2qomHqGgsJ+DLTWVEtpJVJp1ke42ocyaAMr1dsq3uIQ9P6JJ1g3usHph311jy8WutZc1x6LZxQokHK9kwcYPyp2Tyb4WRMJwUrLGMH+SFM/xwe/NMwh4G2/U9RG8FAJ/cB/R5FcXytucyy3RzSdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718356053; c=relaxed/simple;
	bh=YzndSkdmYyM1m4OnS6tSHoY/XZcUglagXcQvICViWYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDtIbQLkPi+i9YMJzddNCilGlAIn6i6PTPu6MSfK9jjfB5FqJ5eiioaL51zsLgZHoI18VC8O1PgEqGXLdRBm/KuAXJ/CVcTM8AqGN6zZ4ZFnnb/70QV4LqpirvfW5PapYqJTSOwVw/MpvnpzaWzyvacNSznh+NrN3Q6+xAn3nOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EijsRRR3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EijsRRR3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3A9C32786;
	Fri, 14 Jun 2024 09:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718356052;
	bh=YzndSkdmYyM1m4OnS6tSHoY/XZcUglagXcQvICViWYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EijsRRR3G0TXmpDeNS2FYgGYt/aKTBB3SxmvWFz5ws+djrSzomZqXeAMri2G+ftCg
	 S9uswQ1nIIJsLER8DLLucQITw5+SkVnSXvapO3+Mx/OKVj15/Ev5xQMHXVnNX2uk5S
	 9za9m3b3RunIl2UzkourNWQZlEMkpxaR3olwW/k8=
Date: Fri, 14 Jun 2024 11:07:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250: Fixes: Fix port count mismatch with
 the device
Message-ID: <2024061406-simmering-sanded-17ef@gregkh>
References: <20240614090322.2303-1-crescentcy.hsieh@moxa.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614090322.2303-1-crescentcy.hsieh@moxa.com>

On Fri, Jun 14, 2024 at 05:03:22PM +0800, Crescent Hsieh wrote:
> Normally, the number of ports is indicated by the third digit of the
> device ID on Moxa PCI serial boards. For example, `0x1121` indicates a
> device with 2 ports.
> 
> However, `CP116E_A_A` and `CP116E_A_B` are exceptions; they have 8
> ports, but the third digit of the device ID is `6`.
> 
> This patch introduces a function to retrieve the number of ports on Moxa
> PCI serial boards, addressing the issue described above.
> 
> Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

What commit id does this fix?

thanks,

greg k-h
