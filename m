Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB2F56442
	for <linux-serial@vger.kernel.org>; Mon, 18 Mar 2024 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787981; cv=none; b=pK3agABd5n9krW2ejmJtQN90WAwwndvoVZq7ZBtTsVK4Qw/+Jr2CuaaNzj+d50PtGRqH4z4P65PNesmJncEd6OJ+67kAatCIj1cgWfOySICYqDn0/Vr/N/+9TbVEsJ8CfwimsglHUhgABbB7mmKIhKiRPZHRfBZt9qtTOEYBwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787981; c=relaxed/simple;
	bh=WA9t2JLaCdhVBKvzAFSO3yj34I9PGx2jtsLcn5J2f68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oprIm3zOzhLlqlOxtl0hVZHWWaqd2Kzub0w+hlo+VXvQ6vtaMNUXAVzARBEL/+O4VC52+hX8dOR/5x3J+RONzirSoTpydNVJZ+8UlEQIIS7a/RYf1vgQzR+X0UVECVqI9akBxnYYDi7XsBok2ADSnMtgY/bNmAvh5dAuv7UO/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ecMvraCI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecMvraCI"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dddd7d64cdso23715ad.1
        for <linux-serial@vger.kernel.org>; Mon, 18 Mar 2024 11:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710787979; x=1711392779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooCrJpUnHKphfXZ5NhuriLnnuqEoFFTTE4QaO2C2COE=;
        b=ecMvraCIWowvN5IajLtRd/WNlsD4i21GxzfqBmXTyTaO3Bmlz0QZl3qI3dKC0cthMm
         bHoNEWOgj/8P+oW11+08fYuqmlrTMYNzWHruEL2HGxwfrEIw+hzQWHbWDHOyldx7n8cO
         SQdUkOKDzbqQ7XTPvhDWHeQlA4TUwz1taXKDFViBqPoApHEOXeIpKOvdso79OIdAAIuM
         EtGhwjUkM15ynFUytINpv+D5/S5F3ShY8AgT3JkmaW6c6j+Cy8KO3/dKnLh4NoK6Asfq
         9MrNrfEjsOO6igAstZiKyDgnpGMku4Xc4ZRePrT0J+1DZbL5PSqxYcuzy5GyvYbKLkLT
         IKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710787979; x=1711392779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooCrJpUnHKphfXZ5NhuriLnnuqEoFFTTE4QaO2C2COE=;
        b=Zxu+XT6YlWxVfCMAJIyuXic+SlcyesWF4xl5PG2/1RVT6rF5jYrQH3ewiYmyrhQ5/9
         2fpMSGAp3b/1pxB00A+80W8+ncswOmcnrbFkCJBpKV0+8LvpCvSfY8PYJr5yp9uduK/o
         eYjac7svfakefVaXFJXx3amztjKi1JWFvJD8RkTAoQi92a10DXB0e7sRJD+OBOG1kB3s
         Jnbbilxn+pmpki9MBW2Ia3MOSTN4M5JCCq3heSfBc/RB5f69SbZSZrzxcaULMojdkPdI
         q4S+PaZqKASoA2LXzPa3VM4C9ScjfcFcjmKe11TZZJhGJUqjvPb36y4uMezM5QJ20SPe
         K/4A==
X-Forwarded-Encrypted: i=1; AJvYcCUy5Ee8EzbJzbmtwszZVWWAKqCnv1AJfl3A5p/Ma42SP2yLqAtSBEzT41tPGQaJqMpSr9rULIu0UHZhmDnmF4bH3Amiutez3ZU9vexc
X-Gm-Message-State: AOJu0YxGQpuExv8GsrfRr33AU4on3d5QIK1QRQa3yfYOY+FDuP/yjSbA
	AsUgnHtHGHXqQTyqmeXV3nBJ/I7QX87AH7mnLycT21EyTPy6xEo1hj4hC7mY31R5/87+GNpal5E
	uZ9188Ygd+ww9WbmFj3cTt1lntTuT7bIAtBNi
X-Google-Smtp-Source: AGHT+IFxnWdVHhFA9G5toRi+YSBgRJ4vD3ZYF6ZNV3WhNQhJfWcVdbaPyyKN/dFGLUM66Zp9Nzo3aBAZ8CtEp5ZKoYc=
X-Received: by 2002:a17:902:e848:b0:1de:f8f:7d56 with SMTP id
 t8-20020a170902e84800b001de0f8f7d56mr48333plg.8.1710787978738; Mon, 18 Mar
 2024 11:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240317214123.34482-1-hdegoede@redhat.com> <ZfgZEcg2RXSz08Gd@smile.fi.intel.com>
In-Reply-To: <ZfgZEcg2RXSz08Gd@smile.fi.intel.com>
From: Peter Collingbourne <pcc@google.com>
Date: Mon, 18 Mar 2024 11:52:45 -0700
Message-ID: <CAMn1gO4zPpwVDcv5FFiimG0MkGdni_0QRMoJH9SSA3LJAk7JqQ@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Revert: Do not reclock if already at
 correct rate
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 3:36=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Mar 17, 2024 at 10:41:23PM +0100, Hans de Goede wrote:
> > Commit e5d6bd25f93d ("serial: 8250_dw: Do not reclock if already at
> > correct rate") breaks the dw UARTs on Intel Bay Trail (BYT) and
> > Cherry Trail (CHT) SoCs.
> >
> > Before this change the RTL8732BS Bluetooth HCI which is found
> > connected over the dw UART on both BYT and CHT boards works properly:
> >
> > Bluetooth: hci0: RTL: examining hci_ver=3D06 hci_rev=3D000b lmp_ver=3D0=
6 lmp_subver=3D8723
> > Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
> > Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
> > Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
> > Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
> > Bluetooth: hci0: RTL: fw version 0x365d462e
> >
> > where as after this change probing it fails:
> >
> > Bluetooth: hci0: RTL: examining hci_ver=3D06 hci_rev=3D000b lmp_ver=3D0=
6 lmp_subver=3D8723
> > Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
> > Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
> > Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
> > Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
> > Bluetooth: hci0: command 0xfc20 tx timeout
> > Bluetooth: hci0: RTL: download fw command failed (-110)
> >
> > Revert the changes to fix this regression.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> > Note it is not entirely clear to me why this commit is causing
> > this issue. Maybe probe() needs to explicitly set the clk rate
> > which it just got (that feels like a clk driver issue) or maybe
> > the issue is that unless setup before hand by firmware /
> > the bootloader serial8250_update_uartclk() needs to be called
> > at least once to setup things ?  Note that probe() does not call
> > serial8250_update_uartclk(), this is only called from the
> > dw8250_clk_notifier_cb()
> >
> > This requires more debugging which is why I'm proposing
> > a straight revert to fix the regression ASAP and then this
> > can be investigated further.
>
> Yep. When I reviewed the original submission I was got puzzled with
> the CLK APIs. Now I might remember that ->set_rate() can't be called
> on prepared/enabled clocks and it's possible the same limitation
> is applied to ->round_rate().
>
> I also tried to find documentation about the requirements for those
> APIs, but failed (maybe was not pursuing enough, dunno). If you happen
> to know the one, can you point on it?

To me it seems to be unlikely to be related to round_rate(). It seems
more likely that my patch causes us to never actually set the clock
rate (e.g. because uartclk was initialized to the intended clock rate
instead of the current actual clock rate). It should be possible to
confirm by checking the behavior with my patch with `&& p->uartclk !=3D
rate` removed, which I would expect to unbreak Hans's scenario. If my
hypothesis is correct, the fix might involve querying the clock with
clk_get_rate() in the if instead of reading from uartclk.

Peter
