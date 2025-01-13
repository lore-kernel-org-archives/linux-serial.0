Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D001F9A99
	for <linux-serial@vger.kernel.org>; Mon, 13 Jan 2025 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736805256; cv=none; b=gFuOo0SSqutyRK314hi9fMCmCsw6JQgDYhtLdA92GaK7bJHm+k8r7k61lUAg87LM3NHzqQFqY1gLpVKOjvuG6VmaTeMdlZ6iSWBwSaLWHyw2i2qL4Nst2LJoEua6mMvTaigqtlNIysO3U4rFFdMFxe/bk2T6SH09sv0pT6VCHBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736805256; c=relaxed/simple;
	bh=WxxMtCkCrXU9YnOfoi/qrBGnMuq70LEjsmu9uQtbCOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i03gMCmPjT23FTCIwPcxCF1DumQi0jGNN4MbUqo83rerIQqRMq3V9X362tITKNZGohRHU5rQjX+beZq2o0NDheCSKsnaxz3d5HUwPnLtgeg5ZkAmRjCigZl8cVE35PGUn+sCIKoqRrEbPwBREsQdQxh5mWxv8fYrbYNrvKFGdLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HS/PwBmq; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HS/PwBmq"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso6899168a12.3
        for <linux-serial@vger.kernel.org>; Mon, 13 Jan 2025 13:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736805249; x=1737410049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlhGBN9woQSdGnzV8x96ogtBqQuC9g0JDu8YvjYCsss=;
        b=HS/PwBmqXZjT4T/ylYrdiSqhd28RuVTevzGjWk5PwIJSAV+mCSbg70IwwivNLcVkBg
         Byi/CukuNnk8cAsZTcD06saGJdIbiOlPJhNdbEESE8aIVp+/N0gI4Ns4/f3JUOEFS5Xl
         ZjxVr4tj1g8uDOX0Ko6KfaqvxtPR9w9/+PbZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736805249; x=1737410049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlhGBN9woQSdGnzV8x96ogtBqQuC9g0JDu8YvjYCsss=;
        b=XURb1G87gGUCPNdRn/U03CWGUOiUm9Lqy0T/889fQeMGVx/OZTIvyVftkH5B1FCq9/
         ixQarP8f+T77s2vFWKneGgnJ3C/4HEUPFBHu2iIoesWIpuuQDYhJ2/8TxoDITYj7KtGx
         zR6FutLd9uF2CnrlU2l+6hc8UHAabx8ImEJzAcs7LWt8AQJEFz9B8yuPOAn0ZM2h9x4E
         gdI19J0G1iDQQ6h19JRh/XxryzBX33CLubLjObbHS1GnH+MF5a0EWfCz/AP7bR+Jv4gh
         UIjMBIvODY+/0+AjNSAVZQJl2bE2RzQdDSwTT/bpckFp5NcgPpD+FubX1JGzK1PqQzwE
         TIwg==
X-Forwarded-Encrypted: i=1; AJvYcCWWlD8+CRiB5CngaR3JUImKL3DO0eq1y11Gm1uWnGK+JpmP2fe6ZOxbOjG6/yuHXUmwI9TlzYI7JhHYbQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNC6wiDs5EriwwEezXfhjrHlatWtJHGrvg+OBbd3mC488cuXlX
	ubPV+yXDWUBsvkN98fPF97828HfTyqLe6YieGQD3zVIYRw/1D696koFmr82QpcS04eUOxCYDW/r
	lKl1h
X-Gm-Gg: ASbGnctlp+/rnZKNRyCn0HphQ2ujBK71heHcTaf0PFDkuR4wU3PXJHU20yvGPxqGxu4
	u7EUrvTHl/U8Szqf/CvLEJVp7ks82vd2uyEgNWPNTkd2wmzr6LChG9GIlgsf+/LFBJRT5lon43O
	XYNJ1X/m/+1eUYrWzDkka+0kREFjr3LskjGGlQOkiBoNhQdsWv5Rn4wIXRyYPlyhxzxM6Y+f0J5
	3KWv53TwdULbwkabKmz4QwSqlmUdyIZsRdpZO8q2KvpAQERa6jryZDUsxEgF4E3tqhcoAnu6Pb8
	NwrN8GOGE2k902AOCTRe
X-Google-Smtp-Source: AGHT+IHE/P85O4ut1ge+VUE47rd5+66q8RtviikmMfNWoYk/wXB9ojtbASPhekqEJ6B7Ka+VceSzDw==
X-Received: by 2002:a17:907:7ba8:b0:ab2:f5e9:9a27 with SMTP id a640c23a62f3a-ab2f5e99b6amr1094448366b.28.1736805249164;
        Mon, 13 Jan 2025 13:54:09 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9563b06sm554151866b.100.2025.01.13.13.54.08
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 13:54:08 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3863c36a731so3477218f8f.1
        for <linux-serial@vger.kernel.org>; Mon, 13 Jan 2025 13:54:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjtIlILSql6/mBIT6Mu6syfym8DSXajuXQSMuwFfEHrliPQd98gQYdD76vzzyfTARg7L2+1onn2KfY/7M=@vger.kernel.org
X-Received: by 2002:a05:6000:1447:b0:386:1cf9:b96e with SMTP id
 ffacd0b85a97d-38a8733d452mr12466935f8f.55.1736805247997; Mon, 13 Jan 2025
 13:54:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112135759.105541-1-linux@treblig.org>
In-Reply-To: <20250112135759.105541-1-linux@treblig.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 13 Jan 2025 13:53:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VH5YWfTggGNt2KLoSPKqVTmWArEgccok3uFQ5BCA7cNw@mail.gmail.com>
X-Gm-Features: AbW1kva2TviXMYhxyHpnGtNBY4aB7CXv_b9DnL121HpWNrJodi84o5E5d9nFw0s
Message-ID: <CAD=FV=VH5YWfTggGNt2KLoSPKqVTmWArEgccok3uFQ5BCA7cNw@mail.gmail.com>
Subject: Re: [PATCH] serial: kgdb_nmi: Remove unused knock code
To: linux@treblig.org
Cc: jason.wessel@windriver.com, danielt@kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, linux-serial@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 12, 2025 at 5:58=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> kgdb_nmi_poll_knock() has been unused since it was added in 2013 in
> commit 0c57dfcc6c1d ("tty/serial: Add kgdb_nmi driver")
>
> Remove it, the static helpers, and module parameters it used.
>
> (The comment explaining why it might be used sounds sensible, but
> it's never been wired up, perhaps it's worth doing somewhere?)
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/tty/serial/kgdb_nmi.c | 101 ----------------------------------
>  include/linux/kgdb.h          |   2 -
>  2 files changed, 103 deletions(-)

I guess this functionality was supposed to be added in a later patch
in the series? I see a use of the call here:

https://lore.kernel.org/lkml/1348522080-32629-9-git-send-email-anton.voront=
sov@linaro.org/

...but that never landed...

Is the answer here that we should just fully revert commit
0c57dfcc6c1d ("tty/serial: Add kgdb_nmi driver")? From a quick glance
I also don't see any architectures that implement
`arch_kgdb_ops.enable_nmi`? I guess you'd also want to revert these
two maybe?

ad394f66fa57 kdb: Implement disable_nmi command
5a14fead07bc kernel/debug: Mask KGDB NMI upon entry

I don't know all of the history here. Maybe Daniel or Sumit do?


In general I've sorta given up on the idea of trying to run a serial
driver at NMI priority. I know Sumit had some patches for that where
he wanted to interpret sysrq-g at NMI time, but it always felt a
little fragile (and I guess never landed). IMO, having the serial port
be at normal priority level is nearly always enough when combined with
a watchdog that can use NMIs to break into a locked-up CPU.
