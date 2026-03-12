Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFC6345752
	for <linux-serial@vger.kernel.org>; Thu, 12 Mar 2026 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323153; cv=none; b=W/xjc2fRBj+DotgXcQRpTXBLhvqojBP5DU0aJyeVGp00aaLLnx9VJvSxbJlU8QRAAQrL54Zxe0SITm+chBgw0XgfO8nWL4HYRwZl4cfLS3hBHd2cr/g2kiJiy1fb4LmWCGhsWk3sUOam4dLDHTJfLoRxDYJXxRT54Ng3dCZ++NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323153; c=relaxed/simple;
	bh=T80KNNSV0km5WN2ooC4W3mCrtmJiZZqijD5j8dkhdAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+IbDaYAUJP47PdJjU/QCW0aOvxXlr0tOGRO6weadq+ned3OX/ZAHxiZaMWkgDZwHtjUCWbOsrsmvHsN66hagI8PFRxZuIxy9ncSkjLkk7lMCpNtLPuDeZw1h9csVCINhTJMUn4gKv8LBSdf5966hmzKB1K5aA0XHSdY462oE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eSO7C17Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eSO7C17Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BC7C4CEF7;
	Thu, 12 Mar 2026 13:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773323152;
	bh=T80KNNSV0km5WN2ooC4W3mCrtmJiZZqijD5j8dkhdAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSO7C17Qi6Ic+1XO4k3X3C4s25h7w3l8zK6mz9mgTWGbT1/CGv3d2ttBNYlbG/Y5c
	 jtMvLwg90ZN2yOt9iga0QdfPb1FvhC2duGvWXuXp5FdSUWL6+2qdb4Yn+BzKE/f1n8
	 6loEBP32nvHRqCTKLsit/lhFMJfLEAEZwTRE+rZA=
Date: Thu, 12 Mar 2026 14:45:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: LiuQingtao <qtliu@mail.ustc.edu.cn>
Cc: jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, neil.armstrong@linaro.org,
	bjorn.andersson@oss.qualcomm.com, marex@nabladev.com, dev@kael-k.io,
	mani@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
	liu.wenhong35@zte.com.cn, liu.qingtao2@zte.com.cn,
	hu.yuye@zte.com.cn, dai.hualiang@zte.com.cn,
	deng.weixian@zte.com.cn, jia.yunxiang@zte.com.cn,
	bai.lu5@zte.com.cn, yang.susheng@zte.com.cn, shen.lin1@zte.com.cn,
	tan.hu@zte.com.cn, zuo.jiang@zte.com.cn
Subject: Re: [PATCH v1 2/2] LRW UART: serial: add driver for the LRW UART
Message-ID: <2026031201-dense-unrefined-7bf5@gregkh>
References: <20260213093334.9217-1-qtliu@mail.ustc.edu.cn>
 <20260213093334.9217-3-qtliu@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213093334.9217-3-qtliu@mail.ustc.edu.cn>

On Fri, Feb 13, 2026 at 05:33:34PM +0800, LiuQingtao wrote:
> From: Wenhong Liu <liu.wenhong35@zte.com.cn>
> 
> This commit introduces a serial driver for the LRW UART controller
> 
> Key features implemented:
> - Support for FIFO mode (16-byte depth)
> - Baud rate configuration
> - Standard asynchronous communication formats:
>   * Data bits: 5, 6, 7, 8, 9 bits
>   * Parity: odd, even, fixed, none
>   * Stop bits: 1 or 2 bits
> - Hardware flow control (RTS/CTS)
> - Multiple interrupt reporting mechanisms
> 
> Signed-off-by: Wenhong Liu <liu.wenhong35@zte.com.cn>
> Signed-off-by: Qingtao Liu <liu.qingtao2@zte.com.cn>
> ---
>  MAINTAINERS                      |    3 +
>  drivers/tty/serial/Kconfig       |   33 +
>  drivers/tty/serial/Makefile      |    1 +
>  drivers/tty/serial/lrw_uart.c    | 2822 ++++++++++++++++++++++++++++++

This really is a totally new uart?  No relation to any existing devices
at all?  Why would that be created?

Anyway, this doesn't seem to build properly, how was it tested?

> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -231,6 +231,9 @@
>  /* Sunplus UART */
>  #define PORT_SUNPLUS	123
>  
> +/* LRW UART */
> +#define PORT_LRW	124

Why is this id needed?

thanks,

greg k-h
