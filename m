Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008A4334685
	for <linux-serial@vger.kernel.org>; Fri,  6 Mar 2026 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772783527; cv=none; b=EsTrO+nwCaEtcdydPbCMJ88gOvNRN4S2Z90eFh/B8t9hjNSLP06pmsMSpb6lZeEZpxwaVOXw9t6wZQ/je2MsCGH6vhxfzVyvNx13r4w4lzFnUkH5zo9/EycYG61fby17CP3FJaUzthYjeq3Vgm4FKnnke/jAgIqKOTlhP48S3Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772783527; c=relaxed/simple;
	bh=1DSf/40QIi0281oAVrfAMFHgyT4F0i/JEwAu+RloXTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jq4yrqkK0CjOcuQIAZJiHfi75mdiFE7pxtCkLdcaoAJntVsMk8e6mUuv2eW5JmaD0MdEJDg4oAqpTw4i1rcvE868HvoDy5xohJjeL8dQTo/s3MA0cQuu4uAT8cn+8vNCw0+SEA+W778MM3AZYtGbMCXhXl4bRwavLxwFq5PJyQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/v9F3ot; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/v9F3ot"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4837584120eso68135265e9.1
        for <linux-serial@vger.kernel.org>; Thu, 05 Mar 2026 23:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772783524; x=1773388324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IeT+0mSKswHLx4Rvh/oZxQm5lIPM5axHkAAQqdyqiJM=;
        b=B/v9F3otvopqFfiKWeT5uRYv9nIeT72iv8i+l+r1uR74sXhg80+1Ske5fL51tpNpN7
         j/SXjn21bgBHsxqslJG4QDx3GU7wmTeNv1ZjqufkN1JLj6JJPqkwH36Si7KvsDueMQni
         lNV6dtM9Z01QimxSE8U36WVT4oooelB58OkrPigvtnc6WF4bNJrARrBLr4poMMmWhP/4
         1Oa9miIUut2isL6Lpb8lPXDC5DKyKK6eoUg48yFq7XGxkqxsLZemr8CtI66AlwdGJyoA
         lnNg9FnlkPyHHATYFczyZRSYLGLvCAxbnOJos+jmnzu/Z8MxAiaOvzPHDU4x7P775KPZ
         CjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772783524; x=1773388324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeT+0mSKswHLx4Rvh/oZxQm5lIPM5axHkAAQqdyqiJM=;
        b=AIazxbv4MlnNnAy9KbmgZSfLgzavoZvY/1rVEvPDFryE45FoSiHW/exjvKdyQs9tpj
         0NBwF2fGLQkZW3tI2bnv7ZvBK2sai1zpQxV9IHkscywTxC0aiNG8hdUj3HwUiSFsVsJt
         TFhW4auKsD/sUFH0kPl2TxO+5eGXkmyT4xj4d0RybHpvHHG1bzSBvJwZKzrkQkdtJZH2
         D42yWl8FWqp6jWmhlRtJHy06eDZPG1NRBePzcO62Nb7fR9Rdz9bIxG7lTt4RHPbMV8BB
         Kw13ldF9/LwoHGNquIyYSPBlcJ+4bBv0F+RBfXo7LmnOZr/jW7sdQvHlc9x9es2k8rcC
         t23Q==
X-Forwarded-Encrypted: i=1; AJvYcCXn4hgxg/oPFNDK0dvzjON0vHtjG6FX0Re+OF0vUP3G6EXNvOiEqI7BsoMfdYZezPth00f0066fxLHj6oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Wqq3GvRJjhRp139Mux0vrkv71PycLgYP/8d1ZX7yjvPKxxu1
	l8GjTtC6HSkI8Cn5ZoHmEg/Q08F8luoOk2cC76piwB9MfQwwr/0+I11u
X-Gm-Gg: ATEYQzxYE1zfaguxL3hLoVCjzjNfs/7vfzCCcDR85jzO8UCxkBK/llTaq4O+27mpCF9
	bRj5AOuLjWLGYlipb2WtgLhnrS66tv9s2q8DN6bBrsVAY7jJF8ZFhBuMhUPz7RzL8muFaYnWjWW
	/1gUCnsTyQfRWBlE6p5Kf8IEfdOEHYZkhLVhHeosQpFtWPhqzqOUHFrzATgzYOCpoqZbHIGB0DX
	j+DQVLPf7vAfygoh4WHmYDLJzVhLoLzkoa5AkKQ4uskZADVKu98Krrnh8R66pEcdPy6nOKTzsmT
	espVdMl3dah+avpdwH+4A6B+XoWB11/vLzJm5vwLAFUO6aNJUlUKByNcJ8c6/l2ySmbDV7/kTdq
	Kh9OfDrRSum2kexEChNg74KXILakICTc1Q9kt4mCHlCMzqA6KJSCRe23zSuXnLy9qK+0UWDk7as
	uLlQFTIFJzqW/nA0aoVmXiFO1K7Pdna74haYtX7VPfeN6H5i0zydwVCnRqDw==
X-Received: by 2002:a05:600c:3488:b0:47a:81b7:9a20 with SMTP id 5b1f17b1804b1-48526923bc7mr16119525e9.9.1772783524062;
        Thu, 05 Mar 2026 23:52:04 -0800 (PST)
Received: from osama ([2c0f:fc89:104:8900:7a1a:21b3:e0a6:ba62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485246ed174sm17072405e9.5.2026.03.05.23.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 23:52:03 -0800 (PST)
Date: Fri, 6 Mar 2026 08:51:59 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: syzbot+80806cf7508e92c7cc86@syzkaller.appspotmail.com
Subject: Re: [PATCH] tty: n_tty: fix KCSAN data-race in n_tty_flush_buffer /
 n_tty_lookahead_flow_ctrl
Message-ID: <aaqHn4t5IXY3d31x@osama>
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

Hi All,

Can you please review?
Thanks for your time in advance.

BR,
Osama
