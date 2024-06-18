Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112D91AB915
	for <linux-serial@vger.kernel.org>; Tue, 18 Jun 2024 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716610; cv=none; b=YLA9nvfD50/drEhdiHffB2/xlgrOj6taGsG26bXGBX1JylMCpGaQ8GkZT8cFI2dyNYHXpjyDQ7A51i+UZlY5fuc8DT1T8c52gtPAXgSLvUeAqQCOCckciAsnzXRE3qg0yxW1nDogkrx4NiJLJHJybWa1EJgD8zuEB8jRInShCRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716610; c=relaxed/simple;
	bh=hOVXynVrJqlICx8Jz8//qfgFh9Lh2Hsor9p0s6PiDn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMjtYVEjA/uDhmM4xjKP9AOpDGFJnobxTbX8RleynV3eWUO4Nb6f+vjwf9pDBM24arOE/Qm3ToDpl4uwMT3wAliVu0lq9rnXcwqy+RqvGlSg8/f/aSwZa79EvhZ5LUiot+cYQOwLhHSQh6so82TKfSr6okoDJa3tvU1d/MkWIqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DVihYnhN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DVihYnhN"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a63359aaaa6so825181066b.2
        for <linux-serial@vger.kernel.org>; Tue, 18 Jun 2024 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718716605; x=1719321405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKQBoLvrOe16gbYraGhce1y8kSCuWU/qDvfQzHcjb1c=;
        b=DVihYnhNJcj08SXYFBZSYueHUvjPRuOTPAFOwMdHMtdGlchhYofZtcAVmm/weEJF/i
         2YMfsRre9jAfWwxfiT5wldnp5clo+SM8gkesTBUe2PE2WQrA6WLq65WmaimAVkvU96vq
         5g6i+/0Qqd0wtvvVq2S/Cj9zN2ezg4yo3oHwhSqi9hQ3LR4C+sbuIbMSEdMO1SOe3AnX
         MtwhOhI/hPeQ2RYgu7PACFwl/socuA+vs4d7HqLaZJ31opFPoS52z71HzIgu0HrYxD1W
         1HuChRHOyXJAn6xzcUIk00mApX8xrtY5CbO1dCs8MQfwuyfdDah3ONR+6upIVIVW/ynI
         ETjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718716605; x=1719321405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKQBoLvrOe16gbYraGhce1y8kSCuWU/qDvfQzHcjb1c=;
        b=k7Kv1pwIva2ixTLtBUmd1nbdu1riEDrmqZjP2roKV3iujehsgKIgDiRQEogFby/QZB
         30OSvZpRrfPysuoM2jLkclzbPYYhr+4XW7xkIA1j0L9gQPaPfLAIfuWH5lKzzcSb/9dy
         i6Dd9CVA9sn5LczK4z03A6SNocxMKHthw1ALd9nmJVRpghYrRaZnpF8XIleqMDvz2kka
         fKPDyH8CATWs+X6L1/yPH+PeDkwpLZSSZBFhimjYCNqYtAE4pCcePuDjvXRriuX1fDFQ
         tMtNvlU4jXIYDayLaVk0aynyZ4OfIDFt4otbPGkdQxNGTQ1MPCViv/VotNzrljsZyUAU
         3zUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWItGu94Kjq3NBMO70hvr8lOmtcTNKnB35Jdx+xdBgTcmtehYBfgSu1BAVEoLhmdOgK8fQCl6YEDUdyufPU5CxTI7QyNEby6fTEVXIv
X-Gm-Message-State: AOJu0YzWBXuK++VTObYNiYhoZN+dBXjC9mJJvOZCkeuR9k8dxcSeVBKz
	y4Jpxsurq+TgD8F4F2/0pAIYF4B7sZe+nqzkbYBi5OP2DOQB9GgzxSHkNHGuwY9rsRllgrEb530
	Z
X-Google-Smtp-Source: AGHT+IGxHFTOx2RcPNTA1EnAUavLZAl4rnZZDEPL2bLu6LEHZGKKXAHjD9sldGiatGLQ1Ll9gQqhBw==
X-Received: by 2002:a17:906:138c:b0:a6f:2e28:4008 with SMTP id a640c23a62f3a-a6f60dc572cmr808317966b.54.1718716605056;
        Tue, 18 Jun 2024 06:16:45 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f4172csm625725266b.175.2024.06.18.06.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:16:44 -0700 (PDT)
Date: Tue, 18 Jun 2024 15:16:43 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] printk: Add
 match_devname_and_update_preferred_console()
Message-ID: <ZnGIu9r6DZLbQMOb@pathway.suse.cz>
References: <20240618045458.14731-1-tony.lindgren@linux.intel.com>
 <20240618045458.14731-3-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618045458.14731-3-tony.lindgren@linux.intel.com>

On Tue 2024-06-18 07:54:49, Tony Lindgren wrote:
> Let's add match_devname_and_update_preferred_console() for driver
> subsystems to call during init when the console is ready, and it's
> character device name is known. For now, we use it only for the serial
> layer to allow console=DEVNAME:0.0 style hardware based addressing for
> consoles.
> 
> The earlier attempt on doing this caused a regression with the kernel
> command line console order as it added calling __add_preferred_console()
> again later on during init. A better approach was suggested by Petr where
> we add the deferred console to the console_cmdline[] and update it later
> on when the console is ready.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Co-developed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>

Looks good and fixes the regression:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
