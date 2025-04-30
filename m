Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A29226139A;
	Wed, 30 Apr 2025 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014811; cv=none; b=aqP6kdf2Iu9FUOUsTiZi+zDmAalLQOkdhi9IYwNjkqZVzyFE+o0cAla3s5hJkMtoYA18PQAcRWzSH2YxQF5Ss2tnU1ifHdhT1Q65OrS9JfKbrD5xNW3LigkeD/FY4/sg1Qkq1eeLfF3xWYsnmepIdtduPkyhgRrrFus1uIgERKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014811; c=relaxed/simple;
	bh=RL/8XTQxUPcBIYY01+9ALkEe5daMAevNC3FTDM2eoLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7Kf7zuVxuhAsDKRwS+0fu5T0RFcuriSF1JN5zWPb7A8lpPMLVHhwhYjT04CCZ99l5eydnKj0cmGysBmwYILbEb7cFK5APLBJh/cj53aAiIsuJRYXZrN4Q2geLgIcDwBWduYBMf8l6oylK2mHgGJUm49WYM4zjsK3X/nSSJOp+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WEKM5o9R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WEKM5o9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B8EC4CEE9;
	Wed, 30 Apr 2025 12:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746014811;
	bh=RL/8XTQxUPcBIYY01+9ALkEe5daMAevNC3FTDM2eoLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEKM5o9RqtjECWTJw91jObFoiWD/O7HUBaybfAyTUp1Jy6U8b6ZRrqSGtUfQSLAAH
	 o5l/N9m8MC4/QvRQT26NjRhvrp86l1YMqAUVTkqfWIYa7TnknTjr5W//3rQdfvXdS0
	 mT3ZTk4ZKFyL7OrutPujsZf1iVfymc0Kfkia2SXU=
Date: Wed, 30 Apr 2025 13:40:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Xin Chen <quic_cxin@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	liulzhao@qti.qualcomm.com, quic_chejiang@quicinc.com,
	zaiyongc@qti.qualcomm.com, quic_zijuhu@quicinc.com,
	quic_mohamull@quicinc.com,
	Panicker Harish <quic_pharish@quicinc.com>
Subject: Re: [PATCH v1] tty: serdev: serdev-ttyport: Fix use-after-free in
 ttyport_close() due to uninitialized serport->tty
Message-ID: <2025043022-rumbling-guy-26fb@gregkh>
References: <20250430111617.1151390-1-quic_cxin@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430111617.1151390-1-quic_cxin@quicinc.com>

On Wed, Apr 30, 2025 at 07:16:17PM +0800, Xin Chen wrote:
> When ttyport_open() fails to initialize a tty device, serport->tty is not
> set to NULL, leading to a use-after-free scenario in ttyport_close().
> 
> To fix this, initialize serport->tty to NULL upon failure and check its
> value before reading.
> 
> Call trace1:
> release_tty
> tty_init_dev
> ttyport_open
> serdev_device_open
> qca_setup[hci_uart]
> hci_uart_setup[hci_uart]
> hci_dev_open_sync[bluetooth]
> hci_dev_do_open[bluetooth]
> hci_dev_open[bluetooth]
> hci_sock_bind[bluetooth]
> 
> Call trace2:
> refcount_warn_saturate
> tty_lock
> ttyport_close
> serdev_device_close
> hci_uart_close[hci_uart]
> hci_dev_open_sync[bluetooth]
> hci_dev_do_open[bluetooth]
> hci_dev_open[bluetooth]
> hci_sock_bind[bluetooth]
> 
> Co-developed-by: Panicker Harish <quic_pharish@quicinc.com>
> Signed-off-by: Panicker Harish <quic_pharish@quicinc.com>
> Signed-off-by: Xin Chen <quic_cxin@quicinc.com>
> ---
>  drivers/tty/serdev/serdev-ttyport.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> index 3d7ae7fa5018..287908f2009b 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -88,6 +88,10 @@ static void ttyport_write_flush(struct serdev_controller *ctrl)
>  {
>  	struct serport *serport = serdev_controller_get_drvdata(ctrl);
>  	struct tty_struct *tty = serport->tty;
> +	if (!tty) {
> +		dev_err(&ctrl->dev, "tty is null\n");
> +		return;
> +	}

What prevents tty from going NULL right after you just checked this?

And why print out that message, what can userspace do with it?

> 
>  	tty_driver_flush_buffer(tty);
>  }
> @@ -108,8 +112,10 @@ static int ttyport_open(struct serdev_controller *ctrl)
>  	int ret;
> 
>  	tty = tty_init_dev(serport->tty_drv, serport->tty_idx);
> -	if (IS_ERR(tty))
> +	if (IS_ERR(tty)) {
> +		serport->tty = NULL;
>  		return PTR_ERR(tty);
> +	}
>  	serport->tty = tty;
> 
>  	if (!tty->ops->open || !tty->ops->close) {
> @@ -156,6 +162,11 @@ static void ttyport_close(struct serdev_controller *ctrl)
> 
>  	clear_bit(SERPORT_ACTIVE, &serport->flags);
> 
> +	if (!tty) {
> +		dev_err(&ctrl->dev, "tty is null\n");
> +		return;
> +	}

Again, what prevents it from changing right after you just checked it?

thanks,

greg k-h
