Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194F51EE14
	for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790196110; cv=pass; b=FZeE5U/8L6uMC46BAxo01tyMumWwiqJ+140WXgGviUpJkMafWa/0CPbkDljNQd1E3dHhRTs1SAD5EbXE+L++hUxaLoOgp6AGNw8SdmSRR7K5CmmMT0vKNy4P5dDLTNJv7JBE5Ax/hTqJtLpoRDP2wE3G6i4zMOEWNJYWhymEoD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790196110; c=relaxed/simple;
	bh=Lo63KNDxHLfQPbHehQEJ2TckClhkCTu4ZWquj/U3zkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5MX7stXuBabRgO7THoie8l3JfwpzXo3wD9WGw/5Xkd27lwMQ2YPSMkZ6ZVMjQYoWl57K9QcDwiLgXgFKMw71ajo1eLy8CwRVl5cllp1oRtS2rA4+p1lG+bdTTq3I78l84lVpOf1/vUmF/MpuKPbyzxgZAN0CR7euEQjuo2M1A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KK/8AOIN; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK/8AOIN"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc4c08393dfso961786a12.3
        for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 13:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790196107; cv=none;
        d=google.com; s=arc-20260327;
        b=esMQ/1EAQNebqqHm6RNybeRi4WgPRn3o3YbAjGBH3AfI7PcD0X9LSQqBP8N4DuHTIo
         QyJXE4b2ACgzczJMwlY+GSKBqyNDXmW0QRVQLpLs+NaTVlR8RaEkgDhwtSnavJruEFSQ
         +DCWwDlXkJ/Tf4fy1vbzokTtAlAbNwv4RNx5ZODZxxBDmgeJSwknlcmqBQ5iYtAwxmaP
         3ke4QTGEU1xJj7Icw+v5PWLXeVsY/kSTmMlTDPuqckB29ltWXovGAThT3ot0QH1RxFqQ
         5KfJCPAZQEO7K4mp/r53Bw92cRGf0n6V0T85c2wmJYBFH24LXbXnhIwXKxtsWDC57Hk6
         oEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Rk90bsYMJt5ZclNkQTVUd9tGxjSt+PKuql/N4zT35M=;
        fh=kzw3tnYeH7Ed//p3gi5qo1bdblxS77gKSNGd2l85ask=;
        b=CygUVSCl0CVrvhOath4mJtd7gg4Qxlw8Yil8oUZCvg/FXP8Vy1YarJlApyiqBRfe+w
         Akhoi+pwGkMkN9IdZrKtk3quUYILPdy1PRNGuryXYoE23qcLPgyXDs0mrYq7Ubl4b32l
         m3+etwRZQnZyqxWkEExPJ4Dkn5axFcFa4VjYP28e3CWF5OC9UrdAyRGK91cIwsItrXc/
         zcJqopeFWUTxkUW/OmSTmcZ5dNo70laXUXaVp5jnbnVolWxT4uM6rnFWw79CjKx+95uJ
         dlzh8X33AF106k7gUd731aSPO8MIGoEKwYurFOl9PT7tYq209yZQ8/PdoPuULMKnrMD+
         hrNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790196107; x=1790800907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Rk90bsYMJt5ZclNkQTVUd9tGxjSt+PKuql/N4zT35M=;
        b=KK/8AOINc0pNtu+Va64iP13bQU9eUYg3oIdIw8s5Ci2/hAZyKMasJbc21mcIBaMp2O
         tYDn71VCJne7qmvFIbkSfOQ/51qo95qR7NsgA5HBIJEriMBbIhIvxiFYZhsSfmlWhj2V
         Vfv2VUQ6HmCAmTfEMxlOFKZ0bIEGYG8HvdNWoulJmu00uqDqYcrm572G+Y1kXMLXCI0h
         BPAqhpskB+T7ptQ0nH2EPTVCCdJXsQTMQ37wOQ2jNVh6G5sfmAsa/Fa2/tNTWzhpdRDv
         DxsuWGzD2/LV+CqwV+Q4qRy8QHf9rlVGHeyYSkjCeO/gj+hk+AjLRzeXR28FKXo1+zSG
         4mKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790196107; x=1790800907;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Rk90bsYMJt5ZclNkQTVUd9tGxjSt+PKuql/N4zT35M=;
        b=MtEjIJhFxlJunFCl1ipGk7Ucd0dKMjhMwuaBFEt+sR7dxud2rqbxBzQzx8pbpYR7yE
         5kI9+8taQSn/SN1n1hs6LoHgmtafnjZlhWcLlNZVnpl3CvGYeBChrpDWsP8DkOQVnkfT
         AuAgvsye/91QBMP2YWA5BzFqc1mfiYcf4bdVWKbV65DUM6W78IogiLyvUdqahXAWVW0l
         eSMiXeFhLzIOMhybDIhY+yBh/k7E5MZRTm7O4UyA91Ca7ZF3Lm6DWKZdT4d2gCXG923t
         2vk5z/tgWiUpdd3y9YjsT4+qqaBJZ5qxb1A4QfSnO8/tLwmjgCAXU49Z7PGGuWbdOgIw
         olpg==
X-Forwarded-Encrypted: i=1; AKwUvBzX1uoZHiW+9fwYl6i+Myn7QkyoYDihW8P9mw/eLn3GqD/84i7dJ7C7fO6RRW4LZKtQ3+I6nt88qb6mFWI=@vger.kernel.org
X-Gm-Message-State: AFuF++mFlmcBKh1Ax9sSSLdn6kJwMUAS9sztQ9VfGL2OogJwA4cponQR
	74VNybI7wnj2CYilAKtQa4U8WiC3wzfuWnmCzDg3PHCP0OGRUE/30j85hes1TUz00EKZk6ZQsV7
	SlQUmZr5QJjdNIWOH1EYYSBUtjIUXFPs=
X-Gm-Gg: AYBFou2RgOqoLbktX+0PKRt4VR72cPvlDnwfXqMmuGZt0rByDSZBV4uJk0j+k8BuINF
	PwM7j2QQnvRdD+GPQGDRsSIbmaFIZvgiPZ7OzzZbmCSOM/wI5RxezSfR2Ia+Fwd9jXUmELVBOvh
	wUzen0mHG0V4rTb0LvHoQX86wc7CfwLQxwQxQ6HjJhr0ZmOQfaeYQX2e3NYpw+Wv1juCP6Orn9z
	Sy+5gk5LS3bT12PRoBQhNhSa4Wn5HUKG2qMKRVMAg1E2VFEknqGKY+Neqi+EwHhYH9jEgTpOL94
	DX4SbhT5DqYf4Ki0TEcarwHRN8Gxhj4AeH2g9aglcq88Vg/+QUhRK6nupVgy1hcMmgaJwC/ZMcb
	MlI2IKvV86PREsIfw+oKD1nLvAyinCBxf1xV4dUpN
X-Received: by 2002:a05:6a20:d522:b0:3dd:f9ff:f88 with SMTP id
 adf61e73a8af0-3de0ea1cc41mr281016637.59.1790196106915; Wed, 23 Sep 2026
 13:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819144458.253967-1-joaofl@gmail.com> <2026092313-snare-goggles-ed1c@gregkh>
In-Reply-To: <2026092313-snare-goggles-ed1c@gregkh>
From: =?UTF-8?Q?Jo=C3=A3o_Loureiro?= <joaofl@gmail.com>
Date: Wed, 23 Sep 2026 22:41:09 +0200
X-Gm-Features: AcwNN1Vp4K1x9c17_VZLSp1YwuVUe8d-gHRrdZOHa6Ix1f3X9Cm2yhfxp6piCjw
Message-ID: <CAJMWnCiJsNXsEe9JWDGBzHBGiUToco31ysoHF_Loj-9=YMQ3GQ@mail.gmail.com>
Subject: Re: [PATCH] serial: fsl_lpuart: add support for GPIO-controlled modem lines
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Sherry Sun <sherry.sun@nxp.com>, 
	Frank Li <frank.li@nxp.com>, Alexander Dahl <ada@thorsis.com>, linux-serial@vger.kernel.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 02:53PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 19, 2026 at 04:44:53PM +0200, Jo=C3=A3o Loureiro wrote:
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -1301,6 +1301,7 @@ config SERIAL_FSL_LPUART
> >       tristate "Freescale lpuart serial port support"
> >       depends on HAS_DMA
> >       select SERIAL_CORE
> > +     select SERIAL_MCTRL_GPIO if GPIOLIB
>
> Why not depends?

Because SERIAL_MCTRL_GPIO is a hidden symbol.  It is declared as a bare
"tristate" with no prompt at the end of the same Kconfig file, so it can
only ever be enabled by a select.  With "depends on SERIAL_MCTRL_GPIO"
nothing could ever satisfy the dependency and SERIAL_FSL_LPUART would
become unselectable.

The dependency is also not a hard one.  serial_mctrl_gpio.h provides
no-op static inlines for the !CONFIG_GPIOLIB case, so fsl_lpuart still
builds and behaves exactly as before when GPIOLIB is off; the GPIO modem
lines are an optional extra rather than a requirement.  A depends would
silently drop LPUART from those configurations.

Finally, this is what every other user of the helpers does:
SERIAL_ATMEL, SERIAL_IMX, SERIAL_SH_SCI, SERIAL_STM32, SERIAL_MXS_AUART,
SERIAL_SA1100, SERIAL_CLPS711X and SERIAL_AR933X all spell it as
"select SERIAL_MCTRL_GPIO if GPIOLIB" in the same file, so this keeps
fsl_lpuart consistent with them.

Thanks,
Jo=C3=A3o
