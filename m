Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA721271443
	for <linux-serial@vger.kernel.org>; Sun, 19 Jul 2026 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784456898; cv=none; b=e5cgJrEEis1Fe5VBqwNO9u/G0ve+AKEU5acGLba2YbXDawWE8U8ADynr7wY1O3rB0ttWp/yVDPQm2DBzVKVdjbiZ+IPCoka/u4tsy4HaCcNLfnptwD1fPULpkJTGYbt6YaZPLX2D5y8AfjKfYkMUUQn07gikGmX+kTfVW/8uoBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784456898; c=relaxed/simple;
	bh=g4ZZaOTO2J+J98q3MWOGEx72v4eV2zUx1DrY5sEQG0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qx9s6dSYddPuYHvfnHCka62x5hu0zu8gBrbfO3xQtx6t8+ItzmFvtVYunuCi5DioIwfJ9/7Sg3GJ1WRBlujuSzDdffwRhPdrH3nJEIAiSCGEP/ci1YCqnUPwXev88XQ/PPYR+zknKvNvjBPK2i5jEp9OpdK1G0wAUpokWLtx4qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNddR3Zu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNddR3Zu"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so8068211f8f.1
        for <linux-serial@vger.kernel.org>; Sun, 19 Jul 2026 03:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784456895; x=1785061695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EAHHds1xld5SV8DD6I9qoxlQ4PAV7RbF6w4wkxnn+h0=;
        b=ZNddR3ZudYjCAHeGpTeI2n9hZrlLYQoJZ05Snl40uCBlIkFL40jp0h5vyef2pjqsvl
         7Div4QBwjI0c01OKRSclU0MNCKoEbPY3v9tYVC43ilURCU+FjM6frgv9S9fX11R/0WS2
         2r+hM0VnX28Z2Ron/Hr7sFjPuKL42qTKv+VYx9eyeZIKVtcwi1zoewu7S9UWSvYXWAxB
         kWwqEyCTfkKevfSMSrWORUb+U6FcWT4nFcTr1GFqkh4CoNUYRnktWJCwjIE1sM7xbOMe
         io5+hNR80AnghfcSVkeReaV99HxMtlVQOTcn2ijXmbw/nq8NajdCn0d/NWFUddscJ3bo
         h2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784456895; x=1785061695;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EAHHds1xld5SV8DD6I9qoxlQ4PAV7RbF6w4wkxnn+h0=;
        b=jMGbc7AvQVpLkDzYgk7wqidoEXTCFC1RsQkUtKJ/ZWucdGNSMIi+MR1FLLFO/OC/lu
         pZ2bzxkaD4fhvSRfGXSQzJzvQMIAGVv/Fkptot02w3nHXubN0b7DjLFKaifphWsik9TA
         s7w1Tq46Tc0GliChTWXhsw+hjH6/gTIFmld+oCRo8TdE8yzRxqfLfNioEoqaALnZkvPB
         28C0BnwjexzcxO1q4yU3Kejeakh3V8/QoaAroUdoq8In/lsPASKW/lmATZdTtbHGmGiH
         l2M+2pgktV38Oz26sKj9Zhu/NH6cv/2RrkyWC+uENG31abEhxVG6aTKwa02qfuReUYgD
         13eA==
X-Forwarded-Encrypted: i=1; AHgh+RoHzRlZcwozbYMX6a2fBQOztrlldjWXZGKWl2Mw+JQZ3ASD5tE04iBJqi27LuwjFa8GcFO99HLN3Advrq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaji6CD2vBdjbxt4sFwPhMhrAcR06DVZovM5uxhmjvCPJ66IlQ
	CdLptRplsGDXgRJNTMDpijpk3FCc6m4Cu7Sy7KKDiypQZ78YFuExFr2/
X-Gm-Gg: AfdE7ck+tA5g4aTUGkqNikQg+DDIenPWznipbwaprRoWR8AVOl82wAQxRNgNjD1Qa1d
	kFEokQDmnGLyXmoY4IGdJHeAXqaPOAkL/PLajI7DKzVMxTDItJXJM7lm+WbbBu+agBEffx3De0j
	e+ciWBPnzLN8WwhBPm6Pp7KdX/0mp1WSHkOSrE8CztMWvFlLJQ+lbqK2A891f48m40rUXUZ2IMc
	4+a7SEvRQpdZvk97UkFI7q57VLkiTmjmoAhY6n3m5OdcXJIZ2YW1i9nstRVuUJqLXeXD9Qop/v4
	7joySz4k6jLeSWlg0JExpf23IjUqguAFyZzDSnZzj5/En8lujo3NgTgUb4BiTiloTYL2hTI/hEH
	kpKyG3vDXAJJSCLyJ1ByoPEvljvs/A6UCka+Py9FEPZuLPgKCMpqtip5p8nJljbbbD2bJYe+MvH
	2x3ZAtq0zds0Tvd54pMJIEZQZIsDuQhs9o4N8fUaKCfVadNPSGG1Ur17mfcLwHg5SLvS8HEVqQL
	K182Zf4en77AswJ6JPvb9bcept2K5RBBc+LtK97DtPdYOHDzdxwbQ==
X-Received: by 2002:a05:6000:1882:b0:47f:5c33:5eb9 with SMTP id ffacd0b85a97d-47f6233c20amr10734959f8f.52.1784456894756;
        Sun, 19 Jul 2026 03:28:14 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-077-007-018-194.77.7.pool.telefonica.de. [77.7.18.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd1csm19863025f8f.29.2026.07.19.03.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:28:14 -0700 (PDT)
Date: Sun, 19 Jul 2026 12:27:41 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: amba-pl011: unprepare console clock on
 unregister
Message-ID: <alyjOGyTd19Obemi@MacBook-Pro-von-Karl>
References: <20260719063502.18852-1-kmehltretter@gmail.com>
 <20260719063502.18852-2-kmehltretter@gmail.com>
 <20260719070454.D6FA21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719070454.D6FA21F000E9@smtp.kernel.org>

On Sun, Jul 19, 2026 at 07:04:54AM +0100, sashiko-bot@kernel.org wrote:
> This is a pre-existing issue, but does uap need a NULL check here to
> prevent a kernel panic on error paths?
> 
> If uart_add_one_port() fails internally (e.g., an allocation failure in
> serial_core_add_one_port() returning -ENOMEM), it returns an error but
> crucially fails to unregister the console that was already registered
> earlier in uart_configure_port().
> 
> The caller sees the error and clears the pointer:
> 
> drivers/tty/serial/amba-pl011.c:pl011_register_port() {
>     ...
>     ret = uart_add_one_port(&amba_reg, &uap->port);
>     if (ret)
>         pl011_unregister_port(uap);

Good catch in a rare error path.  A NULL check alone is not enough
because other callbacks use the same pointer.

The underlying issue is that serial core can leave the console registered
after uart_add_one_port() fails. I will investigate that separately.

Karl
