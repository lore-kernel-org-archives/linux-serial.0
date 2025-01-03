Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662CF1FA8E4
	for <linux-serial@vger.kernel.org>; Fri,  3 Jan 2025 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735918209; cv=none; b=oO1X0n5C2rX3i+0a1ORg6kXm9SvkFBq3k7jD+KjkyKFkyiBD10dUx0Ra7iF3/mNlGQZCz+1mB1Ih8ottjmM1W+oU0Wf6VJPDmXFfR9N8kM1ePkNwy4YRVQllZYLlhTv1zbleZZRdEGPfiw5IRHkcauFOSvoINITN31Nh7xtH8MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735918209; c=relaxed/simple;
	bh=Qqcj0OUvhvzwX8pQNRhvvaozpW4SpClzd3s6PmyvN8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2wn8747LPulUE1aSU2n4dxEq3x0WR4ZjtKe6DCN5ReyxQor6SbJk2kCAYcwt/91evUJQdJZIrLOQ3peNAKjjPGLtFQR1BMjeok54h6AyLsdcOzEa7y9QJPrreMwAsr7IcKjUB0VxU2jjhBlUnzuRNtLb8LPBS5kdY6J0046n9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N9jBhNUe; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N9jBhNUe"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4362f61757fso122908755e9.2
        for <linux-serial@vger.kernel.org>; Fri, 03 Jan 2025 07:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735918204; x=1736523004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ice7cYRdFs+QLoHiO93smnTaXPt65ioMoXGDDatRNI4=;
        b=N9jBhNUe0FayS9tfP15EBhAyd0detxGPw5RXJ6pO8dlSfqKAZX2Vg3aZsl/NaVi+qm
         CAdoUA8aGgtFRx0n+QQv6AYHaikdEhElg/6NcmL1O/fIs2yOjEFdAHJGpZuVGQUxL2an
         ion31lFwtz/52CxzqE/rutluI3DEwIUzUGJG0PYg+XgcaXYv3lwwpkRyNQwvz0hMZol0
         KB966DutOkaLuYzg8JrKTSsiTPMY9ytQjdJ3gRu5p1EcHjrjQrFrqpJkuSjh+MPbcHPQ
         x93Nst5au2sMam0ALxF8UQwJWmn1nt3olIDYTJoYwzH/6xJCJVtdAPwxmhOhvP590zOt
         k6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735918204; x=1736523004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ice7cYRdFs+QLoHiO93smnTaXPt65ioMoXGDDatRNI4=;
        b=eTIzD58FeT58F+VsIZR+xBja3Rxu0jj2htHNyZKfKgz6ft6UgBPyFMR4Dd4rWdBhtO
         RRybXFFP2CX682py1nbp+xIUHDCp8fSWPK/yhu+7feA0ZSGrxDC29Fn9edSmNp+M6CW+
         5L8g6bfMs+zpISdSJaTawROI+GwYs+bt1vGGWI0t60m+GfxGV6ZtOra2+8ernQLK+8gX
         LJ0kRRoHZ0YEOphch9PHARy7NFs1TYS2jW1Lr450aW+RP3dUEih5mM2FtoNdJ1omkIom
         8qcbpyIgOh4p/LxAudD5NCsyQCf0/7o/escy0Uo65Yp5v9hjAOel2MCiOas6b7v7XEdo
         pa6g==
X-Forwarded-Encrypted: i=1; AJvYcCWtA9m9okiou8nOCiHENl6MktNvEGhRL3hsoYDaWbuUp/h398dE+Ar9JCt5bdUoJS6JsQPgGYtbAQBnNc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaxgB906kZL+QmqNlxXwBRjHdKgDfVA38Aum/v7C7jVd0pc8XH
	oPdHqpvw4X42IAlscsaKp4s/7vOcMfakoaP562JFiH0q8ALRTkQ1CN+0iPcud5k=
X-Gm-Gg: ASbGncvFjaptI5oObuTqN/2fpemyL+5+xfElvtNvCfMwJymqpYcfO7t/d1GDTlp0lLJ
	H/ehBMsJQxSxCKf9PcLLslnfD7RGt0cO1GMT+fkzJ5fKw231hIzKdk//GrzXfIQeiKRi+NZCRxw
	TweyFP767RYTuIW3nSMBpvEFrnivXcPE90ZxSFE6B/R5ChOsDFiqQTN8eJ8peHTdkdEYUn2I7Bx
	MlxiVVNqRuDpvpYdIYfn7Vj4RVa8amNXSpPMPwbEOIpv39o4F7aOqGfUQ==
X-Google-Smtp-Source: AGHT+IH6JmsUHg85TdAQhpQucHKqxoNFRbNhm5zR5E1P6rwqwaNo/Q6VArzNm4hYKNojN140/QcgDQ==
X-Received: by 2002:a5d:6da1:0:b0:385:e5d8:2bea with SMTP id ffacd0b85a97d-38a221fa065mr40145822f8f.20.1735918204519;
        Fri, 03 Jan 2025 07:30:04 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e1a1sm40462019f8f.69.2025.01.03.07.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:30:03 -0800 (PST)
Date: Fri, 3 Jan 2025 16:30:00 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Sunil V L <sunilvl@ventanamicro.com>,
	Matt Turner <mattst88@gmail.com>, Stefan Wahren <wahrenst@gmx.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH tty-next v4 4/6] serial: 8250: Provide flag for IER
 toggling for RS485
Message-ID: <Z3gCeP_P7VPpcOLA@pathway.suse.cz>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
 <20241227224523.28131-5-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227224523.28131-5-john.ogness@linutronix.de>

On Fri 2024-12-27 23:51:20, John Ogness wrote:
> For RS485 mode, if SER_RS485_RX_DURING_TX is not available, the
> console ->write() callback needs to enable/disable Tx. It does
> this by calling the ->rs485_start_tx() and ->rs485_stop_tx()
> callbacks. However, some of these callbacks also disable/enable
> interrupts and makes power management calls. This causes 2
> problems for console writing:
> 
> 1. A console write can occur in contexts that are illegal for
>    pm_runtime_*(). It is not even necessary for console writing
>    to use pm_runtime_*() because a console already does this in
>    serial8250_console_setup() and serial8250_console_exit().
>
> 2. The console ->write() callback already handles
>    disabling/enabling the interrupts by properly restoring the
>    previous IER value.

I was a bit confused by the description of the 2nd problem.
It is not clear whether it actually is a problem.

My understanding is that the nested IER manipulation does not
harm. And it is not needed at the same time. As a result,
the related pr_runtime_*() calls are not needed either.
So this is 2nd reason why the problematic pr_runtime_*() calls
can be removed in the serial8250_console_write() code path.

> Add an argument @toggle_ier to the ->rs485_start_tx() and
> ->rs485_stop_tx() callbacks to specify if they may disable/enable
> receive interrupts while using pm_runtime_*(). Console writing
> will not allow the toggling.
> 
> For all call sites other than console writing there is no
> functional change.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

It seems that the patch does what is says. I'll try to describe
it using my words to explain how I understand it.

IMHO, the main motivation is to prevent calling pm_runtime_*() in
serial8250_console_write(). It is not safe in some contexts,
especially in NMI. And it is not needed from two reasons:

  1. The console->write() callback is used only by registered consoles.
     And the pm_runtime usage counter is already bumped during
     the console registration by serial8250_console_setup().

  2. The pm_runtime_*() calls are used in the following code path

	+ serial8250_console_write()
	  + up->rs485_start_tx()
	    + serial8250_em485_start_tx()
	      + serial8250_stop_rx()

     This code is not needed because serial8250_console_write()
     always clears IER by __serial8250_clear_IER(up) anyway.

     In fact, the extra IER manipulation in serial8250_em485_start_tx()
     might be seen as a bug. Well, it is a NOP.

All in all, the patch looks good to me.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
