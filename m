Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D007332EBB
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256728; cv=none; b=Ubanse8bucfHurZkCY3GH4ubpoEQPRG8uSTCEBh8iRaY4HcX9EALEmD3lisuMXwqczlj7QNgeoC7MKxDj9x/zy+0QfsSAJfDP226898oGTPuJOyPNzcVt/Ny3RnMqBORbkE2qcJqMDjMMAcFnPGf6DjiRZi/ztDZecYKHZQc6Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256728; c=relaxed/simple;
	bh=rtLMAEmz2IzkA1DYaVPmPRU/8Efq7KaYN5SxwL5Z9Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wel+zrZJnvs7AhyXEHZqP+Z8Fh0TZIMUGrNRJB2kcdsJKgiBNRAF/J2XrjH7eXqpaKs2ldjCJrZh+teh0EaXABt6ck1qYMEtJ74Pm+Crz8z+f3MuXZu8a7AaMRsquHIwXDtJMHOqdb5Zl4yRKLo2dDSyS00kRGSL7o++vW8tVE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YXTDVx7l; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YXTDVx7l"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso3990325e9.2
        for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 07:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764256724; x=1764861524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B8l5BzR1mRAYzIMvpm2Ko/o8KqU+gsOnJSeaJXaAzPk=;
        b=YXTDVx7lX0H31A6I+5fApcWVB6YQNPB3gFzYkxH7GBCum7I6GGWM110Ljlfil+Di+A
         bxqFmy3uE6/bnmNLBlkhmhp0LlVjYbZnXDji5PePLnXSVNL5GL6dk/bwNrGNWjyUVwNv
         qFshlIki2XL/AfJfVu/0nFbhZpNzuugdUMeaNhM0XfHzTengNEXkGpFc9Zp8xbQT8O3r
         E0aqf2XqSB46MEKsCMxyda0IBA890uFnEMOBbV5poV7sBytwkNoyFyOWE4fCS9pCkM9L
         w/E+hu8LDJP5pXZK0JIaL2oThBh8NSyWz7H9bpRvgCIEAvCpNgIdFtkkLtQV+X5zgNDn
         zKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764256724; x=1764861524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8l5BzR1mRAYzIMvpm2Ko/o8KqU+gsOnJSeaJXaAzPk=;
        b=aEJQizTiW5xqzt+E20SzjDrfz0zEdhT8u8ZG/Zlt+A9lVJnSx6bAqai4TBch48UJEs
         Pzrr3dqAYJGcjFug/0/iYO8b/M3Z6KbVqmt6V4TjAzBS3Sf/Xa2PcE+zkzRQLZLgXFv7
         XXkfnQ9fwcDf1ZQIdxjEcU3cOjwwywSh0DFKEUbsy/kbJF2w0Uiu5rJvsmNZdmBQHWbH
         rbGjrmwl1cueNRmti5BXPX2t93iHiJj3kMJHHgt0sESll2eCJiFcUXUbahmnmGT0nm+8
         ve20vckJRd3mIvKBzZT5MCiH+BXjOld5z/1sgBx6pLYqhwXMlr2hXVF3Ois2SV6pUneW
         NgSA==
X-Forwarded-Encrypted: i=1; AJvYcCVRfAKVylbCCnumqACOoVmKcAt3VJ9doesQ+Mb4K5qV/ODGw3QhGEvZcU26e4jUS5dS3kPDVMu9+v4y6vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtebI8YEsmnPLNnykTuYG65YCaukk01k1SSP/4a42Qba2u4NJw
	CVk7LTgX1dVtHEL5m+yCihYWEnkSX+WIl+Gvbg77hP31s7Av5YUi2i1XdXWpmD4E4pQ=
X-Gm-Gg: ASbGncuMSxKq1ch15XRfsWy4/fyrFYYCYhB44hSgCz3rxFdRao4eRmjTaFesnl3t5+T
	AVxzLCi/BPq01mQybI95I2dp04TneAXMtRyEyoL/PJICRZMelPU2B4fdUeSDUy2N88sFMeuPUJf
	Qtbl3HTdrJ8/VeUTVJA1ugBk6uySRZWI+gxo2ZCIG5NuhfTp4RWY7CFVIdTrSPWITpN+uZPbQtl
	fmYRFcGYtg+DIuLSrsWhTRwriAjl0nmbOnVW6wm6iYAyG6nQGnuLlYepYfKzde11dx94+QpYyZo
	uGVfNry6V+J6pGK39Ifq7pgCKXl3nh1KmiJjXWgVjOsd+CXI0g8UTKzzbrTyR3AyqOcDTTkf46c
	avfqq5Kxzx2mLDI8aZi6YKgrnwV/3+fH4xKvxHSbcXd3jgHK3f/BGc3Gve4zlmwN1wWUAwQbkNJ
	pVVRdglFO+f5rWcr19xt7bSn9F
X-Google-Smtp-Source: AGHT+IE1ABJky03kTdd0RIp7HhLXOcrkFMBT0s/CBFZhAw1YYwvym+Cxf0cLbK7YSjhHltd5yp0qEw==
X-Received: by 2002:a05:600c:1f94:b0:477:7725:c16a with SMTP id 5b1f17b1804b1-477c0170de8mr221559015e9.10.1764256723867;
        Thu, 27 Nov 2025 07:18:43 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47911143a16sm36586915e9.1.2025.11.27.07.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 07:18:43 -0800 (PST)
Date: Thu, 27 Nov 2025 16:18:40 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 0/4] printk cleanup - part 2
Message-ID: <aShr0DZRmpDnL0nz@pathway.suse.cz>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>

On Fri 2025-11-21 15:50:32, Marcos Paulo de Souza wrote:
> The first part can be found here[1]. The proposed changes do not
> change the functionality of printk, but were suggestions made by
> Petr Mladek. I already have more patches for a part 3 ,but I would like
> to see these ones merged first.
> 
> I did the testing with VMs, checking suspend and resume cycles, and it worked
> as expected.
> 
> Thanks for reviewing!

> Marcos Paulo de Souza (4):
>       drivers: serial: kgdboc: Drop checks for CON_ENABLED and CON_BOOT
>       arch: um: kmsg_dump: Use console_is_usable
>       printk: Use console_is_usable on console_unblank

These three patches were simple, straightforward, and ready for linux
next.

I have comitted them into printk/linux.git, branch rework/nbcon-in-kdb.
I am going to push them for 6.19.

>       printk: Make console_{suspend,resume} handle CON_SUSPENDED

This patch still need some love and v3.

Best Regards,
Petr
