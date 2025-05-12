Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182891A316E
	for <linux-serial@vger.kernel.org>; Mon, 12 May 2025 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050434; cv=none; b=F8VDVEGvYsFptkfTaU/2YnNKbOk50MN/YN0tptDNN4jDpTKpaZRxrI0+fpxPX2nytOX2kjndhOQDO71WMg0kcWqRRCVpIucxS75Jkiy9a2Ju/nqcUsHfwcjo3ML+ZwJjQfi/STr8wmzMw3Y5GStp2b7gioJHkQW6kKmhiJ79v18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050434; c=relaxed/simple;
	bh=dYdmcxtOT0PL3hJhNzp7IkiVHqpd2RzVPV4jjj8pTeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3VbRwJ2YzIbYf2WNTNeQaxFb+L0TbvQP0+vXpOevZrEhdom5qrNEYN+oqWbzgrmql3UTZoJ24hc0yJE7VZUy2XOd5+X0Zxc78igp+XPxgRTCc3KNj6Xt8mp62YeyurKOzwdiaw1us1q0KRr7wRMlGO0n2y6wFQXLcHHoZjjr1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IEiSIk+R; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IEiSIk+R"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5faaddb09feso8675527a12.2
        for <linux-serial@vger.kernel.org>; Mon, 12 May 2025 04:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747050430; x=1747655230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVLv+spmoaAvztxddjO2Hy7beQH8ngEJQDm25GE/NA4=;
        b=IEiSIk+Rf3mcZxTAE64R3kaYOYd5GO6QfLZK4n2t7HNi5WZ29o+j5pPIOsa2Ccv33x
         PaAvmQsY3D00klvgaDbbtub/RrHEdXxs8/grIn6BI2YvZDhGwWtEKWa/StgSBj6wg+DO
         jBbrByrVbyL6Tq3BtyYfDoHOac5PxhjvWoT7i6tPzTnFOoDcuP5xAP57SoYeNn9nkI2m
         +eR/yJguHyNH0nAtS+pUK2882HRo/q8Kt0V1bUgayU1cDawzwLzX5c/KNHd0uQ2EeWBb
         uSkmAKpY8+ddw+P+XjzdVMz3Fk/ZmEP005rL4eAW///Hzpv1KbrP2Jf+TRyzxYachl80
         +ohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747050430; x=1747655230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVLv+spmoaAvztxddjO2Hy7beQH8ngEJQDm25GE/NA4=;
        b=ZjpUbiVoUoLB3RxwvzLF/1yuEtzv3SsbkDMHN5zvVT4Ds39BwcC5HfMhaqJmswr64p
         qDOFaVPHRVqKzdijauFX9NvvYN76ygflivfC3CfNxtMLc+mETY7WmdXgZsekF6n7Chkm
         lAsEy19Z99qD4DJPnYzsOTyITEDMCQXlBFoByfziHPE5eIr2ps5nR+cQW62qBN+lddj4
         9OwEacqDX66x8SAAw8AAURGZYNzSqjf571g0QJ0W384yZTL1xhgkJ299+ZqPM8ESWsBs
         AzNmuk4QSbkF6HL7+WZARgmmD5dO5ZMxZd4MCZLoCvDMVg5nfCYnwNVdoanZPRoIhkSb
         xAKw==
X-Forwarded-Encrypted: i=1; AJvYcCWmVrd5yka1UNOrPrzYt++8YuEAijwAcziFEOA4A6p67/eq6wk5hX68tM/FkbB0qwotd46yKxfKdQkD0ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4B6mHBnbItiym3v3qVigCmaM1Hi6zyDhCWh9CTHiYJD3/Ldkp
	dbtqQRDhBkKZoiTnpyc9PbJpzevLkYzs88iK7bat87fd5iAf2EVbqOlxQTMoVuY=
X-Gm-Gg: ASbGncuaM8fBgqISE5J1bFfyTwsqfQaDTMNyd/v584EXGkuzgBH4X0lOFcPJUx7fi/q
	7l6ICwrizWGcKWpRgKenCD7L/yGPo4FNE4Aj70w5yBDkS38HLX59RlOKhW35yedCNc29VNHzuCA
	Okxu/aPLMHwyvC3a5vhsv/m5+rp+ySx3PnXwXEsnUZsoJCSB5yULzbJUb8zQPPgd/Lnljh+0YiH
	twxkHlBm0GHNma0aNGpnBJ6ugfgB49sZROIWisOrzJEaoRwg9MF6eJcIkzbBBF5M6aYktsxhJiT
	k+sAaGF38VjFS/yZ8YBngrdE2SRhpzUUx4c5QjYMaJoEvcfEE726Lu2ODTu7OGhW
X-Google-Smtp-Source: AGHT+IE1VbmKMbNr2uygysNhb2Q2CrLOamNkk+qyab09zQFyHUhGx9xJDRQHSPfoK5VaWJdnc5BVDg==
X-Received: by 2002:a17:907:7ea0:b0:aca:a688:fb13 with SMTP id a640c23a62f3a-ad219057ff1mr1315018666b.36.1747050430347;
        Mon, 12 May 2025 04:47:10 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad219346b85sm601439466b.49.2025.05.12.04.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 04:47:10 -0700 (PDT)
Date: Mon, 12 May 2025 13:47:08 +0200
From: Petr Mladek <pmladek@suse.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: john.ogness@linutronix.de, Jason@zx2c4.com, gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	lkp@intel.com, oe-lkp@lists.linux.dev, oliver.sang@intel.com
Subject: Re: [PATCH] rslib: Add scheduling points during the test
Message-ID: <aCHfvBOY0vQ58uaC@pathway.suse.cz>
References: <20250510013515.69636-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510013515.69636-1-ryotkkr98@gmail.com>

On Sat 2025-05-10 10:35:15, Ryo Takakura wrote:
> The test has been prone to softlockup but stayed unnoticed because
> of the printk calls during the test resets the soflockup watchdog by
> calling touch_nmi_watchdog(). With the commit b63e6f60eab4 ("serial:
> 8250: Switch to nbcon console"), the printk calls no longer suppress
> the softlockup and warnings can be observed more evidently that shows
> the test needs more scheduling points.
> 
> Provide scheduling points by adding cond_resched() for each test
> iteration on their up to/beyond error correction capacity.
> 

We should add here:

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202501221029.fb0d574d-lkp@intel.com

> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>

Otherwise, it looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks a lot for nailing it down.

Best Regards,
Petr
