Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7431C21D595
	for <linux-serial@vger.kernel.org>; Tue, 11 Mar 2025 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689485; cv=none; b=aAwBwbotrVswxKPUgD8L3CgH1Qm5o0VjQ1wwbTquD7XOKM9++u8/TLEXGpp8MPd8B2rHNs5jF5jvzMabw85mgTYEL/0bSl075aRj0HwTNNpbHCqae9r7CFHgOmIrGfIdqPVpketI35/7rBPEZiIuVTkZke7d/cvOXPP3mGk6oYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689485; c=relaxed/simple;
	bh=EbXZ3DQ9+b6N6Hl4SN9qCQLNiQGag830oTI8EnFB6Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saJnQ5ETBPLaym82enp0QqXzFwtwnyuwwAX2HAUzAKA0NFcL5gr8n4QLE8SNcJO8hTJNPwBZQ1vNMjTxuAth8Rd3qowC9CetuloFawrYEzJkGl9sNkvAUoYxRjkUyYUEfln6+uHUAnquQL/21FFGYWMXa2kd/r7hOWKBs+FFgz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hGLkOhv5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hGLkOhv5"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so2933263f8f.2
        for <linux-serial@vger.kernel.org>; Tue, 11 Mar 2025 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741689481; x=1742294281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SyAWrxEwUsWnM7LVGAbr1T8GXaCm2RFT3dQ++j9eSpM=;
        b=hGLkOhv5IYqDFE5iLkNuWygCyyEreuG0TtFOTjd+Bj+I+flIbFqCF4mAVs0Bjf4uXJ
         yW3zq41RXMHvM0fmclIOvzE57JEbgFR7rFSZUj10eY2CKGya97a8eejy3nE1FIVrWgvi
         69Va/2L12qgcEFgn5G7AGxvq3/MfRizQSppX7SBM596yz0SASYC6p32XkO1j+PvRiQ5R
         lcSeTQHtyc8V9a5gkD7817yJVdENTnGs8Pec3L9pfPZOeweq6nAxAHTyg9K+742cvDVJ
         PtjsawwuriCo8IEu7AxsywaTypbChvTVXVyaAfa7vvvvu2hkZ/LVvTp9r3ONhKBasFUu
         eHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741689481; x=1742294281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyAWrxEwUsWnM7LVGAbr1T8GXaCm2RFT3dQ++j9eSpM=;
        b=EY/R3BK0n1G+jsJpaT82sKKa/S5TPDjA5CSIFucfAjwfCzxy85EiqOBg+yk1ldzR6v
         Irqfg9ZrrfY/gyDPhWhpb9sEMyuyRi01e/W719PoOIKEC7mIxwTtTOSoRR838p24tApY
         wvr0yq9/q4yPhYSRmm8fZWVDMWITyKNTF+9f3K1kche81rvrv7gaXSq1TAEKZbEy4a7i
         IrZxhNxgH0znz1/Sp6hQH4XR0u1HCfOahagwvfgnNRuujp3naHiZo4PcBhfyQlwQwOY+
         I/Tgmjo6NJ/kCZU/IQRxWhyYO66UBxazQrIIV4ZpJ73AscjkaXrHIuum6ItGge0aT7K6
         pX+g==
X-Forwarded-Encrypted: i=1; AJvYcCWr4LBTJHDcNW7aDmww3g8hmccT2DMRcE6woR5AE/klqAEyTv3br8G7BnoXWryTDpJ40aJUxw4gjQ8qzBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQDrmdcLNRL//T1z6Pi9saa6z5wAwpNIKVJKaNc4Tt3+OQaFY
	xVYkPyxu12A5VvymRGFomqZ0Z5e6ijbCNCwU+UOBD4zpsWRKYwqw1+Wx78bewjs=
X-Gm-Gg: ASbGnctBya1raRrJne7PBmedpx+ZyrfPIGy4q73anFTwl1Qeirf2f3FmdR+4R3JnjDO
	CiUB5IjECuZq276MFiA2jRvMAtDOPOMs1bxLt4TsDpU2aK3k1yqoEfPbUiqh29yT1Gib8/qjmpo
	FwCLmI1DfZu0Yif94/3dQ1HOABrVG0V5sQY1NDfIer9KtLqUWepd7j2ztxms8swW+KLCLCTmCyI
	LFOTdAy9k5l3qUKUFkThe6V6w5qxlfpg5K7O/tvxEeadkY4XSB4bUjBs1411ab07HfhMBMnnT4k
	2CuTLj1mhXWDgvPmRdbMqNuCCkN8N6qHimCwB5AR5teVV8Y=
X-Google-Smtp-Source: AGHT+IF/j8vaXxrz6NQ9qVToImBHcx1sXj5BHKod2F3PwyhmwrRzoNCSAtC5+f+03GzQ5ewdWZTRdg==
X-Received: by 2002:a05:6000:2c5:b0:391:10c5:d1a9 with SMTP id ffacd0b85a97d-39132d82751mr12162685f8f.31.1741689480756;
        Tue, 11 Mar 2025 03:38:00 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0195casm18059782f8f.53.2025.03.11.03.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 03:38:00 -0700 (PDT)
Date: Tue, 11 Mar 2025 11:37:58 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Todd E Brandt <todd.e.brandt@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/5] printk: renaming some suspend/resume functions and
 one fix for unblanking
Message-ID: <Z9AShs1dEO0jrgjL@pathway.suse.cz>
References: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>

On Wed 2025-02-26 16:59:00, Marcos Paulo de Souza wrote:
> Hello, I've being working on some patches that help to clarify the suspend/resume
> of printk machinery. The last patch on this patchset address one issue regarding
> suspended consoles and blanking.
> 
> This is a part one patchset that I would like to see merged before I send more patches
> that will rework the suspend flag (a global suspend flag istead of per console) and
> the removal of CON_ENABLED flag later on (I've created a function that will forcibly)
> register the console instead of using this flag.
> 
> Please review!
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Looks good to me. I could fix the typos when pushing.

Well, there is one more thing. It seems that the simple graphic logger
was merged for 6.14-rc1. And the console_stop()/console_start() API
is used also in drivers/gpu/drm/clients/drm_log.c.

It is actually the code which motivated this rename, as already
pointed out by John, see
https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.suse.cz/

Well, I am going to update these two locations when pushing this
as well. Let's just get this change done.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
