Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0471B87E9
	for <linux-serial@vger.kernel.org>; Fri,  3 Jan 2025 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735897164; cv=none; b=qGxdwfbHiUVDADNzmW3BwcdN4IiM3z6UtKHEvefXrcCaspYIoClwFEERlCaGko43l+F7d7VgrqLmeKAPUPY4SIEzGcmLm8Gg4YBV3AAs7/HQO3AdFsERmyuR+QnaggAIual3mV42qa/c9taUKMst+OcZLs6EygdDCWcJpl8VaeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735897164; c=relaxed/simple;
	bh=7M4EtXDo8jtfmJu7+PmWZd4KRBsUgjbBzCzokKFW3hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngywyphfC2hXeXIVBRJh+KwPWnAv3hiLUUz46QAZT/RcycUdKG0QGEa2pHGbcbA7M9lCwtwadEMAb5gP6MGK5YGArrYGol5JQbD2Xmtw+CEf2atp+w9+KQuaYZ+J96sxxRA8ahEAYMzsOlA2CDTWU2OIO3H8UbNAcS+nk3QEH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RYgmNxl6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RYgmNxl6"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4368a293339so83693015e9.3
        for <linux-serial@vger.kernel.org>; Fri, 03 Jan 2025 01:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735897160; x=1736501960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FfxonrPo3jXLioZLavUyBQmBHKCJNH7Ewu6LEw1lWvQ=;
        b=RYgmNxl6GJTBhCPYjDVpXXBoc4A10jJjBXsT1Y6YZ99di15BLSB2P25kW7HfYZysGb
         y9TwsxWC86Ij95/AQaEVHrhtzw3OHR0XCETIcjnWiyLJbhnOioC6s7uvcOw5V03+eMzx
         r5Q/9tDLP9hmoeMCn3gVVOhlAUaWy9aKP5GYNBABz6OPcSkJ6SC7BY/yU3wy9N10lBQS
         7V7wOS+R2PrHpAx6QPJH4dJhydG29JkL/1xaeDe18UF+SAZDoxz3aB+yc+XN9RytXHmp
         PoBH59dHeNwkPsYCALqa5VLXtlBcKXn30S8aActtBw0KJzbRMIT2V61tovuUuReBE/OC
         4vUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735897160; x=1736501960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfxonrPo3jXLioZLavUyBQmBHKCJNH7Ewu6LEw1lWvQ=;
        b=UCrQjEGEr01UGqbdXEoC7x82DmEe3GofIpcy5WLpeD96DvruTz5rlwnGK70NUCstTm
         o6HTnVSW/OMdzR3mh24itkB4RPJ4+Fxt2VKyXhEw3IE+ZvHd01+B0lB+Zf+viyqxe9Db
         NfbNX306SV/nAYPBJvOdb7pDGM2EU34BeJm5iIZBt5qjK9vXPQrx8PPwkGSzPvUgKwaB
         13722buQg+Ll/s8Wae7yCvFIIqrkwsEEiXEFM1EP54pRl4CQYCW9CeMEPzO2omF7MTUO
         Z/+v9aN/JRheF57aWu/j4Jc1wajIf0cK6vBcpQCqOy2nbRtBFcojGpoX68tkXVRWTv9t
         rAXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBFIE6U9F3vhmsVpunR0GXCxTaCUqA+6dASHXDnaR4NMACIWxiBJzSa2Ggh37LMyycjrO4Zj49iEl57BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6SU39FA2gknJeC4g7I+TpnSydWlbx/hr5sTytdDJodwXeHSEE
	HDuEAmQp3o6dVq4ZlOcE1LlvIWFCgDl2XqKrmA0rO7r03QursV8uioHm1KDQSwc=
X-Gm-Gg: ASbGncvsav0L+NjybODl1wqIbiIS9xCPWBVkksjG+l7UPrSHRvzxPc3+XbZ+0TKo8Lg
	R1jsmVMrMQlJJr9eVr95AxFNY3DngSN9fQPYhgmW6aPIlfByZaZHBI+iH0toyT8my6Qkk8E1rUG
	9XM+0VbrkiNBg6rjur679ylO+sM8AI1DQ47cdfo5Y/PVdvA3bkMEukzj+Jmkt/floScdDAOA6Mr
	JTvIH9R6aGj1O7WafqgKyW8vbl8GWVU8r7fCLIKETYOSGBNEUPf03s6wg==
X-Google-Smtp-Source: AGHT+IHPKlSDdCZdhJI6kS/EAbcodAwjYJG0AXSAIKZV5aRr7XaBj3RqGb6v7PDJHuUwpDTbkR0GkA==
X-Received: by 2002:a5d:5f82:0:b0:385:ee59:4510 with SMTP id ffacd0b85a97d-38a221e17d0mr36604406f8f.9.1735897160512;
        Fri, 03 Jan 2025 01:39:20 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832ec4sm39772826f8f.26.2025.01.03.01.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 01:39:20 -0800 (PST)
Date: Fri, 3 Jan 2025 10:39:17 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PATCH tty-next v4 1/6] serial: 8250: Adjust the timeout for
 FIFO mode
Message-ID: <Z3ewRTKw-jh_bJ73@pathway.suse.cz>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
 <20241227224523.28131-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227224523.28131-2-john.ogness@linutronix.de>

On Fri 2024-12-27 23:51:17, John Ogness wrote:
> After a console has written a record into UART_TX, it uses
> wait_for_xmitr() to wait until the data has been sent out before
> returning. However, wait_for_xmitr() will timeout after 10ms,
> regardless if the data has been transmitted or not.
> 
> For single bytes, this timeout is sufficient even at very slow
> baud rates, such as 1200bps. However, when FIFO mode is used,
> there may be 64 bytes pushed into the FIFO at once. At a baud
> rate of 115200bps, the 10ms timeout is still sufficient. But
> when using lower baud rates (such as 57600bps), the timeout
> is _not_ sufficient. This causes longer lines to be cut off,
> resulting in lost and horribly misformatted output on the
> console.
> 
> When using FIFO mode, take the number of bytes into account to
> determine an appropriate maximum timeout. Increasing the timeout
> does not affect performance since ideally the timeout never
> occurs.
> 
> Fixes: 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Wander Lairson Costa <wander@redhat.com>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
