Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE383BED7F
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578993; cv=pass; b=MeIbckdVykJQHfchGWyv2NWEDXO7VvOXNg/IIHPE8aj+O5AvSWMQQdYa+m4L2qUkksCTMBa1XER7yA4I2VrOMF2OAZaurNURKdHbcwx4em5MXs/eb0ddAyhY/0DQX1SYRpQ8H9YZ6m+c+rDbdANXne/5QOJG31PMlgqO9g96+O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578993; c=relaxed/simple;
	bh=RTMFMxuArwN9jelOoBB7ESiLdUnGOKJdUxXh/xMMGGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOzlWiULP4FR9ZxdE5PkZ6bgSlfzjpbdneWJ1D/ttBCAGoEOJ5XWUMMIQkpAAVXCba8eJjkPnCY/foa3M1NC4o4tg4ImrnzGrtOhwcxyJCXfus4sRCh6+tNL41oPuPk2SEMr/HXuO+M2M1LWqsr2Y3X2jYo9tYFh1sgKQqYTnrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1iPnccw; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1iPnccw"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c167aa9500dso754870066b.3
        for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 13:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784578990; cv=none;
        d=google.com; s=arc-20260327;
        b=Nf5NuaUUTwD1JFjNV33SigpiH6Aeh/INo3KbS/aBVhC2KSR8r7IYnNuUv5oeusIUz0
         C3gX6u8EobG6qx9e7UnonTUzey/FK1v7Duz9RpeKH3u1HW2oJKbuaP5XxKCTicjY9u/Y
         FiMy+YmUInas8qMAdtxBa8np7KjbIVKFq5FNm0QvObPm2miDX2dk/pwT321aMqcFVLPu
         mzvGVuQuFHmYkvVtijhXiyzVsBNY7rITbPR63kMQXqmzo254KdSHTbo4dVez+QzjfQLB
         YW+7fnMvdPOnT+mFuSux1Y3VOb3tekz0dOza29NgjAp3wsCwcAlw6h+IfC9dZo4fDBsB
         e3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U5p3cHtQtnS2cSmiUqe9etBZiOH35jMaML1hTW4v5So=;
        fh=G+UuoMG3ucGGqydwzvNnnP2hI6bvbAxD+aQ6cmKEAFo=;
        b=BWRCXSwkUAXm+3J5R+DayNuPA8xWG0nmN1QeMvkCKtmDblOT0QMqLwgX5e6E37y6AK
         Ntwpe3rsaxPHL14jIgstLxaBgN/EvwJQwf5+HYzXPWviaSvBdeivSw5FWoRltlxYDLWe
         y9n0uW4wbRucLTVbY9ViGpTQrEE+QqQCYMJlGv3v0jRBSSyouWOiESmF3EnmneqM0G0v
         3yoc6pu7xUfs5d7LCK6qOoV/w3IW9p3TA0k+tTlk4O71SKhZlbzNNk5S+QsH6yECAUWP
         uHANedJhlRrHeC+ettX7220L2S2+ruXKJjtwxIOu0PadX1milxPyIl7P00PDzhvnaH/D
         GZkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784578990; x=1785183790; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U5p3cHtQtnS2cSmiUqe9etBZiOH35jMaML1hTW4v5So=;
        b=k1iPnccwVTAdMkaX1nM6YH4EzxBbQ8RLEEGRaA5odgvx56s45Ag6+H0MLdFhFVSapp
         5gKK1ZS0XGzV3Jf8PkLQJ6BPxbTxHe1metWCMFIseym1lMq6YBwM5gk/vTTxtrPZeaPH
         oIFsozg6rVk3AOnKxmRNXykIpx2ZTDxoCwFuTGUYIEeRDAJOA02kdWnzXs6JTV/G7waj
         lFIC5ZFVx4M3hcjHIokbl9ELhImmnp9+B70HJQlPMqZsIXtHXwoeD1kWzW59LclVcFeJ
         FbfYSCQ+SsusYMsHASM/Vn7aa80XmS4hvQNVPrjhIYXg1pAgzlV8Rh27HjjBidIotOIv
         aSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784578990; x=1785183790;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U5p3cHtQtnS2cSmiUqe9etBZiOH35jMaML1hTW4v5So=;
        b=U93dYu3j4n9mrZw+BtFPaZqAH3S2NGlB6EZNEAspK1Cw6rVxQxUbfOirq/rtI1cZ4y
         j+N2NPE72gSckGHUAeNsfaWd1ygsebMOiYf5IXIG77enK/lGzRnaynMierHLWfA9/XIX
         bANXA/h4OQedpsQOtrZW58pLGeGjgWkIUs+kE9XXvPl5WqTdUM4iGoZtCkj0aZmRa9iF
         k68E3imrIu52fzHpbD55jgC0t1oclJFyPOvIKla9kDpmO6jFCs0Vo6PwgKf2LUu8FRZA
         dOVmfaQ2o4isfCOl2t41xkSMZM+YEPP1s/VytEDt9gud36uvR9G0ZYcystAIo/eUCkBP
         uQ9g==
X-Forwarded-Encrypted: i=1; AHgh+Ro/QR3vkNMfAqZkM0NgAfS6gZx+zdI0K3nl8BVQH9p6ci1NZlyS++wg+qe+ZV8pZUeFWCOI0qVw60Uh6Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YybvSDD+n3wvoDXQrKePHXYDcn5MU7d8LkJ4ArUO1HFANkWPRd8
	2QkxogRGLkON38zw2z/vu5APxC1jFqCL8L8yw8F73qD/gh5i7+xkTT93m/3J55AHWm+rEjP7rJm
	a66JNDchEr0SBKUcJB+HHQCrKYs+r/c0=
X-Gm-Gg: AfdE7cnPr5ZDAmyEX3tPsy8Gcy6fvDuSc2PIBFtpPGZMMVI5hVhVR/F7FMHaXdSmhML
	2aS4JBt0IxDGpoGawdTCkqi2zkTnXjCBGWuCA/eKfQTA39zXmK7yUJUC0myKkVuMl/O+Dt5+Gdm
	3h3Xc9KwnxPMn/L5RgV2IxnHfxcRpT4m0u/ak+Jb7ZxDkPWo27mjzq15/m6+i6aRNBjqvd3A83e
	y/xKS8ry+yyfdoF9qqQ/JTLYgx0MXsJze0/WMAXRLEjm19mNSYk5N7ysI2T0SqjA9OC+4ELxBJk
	3ZUwO+VAAL7LAdduRcomMtYuLLVjH74GFsroXTjFnM0+BD9XkSHPTdbGIA6OeSB8N1muBsdhQnf
	9IAX5M0fbD3X5K1j6ydRFtopapuKLZsQZKbtqhEEjBtW1r8s=
X-Received: by 2002:a17:907:3e18:b0:c16:82cb:36c with SMTP id
 a640c23a62f3a-c16b4878388mr701703066b.65.1784578989603; Mon, 20 Jul 2026
 13:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522101042.21976-1-fushuai.wang@linux.dev> <dnpnqx6fz4osobhi7ydt2pi6hvqb4lm5vonpfpwrl2nogpadmw@6bqiyjskjo5j>
In-Reply-To: <dnpnqx6fz4osobhi7ydt2pi6hvqb4lm5vonpfpwrl2nogpadmw@6bqiyjskjo5j>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 20 Jul 2026 23:22:32 +0300
X-Gm-Features: AUfX_mxtOFcF-lXO1FmKE2L6YVCWQGBhiXFoukdSxDl7f7nq0E5VpURnHlR6Z0Q
Message-ID: <CAHp75VcTs2Vro3vg8dqmYfRebk6bBfmJCZFBgD2KMHpTKY6jvQ@mail.gmail.com>
Subject: Re: [PATCH v3] serial: 8250: Clear CON_PRINTBUFFER on port re-registration
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Fushuai Wang <fushuai.wang@linux.dev>, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com, 
	osama.abdelkader@gmail.com, jackzxcui1989@163.com, kees@kernel.org, 
	sean@mess.org, alan@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, wangfushuai@baidu.com, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 10:22=E2=80=AFPM Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
> On Fri, May 22, 2026 at 06:10:42PM +0800, Fushuai Wang wrote:

> Seems like this patch was added in next-20261717.

0717

> I'm noticing that this patch is causing no serial output to be visible
> on riscv boards till the uart device is registered. Normally while
> booting, we expect for all the prints made before this to be
> buffered and appear post serial device initialization.
>
> =3D> booti 0x11000000 0x21000000:${initrd_size} 0x31000000
> Moving Image from 0x11000000 to 0x200000, end=3D1ca6000
> [ 161.301] ## Flattened Device Tree blob at 31000000
> [ 161.302]    Booting using the fdt blob at 0x31000000
> [ 161.307]    Loading Ramdisk to 7653e000, end 7dd81853 ... OK
> [ 161.366]    Loading Device Tree to 0000000076532000, end 000000007653d2=
5d ... OK
>
> Starting kernel ...
>
> [    0.235159] printk: legacy console [ttyS0] enabled
> [    0.238787] /soc/i2c@d401d800/pmic@41: Fixed dependency cycle(s) with =
/soc/i2c@d401d800/pmic@41/regulators/buck5
>
> Most devs who are debugging might be booting with the earlycon boot
> parameter. If earlycon is present, serial output is present, but
> with earlycon missing (which is what most distros use), I don't get
> any serial output till this point.

Perhaps it's inconvenient. Logically I support using earlycon (I have
noticed a few times in the past double printing of the kernel buffer
to the serial console). So I tend more towards that this patch
actually gives a better experience. However, I haven't given any tag
to it, nor do I object to any improvements or reverting to the old
behaviour =E2=80=94 your inconvenience will become mine :-)

Just my 2c.

--=20
With Best Regards,
Andy Shevchenko
