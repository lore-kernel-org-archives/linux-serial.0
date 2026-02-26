Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944C63EDABD
	for <linux-serial@vger.kernel.org>; Thu, 26 Feb 2026 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119016; cv=none; b=WkY/nRqDgDls4Tdqjv3KUWXMaPy/+IuAcPeiConIjixMOepI9xtmtLg8dcvulJo5Qx5GiUPXc1tHS8XPdT7LiR2g3bgxL4SGquIFAnYyMI9gHN0OuPDV1ky0WjtfAfJ5W9ufgE9bkxoEwiBzaXIFbycpIiwT+SgnQjk6b9erhsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119016; c=relaxed/simple;
	bh=31s2WJyuIuyZZS39CvKxsQBTXRhjei2RcsCwi+NC6g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBSwgEmKLNI4bVB5cxlVaARskcJdmg9cf2zUgBDu+4Uq4eyGeZboK9ipOhToaSP0ri2Jq8HS7r8/v28UVijTBA6glJT4CfEvyShX9A76Ayw5p1ty2tZwUFnwTFj963YVrPwJuO/nATdYOQN5llMS/b3GWc0w75Z/7atuq42j+cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj1jzceO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj1jzceO"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48371119eacso11532725e9.2
        for <linux-serial@vger.kernel.org>; Thu, 26 Feb 2026 07:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772119014; x=1772723814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+9nNRTMs9TtVhYWkHqh6WpqdW+Y7K36DSB96fNVI8Q=;
        b=Wj1jzceOQnBcvuq3HBPXc4pkAD6wDfd9ubyXSy38hq6N9eA5GhitBTZYzsWZAO9crD
         eHulHl5nytsvClP3e/tsSjNvl7TBlvBfnPTb90Qz+GoI22hrFLe28Cs0bZCF6dGrZUp7
         Gu+eC3XBZ6nIq+M8JFEH4NZgDbBNLr2oOUSsHBVRGIynpsryI9ClCvtOC0KY/8Gc/Ar3
         ElU/IWIDxTmcO96wtBIJJSeK2paLCFX9rIUsGwrx/X/aud1t8Kwp49P9XxnZu5GRLwV4
         bgoJucC1V8y/HBhzmPcSKkBDzOQCDjO0Cb7veoX1QziCaRIecMIo6kqjphAIAY24iE6H
         TN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772119014; x=1772723814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+9nNRTMs9TtVhYWkHqh6WpqdW+Y7K36DSB96fNVI8Q=;
        b=gJ6o+ECb9IMWM/XGPSOJXbdJ+TX2AbYQLzQF4oCApNHSB1UILt50teomlCc6hsmubM
         5MIKEeJpyZFIT2iu0cYt/p/D+xkJnORf//xel+/BgeNn+8/aXmKmf2kD68EbE2juimnX
         zf2K5zapysJTorfpOmJh/ZA1x23fJIC6dK+rwuvb0EkX+JLeKCtXUykjJGWmaVJ0NmcZ
         E4sdka1lrOhhTYhLPRBJTd8wNNxqFShRBEZDl0W/SPFqNJlX4rDKpx444+GDx0p0tRH7
         Idt5F5JVZn95/QvGbuM8bndN9RdjxfD5/tIzwXwm0ufsLuwVZdMHFTgxAdgyWYgW4iyd
         zQoA==
X-Forwarded-Encrypted: i=1; AJvYcCVgLE2JDItgSFmsPizZe/ZD2pC3K8J4cdIzza0j3dya1/GE71YELgEe0y+raU1JtFyDMEIlH2SYbIXidKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlfCLVl1DfSqQ1T2iyGOE7iVeRmLfskkc0InFEK6TYnRcpMLRo
	rmyxlOmCidHN7CcCnrqo5L3qkXBwxMBWWXQ2myFjCHmGRQuyqISDfkqT
X-Gm-Gg: ATEYQzwc+s2z/xeTcRkpaWBXPvyvTc+bTqhOG1BMNLExT4nNChA1TdIpZbtmR0ho/i2
	42CLQtQTr1SrGjUNNPY/EdnVM0tTo9YSMycqTN3EtQo39d8+PgtvUHe/0EMdSqpSYXKshCJktVW
	M0IFJBmLkjTKq4CnzZ8FjOrZOJhLx4OtRpDPtjWtzib4x9pdJzHwNmWSs3Z63aEDrFCq6zELab3
	1d1j/FZ0X9XuBuGmmjIoOOV+S3WEE1f9nl6LNLj+I9aqFZrcO41jm7WJB9NJ79xmequ8OLTp8IL
	DqxPurQDAMeAA2xE/Ts41uQpJkPNh4XSqtq9G8e3ibbPoa9ps8S/CaKkNO3ul8yfStRmYn8E6ii
	dmRaAxTSsf8tG+NRLhTQ9vobwLLGNTtYfasJMhqaIdJyvMoEMUE3vsFY2Sh2k/HpaYsGTsYbQOx
	4IL9POcjXu+EuUArvL9dHMOIm6zZm9pJpCvgG2KUY9i713S3396u0pEOwd
X-Received: by 2002:a05:600c:638d:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-483c3dd71eamr33988995e9.20.1772119013595;
        Thu, 26 Feb 2026 07:16:53 -0800 (PST)
Received: from osama ([41.232.219.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b84023sm50654235e9.12.2026.02.26.07.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:16:53 -0800 (PST)
Date: Thu, 26 Feb 2026 16:16:49 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: syzbot+80806cf7508e92c7cc86@syzkaller.appspotmail.com
Subject: Re: [PATCH] tty: n_tty: fix KCSAN data-race in n_tty_flush_buffer /
 n_tty_lookahead_flow_ctrl
Message-ID: <aaBj4TvUu_-4qhyI@osama>
References: <20260211210838.45127-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211210838.45127-1-osama.abdelkader@gmail.com>

On Wed, Feb 11, 2026 at 10:08:38PM +0100, Osama Abdelkader wrote:
> n_tty_lookahead_flow_ctrl() accesses ldata->lookahead_count without
> holding termios_rwsem, while reset_buffer_flags() in n_tty_flush_buffer()
> resets it with exclusive termios_rwsem held. This causes a data race
> reported by KCSAN when a PTY is closed while flush_to_ldisc is still
> processing lookahead data.
> 
> Fix by taking termios_rwsem (read) in n_tty_lookahead_flow_ctrl(),
> consistent with __receive_buf() which also modifies lookahead_count
> under the read lock.
> 
> Reported-by: syzbot+80806cf7508e92c7cc86@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=80806cf7508e92c7cc86
> Fixes: 6bb6fa6908eb ("tty: Implement lookahead to process XON/XOFF timely")
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/tty/n_tty.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index e6a0f5b40d0a..725d6ed2b863 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -1480,6 +1480,8 @@ static void n_tty_lookahead_flow_ctrl(struct tty_struct *tty, const u8 *cp,
>  	struct n_tty_data *ldata = tty->disc_data;
>  	u8 flag = TTY_NORMAL;
>  
> +	guard(rwsem_read)(&tty->termios_rwsem);
> +
>  	ldata->lookahead_count += count;
>  
>  	if (!I_IXON(tty))
> -- 
> 2.43.0
> 

ping
