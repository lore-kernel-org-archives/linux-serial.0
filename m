Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16995382;
	Thu, 11 Jan 2024 06:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NGvG5Scy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC21C433F1;
	Thu, 11 Jan 2024 06:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704955961;
	bh=xODAJt+RpoPJsO1LiIGKxZkDf5NGLa+gJ+Rp4TBoiSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NGvG5Scy2oHu4RjRhn1DooJi/oby9fU1wUT8C/miebL+QfF1a7sx6/bdVrPlGHAsB
	 tBhO9Fvb91ySI920IiZ6n2VdGLlROSdvkQZlWzpWSvk9pj8odtmearkVcKkeOS3xSk
	 z6uZy/1xiehw7QgVXhsfcTKktwA5BACgrXA6NcxE=
Date: Thu, 11 Jan 2024 07:52:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Pratt <mcpratt@pm.me>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 RESEND] serial: 8250: Set fifo timeout with
 uart_fifo_timeout()
Message-ID: <2024011125-stiffness-mutilated-75bb@gregkh>
References: <20240111002056.28205-1-mcpratt@pm.me>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111002056.28205-1-mcpratt@pm.me>

On Thu, Jan 11, 2024 at 12:27:07AM +0000, Michael Pratt wrote:
> Commit 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
> reworked functions for basic 8250 and 16550 type serial devices
> in order to enable and use the internal FIFO device for buffering,
> however the default timeout of 10 ms remained, which is proving
> to be insufficient for low baud rates like 9600, causing data overrun.
> 
> Unforunately, that commit was written and accepted just before commit
> 31f6bd7fad3b ("serial: Store character timing information to uart_port")
> which introduced the frame_time member of the uart_port struct
> in order to store the amount of time it takes to send one UART frame
> relative to the baud rate and other serial port configuration,
> and commit f9008285bb69 ("serial: Drop timeout from uart_port")
> which established function uart_fifo_timeout() in order to
> calculate a reasonable timeout to wait for all frames
> in the FIFO device to flush before writing data again
> using the now stored frame_time value and size of the buffer.
> 
> Fix this by using the new function to calculate the timeout
> whenever the buffer is larger than 1 byte (unknown port default).
> 
> Tested on a MIPS device (ar934x) at baud rates 625, 9600, 115200.
> 
> Signed-off-by: Michael Pratt <mcpratt@pm.me>
> ---
> v1 thread: https://lore.kernel.org/linux-serial/20231125063552.517-1-mcpratt@pm.me/

What commit id does this fix?

thanks,

greg k-h
