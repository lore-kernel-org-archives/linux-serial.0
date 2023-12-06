Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7141112E49
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+DDbMBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0877DC433C8;
	Wed,  6 Dec 2023 08:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701850140;
	bh=dbaCGgIHqNo8yZQRScnnf4gBHa499emj86x/EkqbO/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+DDbMBPoM0fGmXfCIj0JkmfrfPa/SphYYlAmjkW/jxPEzVI5S13EMHbvhHINZMdj
	 zVgvI/lJdxtYTh7FevhIk3e0Z+9rv7OmwinbmzIi0EHq2fJMyHcRZSBX8NaBQfnEs+
	 TBAbaam4eFEAXrtOUzBKHIxAD7RcSo1a39zr4igBm1gqJB2CRyR1teBPl04dZcJyTs
	 era9Iu/qf6H0sRhLAzQ1Wjoqcf6O23/7CA/fpmCuWqgcNKlyOtC4KJLUdOT+wEeVSJ
	 8Cyl/CaA7vKm7Uf1FzHsFb8zUNwCgbBaxZDfBUDmdsl6WoMnb8t4R0XUXAZuuKgVe7
	 rGRTNsvTMDYyQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rAmyY-0006ae-28;
	Wed, 06 Dec 2023 09:09:46 +0100
Date: Wed, 6 Dec 2023 09:09:46 +0100
From: Johan Hovold <johan@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 23/27] tty: serdev: convert to u8 and size_t
Message-ID: <ZXAsSjFzBaBdqJSg@hovoldconsulting.com>
References: <20231206073712.17776-1-jirislaby@kernel.org>
 <20231206073712.17776-24-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206073712.17776-24-jirislaby@kernel.org>

On Wed, Dec 06, 2023 at 08:37:08AM +0100, Jiri Slaby wrote:
> Switch character types to u8 and sizes to size_t. To conform to
> characters/sizes in the rest of the tty layer.
>
> This patch converts struct serdev_device_ops hooks and its
> instantiations.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> ---
  
> diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
> index 5d8e9bfb24d0..baa956494e79 100644
> --- a/drivers/gnss/serial.c
> +++ b/drivers/gnss/serial.c
> @@ -80,8 +80,8 @@ static const struct gnss_operations gnss_serial_gnss_ops = {
>  	.write_raw	= gnss_serial_write_raw,
>  };
>  
> -static int gnss_serial_receive_buf(struct serdev_device *serdev,
> -					const unsigned char *buf, size_t count)
> +static ssize_t gnss_serial_receive_buf(struct serdev_device *serdev,
> +				       const u8 *buf, size_t count)
>  {
>  	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
>  	struct gnss_device *gdev = gserial->gdev;
> diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> index bcb53ccfee4d..6801a8fb2040 100644
> --- a/drivers/gnss/sirf.c
> +++ b/drivers/gnss/sirf.c
> @@ -160,8 +160,8 @@ static const struct gnss_operations sirf_gnss_ops = {
>  	.write_raw	= sirf_write_raw,
>  };
>  
> -static int sirf_receive_buf(struct serdev_device *serdev,
> -				const unsigned char *buf, size_t count)
> +static ssize_t sirf_receive_buf(struct serdev_device *serdev,
> +				const u8 *buf, size_t count)
>  {

The gnss subsystem consistently use tabs-only for indentation of
continuation lines so please don't change the indentation for these
files.

With that fixed:

Acked-by: Johan Hovold <johan@kernel.org>

Johan
