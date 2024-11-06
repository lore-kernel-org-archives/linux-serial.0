Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FC320110E
	for <linux-serial@vger.kernel.org>; Wed,  6 Nov 2024 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907750; cv=none; b=jDk8IOv/swlsGrFqjRmkz3znSfmGObC1NK5P6YXsjM9MP/yAT9QReZn8bA2+GpfpkW+el4LjfgHC7xcuny2ht3XH8vEnwqbTTYYp6uZNSIv9hBQG2ldarYMLaXnikloYpDoZ20AJFwA6Lwoy5asdFXgNlaMgvj1ynVwTznVENLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907750; c=relaxed/simple;
	bh=rXpfHHtaAD5pTcx1X9at8HJg/Dbu27X0NgaP+4zCyjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ4d6mEyaH14eSqAR5LSD2s0Gfa83XdS0248jN0EbXKmnrMp7WMfVwShaNAusoeu26ZdNRg7bmogQj3LbDejx7xA8meQbOApghq8b8XF4zFh8xnn45JBpyuhzqJmXPmmsas+8Xz4jIre7/KNJWx/R1rRLGE4lkbpEqwDkYnwcEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RBSlUJlo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RBSlUJlo"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4316cce103dso80313415e9.3
        for <linux-serial@vger.kernel.org>; Wed, 06 Nov 2024 07:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730907747; x=1731512547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ti7UsIKyZqf2Hot2MVTOlKId95dgb1Zot1pr3BqVVw=;
        b=RBSlUJloMrVDNAYbrbIn3vGHJE9lNf1kaSwsLfJiQik3MCXxmm33xsnWIKhugy+C2n
         k9Xto7JyjuoP3AfQ5bFfF0eNTLx2mZsOzjFQwCRwRpDiF0OEJQko/gm1UsxbWecPVSpk
         hLDcptH5UcnTO74GOS5eIChvYZ50KwCCKzcef5nKYWCzMOL5cr8xJFmWO+QRFUFuB+5N
         gvHx1hPf/tHEPJufU4GJTapeP0pGj6A4pa1/jbx9cY4MTtidIg+QxTmMA2weyB2Bmd7a
         U19nlsyzTcLVmTnuzcUCFQl8MUBRzlpkhbtuf8NKNQ/K8qK6nX4bJoD6Y0cMUqWzeL93
         shvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730907747; x=1731512547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ti7UsIKyZqf2Hot2MVTOlKId95dgb1Zot1pr3BqVVw=;
        b=c26sqisv+/qtkFssnx/N826HXEeKGdR2uHsNt7Y1r6Z+4FontDtS/bSoQWh3f9kj+i
         8GVkTo1LfPchIQDk3p0l6V9OiiNMep1P0zPGFxTnb30oOBwafeGhlcpzuhsTa+3hEUka
         7k3/nFgPNI7yiEsoODZcUpLa+ddhsu74fZZvWUKsjVLUcb9YGr5ikin0XMMUv+sOKQLL
         1M0ZptZwQuyk864thRCyWjrIU5HaejxB+n87wIsmxQGxNjd84qsTZ5Q7bHsQW9X5pcpV
         Ao8A609aDMrpvQYyEXzwbV16zCzQxyPxt5i2af4CTB8OtqKk4o/vtaBpfxMZgwk6veWJ
         yG9A==
X-Forwarded-Encrypted: i=1; AJvYcCUFEkhZWsod4nEtbn1ssHENdBkYA4uFpurF6xdOrjxexLqzHMYpFhC9nJoSKPSyBHVVprkndRIfQn6pCXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMDttwRneuovv7WihKkHw7r3b21KuqGlNH/hC5jr8HIf29xgna
	c/6qhgK0RMAo3xuq5J0lYHM2yPAgelXvrHwZvGiFvmiRRvbxEXwSnF29KkRkzMY=
X-Google-Smtp-Source: AGHT+IHL/9OFC3B7xauZzAm3FztTY/x82hTX3rnLuRwwJLNiavrv7/WtChDCcQs0E4+aSR2o60E95Q==
X-Received: by 2002:a05:6000:156e:b0:37d:61aa:67de with SMTP id ffacd0b85a97d-381c7ac3be6mr20806701f8f.42.1730907746813;
        Wed, 06 Nov 2024 07:42:26 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6eb5fesm28133095e9.41.2024.11.06.07.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:42:26 -0800 (PST)
Date: Wed, 6 Nov 2024 16:42:23 +0100
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
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Stefan Wahren <wahrenst@gmx.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Ronald Wahl <ronald.wahl@raritan.com>, Udit Kumar <u-kumar1@ti.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH tty-next v3 4/6] serial: 8250: Specify console context
 for rs485_start/stop_tx
Message-ID: <ZyuOX4VVbfAFhMfV@pathway.suse.cz>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-5-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025105728.602310-5-john.ogness@linutronix.de>

On Fri 2024-10-25 13:03:26, John Ogness wrote:
> For RS485 mode, if SER_RS485_RX_DURING_TX is not available, the
> console write callback needs to enable/disable TX. It does this
> by calling the rs485_start/stop_tx() callbacks. However, these
> callbacks will disable/enable interrupts, which is a problem
> for console write, as it must be responsible for
> disabling/enabling interrupts.

It is not clear to me what exactly is the problem. Is the main
problem calling pm_runtime*() API because it uses extra locks
and can cause deadlocks? Or is it more complicated?

IMHO, it would deserve some explanation.

> Add an argument @in_con to the rs485_start/stop_tx() callbacks
> to specify if they are being called from console write. If so,
> the callbacks will not handle interrupt disabling/enabling.
> 
> For all call sites other than console write, there is no
> functional change.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

It looks like the code does what the description says. And honestly,
I do not have any idea how to improve the naming. I would keep
it as is after reading John's answers in the thread.

IMHO, one thing which makes things comlicated is that
serial8250_em485_start_tx() and serial8250_em485_stop_tx()
are not completely reversible operations. Especially,
the change done by __serial8250_stop_rx_mask_dr() is
not reverted in serial8250_em485_stop_tx(). It makes
things look tricky. But I think that it is beyond the scope
of this patchset to do anything about it.

Just 2 my cents.

Best Regaards,
Petr
