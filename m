Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4BA13AC2
	for <linux-serial@vger.kernel.org>; Thu,  7 Dec 2023 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DkeI20qb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23F1C433CA;
	Thu,  7 Dec 2023 06:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701931852;
	bh=eNOoRifw3pcMdqR8mFp57I5wpZw0VHKTdlMIljfmj0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkeI20qblr9RXiQD0vDYYImVqA5tLmmv1cPicG2LYM9Ca33Kr9TC6W0vglahzaOQg
	 y8OEOe02Ofo3FXUwFVXu7h7JkVPrewtQHjATrmoXb1SPIFjSbj3rehM9TgBOo7OduT
	 VQqlLuXFrf6ocPL5ul85/s4MLNktONdMLFMCud1s=
Date: Thu, 7 Dec 2023 10:40:45 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Christina Quast <contact@christina-quast.de>
Cc: linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	johan@kernel.org, daniel.beer@igorinstitute.com
Subject: Re: [PATCH v4] hid-ft260: Add serial driver
Message-ID: <2023120734-ravioli-unclasp-e8df@gregkh>
References: <20231204184542.16835-1-contact@christina-quast.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204184542.16835-1-contact@christina-quast.de>

On Mon, Dec 04, 2023 at 07:45:42PM +0100, Christina Quast wrote:
> Adds the serial driver for FT260 USB HID devices, providing direct and
> simplified access to UART functionality without the need for FT260 HID
> report format knowledge.
> 
> This chip implements an UART and I2C interface, but only the latter was
> previously supported with a kernel driver. For the UART interface, only
> FTDI example code using hidraw from userspace was available.
> 
> This commit adds a serial interface /dev/ttyFTx (FT as in FT260), which
> implements tty serial driver ops, facilitating baudrate configuration,
> data transmission and reception, termios settings.
> 
> Signed-off-by: Daniel Beer <daniel.beer@igorinstitute.com>
> Signed-off-by: Christina Quast <contact@christina-quast.de>
> ---
> 
> V1 -> V2: Adressed review comments, added power saving mode quirk
> V2 -> V3: Added return 0 in ft260_i2c_probe function
> V3 -> V4:
>  - Adressed review comments
>  - Added get_icount
>  - Fixed tty port lifetime bug

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
