Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964BD1E9B35
	for <linux-serial@vger.kernel.org>; Thu, 10 Apr 2025 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288199; cv=none; b=RlLPYLFhbujHpY9cfJR06eQECrLy/L2sHv6OHbiezam/ZOXMGKXTGI3x2rLS8URznVwl4uLHjuB6aN0sSXv95HtB3u02bcNbWyCEjxqbKTzSp3XgVjkL3EGABbLOObBxRsK0L3rSSWeK2zGhtu+3tD1cfzqaNSxKrIq45s/jD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288199; c=relaxed/simple;
	bh=r8RtWRc3Ys7lb3CPSdWXdXYs7h+Ngv/uXqjlSPDyyMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpCL90Z5bRmOZTyes1a1XDwYY5WFMckaoyjkto2sPNMxujqEtDxIo/U8wZWMESBXCW6S3Jan9oxew3FxFamc4kh6BpUX/rIs7bBxPZyI+coKCovhVULICkKe7xSJ2SLMM4GMnOwFIMdXbo40tDE/VXQMuX5Bl9wkE2JrI3O1ECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Oa/32uow; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Oa/32uow"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso1109374a12.1
        for <linux-serial@vger.kernel.org>; Thu, 10 Apr 2025 05:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744288195; x=1744892995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W58zftoxA/h0euOQhznKhUitEEsPpASpF27ovwB6sRg=;
        b=Oa/32uowiqXj8XBX0is2329SdphK9jB39e0NI0w1swXjaktwRBP36+wSrPqRWRF9G3
         QTsZsI6y/Q+BcIIcLFiUPbZuML6K4dj4rfUwR/xqI7x5qyalODUKbT4OoXc2jqNBLJRx
         tN0cg7yUnVRtHhiZ0gsXIVqfy7/7MAYWnSy3DtzW+jog40yfUX3MK177F1oZAy9Ok1RP
         G3Th1wD1YS2Z1BQPfMbjsBedmXQz1B6AkS0Uc+4/rbW5hbHBOq9iR798vDVQ9M+cSrLk
         4csuHq4RNHZF39yT8UsLGq44H3UfD4k7j+id1JorKfTDVWilJwsfpT5pJtF6aKVr3u2y
         VGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744288195; x=1744892995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W58zftoxA/h0euOQhznKhUitEEsPpASpF27ovwB6sRg=;
        b=jZijpJ+52OUpjZTc2ntVXu0HWCiYcR7TGEUIeUYUcOzu0crk36sUybBfadjzKe6t9F
         VYYOEzYi6yd6u2NIrkQLfzjRnGiFeB2Qv9RcgeN8bGYsgFv+t2B815PW887tWkxtutc3
         SIi9luOZNZC7vkHHBjkL6cuyMnYfIJBn8eiKxVe2YCXVE5ao9tdDKWPscZ4i9eCm1aPE
         xoG1WLykoHlFGnliv0GApP4c+fXAw6bXmtFCwpDSSf62HJH8kHRlrlaDL/S8RweAg0rW
         mttcWxbAIsdlmWNIQT+8C/gS4ptFHHugCY3vR6V+5tU1O8H3qu4lSkmtmThvfpWYGRLy
         9+eg==
X-Forwarded-Encrypted: i=1; AJvYcCWKhwsVgclYLJV5i6R96c5zchYb4xw4PBznR4snEoIGc7MiVbwIArkzf0difXK5kh7T05MlU2Pnbfvv9Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsLRi10WgiV2NMU+zmgMih8vMDfmYsd1mYez6nA9CfqFaiwVQ2
	QYDko+4mpKs6geo2eUyTIxJEli+YB416uhhsPaZ2KNOs19/vpDFQ4dBRmOgT9H8=
X-Gm-Gg: ASbGncsNoYv64nv2OpnFrpiKNFPobEfZuZt+PvNXT2grghjO5TL2k6grHQ5o49QmYAD
	J5CGeWavEVIYx+4EhPogxyd4gNidL5FrIlDrFm/PWbneKydedWjObOUaAVpfGJSzpbgZLigeDXf
	tpShNZegnaPeXH8CqdNOpVSE91a065MMzKrkL76tgdlc6glNvoGrrP/DvoiZgRFfR+EgfNi/L+O
	xaMRs7FaObLKwHTnMyVlVgsAKAMoUbOBloybDpMv/5H1fMpJKb0NRAhfE4JgiSiE2MctfsWS0s6
	NXrPOBjCyxaYKJMPKjc8fHN6dF6p+vct+Lzr/IRx3r4=
X-Google-Smtp-Source: AGHT+IGkRcCdesVQfmGut/2T1Nf41hQW3Xy07xSRue+c6AyThON1gDnGuZ55vBm3LGdN2t2bjeOkNg==
X-Received: by 2002:a05:6402:5194:b0:5e5:4807:5441 with SMTP id 4fb4d7f45d1cf-5f329337b8cmr2248387a12.30.1744288194931;
        Thu, 10 Apr 2025 05:29:54 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f2fbd17646sm2295348a12.56.2025.04.10.05.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 05:29:54 -0700 (PDT)
Date: Thu, 10 Apr 2025 14:29:33 +0200
From: Petr Mladek <pmladek@suse.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, bigeasy@linutronix.de,
	conor.dooley@microchip.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, john.ogness@linutronix.de, palmer@dabbelt.com,
	paul.walmsley@sifive.com, samuel.holland@sifive.com,
	u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] serial: sifive: Switch to nbcon console
Message-ID: <Z_e5rWcJKUh7eozw@pathway.suse.cz>
References: <20250405145915.493173-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405145915.493173-1-ryotkkr98@gmail.com>

On Sat 2025-04-05 23:59:15, Ryo Takakura wrote:
> Add the necessary callbacks(write_atomic, write_thread, device_lock
> and device_unlock) and CON_NBCON flag to switch the sifive console
> driver to perform as nbcon console.
> 
> Both ->write_atomic() and ->write_thread() will check for console
> ownership whenever they are accessing registers.
> 
> The ->device_lock()/unlock() will provide the additional serilization
> necessary for ->write_thread() which is called from dedicated printing
> thread.
> 
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

I do not have the hardware around so I could not test it.
But the code looks good. With the added comment (reported
by the robot):

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
