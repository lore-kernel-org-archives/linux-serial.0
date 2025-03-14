Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1E11EB3E;
	Fri, 14 Mar 2025 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960547; cv=none; b=hU1tDZPsCYwGaSFVcxNFteHxKaGKkPOziHS0MMNR0dw8bHMs08iabLU16PTuNHWJpmMudlGWqrCv+xXAnNiFkzJRp28TebhS2n1ASPF4o2e8HFAcsEZ0PHHUI/inccCjxTpmwWNj97wHBwiQkC5CDF/m4kQe+ILcYwq6bSF0CYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960547; c=relaxed/simple;
	bh=CGaulF+UNq/UkfDb8/gi2jAvYZbz2RC3gaALMdwvzBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqjzyjGtPV5Ss+UaQHczzYrE6De30icBMBVevxmexn/tLpUax83vpVSU9kya7aElQkvP0MiDQcMMMJz3tGWdqadpBJJYFC6ir9tYYYGNlCXoF2A+KwycrqS7p49dkXKLPZQKPD2vKxr3JPN4Oy9hmf/x4+x23OSk5gL2eAC8LJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZ8nTXI+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZ8nTXI+"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac25313ea37so423446366b.1;
        Fri, 14 Mar 2025 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741960544; x=1742565344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEnFpGM/wdzS+VVXhShlJt1TkX2vM3Hth/UdwF3fpV0=;
        b=JZ8nTXI+jMCPL5OKFg6fG5EV06XAsmozv1/bl8gzTKqwA5qDb2Uzhy8u2cUikZGxfU
         DHkREwc4DmL2JtHGoD6T7uU70FW86Al9Uf9QvX33G/4ba6pw8FoUlr3JjCSByMfcM2HF
         5uwTlWrORBHaoIc86fmLbRfooljZfjQoQdR/dh2dD0jFk3JNmSd6jePnRcDFCcn8xYKQ
         iXgbOJaDIJxs5Y7OnN9lCLbKatxXcST20dyA4TANsWznkx/rjSNQNAyBHHsUjD2nHsIY
         LuoVL+lf+95yY7EZKOGvYV3mNjiXsGRDEtmr701a5azCScLoeEmgqBhA/QvGd1kYwXe0
         cOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741960544; x=1742565344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEnFpGM/wdzS+VVXhShlJt1TkX2vM3Hth/UdwF3fpV0=;
        b=Rz3U48SLWrHXUCGdyCc/PUL+WtaTejPKaBm/G44NdK3rbpkrl3tiDaEt+EF8kzstUQ
         NXVqqrL8meRTq9cHhnKCrWL8B9mT+tbcJlQrybYGL3EHdmcxaySvnC6qgghX1laiq0Un
         UO9ObtVF/5y0yoFxiNub6A9ZsKctpuLmui4y4wBdXoDsNG+qnPoDA+6UPTSCvC+F9H3Y
         k0j9UxvBQcPRKy/DNFy+9tsMyw8fHa7SrzvaDdfHI4ZZfInrlfwR1dSuDy7u9OVQRAjU
         D0DtGPostwv5BZudY7pqrHmcmxFQOSRCpjQilTuYDnv7Ll8UZ+pSwjkT6ueDfZcPDBGV
         WeGg==
X-Forwarded-Encrypted: i=1; AJvYcCWZFql+6LmSeCRtCOipvlf4i2yz+WWcdlJ6KjoLPwyyWOVnKvH2FpiNcoS36jUQQJzRVdYCQqzx8OZjCSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGVb5MSQS+szYb0tl8BUqK+Mh+3D1OEn6d/48R84JtphxI9amC
	E3Sqqyi6gtskBPEqHZUZLR2plj9pwyZvQj5RVpwh4dYphGsHi3em/APbK4I+NMGjVvrAC5+qooO
	H26YcoXPTDvISZEMffpxcxOjC3ZY=
X-Gm-Gg: ASbGncv5gVbmphjbGTBbWxu6NiH+7x1cCmF/+1WfYu9Wduy1a6Vj3H1WpLAxBMXfldB
	7Pusebh+d5ivtRJ6LcaQsvtOZ9Ht2ckwNEfrU4IlnmtDx0cFdAhvdFsLBRLc+onVTtAL4Bk0qLi
	Pc2m0oR8PBsheDo5UndVkHVoUWFE8e
X-Google-Smtp-Source: AGHT+IHdwlSCytzicDp8ttI013vOivNNvzskW2SaRoEZIL3BQOo2nH1sG1pGrPPerD8oKcQ6RlJrx+EqJyrJFetsRgk=
X-Received: by 2002:a17:907:3d8d:b0:abf:614a:3e48 with SMTP id
 a640c23a62f3a-ac3304042e6mr371696466b.50.1741960544227; Fri, 14 Mar 2025
 06:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314125244.3202791-1-adamsimonelli@gmail.com> <20250314125244.3202791-2-adamsimonelli@gmail.com>
In-Reply-To: <20250314125244.3202791-2-adamsimonelli@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 14 Mar 2025 15:55:07 +0200
X-Gm-Features: AQ5f1Jp0MccMsvrLa3GEqzTCm2sbhOoSasPVMaeJBLsToKhCQaFmPTrA1CQHVDM
Message-ID: <CAHp75VdaDyyNEKi=S4Y9wKR-Dqb0M30c+rHVs6FiWc3L0vc=Uw@mail.gmail.com>
Subject: Re: [PATCH v11 1/1] printk: Add an option to allow ttynull to be a
 default console device
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 2:52=E2=80=AFPM <adamsimonelli@gmail.com> wrote:
>
> From: Adam Simonelli <adamsimonelli@gmail.com>
>
> The new option is CONFIG_NULL_TTY_DEFAULT_CONSOLE.
>
> if enabled, and CONFIG_VT is disabled, ttynull will become the default
> primary console device.
>
> ttynull will be the only console device usually with this option enabled.
> Some architectures do call add_preferred_console() which may add another
> console though.
>
> Motivation:
>
> Many distributions ship with CONFIG_VT enabled. On tested desktop hardwar=
e
> if CONFIG_VT is disabled, the default console device falls back to
> /dev/ttyS0 instead of /dev/tty.
>
> This could cause issues in user space, and hardware problems:
>
> 1. The user space issues include the case where  /dev/ttyS0 is
> disconnected, and the TCGETS ioctl, which some user space libraries use
> as a probe to determine if a file is a tty, is called on /dev/console and
> fails. Programs that call isatty() on /dev/console and get an incorrect
> false value may skip expected logging to /dev/console.
>
> 2. The hardware issues include the case if a user has a science instrumen=
t
> or other device connected to the /dev/ttyS0 port, and they were to upgrad=
e
> to a kernel that is disabling the CONFIG_VT option, kernel logs will then=
 be
> sent to the device connected to /dev/ttyS0 unless they edit their kernel
> command line manually.
>
> The new CONFIG_NULL_TTY_DEFAULT_CONSOLE option will give users and
> distribution maintainers an option to avoid this. Disabling CONFIG_VT and
> enabling CONFIG_NULL_TTY_DEFAULT_CONSOLE will ensure the default kernel
> console behavior is not dependent on hardware configuration by default, a=
nd
> avoid unexpected new behavior on devices connected to the /dev/ttyS0 seri=
al
> port.

> Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>

You forgot to collect Petr's tags. Use `b4` (should be available in
your distro) to gather them from the mailing list (as of the previous
round of the review).

--=20
With Best Regards,
Andy Shevchenko
