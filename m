Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDBB21D5B0
	for <linux-serial@vger.kernel.org>; Thu,  9 Jan 2025 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439198; cv=none; b=EpJEuXiG6VynzQmwPyR/XsnHTr2aSoCLYkdSttoyHRxpKi3LncmjySdV7jmRk70vhoSyTMASj2hIsaivFYgqOHIZq0qEBBiX7SmIkCZbDOHjXHueKlKl4KkQyCSg8zaihStmIsZ8BNA/3ynCy8XWMc6BPP6TCPqvbHaX9KmEPrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439198; c=relaxed/simple;
	bh=hrHoS4vPlPfy16tkj356Uv+3+REsoEqobKAqrk9g0ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESaGbtUhN87UyNUkt6Z6JcN/rgi+hJhAlC7QyE65QaolsfHk2QFqCkptVfbmpGTeN+SB28AI5yv500rLSlKcD7uiDUCY2vqbm2ddVyMzFQCX4U31BmlSMBx7v9bfAU/CsZ9zFpHfCSO74FzBJoRR384Se9DbYzfkQwSoUlxIAQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QY7h4boy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QY7h4boy"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so629658f8f.2
        for <linux-serial@vger.kernel.org>; Thu, 09 Jan 2025 08:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736439193; x=1737043993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kai5ZgxDf+EShyzs7bDwWO83K4Oce/nwpcJg76eHGM4=;
        b=QY7h4boyJd/WdMU9zEM4zRsf+0I4wrNFPJ4g6z57OwQAXQ/APKVwPZ3O21hCL76asa
         OKaEu6tslHqcnlVAjwIZVtgsjaCq0jaeahT4hmEWjORLjGOsTVH3ZZ5me0wTLKb3vrVm
         orD5tsDQ/PKQ+aSdPz6CfL2Cr9wFrQEDfqK3ZebbWjnuBbcioJRPgYh54O6JXPjCF++8
         hgMlGMiQPkeL9fAiPNzEYmTjwTNA5t1Ob6tEldZroGAuy1Kt/RCkZIiHtqNriC8SgH8s
         ExHAHV7f5BN94rmPLmRSO+QZuE9whJ4T4i371VjmmP8wDss+WBrtjZw7m2bMun+V2ZHg
         w1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736439193; x=1737043993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kai5ZgxDf+EShyzs7bDwWO83K4Oce/nwpcJg76eHGM4=;
        b=swTR8nbhIuP+ncE/yOLn1qIpuwsB+/VbHws4HQwuZ6Lbi2+YflUFkDVThmJYlbDa5D
         /FkpnS5DpajZxoJKYL4YtdTlKh0WRN+eZPo9833RM3/J6QDz3Cn3W2Hxr4MHC88Lk/fJ
         RBADXRp97AwAQyOxCwYocOUXertE4bmaS2XqMpNt8+MJf45+4ue5PiPc9ZYxYFHGV/AT
         PUF9KM5sju6dyFLo/ZB8wXV2J8m4DPohfcBGDVzND0fEkLnY03DA9qaTrOJRJQ7RzE3U
         POqtnQHA8odw3fIUdFGLbAtZcO2ljsInL1y9EtAoNRpOMBUGShinOLYP8FIS0PiPnJjz
         JoEA==
X-Forwarded-Encrypted: i=1; AJvYcCUSLUBxwU076xRqTHZt/A3v70ypGqSrhyuT9F1yCeuJ3wlIJ3sRYYEDrX2FWODm5MEFuaKbOTr+E+zQo9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgYzF+GHed9eeKxTlBLqQqW2HXJl9tIECw78aMGJ274z5uSu/p
	4tdkaQ8Ux8Pbi3e+bPlEWp73X/Zot6xAgyLVzInAYcW8OemtFPm8JuF2+h5OM4ha3sCrDy4YkKF
	c
X-Gm-Gg: ASbGnculsj51Wuzpak23b0gFE9SlbxRtv6UcnQ18AkFtOU+NjnCyNFziIw99BzxBZhL
	UHvmMr2vMUodeV37aTwFsv5FY0dQoBd6mb22GTaSAC7pu091Z7SnPi+5jf8v7L/zcLFthVbaJtw
	BP6Ivcnn/28uwp2mpd+3ZU+InNMcXBiIpj/YKBo/YFw5iint5kovCATGCIGP0uODFAMj7gIgdSe
	+JIHvPVGBOxNOGxA/QnUkFBtjLkuU4AjIFywj3+fD3bVQL3eKckYS+mfA==
X-Google-Smtp-Source: AGHT+IEKi5W9KtWRj/RV+N8EK/6UrsGmYGe36NimQHrosYmeKEq1AxHaQOTx8OfeKcJcyKsFoedR1g==
X-Received: by 2002:a05:6000:1847:b0:385:f060:b7fc with SMTP id ffacd0b85a97d-38a8730a60cmr6395814f8f.25.1736439193253;
        Thu, 09 Jan 2025 08:13:13 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e89fc3sm60501045e9.30.2025.01.09.08.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 08:13:12 -0800 (PST)
Date: Thu, 9 Jan 2025 17:13:10 +0100
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
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH tty-next v5 5/6] serial: 8250: Switch to nbcon console
Message-ID: <Z3_1fZQ3BG4aggHx@pathway.suse.cz>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
 <20250107212702.169493-6-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107212702.169493-6-john.ogness@linutronix.de>

On Tue 2025-01-07 22:33:01, John Ogness wrote:
> Implement the necessary callbacks to switch the 8250 console driver
> to perform as an nbcon console.
> 
> Add implementations for the nbcon console callbacks:
> 
>   ->write_atomic()
>   ->write_thread()
>   ->device_lock()
>   ->device_unlock()
> 
> and add CON_NBCON to the initial @flags.
> 
> All register access in the callbacks are within unsafe sections.
> The ->write_atomic() and ->write_thread() callbacks allow safe
> handover/takeover per byte and add a preceding newline if they
> take over from another context mid-line.
> 
> For the ->write_atomic() callback, a new irq_work is used to defer
> modem control since it may be called from a context that does not
> allow waking up tasks.
> 
> Note: A new __serial8250_clear_IER() is introduced for direct
> clearing of UART_IER. This will allow to restore the lockdep
> check to serial8250_clear_IER() in a follow-up commit.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

It looks good and seems to work fine:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
