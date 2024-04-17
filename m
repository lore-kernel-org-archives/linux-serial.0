Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EFA13A258
	for <linux-serial@vger.kernel.org>; Wed, 17 Apr 2024 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713348488; cv=none; b=OXHQsgrip/RWOie5Qlh+dGP8o9tYP9QthC284zM08ddLVaw+j8cjRZRDHBZq57LDfh5aybG8pbuCsFuZZMJGRQvk2Lj7XGr6jqUbXcngHGZHTnaR3CCJc9CiI9099xHWd4aQ0k5h9eoOFvAYRGNVcT5og/5I207LZihyHWV282I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713348488; c=relaxed/simple;
	bh=brHN2J0g6h2FWOT2DJL+bvz0WjZxEx35HK2donLvmSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIG1O63dFm/nD/rdsZh+xmuBh7lEHC67eNYC4KGKZg1sbXCI7d9j5PJBJAyBDajDsUxZayEx3udvkxYT+8kdGCi1OY8FGaEbWrrwc+2FbAG01uYEABVY/KryPeI1gtaLXCo4zH4K3nsv12j5rj1R430fAHbqxAiP1YTlgFD/Ddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ItTOHdYw; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ItTOHdYw"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516d6e23253so6015096e87.1
        for <linux-serial@vger.kernel.org>; Wed, 17 Apr 2024 03:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713348483; x=1713953283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rew6iLA0plRdxtIqeoXYtK2CEUSuSYY+qCYCtmDSd1o=;
        b=ItTOHdYw7KVGBu8JyoCVRk0nOG06+jf6GFwUIIGCb7UH/R0LL60+/7JIl0DhDJQKwp
         55xAPWFsd3wkhkmVfZO8hego//PLU1+xgNdJpwz24aIXE5onwqWTAs4Xu3uWM8XuWIVO
         GNHrb02VxO8ThtdtRjb6O+qsMNPncqpsBrqkONzAsU1DvCBuVhKLNoEOARd1KiUJ5GSd
         ks2U0E+payxQnWi9hEsa+mC7Z/NXgobU8vTr+4amZG2UztuN5MhAwWmgu9wjPdj2ZYkI
         /STMyejLuJuu1bNLYaZuCRmZFKe2zqTeOo/hIeMZlAV2ZFTiGZbShOe7YfnGkncy/Wp1
         wwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713348483; x=1713953283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rew6iLA0plRdxtIqeoXYtK2CEUSuSYY+qCYCtmDSd1o=;
        b=DuR8JJCQyJWAXTgO9rUqB491QBRgXzSYUkZsv2cdHraOkIYC9wmwuYrc23mlT8u18q
         AYtzxOoH6UXhESCpwvTFf5wCXJLZxYCtYrjv5ltfRIeLahRSFrmJ1910o0LYyq73S4ss
         qrEGf07cwAJTe7oCeknxEeAL0Ca1CbjU59K8b7lwCi9MLXq5bZDn6MIYOfTO2LAAKDWc
         I732WaabtrAbfO4jC8Fa1H45BJ3xS5UMS4VV+AHdfaicPNGc+bkg11Xe8ayNsmgHYt6z
         HPfvV4J/d9QCV07J4kUCmBbk006xxQJkcWeSjDjpikAQrWcsavND6WXemWQW8iFDUGm2
         LJ9g==
X-Forwarded-Encrypted: i=1; AJvYcCUGwiTuCCwzg7OLsDT792LLCviFAU6m/UQi5VG8vUB7NDO1fZObpEUfc8S7jr+XFKILh2OsD4ijAMUjKxMF0HoiYtK5gBKHCAt5VLX4
X-Gm-Message-State: AOJu0Yzud9jowLSJgWcwsQtEqKhMnpxgobyMhRTe76OfL3XSdEt2s7Wk
	+ToXvMxRoIvT2uuBn7KyS3hVdwKRTqB2L2Vd+dqvJ/STBRwResgmcCT33x2P9mM=
X-Google-Smtp-Source: AGHT+IHpU2FckcUTS4T6HUYuJqnYbBgP+xCaAEopvwDiMHdA/fetkEHgQoPYTTOMp3Se2U1GhQcWFA==
X-Received: by 2002:a19:ca03:0:b0:519:5c34:9652 with SMTP id a3-20020a19ca03000000b005195c349652mr10971lfg.31.1713348483318;
        Wed, 17 Apr 2024 03:08:03 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id i25-20020a0565123e1900b00518dfedc3ddsm1012464lfv.12.2024.04.17.03.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 03:08:02 -0700 (PDT)
Date: Wed, 17 Apr 2024 12:08:02 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, gregkh@linuxfoundation.org,
	linux-amlogic@lists.infradead.org,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 12/15] tty: serial: switch from circ_buf to kfifo
Message-ID: <Zh-fgtujwjiSXz7D@monster>
References: <20240405060826.2521-1-jirislaby@kernel.org>
 <20240405060826.2521-13-jirislaby@kernel.org>
 <CGME20240415125847eucas1p2bc180c35f40f9c490c713679871af9ae@eucas1p2.samsung.com>
 <91ac609b-0fae-4856-a2a6-636908d7ad3c@samsung.com>
 <d70049d5-d0fe-465f-a558-45b6785f6014@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d70049d5-d0fe-465f-a558-45b6785f6014@kernel.org>

On 2024-04-15 15:28, Jiri Slaby wrote:
> On 15. 04. 24, 14:58, Marek Szyprowski wrote:
> > Dear All,
> > 
> > On 05.04.2024 08:08, Jiri Slaby (SUSE) wrote:
> > > Switch from struct circ_buf to proper kfifo. kfifo provides much better
> > > API, esp. when wrap-around of the buffer needs to be taken into account.
> > > Look at pl011_dma_tx_refill() or cpm_uart_tx_pump() changes for example.
> > > 
> > > Kfifo API can also fill in scatter-gather DMA structures, so it easier
> > > for that use case too. Look at lpuart_dma_tx() for example. Note that
> > > not all drivers can be converted to that (like atmel_serial), they
> > > handle DMA specially.
> > > 
> > > Note that usb-serial uses kfifo for TX for ages.
> > > 
> > > omap needed a bit more care as it needs to put a char into FIFO to start
> > > the DMA transfer when OMAP_DMA_TX_KICK is set. In that case, we have to
> > > do kfifo_dma_out_prepare twice: once to find out the tx_size (to find
> > > out if it is worths to do DMA at all -- size >= 4), the second time for
> > > the actual transfer.
> > > 
> > > All traces of circ_buf are removed from serial_core.h (and its struct
> > > uart_state).
> > > 
> > > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > > ...
> > 
> > This patch landed in linux-next as commit 1788cf6a91d9 ("tty: serial:
> > switch from circ_buf to kfifo"). Unfortunately it breaks UART operation
> > on thr Amlogic Meson based boards (drivers/tty/serial/meson_uart.c
> > driver) and Qualcomm RB5 board (drivers/tty/serial/qcom_geni_serial.c).
> > Once the init process is started, a complete garbage is printed to the
> > serial console. Here is an example how it looks:
> 
> Oh my!
> 
> Both drivers move the tail using both kfifo and uart_xmit_advance()
> interfaces. Bah. Does it help to remove that uart_xmit_advance() for both of
> them? (TX stats will be broken.)
> 
> Users of uart_port_tx() are not affected.
> 
> This is my fault when merging uart_xmit_advance() with this series.
> 

I'm trying to run on two dragonboard devices db410c and db845c and both
fails to boot see the boot failure from db845c [1], linux-next tag: next-20240415.
I tried to apply the patch [2] (that you proposed in this thread) ontop of next-20240415. However, that didn't
help bootlog on db845c [3].

Cheers,
Anders
[1] https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2f7sLxYtIQXQzsnTzE1Dye2xweg/logs?format=html
[2] https://lore.kernel.org/lkml/20240416054825.6211-1-jirislaby@kernel.org/raw
[3] https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/anders/tests/2fDgvWnyEmFm9mqMCxOaruBOfTe/logs?format=html
