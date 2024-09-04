Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B861D0495
	for <linux-serial@vger.kernel.org>; Wed,  4 Sep 2024 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460256; cv=none; b=qhq7J+46F2XiIA33ZbwO3hOvKosZppuhaLiW/K7Y6OzJBBTc8kQ5A0DmDEgUp8RzYc7X/M0iCHq6KeTGoSvACAuc9uuR6yKYMbilI9QNKf/Joehp3n4EujjRIDXuPehna3FP0xJa7GBJ1Z+dcVUK3ajpLKZ0SBvJc5H03yXJVmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460256; c=relaxed/simple;
	bh=+ZXu6meYUp2emnk1pUEFpHVRsMcDsWR9d9edP3JL+tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Urup4BhGTXe7aL8s9LdD7+Ukex8toHQdzJq1qaLG17urXXZyAqyjxo0pIgvPW11R8YoW4WksaXZWgkVJKEVXGmrBlWzzA5CY4sw+nfZUVIuwtYgdPEz8h/TVW/wHLd6TA+j/EisfRMpUdZy6hy8S9EvufYgj74v8MFIaxNBUgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EK6m47HZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EK6m47HZ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a1acb51a7so307581666b.2
        for <linux-serial@vger.kernel.org>; Wed, 04 Sep 2024 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725460252; x=1726065052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4mj+3ddf2T3OL11MVG0wgLWW55Rk8MJvA3KeiKNlFbs=;
        b=EK6m47HZAyHgIrhryObg0UtFiQrm6tdnwPgHZ5pMSgAmtRt3Pt7IBgyJ5zD31UMF6T
         7qLWVlQ1PUobHBeqlhByfSoZ1ps4Zzhve0rsDaOTcJKq8wuodsLqUUfb9jDJwbO7KxDO
         MkiV78wAQHf5p0+oqa00nbHa1N+zmmXBBRdCjTQ34f7J+2TAeiHi36RnJ82VbhOKBXLa
         8kNJC5wssnJFt+ZgRIbyAX0GFyRlmimAMnuKjGeOeMGzmua+cm5VlSt8NmDkWXu7oCeY
         gleAH4VphEPkctfggHZVn3FRuxK4yHtOiUMcJw/2cBZG41sfK2TVUAYuo/5Z1z1Ii1Bb
         kc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725460252; x=1726065052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mj+3ddf2T3OL11MVG0wgLWW55Rk8MJvA3KeiKNlFbs=;
        b=Ycc6jLD7wtg3dNUgSQ0vtuPMQS1/skJBYW9hGet65KV7iTZBU/HiNy6qCDoeMZmmdh
         CU5Fbgxqhp40blIxv9Xyp7v3t2dw2iBQePkrEQX/WzmPTy3yLsU5Yd/n12KIOxt7wAi2
         5bvKnG4Q8YWe02gK6Kfg/46ZjfG5V+PJPI12tZ4VcWPRELoI8uUNnFIGAZ5KF6UGdf4P
         x7SXpEdwoe4oDehmCGCOd3BcHxoDlkxUtzhAgAKPLdNdi5v8oSazG1fAwZbN1ZRzumPI
         6ALXrROUjiMVIrLCZ5Ts1kjvXI6GBH2U2X/vmJ5pQGjGpa/LINQm9ycU2fmEsGHqH8Fn
         +zlw==
X-Forwarded-Encrypted: i=1; AJvYcCVBuGszWY5E3fJtsNb1FhxOT89THtAwL767+YQPxu9lP3Z8LE7tnmVBYGThn7omaDO3SQpXS66FWQLnxH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPS5K6/ySKqIncATW6tlZBrHiSI5x/QfStnX2uISY2IrZ4y9pX
	RVSxXmAACTOEPUfmgSmw4JgScHAZFLeVToUC0axf1u3vzW3/rcoWpbMjnwefz64=
X-Google-Smtp-Source: AGHT+IFMOIxyP6G+sV9SFwQbLa7RzZxnlSRsBYqqYkhtUdWNAPfVNmkYr+B0Ioi6gh+avo5V5Q6aYQ==
X-Received: by 2002:a17:907:7206:b0:a89:9a9d:4e13 with SMTP id a640c23a62f3a-a8a1d56efbdmr693848266b.56.1725460251935;
        Wed, 04 Sep 2024 07:30:51 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891a3ceasm810608566b.115.2024.09.04.07.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:30:51 -0700 (PDT)
Date: Wed, 4 Sep 2024 16:30:50 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v6 00/17] add threaded printing + the rest
Message-ID: <ZthvGoJE26dOtsLm@pathway.suse.cz>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904120536.115780-1-john.ogness@linutronix.de>

On Wed 2024-09-04 14:11:19, John Ogness wrote:
> Hi,
> 
> This is v6 of a series to implement threaded console printing
> as well as some other minor pieces (such as proc and sysfs
> recognition of nbcon consoles). v5 is here [0].
> 
> For information about the motivation of the nbcon consoles,
> please read the cover letter of the original v1 [1].
> 
> This series provides the remaining pieces of the printk
> rework. All other components are either already mainline or are
> currently in linux-next. In particular this series does:
> 
> - Implement dedicated printing threads per nbcon console.
> 
> - Implement forced threading of legacy consoles for PREEMPT_RT.
> 
> - Implement nbcon support for proc and sysfs console-related
>   files.
> 
> - Provide a new helper function nbcon_reacquire_nobuf() to
>   allow nbcon console drivers to reacquire ownership.
> 
> Note that this series does *not* provide an nbcon console
> driver. That will come in a follow-up series.

JFYI, the patchset has been committed into printk/linux.git,
branch rework/threaded-printk.

I am not completely sure if we add this early enough for 6.12.
On one hand, the patchset should not change the handling of legacy
consoles and it does not add any nbcon console. But it touches
many code paths where we decide how to flush the consoles
and could imagine doing "ugly" mistakes there.

OK, let's see how it works in linux-next in the following days.
There is still time to catch problems and make the decision.

Best Regards,
Petr
