Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241F413C3FA;
	Tue,  7 May 2024 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089519; cv=none; b=FWZAAy6qqaZMtIVfao3sFK5nbegYk1PsvUpIiIIQz+srILGahO4RoXee7H8RrccKIbf2goRUsTb04yobBST7s5Ai9Uu0pW31dZMQpLJm4fi/bWl9q35f/hR/6kpoFl/A0c9vWw8wpZllO4LHc53KYf4mMq0YFQaQTVVLs8Y42Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089519; c=relaxed/simple;
	bh=qDeG9dx9lt5c7t8P0BjaH9qK5jjsQtKxyHWfXhGiW8s=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 MIME-Version:Date; b=qQfnItR9Ip1o6a2iFZjkB2LfolWO+0OHma5Ln1GUGX6twjWmtYBwE76g0xBnTAMIFySuIoVrTpGEoAIb8DD6fTMCr7ICtToV3WLdEcifblFgPusCRv2JXfWn1dAkBJtU/GTE3yvFMzEn3MAej+wlwqFKGhEMvgm2LJwGoBLcGAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lv7nDSs8; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lv7nDSs8"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f460e05101so1970285b3a.1;
        Tue, 07 May 2024 06:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715089517; x=1715694317; darn=vger.kernel.org;
        h=user-agent:date:mime-version:content-transfer-encoding:references
         :in-reply-to:cc:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rmsg9tzz/nOWQcim8zIXBGX0XtaHp9tb6wgcsuwC3pA=;
        b=lv7nDSs8ikADUE7wkCACEiKTsh1J4DOpZqf/pz3Mh1cf2YGLLOBnQBplEeCFKL5rgR
         8HogO26C10M+ddy/smcEKO1WbGSEt0RCUywRs261gr/3Mk0DK67+Pia+wUgkdyAlECPK
         UIsddo23A/KzhRYOyXC8iWNg0IiLYLgpeHnOWtwPVmK+oNoK42NhfXPognqGmZiGxNKv
         Z7+4x/RTe7CidCGfzpabpZ6lqcZV0Mk+DgJ6vj9cyuz0gwOyrMuu6PJEZZsFIBtcRBuB
         kLtdB3HTitdu4WSBKybeGorI+Bmhdb1czrEM3JHrTNbWOK6C41de+fcR3d7d1R8FC9mr
         pEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715089517; x=1715694317;
        h=user-agent:date:mime-version:content-transfer-encoding:references
         :in-reply-to:cc:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rmsg9tzz/nOWQcim8zIXBGX0XtaHp9tb6wgcsuwC3pA=;
        b=QsUbjCmZtj01krGnqZIYe60SLNU70eBnJ2osHgKXaX1ZRGKL+rNb69Xd+ZoVTZpauA
         ek7TQt4o54htzeiEKpba6j70ftNMFP53jyYWBrhIcKlkqG+HcQAkKiSfphd6obkxi3Ky
         Qnwsus/Q6r328rxTEPU8/Ml7erkqMUtSruZBHHUGc2+YE9TcJTthcPKFKAwupbx1uWIn
         buIq8P0c37+Fkxo5WoiXZn9UKhDBtTLCS4Y7DKr+RY667AKAcaSMRJzJ9J2FzwIvADMg
         cQ5pYogZEQdpZfjrVXAKU7H5PNFpLFof0VIJ2nmylVXrXj9Llzs7UUy6m/2Xo+S5SQru
         UhMA==
X-Forwarded-Encrypted: i=1; AJvYcCVTlyVZJ0qRtrW/mvvgt2x3ukhQHdqlm1NmbfDgW5knGOxDgS2aI7k0AebHH/65925+3g4f13YzM6ws4024x63D8JKOHXHgTiQHdPzUKz7yDiUdAgp7R0wdPnFubsB5MTu6ixwUgMGgPCATvWFBMg/Txg==
X-Gm-Message-State: AOJu0YwJDVkrXnK0aszDNs2oy633xyaDH8ymNgcLAKa9WT6hhZ/19t41
	p0TlUP0jirkffxIp0eA3a98n1b6RNpcqXxgrTMR8hz5LMsPk4gBpHDcihb8B
X-Google-Smtp-Source: AGHT+IEJOXFBZ4UXVvnaeb8oyk+NSCzXQw3reEOu9bZWmig3BkB0fWH3TBux41kzK69xZAwyIeGrYA==
X-Received: by 2002:a05:6a00:6385:b0:6f3:8468:8bb with SMTP id gh5-20020a056a00638500b006f3846808bbmr3591550pfb.17.1715089517238;
        Tue, 07 May 2024 06:45:17 -0700 (PDT)
Received: from [192.168.5.213] ([101.229.120.80])
        by smtp.gmail.com with ESMTPSA id g2-20020aa79f02000000b006f46eb9d809sm4541641pfr.126.2024.05.07.06.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:45:16 -0700 (PDT)
Message-ID: <020e8afb18421d740ed71b640ffc803c7b51bd63.camel@gmail.com>
Subject: Re: [PATCH v3 0/2] Defer probing of SAM if serdev device is not
 ready
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org,  linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Maximilian Luz
	 <luzmaximilian@gmail.com>, Tony Lindgren <tony@atomide.com>
In-Reply-To: <85ac363b-d129-4525-89aa-d4528b8188a7@redhat.com>
References: <20240505130800.2546640-1-weifeng.liu.z@gmail.com>
	 <85ac363b-d129-4525-89aa-d4528b8188a7@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 07 May 2024 21:44:42 +0800
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 

Hi,

On Mon, 2024-05-06 at 16:41 +0200, Hans de Goede wrote:
> Hi,
>=20
> On 5/5/24 3:07 PM, Weifeng Liu wrote:
> > v3 changes:
> > * better formatting, nothing special
> >=20
> > v2 changes:
> > * resolves Andy's comments
> >=20
> > Original letter:
> >=20
> > Greetings,
> >=20
> > This series is intended to remedy a race condition where surface
> > aggregator module (SAM) which is a serdev driver could fail to probe if
> > the underlying UART port is not ready to open.  In such circumstance,
> > invoking serdev_device_open() gets errno -ENXIO, leading to failure in
> > probing of SAM.  However, if the probe is retried in a short delay,
> > serdev_device_open() would work as expected and everything just goes
> > fine.  As a workaround, adding the serial driver (8250_dw) into
> > initramfs or building it into the kernel image significantly mitigates
> > the likelihood of encountering this race condition, as in this way the
> > serial device would be initialized much earlier than probing of SAM.
> >=20
> > However, IMO we should reliably avoid this sort of race condition.  A
> > good way is returning -EPROBE_DEFER when serdev_device_open returns
> > -ENXIO so that the kernel will be able to retry the probing later.  Thi=
s
> > is what the first patch tries to do.
> >=20
> > Though this solution might be a good enough solution for this specific
> > issue, I am wondering why this kind of race condition could ever happen=
,
> > i.e., why a serdes device could be not ready yet at the moment the
> > serdev driver gets called and tries to bind it.  And even if this is an
> > expected behavior how serdev driver works, I do feel it a little bit
> > weird that we need to identify serdev_device_open() returning -ENXIO as
> > non-fatal error and thus return -EPROBE_DEFER manually in such case, as
> > I don't see this sort of behavior in other serdev driver.  Maximilian
> > and Hans suggested discussing the root cause of the race condition here=
.
> > I will be grateful if you could provide some reasoning and insights on
> > this.
> >=20
> > Following is the code path when the issue occurs:
> >=20
> > 	ssam_serial_hub_probe()
> > 	serdev_device_open()
> > 	ctrl->ops->open()	/* this callback being ttyport_open() */
> > 	tty->ops->open()	/* this callback being uart_open() */
> > 	tty_port_open()
> > 	port->ops->activate()	/* this callback being uart_port_activate() */
> > 	Find bit UPF_DEAD is set in uport->flags and fail with errno -ENXIO.
> >=20
> > I notice that flag UPF_DEAD would be set in serial_core_register_port()
> > during calling serial_core_add_one_port() but don't have much idea
> > what's going on under the hood.
>=20
> Thank you this explanation + Andy's questions about this were quite
> useful. I think I have found the root cause of this problem and I have
> attached a patch which should fix this.
>=20
> After dropping your own fix from your local kernel you should be able
> to reproduce this 100% of the time by making the surface_aggregator
> module builtin (CONFIG_SURFACE_AGGREGATOR=3Dy) while making 8250_dw
> a module (CONFIG_SERIAL_8250_DW=3Dm). Although I'm not sure if the uart
> will then not simply be initialzed as something generic. You could also
> try building both into the kernel and see if the issue reproduces then.
>=20

As per your instructions, I

* removed my fixes,
* built surface_aggregator into the kernal,
* built 8250_dw as a module and
* removed 8250_dw from initramfs as well,

and found the occurrence rate of the issue was around 30%.  With your
patch applied, the issue disappeared completely.

Tested-by: Weifeng Liu <weifeng.liu.z@gmail.com>

Really glad to see the final solution in serial core for this issue.=20
This might also help other serdev drivers.  Thank you all.

Best regards,
Weifeng

> Once you can reproduce this reliably, give the attached patch a try
> to fix this please.
>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
> >=20
> > Additionally, add logs to the probe procedure of SAM in the second
> > patch, hoping it could help provide context to user when something
> > miserable happens.
> >=20
> > Context of this series is available in [1].
> >=20
> > Best regards,
> > Weifeng
> >=20
> > Weifeng Liu (2):
> >   platform/surface: aggregator: Defer probing when serdev is not ready
> >   platform/surface: aggregator: Log critical errors during SAM probing
> >=20
> >  drivers/platform/surface/aggregator/core.c | 53 ++++++++++++++++------
> >  1 file changed, 39 insertions(+), 14 deletions(-)

