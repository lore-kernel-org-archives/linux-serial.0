Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762EB43AB9
	for <linux-serial@vger.kernel.org>; Thu, 26 Sep 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361725; cv=none; b=iVF58Q5d2wVzgPJsrUPAOlY6lGjKU32hpNyp+XzQovnLeMFvvO72aXl0mh+QXRULfQhQuxKMzVLF71wbYrVvVWxVEA9LefaHGld0u0RQ78UpfhyDBgb6Vmfwd6Op7qijKTtF0m4/Ew6QhHB/OJi6dg2NUfeBgSf4jG2zBQXbmRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361725; c=relaxed/simple;
	bh=OqYonKzGCjILCYu708WLEs5LyRHpToD5zVgFjmPuPas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTZ4RNfGRMOpqx/YImh7t1eYzVijzTAXXdQazxOO14N05GI7F6synMqy80gZDyknTGW5f6Q7IX7q/Q8a5t4nMyDSkVzfyWe4oHoZG82R+oQyvYXC4IwCkulkmN0kQcZbhohOSqExfgJhadfaXtNVXtIVNG/bKODaCdZ6GMQR3Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k+kIFbbv; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k+kIFbbv"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so823484a12.2
        for <linux-serial@vger.kernel.org>; Thu, 26 Sep 2024 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727361724; x=1727966524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UiwypqVWj+Pq6UkHQw4HXTxEHICagaxRhbAeZwlOk/c=;
        b=k+kIFbbvXz8e+CTQ1/J2RH+iCWd9fOn6HsHFDYH1PWBEQ8Pe7F21vIXmg3pslL9Y/6
         KiQvFNKxuPsBcCaEqjYEeGNrRVVZiVeCw4MAc+VL60e6rkbQeUcL09kKAXzxFi1QjxYD
         GSnvhxni5QghMHjraHRhKXMgbWkIF1H0ZM3Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727361724; x=1727966524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiwypqVWj+Pq6UkHQw4HXTxEHICagaxRhbAeZwlOk/c=;
        b=PWXptiJAt/vFrSOOjr5txAcs9DLL4QuDojJXdpoBevcHUb//tvRxgkIJ6M9n0q3Dtk
         eUTkvUejPkA8+WXnIOILWNp8SnmvardHnzfBeT2tU4ctdxVpciP1BT/wxz/CEBoq3Nfq
         Ol6FOixAtZwePz77VNEx3Usp+/WtLb7E2HgRSCtCoIUhhhNU+6hV2mXO5aM1jVfqpCJt
         lUdWIwYcQ6vhA4cTWBTMhXkMraG2u5EiL/JzcEV/Izu+bQUlCx7h2dMTU4JCP832Hrm3
         86PlSFnysu2ruFDGmKVAdJeHn1i4Atv2oF10VLK0tI9FmjHf5+nRpwdct/Fs3YfI7OKY
         FCig==
X-Forwarded-Encrypted: i=1; AJvYcCWj5+M00z381/WU4gKFvEoEt61JSLAlkxX4bDgAp3JdxG0bCFm091KpQApjhgRyuLTB1dVf+OjOp3POelQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOoc2V8x5ZJsCqb6TNc0bYwsrzju7sBhaz038WLVVR+u62NV6B
	7ykCuUwj7fyZYNmH1rx6MUzPkrik6EIw6HsqHxhJm7LZxOaRvdFkZwLyput9ZA==
X-Google-Smtp-Source: AGHT+IGOkWkjDewDgPP7pa8C1wGncvQZ+q4bdTQ0BCyNrsh3kg7mDoObxgomhP/d62myWASh9Wk6XA==
X-Received: by 2002:a05:6a21:4a4c:b0:1c6:ecee:1850 with SMTP id adf61e73a8af0-1d4e0bf0dd9mr9557652637.49.1727361723683;
        Thu, 26 Sep 2024 07:42:03 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:e44e:26cb:ad57:4d74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9c78eesm4383340b3a.210.2024.09.26.07.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:42:03 -0700 (PDT)
Date: Thu, 26 Sep 2024 23:41:59 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	John Ogness <john.ogness@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [next-20240925] possible circular locking: uart vs kmemleak
Message-ID: <20240926144159.GF11458@google.com>
References: <20240926040715.GC11458@google.com>
 <ZvViU8vmNiXhCjKX@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvViU8vmNiXhCjKX@pathway.suse.cz>

On (24/09/26 15:32), Petr Mladek wrote:
> On Thu 2024-09-26 13:07:15, Sergey Senozhatsky wrote:
> > Greetings,
> > 
> > Ran into the following issue today.  It's sort of interesting, not sure
> > what even to do about it.  The
> > 
> > 	uart -> tty -> mm /* kmalloc -> kmemleak */
> > 
> > chain looks problematic, it certainly overlaps with
> > 
> > 	mm -> printk -> uart  /* which can kmalloc and re-enter mm -> kmemleak? */
> 
> I believe that it will get solved by the uart console driver
> conversion to nbcon. I should remove the path:
> 
> 	printk -> uart
> 
> or more precisely, it should remove the path:
> 
> 	console_owner --> &port_lock_key
> 
> The patchset with the uart 8250 console driver conversion is still
> pending a review, see the last version at
> https://lore.kernel.org/r/20240913140538.221708-1-john.ogness@linutronix.de

It does fix the issue for me, you are right.  Thanks for the pointers.
