Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90155644B
	for <linux-serial@vger.kernel.org>; Mon, 20 May 2024 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716207776; cv=none; b=TJ+D7nXDm4dALxNd5ZNcNvfx7eyeJ7UIMdAAtCHA+r/TmKxmtrJaLpbCwCUD0qyGXEnck32/bNWr/PVn7Qm6zaBM5L5DrSCelEvtuER1kKgT8hvSNJ0lYgF12fXfTFUy0oIuu5EYzltvJa5kq+aM5NKnFb4ltgldFX1u3Da0Xds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716207776; c=relaxed/simple;
	bh=FsjGULNLBK+FjzXLWr/t8FWTDIAjnTpWhcTrRa5F9sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+/Zd0chM4e/P2MnzushV289AwsXm/OZ75yUTSH1WOiYKIPC9UDU5yhS16o1wGQ2Rg5CnxUE8hNY0hFNd7xWyEyZyQC+f1uJrOn6oeRM5tcY4PaJwtDOB1QaPxcRC/26wyNWYfX1P9tCuQa93sv5Fgx9x76oKsomjP+AWdDjDAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dguptPYJ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dguptPYJ"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52192578b95so4864274e87.2
        for <linux-serial@vger.kernel.org>; Mon, 20 May 2024 05:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716207772; x=1716812572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bREYXSNJx7yr5uTrce/LKMVLb4BxuBwY9vQL2AO1CY=;
        b=dguptPYJ6eEH1U3JgYG8j8UeKVQqMosUTvjzVuQX2lW8WEoyc09NoR1oMcTG6LMoay
         bjqhSoidZKDH6slChBbhHO91Hf0e0IzYsV4kvBNpYHR8zsHD0t4lDNi9hvzm9/E4KIZo
         Ycq6nUEwH8GIKoRLb2pXaLkU/LfVONSFoZByMXDd9hULQ1wcAIlIGLqMdKnunohX8V84
         9znpBAcSeYCRa52dKZ8Apzg02GVPxC/mgC0K4mHMd1OSGPBGxs1WxSwvls8v8nG7MV7k
         iBRnym2VcpMKYvuhrj+vC+L7qU6zc2gpsuJhExZnIeMwX28fqU1dME1Vc/yimTYhaw6d
         KZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716207772; x=1716812572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bREYXSNJx7yr5uTrce/LKMVLb4BxuBwY9vQL2AO1CY=;
        b=oOXnMKpE/BrdE3hfNfnNKstkjQLzFeGH/6goAGB58D/YUTx9H9YSkGDBYJoIJayE5H
         /mfCURY4ogyDnPW7Wz7peEQk76fwQfN50HXh0HCj51PssSaGAFZrcR6NT98ZEG8aOio4
         7il7I7w+q8m9N/17nbVD59ZMPjtRtkSmke67KILxzjzwJwmU081FMPG+xp2rnxg4UJMI
         AN+h/XG9N+CJGCCNhnHr07mkKtxf96AnxpnnpRCoeQ20fL4PjP/P7vErODrcUdfE94sU
         0lv2+0nVZTAV2HNf/DJINB/bj6I2XXs5NsOyZkGHnBUdj9rUhcVtIyIRWI/YaNJc4Sex
         H5yw==
X-Forwarded-Encrypted: i=1; AJvYcCX6X+SInAtZJI1E24VJbRJjECEa8m70FEqyNRf0ohwwrF72YY8Ps6Cvd8BTzF8DdmCCxvbZ9Rjwulzd1cZ6bup8/95Tr8cifItYJYl4
X-Gm-Message-State: AOJu0Yw7jbY8ufVI23Y/9vdV6U/P4NwxxAB+z+OOnHzaN8iV9psYZzBj
	cKH7YUYO1aoaQIW+dSbq/up5TNRG7rLkeURWy5772fa8GC29L6LZHbYfvhyuCcc=
X-Google-Smtp-Source: AGHT+IHrIxn8lRvzjOg1Ui/6tQPrN6PSJ3Se90i+uvDj849VnBCvGdQmYRpv36r0fn+9t2zRZhCgVQ==
X-Received: by 2002:a05:6512:3c9e:b0:523:9493:4e63 with SMTP id 2adb3069b0e04-5239493505emr12455625e87.60.1716207771843;
        Mon, 20 May 2024 05:22:51 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cfa7sm1446680866b.33.2024.05.20.05.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 05:22:51 -0700 (PDT)
Date: Mon, 20 May 2024 14:22:50 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v5 12/30] serial: core: Implement processing in
 port->lock wrapper
Message-ID: <ZktAmvpBfk-IrMr9@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-13-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213839.376636-13-john.ogness@linutronix.de>

On Thu 2024-05-02 23:44:21, John Ogness wrote:
> Currently the port->lock wrappers uart_port_lock(),
> uart_port_unlock() (and their variants) only lock/unlock
> the spin_lock.
> 
> If the port is an nbcon console, the wrappers must also
> acquire/release the console and mark the region as unsafe. This
> allows general port->lock synchronization to be synchronized
> with the nbcon console ownership.
> 
> Note that __uart_port_using_nbcon() relies on the port->lock
> being held while a console is added and removed from the
> console list (i.e. all uart nbcon drivers *must* take the
> port->lock in their device_lock() callbacks).
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
