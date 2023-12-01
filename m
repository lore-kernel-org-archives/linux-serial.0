Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB9156E8
	for <linux-serial@vger.kernel.org>; Fri,  1 Dec 2023 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pXTKYoA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A530C433C7;
	Fri,  1 Dec 2023 08:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701419228;
	bh=YLcaKyVFQMf+8rGisK1Ar3iSw1+WcLkQobe+dx+4qNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pXTKYoA9sZB6VcNCyEogwDajMNi77AV9hCyku+YfJ7yJM1ss3SnP2QnxqIx6UreZb
	 9LH4npGMheRCgB4aoYyFF4ddPK9nfyMGGMBU9nZcIpe7Ps2PoBms6bW2hVRj2svOoK
	 1Hw3BAT7dUIuRw/1kvseO9TR5CZZGQjALwcbxKZI=
Date: Fri, 1 Dec 2023 08:27:05 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [RESEND PATCH] tty: serial: 8250: Fix MOXA RS422/RS485 PCIe
 boards not work by default
Message-ID: <2023120146-pyramid-salsa-d8cd@gregkh>
References: <20231201074055.259207-1-crescentcy.hsieh@moxa.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201074055.259207-1-crescentcy.hsieh@moxa.com>

On Fri, Dec 01, 2023 at 03:40:55PM +0800, Crescent CY Hsieh wrote:
> MOXA PCIe RS422/RS485 boards will not function by default because of the
> initial default serial interface of all MOXA PCIe boards is set to
> RS232.
> 
> This patch fixes the problem above by setting the initial default serial
> interface to RS422 for those MOXA RS422/RS485 PCIe boards.
> 
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 58 +++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)

Why is this a RESEND?  What happened to the first attempt, did I miss it
somewhere?

thanks,

greg k-h
