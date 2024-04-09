Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B1812BEAA
	for <linux-serial@vger.kernel.org>; Tue,  9 Apr 2024 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664023; cv=none; b=RCp+6cx7a2NC5aZLiEgHxRF9dUxJhICrMtKKboXA89GRocY1LCNo54sZbOyHKPWykANcoGltSPWkM37zZHhjlRxYqqcVUD3OvOy4FpVnqjZIcbsxWSZZXVB+RNU7x8f9dURedpsx4ytAcezwySeXQWPcG0w29fn0TU5jhgZtYE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664023; c=relaxed/simple;
	bh=9ioVAtBS6mJHjzjQVsH+ySnnVVovVrs0CN+nbCwKczk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taEzisMcpHoDBc0k06xRL8iidM8xEvTqfPyufVIBWNVO2QWr0AiTWABaAW3OmRd3S5wJ86uDsKLVfbewDmTc1ancM+qnWS67uDtpygMFuUxdd9sxXq5/57SW8ecpvEGp6M3rl0+FQ6IaqNZOECQQX9xZqfFXbklz48Uz6QrqgK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dFAqjXez; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dFAqjXez"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-415515178ceso35816065e9.0
        for <linux-serial@vger.kernel.org>; Tue, 09 Apr 2024 05:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712664019; x=1713268819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hTJa7iV3b9gjm+sfpsG6XF4RYgkUlLa38F2U++9H9m8=;
        b=dFAqjXez/znzIg4htXhpbZeZK3oPS1HDhk8CHgZaZ2hWAWU9YwNiTnxqaTynxweGng
         FOL8J6FTdzBZB2lqzNDMWAFpH3oWPDs6bL9mdlwcvodGAgT/qAmK+Y0yq/IZ23aHPHvN
         Owm2Yq8UUW2eBlqekpAfWq9jhUd/S+7oYboUw69DRDSRROoOJy/M0bi0yxraIoR0Cno+
         ncWinxZOSKur4lL74CqTHmB+gxekJkfMYoVqpJYsiPKMuRIkc4P+sTQv3ubsXOJfC7bl
         X+wMExVh8N5IA/w5VJ93a3iufPY4A4peS5yp4a5P9XopKRwOEMuLnB4Bvr+C+07wE0Ub
         eDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712664019; x=1713268819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTJa7iV3b9gjm+sfpsG6XF4RYgkUlLa38F2U++9H9m8=;
        b=LPxD4BP9bFBkyywS9NV43Q7EXleirp0/4QGDr7pm4rZqMbNUHFQ+oLzeckxfpmfFBI
         lLf0z3g6dCTWGIgqESyVaw6xehMu0VsmHAHfNFEfwDv1Ouh2UeiiW81VRwPzfwKmEhh0
         /H7dNqhjPTqa7giClGChR3fXpM/BT/VIeruXPk5s+DYgzIPdwhVs9uLGQ8GkSK8z/wqQ
         jamf92UIHA6PmrtpSQ1dRnKUebuNwY5OEoJGAvU+3mIqmvLVzR0KPE/Rmy6YpUqiwyz2
         C0BBFahTKVpM8txtbD8eB0c6UPR0cXeOopw50pVSXOZNw9svHaRik+NcEp2CN/lkEfI0
         qZGg==
X-Forwarded-Encrypted: i=1; AJvYcCXwyjFITaFVHgrc3/8yk9/7FKwbBudehnaFbkzRzAIj+5866trACMBXgBrQlOukyKt1NRP8dq1ViJj0MB6nLU6ExW9f87JsHN0CajZA
X-Gm-Message-State: AOJu0YxeR1Xfy6u9CWp7YC4LtBTdKuHipg3OrbBmQgeezeM41vI7OEvE
	6mcWxjUSlNR8jePXrxY9LjmNSbY+d3bAmmSWEhoTbxdsooq5tpFcHQI4YrDBr1M=
X-Google-Smtp-Source: AGHT+IEenJ5fVLWDCUgpbL2lvv7/84Jdct4K06qEzDgMrmjzy9n0KwhGkQ1sssD/6NtntOrANaus4w==
X-Received: by 2002:a05:600c:1395:b0:414:245:f6df with SMTP id u21-20020a05600c139500b004140245f6dfmr9065198wmf.21.1712664019450;
        Tue, 09 Apr 2024 05:00:19 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b00416b92dceaesm434506wmb.11.2024.04.09.05.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 05:00:19 -0700 (PDT)
Date: Tue, 9 Apr 2024 14:00:17 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v4 08/27] serial: core: Provide low-level
 functions to lock port
Message-ID: <ZhUt0ZX5aWZ6G8nf@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-9-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-9-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:10, John Ogness wrote:
> It will be necessary at times for the uart nbcon console
> drivers to acquire the port lock directly (without the
> additional nbcon functionality of the port lock wrappers).
> These are special cases such as the implementation of the
> device_lock()/device_unlock() callbacks or for internal
> port lock wrapper synchronization.
> 
> Provide low-level variants __uart_port_lock_irqsave() and
> __uart_port_unlock_irqrestore() for this purpose.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
