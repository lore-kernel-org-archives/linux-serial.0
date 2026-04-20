Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767838B7D5
	for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676417; cv=pass; b=Nr0HFXEN7hMj0lRXEs1fa2U2b21qypNLBqBiGL3ccaqHkSCEd829+wczXsknIqpMrwCf55KPPfeQajsYlBGxyVNhrAPIHJzl7EEGW7r+gAe1qePhKLEEYMqwTPjBvXU1IthjDCiYxElSgr1V3EC4Toh//nnjvdYB8XBd1DtklHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676417; c=relaxed/simple;
	bh=XxirBuD31Nt+C4zSZNg7TpINaJaCS1dX/jpy37erYco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7pcjGIt7uSKlTff83XK1suMDGDOxogd1z/gSr9U/SKA/5yyOwovCdVwfC1q6YnnRIZ5J7FVGUmHDtzc1eowBR0oSaiETK82n2AkDREAyAgZKguhOtX3bDvd+EhHulhGDNXMDDyY24Gp6CxTvRVtAchy6t+1RxlFG+PymNHL7Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sgJrx6VZ; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgJrx6VZ"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b936331786dso347351266b.3
        for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 02:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776676414; cv=none;
        d=google.com; s=arc-20240605;
        b=aNr0viRI/SZcSqhzlRytco9Z9tnu73TCj3zSTdStNxePOk1DgFm6e9oy0FtQQrOV1W
         8gK7FxZPvun9OLILntECKFLdqlallFDua5BSCv6531y4QGCr90aBDAZFkRpTDdTJlKZK
         8tO82n8/aBYr+zbTOmYHls3y0DYjAnKogK9yNrnFh8l9LnUFpQEG8YxrJf+moUu9dxde
         TZecl279i2cqwaAAiYosPylN0nCf2qBUiisrWETASVT5ScYexI0WXr0r3m1MDQT/aeM5
         t0U9jvzKphMOBm6VmjdxhZryZm/UrNjTEPdQSzwGov1T2qwtImJ9c2gpfPzVDdzap2ZA
         B6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6BugEHHQm4XvMDyPiuFQhMIfXiJY3WqflJplQr+j+bY=;
        fh=04pRiNa23krPTuNz5zkf4I7P9oxvsJsEvIUVEelsDo4=;
        b=hkIfWpI4kmV8JKYOf3RadiJ1IojKyrzPkamudPe0VSfGWW+UGxF25PLUCqFlaqyvEa
         4vAxnj5qSzj4iAV8JSsTEvwo1l/SjHQkTbuqt6o/RB9iKiCQct9NxdxBrW50K/xFiV+x
         +sRLcHX4Qo3jXmHJukDi6xxF2fox78ux3cUykaJvt9HakHy95ziMkQMj3MOoJVMq1NQE
         pD9ASYts5c6clJq2m+HGQvgPxVyMFOaQnsfLmtQvajZHOLfV1yjKbmk7bpca/He3Cpi0
         T5LvlxJDgLOIiG6hFVzsjexmAvFtWCqNYogqFXb3fV87XNqVDaQBvDFx5Sjdcb695+Vi
         mKLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776676414; x=1777281214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BugEHHQm4XvMDyPiuFQhMIfXiJY3WqflJplQr+j+bY=;
        b=sgJrx6VZ1ly4fF6Q94CKKKEo7mI8MnfPDs4zApnknG8K5GTcieC2wMHndhsR1DZlZ9
         ieFiaK29+wFF8qwNg7fUtG13U70v0f/L+huN4RdU7ZV/ZcZXxVTXdf77hYuvRt+ddbiW
         64gpJVfOIRwENRajBeF0anfaCAO86vJ6Qd/YfnCLYupM5sN9KMyEsIlhCPDZFsBjgzSV
         uZJ3xV8YS0nW7NnlDmZR1zFC99dW9fio5iZ62USKCBkrD8gefWsiVK+GfRVRQxqWQqZ4
         174d0bGzG1pOmLrdP8JVrTrbvovAoaOLa3O2L7gWtTJurC6YN9EpM/19gf9w0I97GWhS
         +Vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676414; x=1777281214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6BugEHHQm4XvMDyPiuFQhMIfXiJY3WqflJplQr+j+bY=;
        b=BlsxcZTmH1g3Z6nzpoox6U140fEys5OzwEJyF4VZMIvqq8mmIsxNAvGW11f/sslYze
         mQ1sienVJTqx6l/IRgD+J1FKheHImn9JVHklMCfVE5/8AQ1zrnc2/GskB3VJqwl8JBxt
         6L6F1vLz6IpBHhue3HhN02WND10fmmkXYorvwdsSe9IZVwPy8AokSogo9q84Bys6fX0c
         79wJn05CVF2vLGkhfmAXtQOJjgB6OuMWKEW+li81N5hg6kRFZD4rE8RC+B2vVxRD7CJo
         BWL5y22+kgIJahBWvHJtmoiXNmf3qelg7byW1M0nISp+itymFvRghEV9vS9+PzkZyJ5A
         XOIg==
X-Forwarded-Encrypted: i=1; AFNElJ+KUtbOQ+/+5O7hIGu6btk5qxXvas6eC+o4uypItux+gqugZUA1hilDZRaxQq1YCEa1Ku1zmRVDY4odf/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfrIWuxr+A2MhsZlH22hlblneaX+xM3F97JXWFN147tdozGYj8
	iRZi6PKUR9UFvpEtzMLWdN5+yPMcYdj4BSP0NpHkHW8FoPsv/TrRWupi27p7mj9mpKEGy/HgQwx
	E1AxqKtwYAbICqH+LolrvBPJhWe9Xfyw=
X-Gm-Gg: AeBDies1H8M0BEHHs8rkf/a8wJfoOkbcrQvow1BAf3bkYaE9193OlMQg1F11vWcNPHC
	sZnNhru+lVgKbDG7TBmdXmzGoDizQMUpAVXnP1VLps+Y2Z/IPBmqa66Na/Uv9MtkMSahiB7c/od
	OczjeGkxRDvtnfPiwmuHdDqAI/WitLElIFDysuqXDZqPcW5+rA7XjqZS7nL17eSWfzcTK/IRPWw
	R9c8kyqlcYPKywibn1DYzaj8sN8w0GrCCyUE8yEQJH6pYGje5v9QqqgqJ/rZzd5niQ2zE8rkJoV
	FBJqUDpupdCr/ZL/ZaJALpUWmH1zss8LEQttA9tzbYQCLmxX+tPy7CChl4QseLWIRfk0v0kYGS6
	HvinKWDv2ome1utXytQ==
X-Received: by 2002:a17:907:da7:b0:ba6:4e0f:e3a8 with SMTP id
 a640c23a62f3a-ba64e0fe96fmr255493366b.12.1776676413745; Mon, 20 Apr 2026
 02:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417102423.40984-1-john.ogness@linutronix.de> <20260417102423.40984-7-john.ogness@linutronix.de>
In-Reply-To: <20260417102423.40984-7-john.ogness@linutronix.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 20 Apr 2026 12:12:57 +0300
X-Gm-Features: AQROBzBFzwZjKnl1G1tdRS2Ou-R7AD946TWfN1m6T1SB5R7GYFhUWIOiSo5U3-U
Message-ID: <CAHp75Vf4YZVqXa7eH-RFeVsycdzoHijcWFnUbGv2PSmtPya1-w@mail.gmail.com>
Subject: Re: [PATCH tty v3 6/6] serial: 8250: Add support for console flow control
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Ingo Molnar <mingo@kernel.org>, Osama Abdelkader <osama.abdelkader@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Gerhard Engleder <eg@keba.com>, 
	Lukas Wunner <lukas@wunner.de>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Joseph Tilahun <jtilahun@astranis.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 1:24=E2=80=AFPM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> The kernel documentation specifies that the console option 'r' can
> be used to enable hardware flow control for console writes. The 8250
> driver does include code for hardware flow control on the console if
> cons_flow is set, but there is no code path that actually sets this.
> However, that is not the only issue. The problems are:
>
> 1. Specifying the console option 'r' does not lead to cons_flow being
>    set.
>
> 2. Even if cons_flow would be set, serial8250_register_8250_port()
>    clears it.
>
> 3. When the console option 'r' is specified, uart_set_options()
>    attempts to initialize the port for CRTSCTS. However, afterwards
>    it does not set the UPSTAT_CTS_ENABLE status bit and therefore on
>    boot, uart_cts_enabled() is always false. This policy bit is
>    important for console drivers as a criteria if they may poll CTS.
>
> 4. Even though uart_set_options() attempts to initialize the port
>    for CRTSCTS, the 8250 set_termios() callback does not enable the
>    RTS signal (TIOCM_RTS) and thus the hardware is not properly
>    initialized for CTS polling.
>
> 5. Even if modem control was properly setup for CTS polling
>    (TIOCM_RTS), uart_configure_port() clears TIOCM_RTS, thus
>    breaking CTS polling.
>
> 6. wait_for_xmitr() and serial8250_console_write() use cons_flow
>    to decide if CTS polling should occur. However, the condition
>    should also include a check that it is not in RS485 mode and
>    CRTSCTS is actually enabled in the hardware.
>
> Address all these issues as conservatively as possible by gating them
> behind checks focussed on the user specifying console hardware flow
> control support and the hardware being configured for CTS polling
> at the time of the write to the UART.
>
> Since checking the UPSTAT_CTS_ENABLE status bit is a part of the new
> condition gate, these changes also support runtime termios updates to
> disable/enable CRTSCTS.

...

>         struct uart_8250_port *uart;
> +       bool cons_flow;

> +       /* Preserve specified console flow control. */
> +       cons_flow =3D uart_get_cons_flow(&uart->port);

Sorry for nit-picking, but when I see 'bool' and see a getter, I got
confused. I would rather see getter/setter to be something like

    cons_flow =3D uart_is_cons_flow_enabled(&uart->port);
    uart_enable_cons_flow(&uart->port);
    uart_disable_cons_flow(&uart->port);

--=20
With Best Regards,
Andy Shevchenko
