Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA91A288
	for <linux-serial@vger.kernel.org>; Thu, 17 Jul 2025 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754803; cv=none; b=fbzofdNpwMSoKzgynPChfPmMgWy7A5beKEkNShR/cDCyFx5kMy5vgjXi4Fo9zhfUCaiTEMYT3UIrFtfPR2bM84srqpykd1w08CnDNHBOTO4xKreVZUJ4FrB3mmQZEqs72PktcWNSsJY5OPkMEuKZk5yD2VEq2dIZztcuRegvMe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754803; c=relaxed/simple;
	bh=9BstoysraPcNdXHc1n0mia/3lc0Re5lG7hJE8+pelyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgTL1IY1o0L16WRxmj+Tjgoxn7w2vd4i/MxAC93mJ88OyaT3/KZNoKTKGTeiLKuC8zCGc+sOO6PIqWPVU0LzfjXth7WWeEoLHeqqWljLL4KQG0awegb49nkOUE6kRzPkgKX9+ytkZobJXsNudMSQ98PQAFeco/u7/pOxDSmMpis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HbrbVzTo; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HbrbVzTo"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-401c43671ecso480105b6e.0
        for <linux-serial@vger.kernel.org>; Thu, 17 Jul 2025 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752754799; x=1753359599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/4/2GlFbqg9HLiAULIFmkWsYiTvbSro9cghjbjmQBg=;
        b=HbrbVzToAmyaAKLqriCpirFkAhW86rX5D9S6irC1xCmkWyVJJnDu5GEKi8nG3J6EO6
         UBPjpPWIZNhklZVgLI6pVdoO+3y3de8Qhi/OFrtc3xVVNFAX9Fo3GdrjAAqM/KxPQzK/
         qANvAcF90Rbk/1cjiEEJywVd2haeLn/8xaBFm5no1jCLA+zcDpYcGz3xpfFIY41Z803U
         5kEcDVpUldCibmnggSIJJEkfvmsdFQI+X9BHqIafDIS9Eru/mFbXllHjclll2Mns6TUZ
         un9PwlUWbh4/YzDCclyn4V9WhIQFmPaZR/2KxmLnKoMpa91C6K44kRCy+/VL4y/Np6iP
         SmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752754799; x=1753359599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/4/2GlFbqg9HLiAULIFmkWsYiTvbSro9cghjbjmQBg=;
        b=avYuY7dGJ86o7GAPclbQ+RknFotGcCgMfW3sbwqHrBka+R2XWugPJ5VAJlbGOcGf+m
         H7jGPzXd5QaeDiTNUP9rZ4VBoFxZIYoCza6Mr9GueFCohO/wf0GCKtcdqlJp9bvI0e8P
         IoEHSeJ6cIniANxY5/TwErU9ll8Z5UdwEC6KBNcbCMihv9+X5ac/EnMUgMwEaWeU2ozB
         0LDj3j3SMNVk1BsGhFraQW/0yrmVcgYHWh+qkm3GH0qrP+oU6AS/hiVyi/b/6fBLKhkr
         uA1zbma7ilQQ849CJ1eo5q5arvhCqQwVve9l28wZILfbQvd4kF2X9yICW21AD35ZLc9G
         o89A==
X-Forwarded-Encrypted: i=1; AJvYcCVzSNiaDAW+xfQGhsoIh5/1b+lMDtSuBoDgXLYENJgbtw0R0XCaW8nYWIPsBUs13XafKRjDqBmMPChCy5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLKF4Gq8US3iCZaAAzzxUcG80fA9LdzgdnUKBZCgDFAJGjmm7I
	5z9nz+YIgIYcVPgS4WYf1QAbOA8qLraLfvpJ+5locbaWtikujQ5sj4Kq+KmbfnY9vgf+ZyDWt2I
	+wbc6Gi0etKY3zVL8MpNZyO7zNu2EchhzuBAdB+s6eQ==
X-Gm-Gg: ASbGncuyTiMLYw0yPQYldAZW7l9+rad2BDhD18SvYL9ya8jWoJyHFCO85birnv1b2rr
	cWqYlX59UZYSH5BGNFPea3/8uRyGhg7Ov1qY0wUAxUuCd6F+qFUZw/VSZB2+tNsvPtasgrx31C+
	vxNK9xlWQIcGZjvR8Tm3Bg7/KfTRrlTHVR6iVN3n2mZYB+DTCA68TFYRo9O8BLrfoK6RxQ6Xugw
	w2u7ulQqjLPzISqv424X7kIFh0ourU=
X-Google-Smtp-Source: AGHT+IFuE6XD5lTWOXSNH1CM5vjssmv3cQEWKz8QIIOs4ZSd6cXO1A9SSlaFR0OA4UQ7x1Dn9lJKAZEfBfctdkacNn8=
X-Received: by 2002:a05:6808:4f5f:b0:3fe:aebe:dde7 with SMTP id
 5614622812f47-41e2dcc2f2emr2171185b6e.2.1752754799043; Thu, 17 Jul 2025
 05:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610092135.28738-1-cuiyunhui@bytedance.com>
 <20250610092135.28738-2-cuiyunhui@bytedance.com> <84bjqik6ch.fsf@jogness.linutronix.de>
In-Reply-To: <84bjqik6ch.fsf@jogness.linutronix.de>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 17 Jul 2025 20:19:48 +0800
X-Gm-Features: Ac12FXzX-8_oUrVkjPDnBHqZHa66JwCymGHzpPdOgfG20sVHt6vV7FE1XJLHuEU
Message-ID: <CAEEQ3wnBJUjArdfs+vgrsfoQaVJPKD3uwD8hwgg963fUBaNGrA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 1/4] serial: 8250: fix panic due to PSLVERR
To: John Ogness <john.ogness@linutronix.de>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com, 
	benjamin.larsson@genexis.eu, gregkh@linuxfoundation.org, 
	heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com, 
	jirislaby@kernel.org, jkeeping@inmusicbrands.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de, 
	paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com, 
	sunilvl@ventanamicro.com, tim.kryger@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John,

On Fri, Jun 20, 2025 at 7:20=E2=80=AFPM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> On 2025-06-10, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> > When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> > an error response if an attempt is made to read an empty RBR (Receive
> > Buffer Register) while the FIFO is enabled.
> >
> > In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
> > UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> > dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> > function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> > Execution proceeds to the serial_port_in(port, UART_RX).
> > This satisfies the PSLVERR trigger condition.
> >
> > When another CPU (e.g., using printk()) is accessing the UART (UART
> > is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) =3D=
=3D
> > (lcr & ~UART_LCR_SPAR) in dw8250_check_lcr(), causing it to enter
> > dw8250_force_idle().
> >
> > Put serial_port_out(port, UART_LCR, UART_LCR_WLEN8) under the port->loc=
k
> > to fix this issue.
> >
> > Panic backtrace:
> > [    0.442336] Oops - unknown exception [#1]
> > [    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
> > [    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
> > ...
> > [    0.442416] console_on_rootfs+0x26/0x70
> >
> > Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaroun=
d")
> > Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/=
T/
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > Cc: stable@vger.kernel.org
>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

In this patchset, patch[4] has been dropped, and patch[2] may still
need discussion. Could you please pick patch[1] and patch[3] first?

Thanks,
Yunhui
