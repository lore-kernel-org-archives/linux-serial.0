Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE17B12C47D;
	Fri, 10 May 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348667; cv=none; b=rSJKibuOqAGdb6x8qPsq4UWG4zv0LFVkOwdDEWuLrRF5+apSVABIw9p+YqlOG6ryCo55ucd7weQsqjlMT2RbzfMijcPBI35tiiK0rEx7gk9gKLDpTxDPo77uqcUrA9QFa7SC5weMkZgktfZh+vmwQNR9zW0m/Jja7qOogmbvsFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348667; c=relaxed/simple;
	bh=a+narUI2zW12K8fH5XAnD87sFiDziSZ6ANXk+XWXg8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxUB9PFNqqNtqWslCMamG8n1khEOMeIMjGeflgl1RDpzLyoFHJ+relA/Hjtabt/ZwY6bXlkcQ7Sdc5RzplQvLdx70AjgGbC8Qnq/AwHmCcq1FeW27k53wXBYwIN9mKpm8DHes81mU1gwOD0CJcPEv/E7FhsPJfxXwz7dMn8NWz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc8rduGU; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc8rduGU"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a609dd3fso359284766b.0;
        Fri, 10 May 2024 06:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715348664; x=1715953464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8zQ1+fOyoN9FxhEKizmSfFFoRfjJDAWVbQkvx4VSmE=;
        b=Mc8rduGUMDy62jJfmaxXjW3ILRIOwmLNqLwGuZvwD+YhScUPF4Agyyn/FYwGJdKeFn
         Rab7aRdn/T3p9MUeiwJ1CSGu+q4/O40o3dkDcgRV4Bbz4I939eiqmk8B5Y3wl/r47Wr8
         EpVGbBaAsmK1aYBCQWZ4gdmolixjUQnSdEANpjgcSz+XjPPIjipUdliqmD8bJVgx8ccF
         TbBujpzClj9uquvK/uugaiRH3TTY1qClkg7jdXQCqA/cs+5bI5UU4cE+UXhpwKut8Ra3
         oNObvFo/D9wNrOTn8e8IGdIvr68xZvpPPt3wGpBMeOQVSSzqXVfc5jl1OpNReRLHKOg2
         u86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715348664; x=1715953464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8zQ1+fOyoN9FxhEKizmSfFFoRfjJDAWVbQkvx4VSmE=;
        b=BlF3F0F0+MgP7/wcwDh3gJqIrV6OcgjctwfLDzAvA+CkXyPNcDUQIfU+LTyc02RwdK
         y3R6EQbIzjequOPHTSbqlTNIl61S38cKFmbFKBWr1QhNOzhIDO9svh+y/jz4ak+FO+Xw
         fo7h49RYN7/VxqwwGIoDj8YAlp+25OeBSkqWkCMilqRTqSptjLNwRQaZUrAeRM1ck41z
         9ZtQ3N/3x5BE0y6Ka0Ftc4eQ8hppk3iPILtmDyfQk09NX4SlVoSSp8NnpuPSEqeeW4rM
         sRoe41DqRTC/tF3yGH+jeMy7gC8RZcVt7Wcmt/WKvwDLCy2fXlu/DSnrHhCdZVvmxXCh
         ZCbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZZfwoWLksr9J0zf+c7hdOIloIaiz3HYScmBhyK80vOSMK+k7aPcYNPUgurcjZH7ecmSYJ9oAMuwtORsZY44KqzlPux886nF/RWH/zNBCaRDobs00F9R4YzKYanZr+9vtxHqQLFSoToVFaDm3L5pZctQ==
X-Gm-Message-State: AOJu0Yw4Ub66789fjpV+0X0UsTY+zlKkAgn7nYqyF61P+VAM4DXZYcX5
	WUKEVA2h03mRtm7bJTEe8NUrnkplZh/SfUsAwK7udHek1MI8EuevTzlIB0QBlqEMAagpHeamfxh
	EcTiv0JaNAiFFSHk4bKSg6igKK+0=
X-Google-Smtp-Source: AGHT+IHgGoFxkAWnw1M42UAl8QpDJxvW0EvSEIQzxEapo6qUpe5rDOx59WyY+PdQGBWjYvgbBApx71SzI4LHBBoi30E=
X-Received: by 2002:a17:906:b098:b0:a59:cf0d:d7c8 with SMTP id
 a640c23a62f3a-a5a11601484mr486463866b.15.1715348664064; Fri, 10 May 2024
 06:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509141549.63704-1-hdegoede@redhat.com>
In-Reply-To: <20240509141549.63704-1-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 10 May 2024 16:43:47 +0300
Message-ID: <CAHp75VfdZYVSbNfAQ5OzX632f-oGeU08-pHPWb9tf34Q1QU_RA@mail.gmail.com>
Subject: Re: [PATCH] serial: Clear UPF_DEAD before calling tty_port_register_device_attr_serdev()
To: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, platform-driver-x86@vger.kernel.org, 
	linux-serial@vger.kernel.org, Weifeng Liu <weifeng.liu.z@gmail.com>, 
	Tony Lindgren <tony.lindgren@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 5:16=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> If a serdev_device_driver is already loaded for a serdev_tty_port when it
> gets registered by tty_port_register_device_attr_serdev() then that
> driver's probe() method will be called immediately.
>
> The serdev_device_driver's probe() method should then be able to call
> serdev_device_open() successfully, but because UPF_DEAD is still dead
> serdev_device_open() will fail with -ENXIO in this scenario:
>
>   serdev_device_open()
>   ctrl->ops->open()     /* this callback being ttyport_open() */
>   tty->ops->open()      /* this callback being uart_open() */
>   tty_port_open()
>   port->ops->activate() /* this callback being uart_port_activate() */
>   Find bit UPF_DEAD is set in uport->flags and fail with errno -ENXIO.
>
> Fix this be clearing UPF_DEAD before tty_port_register_device_attr_serdev=
()
> note this only moves up the UPD_DEAD clearing a small bit, before:
>
>   tty_port_register_device_attr_serdev();
>   mutex_unlock(&tty_port.mutex);
>   uart_port.flags &=3D ~UPF_DEAD;
>   mutex_unlock(&port_mutex);
>
> after:
>
>   uart_port.flags &=3D ~UPF_DEAD;
>   tty_port_register_device_attr_serdev();
>   mutex_unlock(&tty_port.mutex);
>   mutex_unlock(&port_mutex);

I guess I have given the tag, anyway since Tony OK with this, no more quest=
ions:
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
