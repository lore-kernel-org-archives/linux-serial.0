Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6A28368E
	for <linux-serial@vger.kernel.org>; Thu, 10 Apr 2025 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284589; cv=none; b=IMI3M7dqxJmFNquU9TFeVIX70y7d1BhsYXdP4VDGiIdKD5ZMXxZqHZFrnu3vE2rXrmxqb15ch8pK2WJOal/ajlsF7EU6rQcZ5VOwXnfz7H/p81ulsSeWOH/dH2TeMGQd5dOpgUAK4ytdiJ7FOjv8RgPE2vgkbY5JU3vNN1gekXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284589; c=relaxed/simple;
	bh=7EF92uy0HqAr0vHv++Xpljd9wbqIP32aaDhXDf2csFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ethNKu0+NrnFuLJEPXRHAYTZVMyOL/QtxSWwCqLW9bljq33nnPs0rCp4RPZhvKfjkCqpLmu8ShGtjczCoy53Twa8FKWS7yeE7NT497zzKFunBsMRPk+gzvzeACRTIVFJaqmBKgpe51FehwP2CyZKJnEA5wjzTOuVhABrTjavYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CJJl3MsG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CJJl3MsG"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3913b539aabso355547f8f.2
        for <linux-serial@vger.kernel.org>; Thu, 10 Apr 2025 04:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744284586; x=1744889386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=inreEjGkP2FB86SvKqikRoCXcnYDIYzGtWDBTQYF/sA=;
        b=CJJl3MsGLDMR6MEGfXjAewU7fLufwgbRvt9V3FK52IxvnTq3RD6OKYcfcT02+khAbA
         8RPf8STtBAYkhASw41OKs/2zC8/0rmjLahSqYGX+eZZUg711+DqyuOuIzqrHRVsASkxc
         7FUSqgBktoaUSFFCj285QZFah1sgSdPx8hrSJWhY8ZOiyRlonpYCRDTSbiuI2XodgEYu
         palOUjUQ9Ug1l7YTcF7nf4hNVrg/cOZemHqJ9G8u8b51u9c2YOMkczDCgr7ur+gq+E7U
         hxIPln6blfTqm0sSZU50mZwYWdBQUj2tpt42S1bBssx+E2qRRFkrCt+Dx9uTcJw8Y0a9
         m3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744284586; x=1744889386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inreEjGkP2FB86SvKqikRoCXcnYDIYzGtWDBTQYF/sA=;
        b=d0f3RRiquCm4J4rLPqEAOfoCi7F1cSapTk4pwBYgB7f09aUFscCzWL0LaoweS850St
         0wjFAa0bZbL7AVQ4sQ0XFyYU6MgE/GxdGHFd7kIhCH2qFSZOVKUR9hBy1OzUL79rC/Ut
         70UYz0JYxwBkYbknFwo7Bg1lDa9Ge7OVW3C5RjWBO4bXmwiEHkahllvsxOo49udsPYuQ
         uT9JK7Uj3SmPE8CU9I00xWvtr65OY4c71QhZ36N87Uxa63fLda8kq6ggeI0ZI8cTwcMe
         42MtkKW0DAWdCYHEvZvQeHmqZVVAZo0EzfXX1r4ykd4DGnJPB38VM0+rDn+p4J0CmyzY
         d4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWegjZeTCZlBJ/1diB4b7JAZ/IX4bRx2f8DZ4R1B+lgpE8JLRODUnB0/ZhJPjJ90JVkVuVmXo/eu+i0pDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvksDYJ8SvUsk9vVDIr7N0mizOFrjp7QRW6GLsLYwaw45Y/XHx
	9nX6IkDpoLVkfuuXtCuWoM5mh3muVbVUxbC5B5nXpDv1f2R23ZFyAJzbqSYFB6E=
X-Gm-Gg: ASbGncvc1fvHXAJBPeRhfzYbUbDaahlSdr5ORnEboAEG/6wtZ1RhpI6ytfAEjpgrRDz
	e0PSkO7ffagbxJkChTMWQ94ZZmgUEhcFdoDFAYa7WQYLJcSmSJUd3ol3jUJ3N16vZ9LWLINR/RO
	Jyuo7yQfitt8MPVteusUKh4lUEFOC2s2Y5gtMfGhcs0BCZB/Hq51c/o1fTuIYXnN7Qw/Duicl/D
	SrbmH1dy2mIsjFtdduWYsPfHyWzcbunE7flJKhbfAEFmRy0z1umAnivTQXciB+zRG9BdFHXOk+z
	QC1+1GD2/R87LVQmjX3giOm53fKQwuLo7sq4cUyI0KY=
X-Google-Smtp-Source: AGHT+IGiu0OWEfT2fJWCoTEv1DArNTgNn8X+CE9Dq1sIudD9zQeKyE4/MK4CcE//ivPh7Bmvd/5jzw==
X-Received: by 2002:a05:6000:1863:b0:39c:30d8:f104 with SMTP id ffacd0b85a97d-39d8f36c5femr2027739f8f.6.1744284585872;
        Thu, 10 Apr 2025 04:29:45 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893f0b09sm4616409f8f.63.2025.04.10.04.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 04:29:45 -0700 (PDT)
Date: Thu, 10 Apr 2025 13:29:43 +0200
From: Petr Mladek <pmladek@suse.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, bigeasy@linutronix.de,
	conor.dooley@microchip.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, john.ogness@linutronix.de, palmer@dabbelt.com,
	paul.walmsley@sifive.com, samuel.holland@sifive.com,
	u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] serial: sifive: lock port in startup()/shutdown()
 callbacks
Message-ID: <Z_erp2nLRKzLXuwF@pathway.suse.cz>
References: <20250405145354.492947-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405145354.492947-1-ryotkkr98@gmail.com>

On Sat 2025-04-05 23:53:54, Ryo Takakura wrote:
> startup()/shutdown() callbacks access SIFIVE_SERIAL_IE_OFFS.
> The register is also accessed from write() callback.
> 
> If console were printing and startup()/shutdown() callback
> gets called, its access to the register could be overwritten.
> 
> Add port->lock to startup()/shutdown() callbacks to make sure
> their access to SIFIVE_SERIAL_IE_OFFS is synchronized against
> write() callback.
> 
> Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> Cc: stable@vger.kernel.org

I do not have the hardware around so I could not test it.
But the change make sense. It fixes a real race.
And the code looks reasonable:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
