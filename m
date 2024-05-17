Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A354067A1A
	for <linux-serial@vger.kernel.org>; Fri, 17 May 2024 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957485; cv=none; b=gZ9N2GRrmq+dt7sOcAqoj63irWt7yt0GG5Onu2FOwVKhxkSelGiFa0EcqOSimrdMOmJ3aAKfI3E9SdT8eWdZWfEKiJJMSRQwC+qh7yFy74tC5FvbMFpAD/W5haiF3j/dzTYo1pla8xINUdUlTxKI4aCWhtZq/IYo/S3h+41yXHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957485; c=relaxed/simple;
	bh=1aOVgw6hSgat6smy0lHMoNOBWlOufPQjFo20G/kY2sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gR0Yp9O72IBruzJgoF9DkjNR1L5C73smmp9oN/hKk+XWeXBnPFdmnCDbCVlIMoxQ2WYogfuRVWd24KzIPYzkHEjcGptWgYnYavioipsEH8+U5lhzVBjCiDq+xtvuc6fCaEbj3zdqjscIuV4GOTp76QnUpoMdIqPuTZjYKbikJcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bRTxpj/I; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bRTxpj/I"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41fd5dc04f0so1618855e9.0
        for <linux-serial@vger.kernel.org>; Fri, 17 May 2024 07:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715957481; x=1716562281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1U5jaDar7OfZ99raGWnoHg7cFZibmJ1aTqNn0ttXSs=;
        b=bRTxpj/IblmdTrVz9jPdjA02CBwgQhIQGFeNdKndT9KjyNTETRvDogbciVpdjB6tE5
         cWEsCIfStXkQVEgyo/B7JvHqrOM4QrbsAdqptilRiyTl8cEp0n7hZvbSEHXlNZ58PuHP
         C6r1y2juBKpD1dVKVu3V31Cy34N+FTTxeBk3SYZNwiEckTFrqBdNks5CE/IAsAUYJXkz
         aWOCMKCu44htiDocsNttkMi0RDRJnU2n2i40aY0G2WO4g6svcEJ6+KBIgODaO4e7OZYU
         hDBMGH14pphwJspN6n3JoyRScMIULwLGyGIZincb2QZTX88Ts/ZaHHmzguOjiu7eB8nd
         /Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715957481; x=1716562281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1U5jaDar7OfZ99raGWnoHg7cFZibmJ1aTqNn0ttXSs=;
        b=SbDxxLeOJyjxnw7+2IaGuPVRmLdE3Arwe7Nz21dhpbVDNKVzq6lNmXTIfsu6QGNirz
         YVJfQzg8eUhhbh7fOiHAJg4J7+cjmosmeo/9d8uzB3l+D30xJZCY25+WLJdq4m48u0Lj
         BPKbxyzS4S7i0YCESHY9xqr7ByTC7CW+XRA6W72mC1n1HUhVAGrdkkoXUuq4yV2Y2V9S
         yk51TZ6foR8E8yQ+sZ46uRdMP69oi6/ym5MJadG3VJ9kPwc8tq1QGli4uiUuS3xXQWMv
         RnVXvpcLr1sZkK6/yUDOe5VqYddfsjntKu4iBn/ChcZUWP6FpLPWn4hHNC53MgWCVEGk
         q4dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfDH1MHg5JUdWhZDIBbe7Tc0tUkA0eKEs2pQAPryvnwDPjZXqGvbYVFg4ATSdGALmCo9a5OBy2KafMvw1C7aXAEyV4/98WOh/oAtCM
X-Gm-Message-State: AOJu0YxtPiawJDAsTwe0y51+N+ik0w5rfnd+nmfSOQ97o3ncyV94pDSO
	B8qkbNsf4VsHnX71momivEnd3KdzgJ8WHKBmeUOemXErThzD1peDiStCWXBQQc0=
X-Google-Smtp-Source: AGHT+IGSNgAtmWQfb0w8Kl65ihzrKqCApb6t06Ku0iJmdFWRb730Oyxyj8fQ3oS7uwaOTj9nQj/rrg==
X-Received: by 2002:a05:600c:19c8:b0:41f:d84b:1ade with SMTP id 5b1f17b1804b1-41feac5560amr234770785e9.27.1715957480894;
        Fri, 17 May 2024 07:51:20 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4200e518984sm242602035e9.23.2024.05.17.07.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 07:51:20 -0700 (PDT)
Date: Fri, 17 May 2024 16:51:18 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hongyu Xie <xiehongyu1@kylinos.cn>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v5 09/30] serial: core: Introduce wrapper to set
 @uart_port->cons
Message-ID: <Zkdu5v-ifyGNCV_n@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-10-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213839.376636-10-john.ogness@linutronix.de>

On Thu 2024-05-02 23:44:18, John Ogness wrote:
> Introduce uart_port_set_cons() as a wrapper to set @cons of a
> uart_port. The wrapper sets @cons under the port lock in order
> to prevent @cons from disappearing while another context is
> holding the port lock. This is necessary for a follow-up
> commit relating to the port lock wrappers, which rely on @cons
> not changing between lock and unlock.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
