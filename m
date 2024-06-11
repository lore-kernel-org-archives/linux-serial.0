Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F6D179951;
	Tue, 11 Jun 2024 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718104291; cv=none; b=B4zotmvbvc0ABkNcUdn3RlPRGrr3TMzV7fjWqzcNCNPTB6jzGdh3UUI/FShCZgmEAQjUdn2+wDafBbz7epuj/MspobVwm+kN2Qkxqu9PD2j3hStCAwFfP7ZioVoKGPwM7apg3jGl0RN3JrlWCO6u0fuHtDf+cfZ1xIhx8v8bLxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718104291; c=relaxed/simple;
	bh=uO2OPUhv3WVfU6cyAICdpTmjkXISu/zOdlmZNmHERQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjounMuwQAEgEQMceB/4P6fOmN43MS0RvGczYjdeWK//COXInwBwMx9AXNUGW3fk69HZLNWr+HMR/nbPFd3Ex2rPJNejgfhw0//yUc5bi6pXiNBdrRAqd7d9LSEf3MO1TMmZVdU+03UtA5DkonZN4ZB1dBNL1MPnE8TC/qasX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zuR3uEa0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zuR3uEa0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3F3C2BD10;
	Tue, 11 Jun 2024 11:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718104291;
	bh=uO2OPUhv3WVfU6cyAICdpTmjkXISu/zOdlmZNmHERQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zuR3uEa0eLCEW9zND1Sj/k+K50jXDBWLktOLsKhDNqw+Dk97iYoTPEXRIArFnZWEO
	 +Hs8EG4QEJknysWV53Lt9LsUtEBMHXOh2bbu7kST+Xv3CgmLJhEKGYiXGIYgA2AV/G
	 sZeXjXluJDOiqBh+CtZ7qMtoI2YnLDlNwok0lwlE=
Date: Tue, 11 Jun 2024 13:11:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacky Huang <ychuang570808@gmail.com>
Cc: dan.carpenter@linaro.org, jirislaby@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH] tty: serial: ma35d1: Add a NULL check for of_node
Message-ID: <2024061118-sycamore-leggings-05a9@gregkh>
References: <20240611092251.159149-1-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611092251.159149-1-ychuang570808@gmail.com>

On Tue, Jun 11, 2024 at 09:22:51AM +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> The pdev->dev.of_node can be NULL if the "serial" node is absent.
> Add a NULL check to return an error in such cases.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  drivers/tty/serial/ma35d1_serial.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
> index 19f0a305cc43..3b4206e815fe 100644
> --- a/drivers/tty/serial/ma35d1_serial.c
> +++ b/drivers/tty/serial/ma35d1_serial.c
> @@ -688,12 +688,13 @@ static int ma35d1serial_probe(struct platform_device *pdev)
>  	struct uart_ma35d1_port *up;
>  	int ret = 0;
>  
> -	if (pdev->dev.of_node) {
> -		ret = of_alias_get_id(pdev->dev.of_node, "serial");
> -		if (ret < 0) {
> -			dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
> -			return ret;
> -		}
> +	if (!pdev->dev.of_node)
> +		return -ENODEV;
> +
> +	ret = of_alias_get_id(pdev->dev.of_node, "serial");
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
> +		return ret;
>  	}
>  	up = &ma35d1serial_ports[ret];
>  	up->port.line = ret;

What commit id does this fix?

thanks,

greg k-h
