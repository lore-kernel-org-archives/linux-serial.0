Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D7153B329
	for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188434; cv=pass; b=a1Ozb2MSog8x7j5MKgM3PljzIi+P5ZKXMGTF7Viepg/EkG/O0rWl4cnqAiHgYzw6PQWzWRVPNtuKNaGhd7htTXyXqH4eFOgWHlHskcSkArXI7u+XVFI7zp7RhADnRCDKW1yCgIiuu55N2gPcPVqgTX0zSOGLa0/irnP/g0WttXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188434; c=relaxed/simple;
	bh=CElcEHTV8j9fLleWJFKVU60iC5Y2Vn5eBcn2vHfWwRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyGSxXgnqh2ojwD1m905IUonMcNg3J2sQA2L381ivDHrp3VXD5IkFYTf3ugiKO0uc34pKocH+51rk1f/SVedEshrqw5/0S8iGrtSRtCSomj+G0ieHBXI7EYYc3fR/djMRlPzpkaY5L6eCbZy23eqye9fhI+HiTwLiceeq4nwZFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISOlrzXW; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISOlrzXW"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa1da63791so1891381a12.1
        for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 11:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790188431; cv=none;
        d=google.com; s=arc-20260327;
        b=o6tt2/BFABlQjcvVbVQMoQjSBa/E50V8Rzd500Uup+P6kUDjf3eIPwvySsDHT/+pR1
         v5KhL2Tq2E7wEre9V5Zo7M/1d0qLRAddHmoKyigFqpppcwG7R/1skYHPL/g2EyS6cwd/
         cfK2U4jAF3XMQis2kBcdUpGNEu/XxZTxZ7YDoSItAxJhNdi1sRtJZfRWG2P6MO7QbkTQ
         XfbTpNeLAmeRWVYVaHAxQFuLI4kJLREoCcVBUthbBmPCRGsMwHn0yvYrh75y08+4jOl5
         7EqKSXFVw1lqt6LdHfcWiG+k/5bf5Xt1A0caaOpma6y6WouuN1/dT5mCH1ZLTXzBdZUD
         HitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xWLnpLG+/xCQzg9TUwjuoEhhJm7Z/sPAqn8dxe76jpM=;
        fh=Qs8o4c02DbEnLt6ItQ0zf2/0vp3J+hILC3S+ZClGB8s=;
        b=h2BbKtA2Cb+TQKdCblV43qJXrRVV6rwhFtryBibii9GAAWrfNj1bv0qQWjyMB7K5F3
         khQ6wA0IuD2PUaBK+dob53DKjmwpMN33xiD7OIYjsNJyS/dxTRU/mr+QP97FIbIOAgyU
         dCCwXy06TfPEevJuIGnwQ3bayfe9EBoIpCH2TGoNuvAw9V7p/H84s/qK4aLyGQOKvfqZ
         D+wxJ57SSwBHXSkhhWGS6Gm8IjuTL+xsUrpuVvnOrm/vDpjeYjtxUaze6TOOkXYvcw27
         Bl0cl88q8yIVGBzh7/DTt9HIp9XVjrnage1InApGoKABT4y2AUNfZgIlwy7cO6d0fL0j
         NabQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790188431; x=1790793231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xWLnpLG+/xCQzg9TUwjuoEhhJm7Z/sPAqn8dxe76jpM=;
        b=ISOlrzXWsccaU25hNuSdFL0u52nvkxBpHw44C+Znba6emZx7ibOrDHPdSktH7iLTnr
         0m4OjmYqoL3j47ONYuS+Jgwdj/ClZcN76i+OD7O36Fpw0GKviz+3DVwgkvLoXd2ZF03S
         47t3YyXiExjQo+//K5m89otBMrzt0tcGlEAEenRHjIr/zZikgFXoEFtJUYUAYROlVwqr
         AUjGUlUrwB/AdW7QBWGclSB0UxaAoXxPNQKmGFnZmFAvsqw1DIAPjgjngXX+J0Cv3ANC
         xqBAcsPocVcEUPB7SglKSaQD4KlVm+15Pg6jayskF+jBBeRKIoAArSjEQHnSQszTueIa
         H7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790188431; x=1790793231;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xWLnpLG+/xCQzg9TUwjuoEhhJm7Z/sPAqn8dxe76jpM=;
        b=yKh4gekXg3JdE+jyfyOJVnrqlGyZtGmwcvX6D5zmPuS0yYZPT0leqi0qpuSb99vJRW
         cSH3PMZBMsJMrdBW+Z8wdGq3zzCyiaAN5o72BF5zUlEScJNRFazK5CAkIMDF6l3+siUP
         gBlMgNKClJC0NNKn7i3+Y5iW3JF1+o1mgPabtGRZS5JnwJBPkMXvAeFdehIr24+Y/1He
         dabLihRZk3nFX15ua9npMX9KCwrRwVLcqIYSbN6VECQoofazHiLdHjzqmkXWEnHtJYpF
         +UoGV7jNut03qt3tYXqI+SoauO4P5cWNELQfdtqVg3sQFIk1jF1gTz1S4TyMu/eWS6YS
         kI6w==
X-Gm-Message-State: AFuF++nRG8W6gsSiMrTLqjX+W3e5emFDpUOH5jC9Q2W8vls11bpg6PwX
	OB6VMIQ3HXls0o03ZxfX+zrYHB30K7SRvpc4DjzPKhFhrtk8UOWJ/iEQKaCT/4zW/waO4O3p8U8
	TPZxkoAXRbNALpL/O0H4FGTUSy3iHi+fDwHm0
X-Gm-Gg: AYBFou0t7/WnuMhM7zL3uQW/4z5vWdDPCb4oKRstNPXgiLfdgnSyyxH/2TD+1a0GBSO
	dad1WpnWRdUNBdKy+r9+Bvbg0K9sy7S2ljzmvq845H0JoKH6QqYBX8MDOIOBYkXfnxmpIFBmpqP
	okFQCx18fR/2vXjOFU2/qjhDxS+jSXtsRXPcO5QbzKDNo0634nDLBwCZ5wknNGPH1rlHQ9Dy65M
	nO8rHVTGUrMjsLkLJ7Bjs6jwdAeqq0XsVF6+WcmcAfYglTXYLjgoWiO4dGQuvxFDeg2apceLu+4
	iWdaHmvHBhEcGuwyYhArLmBoMNieSbdo+vAAaOWWhpfBv/UiRJe2WwDdAV5rQAxvGUZt97LWMvz
	Zqfs6FdAuD9MZW2MiuqTzyYm77MdV4sqXJPv6QJ4COKGd3hJGTjmsgc/emXV+W79KySH9adkKwL
	I3PoqeKmCNN5CHxVV0jQcSXJsfCzbTOGg/he2TX5dJxZPohFNTxKpkW1jXPXyEGtiYzz+UzrDBu
	IgT
X-Received: by 2002:a05:6402:44da:b0:6a9:232b:ec6d with SMTP id
 4fb4d7f45d1cf-6aac90c176amr37825a12.41.1790188430470; Wed, 23 Sep 2026
 11:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902221709.340393-1-rosenp@gmail.com> <2026092326-python-dugout-7b05@gregkh>
In-Reply-To: <2026092326-python-dugout-7b05@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 23 Sep 2026 11:33:37 -0700
X-Gm-Features: AclHuK8NujiV0_j5LaQJveo-PMbdxd-TdSj89jEnHI-dYfRz6WNVHLu2U9RoDK8
Message-ID: <CAKxU2N8nYJVWftvmPaOytxj2Cd97kKS9-LRcJ-sWzttibqYJdQ@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: Add Armada 38x earlycon support
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 5:22=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 02, 2026 at 03:17:09PM -0700, Rosen Penev wrote:
> > Register the Armada 38x UART compatible with the built-in 8250
> > earlycon implementation so stdout-path can enable an early console
> > without adding a generic ns16550a compatible to the device tree.
> >
> > Keeping the vendor-specific compatible avoids exposing the UART to the
> > generic OF 8250 runtime driver while preserving the DesignWare driver
> > Armada-specific runtime handling.
> >
> > Assisted-by: Codex:GPT-5
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/tty/serial/8250/8250_early.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/=
8250/8250_early.c
> > index 44ec209f37c4..265d49850e15 100644
> > --- a/drivers/tty/serial/8250/8250_early.c
> > +++ b/drivers/tty/serial/8250/8250_early.c
> > @@ -175,6 +175,7 @@ EARLYCON_DECLARE(uart8250, early_serial8250_setup);
> >  EARLYCON_DECLARE(uart, early_serial8250_setup);
> >  OF_EARLYCON_DECLARE(ns16550, "ns16550", early_serial8250_setup);
> >  OF_EARLYCON_DECLARE(ns16550a, "ns16550a", early_serial8250_setup);
> > +OF_EARLYCON_DECLARE(uart, "marvell,armada-38x-uart", early_serial8250_=
setup);
> >  OF_EARLYCON_DECLARE(uart, "nvidia,tegra20-uart", early_serial8250_setu=
p);
> >  OF_EARLYCON_DECLARE(uart, "snps,dw-apb-uart", early_serial8250_setup);
> >
> > --
> > 2.55.0
> >
>
> How was this tested?
This is actually a bugfix to avoid having to add "ns16550a" in dts,
which arose from a dt bindings commit asking why "ns16550a" is even
needed.

Anyway, the actual earlycon functionality was probably tested on a
Turris Omnia given the author of 62480772263a
>
> thanks,
>
> greg k-h
