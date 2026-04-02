Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CE6364955;
	Thu,  2 Apr 2026 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775154962; cv=none; b=YCH5y1Cvvf5YDlHsUs5tom5v2bVrNJRDBSsEUZhSxFtrqc2hSXZxD6ym1EYzrvL/KwxewCry5JEMhIo4ueccbahWWYji6GEQKExx+S7XZal5ghC87KNYZvj/9lMVZw/lWbPVPccYhBABHZoENUHhd+xlgc0deUsnV8QLu8MP998=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775154962; c=relaxed/simple;
	bh=I+n94382FNgRTWTXHMs6r1Ue4L3neXILjMVmbKi93Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQU5B8BcMvIQ5RIgjwE+ahK/55gC9ai15i/x2FFGWmmRq359xAnrpJVYJp0ABYMvxdtP+kPDecUolg1NT7zKI4veHuUPb7BB4puDdinWyVJIUALgGZdoVdQO6/3gqOmTw8/Nj1Wp/pXtIGyvtbNz79AwRdNCofaShHR8wFhHjPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4YIYXBQc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4YIYXBQc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7ErBNvHoBSB49JsOKSzcxhXQzafeJACcEXEBXM0zjFI=; b=4YIYXBQcUnk3g+WcZm3UrhfdZy
	H3Cyu2cjIpEoFd7vkTXiaeqXOS+ebIiMSHMVLKyZtjGV7HHGAV9cAFbCqzm9LStEUQqyLMtTB7gSh
	pVfKalwesGZO8R6nBGZJMofHBYT23uFWgb2UZtckMB1IHC6bXmiR9AVo6dTtaAE/YYJU+9pw0qMk3
	S1ocbtZreAYpQwQ5Xrugyfz6Tqmb31CQOb9gREYQxmcRBEm9IAho8ELO+7VKtz49lq/s3bf/wBs7l
	JGJh8UclW2JwBLBCdAA+pSbTjlKtFA1iELXtJW4Os+I9vZENQ0oUbtxidarmS4QJJl97imkAM4nJD
	W7CF0Kyw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8MtX-00000000fak-2Dy7;
	Thu, 02 Apr 2026 18:35:55 +0000
Message-ID: <3a14a5ea-7798-4124-a671-f9984e40ebd3@infradead.org>
Date: Thu, 2 Apr 2026 11:35:54 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: ip22zilog: Fix section mispatch warning
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
References: <20260402102154.136620-1-tbogendoerfer@suse.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260402102154.136620-1-tbogendoerfer@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



s/mispatch/mismatch/ in $Subject.

On 4/2/26 3:21 AM, Thomas Bogendoerfer wrote:
> ip22zilog_prepare() is now called by driver probe routine, so it
> shouldn't be in the __init section any longer.
> 
> Fixes: 3fc36ae6abd2 ("tty: serial: ip22zilog: Use platform device for probing")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604020945.c9jAvCPs-lkp@intel.com/
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  drivers/tty/serial/ip22zilog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/ip22zilog.c b/drivers/tty/serial/ip22zilog.c
> index 6e19c6713849..a12101dc0554 100644
> --- a/drivers/tty/serial/ip22zilog.c
> +++ b/drivers/tty/serial/ip22zilog.c
> @@ -1025,7 +1025,7 @@ static struct uart_driver ip22zilog_reg = {
>  #endif
>  };
>  
> -static void __init ip22zilog_prepare(struct uart_ip22zilog_port *up)
> +static void ip22zilog_prepare(struct uart_ip22zilog_port *up)
>  {
>  	unsigned char sysrq_on = IS_ENABLED(CONFIG_SERIAL_IP22_ZILOG_CONSOLE);
>  	int brg;

-- 
~Randy
