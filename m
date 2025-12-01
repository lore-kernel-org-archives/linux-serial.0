Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C7778F4F
	for <linux-serial@vger.kernel.org>; Mon,  1 Dec 2025 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764554770; cv=none; b=Upm5d4rW/vLsfdN2u17diH82M8zx85JeaMQbIIbd3GAE9HCLPkzWtHY6evO3/itSg8jx/sIy1FnNtG7M3VBVwn4mUY/Muy0AgfE9buaLAm9WB9OgZixpLiM5lLMdpSrkUtof30moUACLimztqooy85n+EZfHQ/fDbxrauZVGXrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764554770; c=relaxed/simple;
	bh=F+kqQJANlWpW7OnVnQkGVHRyMGYqBTBP3+OH8C+yiBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOWv3I5AvrpSOzKwDq1xFg7xwC4BJJKRH3TYQ/qneRhFkOFwDtJOrZ5HPrmPGDGhPuVdKUTDp8Q7nfWk1vdqBGLQVQWMX33WGtB25R/W+NqIho+fzQKglrDM+p0PuzL+EgjJ4hPvf+yBf0nw09ia1RNhAV+Ddy8KiPXNdWENsyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4Pr7Z93; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4Pr7Z93"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so6969437a12.0
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 18:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764554767; x=1765159567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdCTfdFQxZs0QfaSHbglBwQrQEtNhzo/yUv0JaPMiB8=;
        b=O4Pr7Z937y0hh+RN92aO81BKfT3oMktFCTfGhmhOpFpBcuxPZuaJ2mdqipsZX/ZwT1
         62AVxEoffjZuJu3sE84k0IlcoFrMl/qqm+zPIspIcDJFNLTxcc++qOKOovefGlwxPzyk
         6wYza/8dJuNZt4JdP0R56Z1MOhXJ6Ky4kUhYM299RX034ieiJq51JGQKwI2cuGnU2HUO
         BePmR5OWbgM3DUeEpony/ZCqwYup6Sf6PZRMEakhounzTYrIOzz44yCI4GepyrKkK3A2
         oTnO0sUeOAcmxIN8xftjMdhMv+iPsPlv2KDYAUm2SKRcll/nADbgj5cHZ/Pi/7Yh5Fgd
         Gr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764554767; x=1765159567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vdCTfdFQxZs0QfaSHbglBwQrQEtNhzo/yUv0JaPMiB8=;
        b=tbnh1Dj05fmpjkpi2jBIBz7BHscUBgVbbML0aBCYyBelwy0BBHbVAXPpiBsMfhyKoW
         g4TgYOFvW7LdSQdd8L90oWbKnvLS3yjz0cnPv3jJ9fNVUcgJEQITqrVBfPNakrak2dCX
         aOiB+h48gEGQBe2XrHoj8d3R+4UNFANwU+Ui581PpV0Dwi41daH+vgV0mSZPhYXAt61X
         XkHgAlpLpfpKruQDbDh4qgOXRiP1PIRCgrgabyTnj0kzU6duanhPHe+3agflfhNa4iNx
         ZR8BA2jOqvlVEFk3lhkwr51qN15dNdtAF3TPPmbYgCKOZn+Xsg2drmaHRJ31jNkuBZB2
         flaA==
X-Forwarded-Encrypted: i=1; AJvYcCW/LZo+wVxib0/L8cKpQQASfaiyKfINxVAkM9sbghNL1320oja5wsUvUNVk/JvSW2vEjbJ0LDufqG0JgI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3otryMCZbAmaCQGmH7/QTpD73Cf6jAW+CdMaDCZr7VqDQj2T
	+5IstufGnTYFzf/6gfDRRkAvjJPwAOiIvyY8Z300KmL1stlAD0+NGHG9/XwUyFMwiA3wsPTDNOa
	WfV2/Y2+e9BKugbuo4BbNtRpTjj7rq5U=
X-Gm-Gg: ASbGncvK1MTFw6I+8L/a2RrHu7YDrBERzolTCIXH7Oxvzewx6kR06izRm0BUC2GRPqa
	o1ymd7n2m1M2rSkqP6wrlgbvtx/6pBJ02dZN9OS2HTUA3H5TcY5lhP1LywfojK2FwulFOUZ6fw/
	xHPwW2aKwIhaliknv7ptBDmh2JJBrVIv7m/xppI/fOJ/RYyuwot/plApPXpX7Im9p7gUAVgSpgi
	aGdI84yZDhLGaA9CVLSg+Z52Bmd6T58qBQzIHZ3AMDbvrWxTi4zC+vkp/6+9FVF8Oa5Io6L8vQM
	aBDYnjz5Pnoz5AIKFzfnXK0FPW8+zJfsnPqgNe4hpJkiRfXvWIRkCxbTJ3c+vMOw5n7P5lU=
X-Google-Smtp-Source: AGHT+IEWg+SlyJk6YO7vl37jZnwCYpneFeWO4+ggqgkVwjVb0+UdHUmis5xKuHaMWITLyr+GdBk5XZJpVpZ85tVZHPc=
X-Received: by 2002:a17:906:9f96:b0:b75:7b39:90c9 with SMTP id
 a640c23a62f3a-b767188523cmr4296054366b.51.1764554767332; Sun, 30 Nov 2025
 18:06:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-24-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-24-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 04:05:30 +0200
X-Gm-Features: AWmQ_bnerFHkD7kF6bFq0e8B5duW5amjOZgRLtuwGPHZphkjgN1OjAisyv4sFSk
Message-ID: <CAHp75Vehx0kwigcGzpa50ksgALTCYaK5L9sbOgi_JX49AUTKAQ@mail.gmail.com>
Subject: Re: [PATCH v1 23/31] serial: 8250_mxpcie: defer uart_write_wakeup to workqueue
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:45=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> When the TX FIFO drops below WAKEUP_CHARS, mxpcie used to call
> uart_write_wakeup() directly from the interrupt path. Move this into a
> per-port work item so we avoid doing TTY wakeups in interrupt context and
> reduce IRQ-side work.
>
> Changes:
> - Add per-port state (event_flags, work, cached uport pointer).
> - In tx_chars(), set a TXLOW event and schedule the per-port work instead
>   of calling uart_write_wakeup() directly.
> - The work handler test-and-clear the TXLOW bit and calls
>   uart_write_wakeup().
>
> This keeps IRQ handlers lightweight and avoids potential locking or RT
> latency issues while preserving existing behavior.
>
> Note: removal path must cancel pending works before unregistering ports.

...

> +       struct pci_dev *pdev =3D to_pci_dev(port->dev);
> +       struct mxpcie8250 *priv =3D pci_get_drvdata(pdev);

dev_get_drvdata();

--=20
With Best Regards,
Andy Shevchenko
