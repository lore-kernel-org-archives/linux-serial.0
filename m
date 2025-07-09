Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395742D9EF5
	for <linux-serial@vger.kernel.org>; Wed,  9 Jul 2025 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752063951; cv=none; b=RTTAN+opf2jXMe19hCWxvexZsa/qI3lksJavD0Q/nJW2bO6kdJ13v+DsS9SA8TohLgccD9okLEVQWDR5aUwUjk+qNiMGFdgYtGzj932MG8vTUfjcbjQsrvxtIqNPCL4EepVHzVwO2WtNzc5Bt3RHeshlMiSRkelQfI0/G/kU6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752063951; c=relaxed/simple;
	bh=wb22XIikD2qATxWdRxTA3iHhTy4uPTHwNH1Z3aIBhaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpWASnL8qUNBeOHzG+8ATjXXOSEd5Lai/ftDXcSBNdGINMSQGXNOI43QS0Ej2cycmJJ1X/Cl8cRezFyEdA45Lxs2Hd1PI9KiMXeBsLUzOAi8FgvghRLvsKOA93AA6VYJgrKzo5P/zFfwnOp/+ojsE79WHIj2uZjXr3i1jbLgMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XiqhXepX; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiqhXepX"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-315b0050bb5so3908413a91.0
        for <linux-serial@vger.kernel.org>; Wed, 09 Jul 2025 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752063949; x=1752668749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S/q7TshKKoT7nXGacRLVg39PUcU9ha1HeRSUxDk9nqI=;
        b=XiqhXepXn0fEjeU4tmuOgqv7YqcMSaCduiCGHfcqz1fz5fjbftcgf3429eZyTDgS+D
         gwBpwOgam1U3ucJmAXuO5udqNNKxhDahphTW7AFbFLJ2ZTMhq674zLf5z9YkDJKjJMMf
         PrUeSYWx5s+k814p8EOOwOogGiaqg7mtDywz8O5TzZ9i+8Qsrlw+kdciiaHTvPh6L/Al
         Apv5R2yVvqTfthL5UK85FSrY2Xsyj7yj0C9sgrbY3huWMv3eizjAOSR1UiZL5ss/hNhG
         U4Fngs16HQl8pB2jdFZA6gXeR7DmHWZK6/75Sz27Pz2oMTpRbqv0IIHtOOu51IpLbnP2
         fxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752063949; x=1752668749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/q7TshKKoT7nXGacRLVg39PUcU9ha1HeRSUxDk9nqI=;
        b=ACPGkGHkDqpOzW/ZlDD30iS2N0C9xi9CfxyBuFNYX69g3l+3PnsMuL0eb2gJzYmWfP
         MLWKVXlau7slHlKjpyFpBFgoazlmsqJmMUTkjWBCpQ42g3UKI7EhdjOieZLMb1MGX7+u
         3RZilTi8Fu33aorH87G0OJqbzJaipz995vEvVd+/mLhPhLnVUq3stButeAlMBmdAGXrG
         hA5RkT8uGj3XPOqNStk3Ahw6M9okDLBqALE6DfuofMqyBhGypIwCZDBbwX49zfb/Y/vx
         CboVJd/c06i3+JQiGEpSrrUiI5hmJ103OpLftfkttfpM9id3nQwi51CfUJs1C7AxNbnO
         QmQA==
X-Forwarded-Encrypted: i=1; AJvYcCVjVOwRPAbSAZpw36N2SqTLYdz47UfoyrBpn1hr6wN8pBwhZ2EKZiBQY6irBxO0AhkTth6SHjuTWpBObQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9ncduZRkBuZzPMLnMfrGTYiPvpTnsNK4i5PsIkeVXrGoxk/s
	7KqCOh8b0WoM3Mfx6NzFEHaBlGj0AHZCWPJhbryMfwPiHOaCnxjYUCwD2VIF/Iln29qrG1l3lo8
	TbFpskL04q0T0cQl5CRoFqEQPdIwTP6FvK2yIhZpCoA==
X-Gm-Gg: ASbGnctxoEXE45nTHEjsuLtp4wOdqjTNOMBGay5quxb7ghG4S6czOL5AJ/lmfzzZZTv
	EZcpXU5XSw5Cq7+TRswYgxPi8Mm1df4VC0N20gwDhs9OMaG+T7YbUczj41AiV8jorHF1BwiefB0
	VhNMFZThrmiC/ppSgcgHg9ECZoAqwEi9Z7/KTvDvQTtFut3Up8l4RrRO2VRp1bZSBZnYqsgl0wb
	nPP
X-Google-Smtp-Source: AGHT+IFcpLtOMbOqJ/FkYbFJ6ZieYCRLYBJIVZAFvoK2D08JwArVwDsz9XqCBlbkUqhACkrjBfuJcYeD1mdTmH+qlOM=
X-Received: by 2002:a17:90a:f6ce:b0:312:daf3:bac9 with SMTP id
 98e67ed59e1d1-31c2fe15c5cmr2399918a91.34.1752063949445; Wed, 09 Jul 2025
 05:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtK2TLbpo-NE-KUXEp0y8+5zXNVRFkqdMjaGgcNFFG77g@mail.gmail.com>
 <2025070924-slurp-monetary-a53f@gregkh>
In-Reply-To: <2025070924-slurp-monetary-a53f@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Jul 2025 17:55:37 +0530
X-Gm-Features: Ac12FXzBT0KHq5ReF1wh3qeMehbB0fUcTYzXrsEznaZ3aV6CJ3ajCFVqPCFB3rg
Message-ID: <CA+G9fYurLq9o_PSbQKCOmSkQfa5-qtAu2HR1PzySBmJM4C4F3g@mail.gmail.com>
Subject: Re: v6.16-rc5: ttys: auto login failed Login incorrect
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-stable <stable@vger.kernel.org>, 
	Jiri Slaby <jslaby@suse.com>, Aidan Stewart <astewart@tektelic.com>, 
	Jakub Lewalski <jakub.lewalski@nokia.com>, Fabio Estevam <festevam@gmail.com>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

+

On Wed, 9 Jul 2025 at 16:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 09, 2025 at 04:26:53PM +0530, Naresh Kamboju wrote:
> > Approximately 20% of devices are experiencing intermittent boot failures
> > with this kernel version. The issue appears to be related to auto login
> > failures, where an incorrect password is being detected on the serial
> > console during the login process.
> >
> > This intermittent regression is noticed on stable-rc 6.15.5-rc2 and
> > Linux mainline master v6.16-rc5. This regressions is only specific
> > to the devices not on the qemu's.
> >
> > Test environments:
> >  - dragonboard-410c
> >  - dragonboard-845c
> >  - e850-96
> >  - juno-r2
> >  - rk3399-rock-pi-4b
> >  - x86
> >
> > Regression Analysis:
> > - New regression? Yes
> > - Reproducibility? 20% only
> >
> > Test regression: 6.15.5-rc2 v6.16-rc5 auto login failed Login incorrect
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > ## log in problem
> >
> > runner-ns46nmmj-project-40964107-concurrent-0 login: #
> > Password:
> > Login incorrect
> > runner-ns46nmmj-project-40964107-concurrent-0 login:
> >
> > ## Investigation
> > The following three patches were reverted and the system was re-tested.
> > The previously reported issues are no longer observed after applying the
> > reverts.
> >
> > serial: imx: Restore original RXTL for console to fix data loss
> >     commit f23c52aafb1675ab1d1f46914556d8e29cbbf7b3 upstream.
> >
> > serial: core: restore of_node information in sysfs
> >     commit d36f0e9a0002f04f4d6dd9be908d58fe5bd3a279 upstream.
> >
> > tty: serial: uartlite: register uart driver in init
> >     [ Upstream commit 6bd697b5fc39fd24e2aa418c7b7d14469f550a93 ]
>
>
> As stated before, those are 3 totally independent changes.  Any chance
> you can nail this down to just one of the above?

You're right, since this issue is intermittent, it's challenging to reproduce
consistently. Pinpointing the exact commit would be ideal, but it will
require more time.

>
> thanks,
>
> greg k-h

Thanks,
Naresh
