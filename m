Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41762206A4
	for <linux-serial@vger.kernel.org>; Thu,  9 Jan 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439222; cv=none; b=pwdw60Wu4EMAYG/9VkkV3WvKKOTS38EvGR/UYi9RuN11IApRMa0s7mxPlMLMuJkcP3ga9mIsq/m2cusV1yKfNQHSxfaXzxQcHSss6T+JQ8abWa59cpOrNyYpx+QL8UDO7Md8TbMoqBHxV7v55A+3diGWuQt+DNhdb4vk9rpbMI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439222; c=relaxed/simple;
	bh=u4gwTeyQ9T0CHmAvGkXl34cVq+1PeCUxNwHkPFcZSDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDPTZ9g/z0Qz9u6Ul9G8hG93YqZO0PHRV174fgiwizba/YjwOpeft/SgQCubrNMAO3UBhxxQ8L7wDJebNA2OjPA726bNfO6TyAqIxtiabPnpLJBcEeJnKRuWlNgPu/W5b21q8gTJWKqjWfD/9DJUFWrIGwq9LsVthti+YYGtbCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Dh0TTomN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dh0TTomN"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43621d27adeso8737625e9.2
        for <linux-serial@vger.kernel.org>; Thu, 09 Jan 2025 08:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736439217; x=1737044017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BcqQ7tD9vjXmsyMr1SyV31CA5HZOiqbPmLrITTQfbxM=;
        b=Dh0TTomN1BxI7Faa4DpeFNKt1S9XJQhPEPwH9Z9TQFcPO0K3Wv5Ff9asCxfXHpuoWL
         sLbXsKjqN0u+nqwaTbzFMM/dTpIFQy6ejYMwsgl9wQRiuDE0LkdILFRnydFr4tD4yYRL
         /PC89DnzYMuaLC+5Frrj9GnKjEKsLfoFrHbEtp6AaCFxo42OWDk7LAH1vRiHm+dBDs6Q
         ajgTocCVIwj2pT2IA6sJib2nmghoPAhYMuAl6KfFBgFDk6lm5uz4p3jlAEniqAWVLmCZ
         6ZgTG/4f0FfFWurS1dYYjz5o30cOhl1TvL5hB/Cf47L09W4oWBLIhkKGAK0pnr342XkY
         YS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736439217; x=1737044017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcqQ7tD9vjXmsyMr1SyV31CA5HZOiqbPmLrITTQfbxM=;
        b=tvmDtO7zSHmjm77VZlUBXyl0NLrCinhoKcM9A9OiU2vbDy27hs3N9JH5JyACLQG5ty
         EPTz9ZIHP5aU4k4mv05YkHBgXi+WKfnG6nWQmMaLZqVWL4u60Sbhg6ePZKi9RCCFnJ9k
         SauO3mJlArzOZbheig3XI79iIlbhfCTUK82us7jRAh/ZlV4X4DftcT8+6z3yxFbTwUwl
         q20xqRgB6sIULF3sU0aRuWyj0qEW8642KEKdQrmhccib/BaO+0jlKI6tBbk/uI8mQcT/
         WBN1q02IISqOa7uoDf0Jen6n5gT96lCOtE5Jd/gcGgf6OqoboTaiY9pcPrU94xoEjqpv
         Azow==
X-Forwarded-Encrypted: i=1; AJvYcCVUFlIGHE4TFOMgZJZdS9H7eWK3Hq0q/RL2FcvY9gYP+lI6Gf34iDQoMiXEp9gu1SEVqIi4OJx5SlGSmGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBb/16VZoYmizvZWxXH+lp+BLzv1hDMagZxkw2m54NX7wcZ+Lw
	CWg7w0IrIaUyv58MzDm8fMLEALI02L0hqzjXede61XbTEz3KFE/Y+gG78sRTZ5o=
X-Gm-Gg: ASbGncvgx/opTIAgnSBO7oaaCeKiJ0SG17WZ9rTSHKX/o5aoJum2wp7g+MtKaJrrmB8
	5G8AVZi+t82TZMhOCnzoZjNH7y6s8MsFAyZwgvhVN3ruRdTXT9rhY/9cFXCr8spogyfYwS1TASy
	YSZOm0ikZEPHWvIhCLhn/Je8mDuLnwMc0X+ZLxYw10JqotdgkVbqjrmX+1/dyXaCltemD+1IGGP
	6wl/GuBowIemnFDPpUG/nqV1YVXkJGt8Bb/LRWtA/ffpozyO3YY8LxbeQ==
X-Google-Smtp-Source: AGHT+IEnVVveqlLA6iTuso7Xs72qhA6/eK/AWC+a46yTv3usIVfs9NopQaVFj+0xAEEoLlwItYqfww==
X-Received: by 2002:a05:600c:5115:b0:434:feb1:adae with SMTP id 5b1f17b1804b1-436e266e823mr63705305e9.3.1736439217099;
        Thu, 09 Jan 2025 08:13:37 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e8a326sm60294735e9.35.2025.01.09.08.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 08:13:36 -0800 (PST)
Date: Thu, 9 Jan 2025 17:13:34 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH tty-next v5 6/6] serial: 8250: Revert "drop lockdep
 annotation from serial8250_clear_IER()"
Message-ID: <Z3_1rr_lyaRB67dj@pathway.suse.cz>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
 <20250107212702.169493-7-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107212702.169493-7-john.ogness@linutronix.de>

On Tue 2025-01-07 22:33:02, John Ogness wrote:
> The 8250 driver no longer depends on @oops_in_progress and
> will no longer violate the port->lock locking constraints.
> 
> This reverts commit 3d9e6f556e235ddcdc9f73600fdd46fe1736b090.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
