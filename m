Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE3826158B;
	Sat,  5 Sep 2026 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644769; cv=none; b=CbIN+EKAHww/m4eSWsnCiNgA2WHkxd1doJebT5oIcgqd3xV++XpZM4c3c7I2r1t+YhYyC3uw45WVKvC3XR07Xy+1fJGBROMAZ/GWJEIJWMf8GbTF5O2mUZFJbVLzqpkyLG8M0GJlGKICQ1WI/7HpRMGfwBQOIX0SPsfZxzi/zxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644769; c=relaxed/simple;
	bh=9o4ZfbxeIICssdBtPhVE6bfvegYP/h6Eog5sDXhYllc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgtTcSAjXD5JxdOzEOKgDMcPatV1RR55711z1FwLnRkJB6AsIkJwW5vHySeVKOYS9UKR816KHyOLqqv0WCLxbLGkbKVEHnyK1KlUlVHfUpt+GrCVIOLmRO3vsNl6jYHdOIQTwQQzDt9hsuQPyUU7jUHVz+2IIn/Nfbe7MPWgs3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PlkUOZPJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PlkUOZPJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=O0a5hwUgJRJeDlJ04FcTYM31qzCZlO49DRdy2+SwZ0I=; b=PlkUOZPJ9RdI8IgFzKhJIq7M8g
	6s4BRQMnoUF/q56Nka7bbzPxFYH9BbJ7ubAD5gg3h28vvI8TXuBKFC/kob97CjlAElVz3vK+Br9Zj
	6rQKphVSoQysX9Ii1Iu+tmUQgl5nJc0G+P9ro1HwRwor56DZqI6nP4I2+AprhC4ijqJ5plFUTBMoe
	1OWwFU5+AgfjFdYZVUYdTfxXM8Wlld6L8CLpbqROhskpcELf9KspHB4k7bEqY8tMoCzlask7dAI4o
	Sixdo8+Qd08/RBGg2kuY6Szek60cSoaQvadk4OtY0qDLNxo6E/b3U9V6Ev8jHf1SQFNn8cd4lc4k9
	S1oAN57Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2yD7-00000004R7l-2Erh;
	Sat, 05 Sep 2026 21:46:05 +0000
Message-ID: <a3c59ca0-b42a-4b70-9e0c-f26f51209436@infradead.org>
Date: Sat, 5 Sep 2026 14:46:04 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: rs485: Pull uart_get_rs485_mode() from
 serial_core.c
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20260905083648.39026-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260905083648.39026-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/5/26 1:36 AM, Karl Mehltretter wrote:
> serial-rs485.rst asks include/uapi/linux/serial.h for both struct
> serial_rs485 and uart_get_rs485_mode(). The function and its kernel-doc
> comment live in drivers/tty/serial/serial_core.c, so the directive has
> never rendered it and the section shows only the structure.
> 
> Add a second directive for serial_core.c.
> 
> Fixes: 0f4648a1a6d3 ("Documentation: rs485: Mention uart_get_rs485_mode()")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
thanks.

> ---
>  Documentation/driver-api/serial/serial-rs485.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documentation/driver-api/serial/serial-rs485.rst
> index f53043d21071..98d8d83718c6 100644
> --- a/Documentation/driver-api/serial/serial-rs485.rst
> +++ b/Documentation/driver-api/serial/serial-rs485.rst
> @@ -50,7 +50,10 @@ RS485 Serial Communications
>     matching to the current configuration.
>  
>  .. kernel-doc:: include/uapi/linux/serial.h
> -   :identifiers: serial_rs485 uart_get_rs485_mode
> +   :identifiers: serial_rs485
> +
> +.. kernel-doc:: drivers/tty/serial/serial_core.c
> +   :identifiers: uart_get_rs485_mode
>  
>  4. Usage from user-level
>  ========================

-- 
~Randy
