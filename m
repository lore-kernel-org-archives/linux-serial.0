Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.222.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793383745;
	b=jRyOxSumEK5jGfe55AzT6vNBvigMJBr43B7hglGBaBByF3yU3P4+d8T2aHdwWZUTrxeO
	 mThHRWpHBB4ROd1gpQFfGStK0FwZeaC6+vL3AkG3uTzo4owQlF3VosI8afuHTiMgVHD+n
	 ikRKxJK3dZB4UesCAvriHnYHNs0rJ6yeDvH+A47Tbee7V2fS/Sc1/j1vBEMXucgC1qQuy
	 1kThffdvLBQfzf0/f5pmUUsKreD3lSd4Iiqer+5wg/oJy1kSwHuRDTmW5s3IzyHMrmTMm
	 KF4AzaNcOaqJoX/Jq3xdUhj8iNvLRX/t9M+7A5qMYXBXq46dfbcYFhczK/OszFJhFIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zCM05k2C0awIth60s9Z4jRxjplzssn0gUpe0d+ZqU04=;
	b=UpX/kyjHIqgYAsFy3V+i50UR6t356pO/ENdGmV6gfje1wEFxCqb7XX8EVOi2BNOOBwWU
	 B8n3MQ6KV7I71L+R2tsGR0MXoVUg1o17orkW8wnnfFLHhDVoOoQfsfcVsSYOhF8vwyPF5
	 vM6spPiFlaR7WSbMcg6IgmWtUYaiICAyOT4tHe+ogiDSMhI6YS7zcyNMKICMyGq07RjAp
	 m5BhoOe8VwyVuL2ZqH8CkPunOyM9id47v0T1O3fUIaKp/0lZ6vljW7FOeW+tA4tNFbWvM
	 /KxACkRFsLpfyf3Mcv1mMZVgz8JBIC9Xz4XwpDTHQ65aPZdIH7xtTbGAYDImxcanbsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y6d0F7jo;
	arc=fail smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EC8606A321
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 18:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2EC8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y6d0F7jo
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so1924845241.0
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 11:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793383744; cv=none;
        d=google.com; s=arc-20260327;
        b=slhFLUy7S1Ckxk2RlcX5AnMbmzgPsTMlBVfWUjWoVPN5/DTNERIsfNAhx0lWW7j4JI
         OHSTpkTySUHxl4brR+ncSTe/Dcb7cRIccyMo/s/9gMhEIKz8S99R3ruh6tbs/7i34KXK
         bNRnu2gL9VAhSbbnZhawwkcG/pdB0FsUs6Rp63k5XpJz7vmbCvi1AXsU8CWkIUrarRxp
         k/t2UQpAv0t7+yM8Yn9ReV4VgT5Dp7JcYVMWhFXBQVDACxV6fNWmkK8L8MKGbQImNBIb
         BG/Ej4eN2DYzH4hK8xRrU0Fw9HqI8c0jQa0nVbv/3BK0A0InnX4wCHd1Pi/1Aq0CKr3S
         NtDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zCM05k2C0awIth60s9Z4jRxjplzssn0gUpe0d+ZqU04=;
        fh=CQ3liGbrxoYzTy1FNEZvfa9G9X0ZdEraTMtBFTlVTDk=;
        b=dWtHaW53KqQP7rqZRjM2faGQeGed57gAdduGKIQ2wSgXSDivqUEvCA1W5WKeTX9vEe
         8IGtu0eW0HMJcstlaUqJgD7KThPPMzlPvjxKxwUjdvDhEcrD/2UrdMlXsFRI4ybCKL64
         gRGBiYkjNRX+1aoQ+ysxZPpBi0ThQy2e+5pYuCyY4i5vTHovUnzwSLuRcN9ZfgyURWNZ
         0Y5flTpsCNJmQDeJWDPwMmCcw9AJHQ5hXBX13c2NBNp5Awi/C/szG0pk5wUifnPw/5TV
         UB8y6SLAJlTJhhW2ZrrTyovAJBFoC0bEz0jbLbJNzYlOirigYQi7PhG4nIXmbaxWjo6a
         5ISQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793383743; x=1793988543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zCM05k2C0awIth60s9Z4jRxjplzssn0gUpe0d+ZqU04=;
        b=Y6d0F7joUSae8PapTk6Km5L3QXiHXvGNI5bavYI7EHmrkB3vAxwC1wtFDdZPhmU9uF
         J9n8gkUbWTyWFe6MqEKCp3bk+yIJSk6VIJWId/b+6QX70NMAYdlkh2SvKdTjxrAALdul
         5V2Png6tfbTWj1SQYYks6G+w9qrDuqrEox0wfr+cjMzTKSrJ4n8ujKavhGrNJU0sELKo
         dbVtNXqbDrJzqrNqhkbm02eSHsIBGYWLpBIFTZvyp55nKWhNp+El0Rr0jGD1KlgJjfIy
         0JdSSKNIsONQmjkaAXL0t+UJK9QyEU2MKbdinjBYc9iHzlUrvRFZaBZSdkbfQWO/g+Cl
         h2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793383743; x=1793988543;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zCM05k2C0awIth60s9Z4jRxjplzssn0gUpe0d+ZqU04=;
        b=PtgOjUDDgvZZGk7H23GnUGJfpSoumKaszljfqrgdtVvZ9WwGeDYSIy7loB0/OU2T1S
         pEZVpa0QMIik2aHthnSVXz08twTcRyM+fTLScRYw1cVIbzTNeMLA9tHcVRlEphGtdoTl
         BKqPbN6KptrWtN+pteb+37478aubKSi/jq6fCWpdit8o3+YCjL4XjhMvIQGoQc3m+FVv
         2UNj1yk1fLzDC4uRvH5mJUGAnAN4ffT/VvN+mQbOPUQC8yXTSPBPs15kOCljHIQMKXHx
         TnlLo5V3AhabL39PGELAGkopJoeoAa4fnfgtYb8O0J6hrRbZoejDlqiLYrx6AZGGOrIO
         3qlA==
X-Forwarded-Encrypted: i=1; AKwUvBwKU/KacOTNZzrmwLjYNT86lw/0/wlfXNsOMWAfLsHmgnmQiHrVyTjzSyaXgCLPkiIHlzGACvA+Mf2T+2Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGv2x0tRttg3tAPxLAP/U6PMPQrI3YYWeBvGGcp4AukVOSuuO9
	zwhkrVVOOs9Sik0Z66KsLJ5IvUtpOEmw2RWxK/+cU7nf7hwGCnSO7D3pejt5NF3XC9IWCuOblT9
	OOw2n3BQUfZFHx6JBxYWfkbQQceqztvQ=
X-Gm-Gg: AYBFou36vdEFVfZWoT1/b6nQQY5wKcozlYPB4MU75s7Qk4DczaVqaTslc7Fc/aP5JrX
	ai6rKHnrWw36/csbO1IwRXUozLNVONUSB5PT6TinqX88/S5SvoUdvKYpOl29hCD4/6YPb9RAJdq
	1Wvs1QQkzg9RH3TCR17hGHMlNeX1n8FY8d4HDvNTBmG2ROYYv70P4PxTzut4FkdiiIBfysuQbBw
	4eFsN9Fo443n7h0A0BfZ8NlfFlnnsGpVSs4qfOjFUsZmze874E12VM86Sj9nRexLnwe1sb2hwqR
	9+bSALCKVWh38kQZZJmHXO/n5dZVa133YzqsUcTY+cyXyjrCip4QjaLsHDTy9D9WWNps0g6bGpF
	dosRz7IUSsMjBTH7+gv01oJuwomGtlYE7mhpOInymb62n0QHmOej24yUb2AONgZomx3/bMehnpY
	8lfJObp6Z06uAtYWZTkLM7ueo53+qXROur8W5BwAkoWkJcc272wwPOqIPpQSRbKAIIejwpylryg
	lUj5YFfxg4nCKxLn0I0BDyyuFnz0w==
X-Received: by 2002:a05:6102:e07:b0:7b3:9d2e:c1a2 with SMTP id
 ada2fe7eead31-7d0543af600mr2250112137.42.1793383743550; Fri, 30 Oct 2026
 11:09:03 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com>
 <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local> <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com>
 <auRl9ztbav4nHi7U@ashevche-desk.local> <CADvTj4p8tjwdftg+H11ob0iaBZKxXrTdkSmhfZHjOYunm5tr9w@mail.gmail.com>
 <auTZtteCFnuoMD3p@ashevche-desk.local>
In-Reply-To: <auTZtteCFnuoMD3p@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 30 Oct 2026 12:08:52 -0600
X-Gm-Features: AclHuK8c5dKv2-dU28EFYCOPnAfJ1MA-zFVMtXg5QQ7p9buAg8gKSWCKNovPJxw
Message-ID: <CADvTj4rXXAEnTyu_AzpF41a2YSHHG1ANozCUSePBoH3QZYbBQg@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] serial: 8250: retain DMA resources when
 termination fails
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Raul E Rangel <rrangel@chromium.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Tony Lindgren <tony@atomide.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Timur Tabi <timur@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 11:54=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 30, 2026 at 11:09:53AM -0600, James Hilliard wrote:
> > On Fri, Oct 30, 2026 at 3:40=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Oct 29, 2026 at 11:19:59AM -0600, James Hilliard wrote:
> > > > On Thu, Oct 29, 2026 at 8:24=E2=80=AFAM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Thu, Oct 29, 2026 at 01:37:02AM -0600, James Hilliard wrote:
>
> ...
>
> > > > > > +     while (rx_ret || tx_ret) {
> > > > > > +             dev_err_ratelimited(p->port.dev,
> > > > > > +                                 "DMA termination failed: RX %=
d, TX %d; retrying\n",
> > > > > > +                                 rx_ret, tx_ret);
> > > > >
> > > > > > +             msleep(100);
> > > > >
> > > > > Huh?!
> > > > >
> > > > > > +             if (rx_ret)
> > > > > > +                     rx_ret =3D dmaengine_terminate_sync(dma->=
rxchan);
> > > > > > +             if (tx_ret)
> > > > > > +                     tx_ret =3D dmaengine_terminate_sync(dma->=
txchan);
> > > > > > +     }
> > > > >
> > > > > This is unacceptable. Sleeping is okay, but value should really m=
atch the
> > > > > baudspeed and other parameters of the transfer.
> > > >
> > > > This sleep is backoff after dmaengine_terminate_sync() has returned
> > > > an error, rather than an estimate of UART transmission time. Each
> > > > retry asks the provider to stop the channel again; elapsed time is
> > > > never treated as evidence that the resources are safe to free.
> > > >
> > > > The particular 100 ms interval has no hardware-derived justificatio=
n.
> > > > However, I don't yet see a sound way to derive the retry cadence fr=
om
> > > > baud rate either. RX can be waiting for input, TX can be held by fl=
ow
> > > > control, and callback retirement is a separate requirement from
> > > > moving bytes through the UART.
> > > >
> > > > Do you have a particular provider failure mode in mind where retryi=
ng
> > > > termination should follow the serial transfer timing? I'd like to
> > > > base the interval on the condition that can make termination succee=
d,
> > > > rather than substitute a wire-time estimate for an arbitrary delay.
> > >
> > > Termination of DMA sometimes require to clean up internal FIFOs and o=
ther state
> > > machines. That's what happens on HW side. In the software waiting for=
 too much
> > > may lead to the very big undesired latencies. The value of 100ms soun=
ds insane
> > > to me for the HSUART cases (megabaud range of speed). Also note, not =
every PCB
> > > design uses HW flow control, so this may be even worse for them.
> >
> > The 100 ms interval can add unnecessary teardown latency if a failed
> > termination becomes retryable much sooner. There is no hardware-derived
> > justification for that particular value.
> >
> > The FIFO/state-machine draining is part of the provider's stop sequence=
.
> > For example, DW performs its FIFO-empty polling inside
> > dwc_terminate_all(). If termination succeeds, this patch proceeds witho=
ut
> > the retry sleep, regardless of baud rate. The sleep is only reached
> > after an error during DMA release, not during normal RX delivery.
> >
> > Baud rate can influence how quickly a transmit FIFO drains, even withou=
t
> > flow control. However, the termination error does not tell 8250 whether
> > that drain is still progressing, how much remains, or whether the
> > controller needs a different recovery operation. That distinction matte=
rs
> > when choosing a retry interval: a shorter interval reduces the added
> > latency, but does not establish that retrying can recover the channel.
> >
> > There is also a specific API detail here: dmaengine_terminate_sync()
> > returns immediately if device_terminate_all() fails, without reaching
> > dmaengine_synchronize(). Consequently, an error leaves callback drainin=
g
> > unconfirmed as well. The retry cadence can change, but resource release
> > still requires successful termination and synchronization.
>
> Most likely this is AI slop. I can't see the justification for 100ms.
> Can you explain that?

100 ms was an arbitrary backoff to avoid a tight retry loop if
termination keeps failing. It was not derived from the baud rate,
FIFO depth, or a DMA provider's recovery timing.

That motivation explains sleeping between retries, but not choosing
100 ms. I don't have evidence supporting that particular interval.

>
> > > > Regardless of the retry interval, shutdown cannot release the buffe=
rs
> > > > until the provider establishes that DMA and its callbacks have stop=
ped.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
