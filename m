Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F6A1714DF
	for <linux-serial@vger.kernel.org>; Thu,  7 Nov 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993260; cv=none; b=rUtO/MsGZ43KQMm/tkLqthB9GEW6aj9JXobSXp+dDQYSptx5o6A1uGR27UCb9Y5AV0cPD2mMXhZMWQF6mid5ZMLoOYaRldrL4Bc4OWSEq4pnFw3DksuB1+wFh2w+KsberQAixGselynlLMTRSgEBb1bCXc6z56Bax5CM88wfYI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993260; c=relaxed/simple;
	bh=yeEs8ewcT1y5GOWSZzmD4QBXT7Wjzlhjh9Jhri8akIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaYfTQhJtTjugo24mQ0qk8ddZrHxz9fJRJfgGOsu/8CDQvUESctVqsjOl/4ADQmBz6tLVMiT7jnrn+IYWP998/aJvpBGi9plNR1tpqXmvRN9dXqNOBn+vZF8viCW1PwArIxzK9SFhO+vfs9RnaMq6qpZYzpMEwCA0COnUVR/xik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BIMFfSZJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BIMFfSZJ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315eac969aso6768425e9.1
        for <linux-serial@vger.kernel.org>; Thu, 07 Nov 2024 07:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730993257; x=1731598057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRf6zRXQpzxdtNWRFDWwDeLUqj/9Qnay3bDxbM8rYgE=;
        b=BIMFfSZJSjc3Gg1cSeYQv48X1zqtmJpCF3R395C4PLDqDkeSHwyjcNB7Gv2qI1ZcfI
         jugajtMZxumCDzRsz2W/PcJE8uw5eVAPhVK98WWaB2MEx+UZe8K25o+E7y17Yw40YI2m
         tnJZUHZjCGaFiBOmBB+f7puCtOIGAduKa1mVg4nutuTPpb+FSkSE8jZa9Ew5p5LX8Pcw
         w/d3mv+cCAeUubC/rH6dyENtJMGgOMXa+so91TbtB3HXhiyf4Uo3wf3PagpAr413JAmf
         R4PkvnI5L7xKQvT9bIqYmI1MMnTGk1jbCNcZly820ewXJSgvYlrCi6pM4dmkbd6CbuzT
         QLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730993257; x=1731598057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRf6zRXQpzxdtNWRFDWwDeLUqj/9Qnay3bDxbM8rYgE=;
        b=m78sE9uRy3/Ptb1SgAQAiAgDcUbySz0/a5WPFMd41lBazs5AeEFC0D/rXYHtyfKSED
         MRD9Cr3iwFW5jFw9Z3hE7iH+IWH5K+nahfoTJ0oYbJpCt7vEIhITWi2NqvrSbzGYu9l5
         bY5qdIvqBMmlecEPk/3l6g4KMhdw3tgdiQJTgJ8uM+CL5r3dETIYMAt3HNteQKlgEGfJ
         LHpTdQWYWSJQtruzefvjCPhgnIO79Sf6pNAENov0F0rJZZZDO4Mpm28zOYOYoWNucAfd
         fx6eruQ94MCYCkIp0rW51QyD7BOYd47aJo9gwFecgrJgnwowieDpRMbj85gdy+3ed0SW
         RFIA==
X-Forwarded-Encrypted: i=1; AJvYcCW9lB8VUbzMbGyxytiA5XkdA2Nauc7Qqv7arT36zH3j7K+VLvBtKklNpqLMJnTCag8tWqJ8eoI2aXqLrhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6pf1xLYRU6XZpY34eNEbdJkvd1f/HpqIBhT+kp6rEb3ShfSLU
	2r80Bgv0cWSHrC55vWDrffxXX6Btpr+ReYb2fZc0PVjQHhLqayvMt3+VWVLopmg=
X-Google-Smtp-Source: AGHT+IG+kN+CsW6tgOY32VUnqA+N8WhRRJS/ykFS7g26dVcf3olFI7/ILrD9W+sOKvYmLQRqPPGUEw==
X-Received: by 2002:a05:600c:1c85:b0:42c:b603:422 with SMTP id 5b1f17b1804b1-432b5f9be4cmr3793255e9.8.1730993257414;
        Thu, 07 Nov 2024 07:27:37 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054b34csm28978925e9.14.2024.11.07.07.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 07:27:36 -0800 (PST)
Date: Thu, 7 Nov 2024 16:27:34 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tty: sysrq: Use printk_force_console context on
 __handle_sysrq
Message-ID: <ZyzcZvQQJ0YHWTk5@pathway.suse.cz>
References: <20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com>
 <20241105-printk-loud-con-v2-2-bd3ecdf7b0e4@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105-printk-loud-con-v2-2-bd3ecdf7b0e4@suse.com>

On Tue 2024-11-05 16:45:09, Marcos Paulo de Souza wrote:
> By using the printk_force_console the loglevel workaround can be removed.
> The workaround existed to always send the sysrq header message to all
> consoles not matter what was the current loglevel, but it won't work for
> deferred messages, since the loglevel can be restore before the message
> is printed, suppressing the message that wasn't supposed to be
> suppressed by the workaround.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
