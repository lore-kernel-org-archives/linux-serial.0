Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792665030;
	b=3utSDAyAsvqM9B3I2NFJiUFzw3kM+HjI3MkaqwV1ewKgffGNvAb8iDmybssRuQ26390p
	 lJKWrQxG1P0tPzYUV9AB0M/jQySOxA1AuhJdLHF6RIq12QJf3j4TbgJi1kAWrX5ewsJLF
	 aGW3wrneM827epJ1HcHgqATsRNWNI8A4nHSJjxfxd8dwXvpSAt+wMFtZb4fJoNVzTPzSX
	 GvsFFdzv9ehT0c6Si2Kx/veJq1PB5fbJur07I/QFD3pukAhu/+AX6mNbJguzLJv7kwFCZ
	 W6jklccZENRRP3Qmxx5t/WEE2a9GJq2UbR7QTKAkUus2d8enmuE2JmgHzSWkUvYa5Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792665030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=BEhHwxYzSMiJvLdiI5HQibRaFl5gonBn5xrnfJkUhrQ=;
	b=OYRCx3IImTxarKLaul0ruVNY1vuxQ+dBC9FN27iWTR9ro9g0rVvdWzTCcdgpeNiy7snB
	 tpfAjyTwe8Q2Q9ydXukeq5b/xxrLqScoUaUKL/IMUXVjQUPXlBrvJfoeOWKpL0He6KKPW
	 r/2xyuzlgVeaL3awD4B6avqPgMFIGNhsU/qVIc/ACSXr0a7kMjNi1qYi2N9z6NmbJWu1F
	 /OndluyMOhr9pLYGXx1Xn2z3x6gCNbKU6Y4OtEgJG1ktrJvCSHQOp/TekIg2fIfLr+t3X
	 t2adgYd3avnONbJUuZElPqoFyjjpgOEIFNa2YlalhGhff7K1qrUi864p0e+GjpfhaQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nN9VfXDM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACBC606A31D
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 10:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ACBC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nN9VfXDM
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b06c0794cfso18599827b3.0
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 03:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792665029; cv=none;
        d=google.com; s=arc-20260327;
        b=YgjKGUFKC0GR/0Q2cXbTs0aIGyWSncXaQqSZwPgBs7YMdUE89siNKsrv0q0Ak9qd5w
         OlYlkqJLJi6dIPAN0kXLGsqU3KE27RuxCRbo0tgg71bCIthFyrYkC+ZL1BuBx0ngHHOi
         IqKpW0Xi1fVmawz/3rKCwv4YiSn7ONFGRxveN93fYCvSdzXrVwDFRDn9P3qTv3fLzVLT
         VK33WCct3WZdu1tbkW3/NRjB4xxbhbSoAMv7hKZsLP222IZ746N2tTnjWhNcMhRr3Km4
         8K8fHEQ3VpJ4C/u3VEpvA6BWzmE1QHT9M+R6G529GrGiMMxkVWflCUWKNKaFNbAA/AYD
         Mt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BEhHwxYzSMiJvLdiI5HQibRaFl5gonBn5xrnfJkUhrQ=;
        fh=qZ+seXf+f2TsJGAcBan+zfngSJsoMHLyq6CoMxxVLFE=;
        b=h2qwMj88pNJsMR76J2IiU5xuXAFc5gIEiZ7aUoZK1KdGjK+5bVRIseEGhXC7fmSfRr
         QOpAgpiNwowZHc3YDTqbhj/AbV3Aauaq9I40xbOg03XCBFm0v+af0K1+N6j9dIr9bKnw
         UqZMjPLa9zcvO16oa90A4t7ACynPMUMK6UR+ZUlv3ZDhtFNoX0S6xvvv33CRXrF5BKVn
         W1beRb2JY0wTdcx6dWit6Bff6OW5lvNXfFXUbMZL3Xp4OcHg7qszFwukmH8jcOV9vrt4
         xIUq9+UiK8eVyvQ7cvOboXmzQmGNqS8sk/K/NtKflXxb0/Vq20nAhGZfvuEhFkg10dPl
         O4cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792665029; x=1793269829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BEhHwxYzSMiJvLdiI5HQibRaFl5gonBn5xrnfJkUhrQ=;
        b=nN9VfXDM0FsUz/mrgy4GZLzQ3MXPeOinIlG5V7+8d+qY0GDkEDX3vx7k5ULeH3SX87
         n4tDI1qa2sGwlUL2bC1psW5uXmYXP1jTWLPm2j/eBKEzGO4TNP8CGXcCSB0TYQQKoNrf
         K31SH4scmVzJCb3yVmwYF9bQC89rcwL3F1V3QYEcYJ1k/lvXd0GrXzHCHp+ef7aGRPDQ
         xjjW75TtK3W/5KkYjbUXiKEdXLqaARPOt7Eabp1zA5WF/KHwkgc+3sPkSVZJn6NV0vtr
         XhbFcwwkxKudvC4WN0nQ+p9qLLxmeMBNkGz8tLilb+cV+q5VXo5xVWj+erxEV0+jgNgB
         fDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792665029; x=1793269829;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BEhHwxYzSMiJvLdiI5HQibRaFl5gonBn5xrnfJkUhrQ=;
        b=E3mwXrSq7bSBCnohny8UI5hieWqTnHahnBtEWR7pvz0+bMMmKXWPioVtFd8AAGJwFV
         YcyumipTdSOx5WiXrYK2MRqHDH2ZoAqm519mObKxXwN3sFzda6T+W8o79pKjV9LzNtNH
         6Y888ityOvuIx+fZIZph2ZzlYZjXesKcDMBeW/GhUIhJRiLobNKcFDU+k0HNFHJUA5TO
         vMlEnMgJxuo91g9PAhpyrrC5uB4Audg1ZXVy0cOG5F1jvp7VOwQHieSj3/ZCBw700VfO
         cvbOmG7Ko7k1hHNBBosCskBiAjs6y7FNeIwnZywkqg/SfxW9MlF0esAUUzVJVPnn+6kE
         6YbQ==
X-Gm-Message-State: AFq9FYJXh5U3vAp17W7cz6CnCA3ACBDKlDOLToIevNb7nG7Be3IaHV7M
	XjkalFCUbJzTDi9fmn8Xjz+0j3eO5TkPS9gvJvMhudRKGw+EDiTWuUNHfIDnP9MMo6r1vK5qokg
	cquXAeH44UVUsBloZgKC9b1hlmjrLqU8=
X-Gm-Gg: AYBFou11sc/JZxMJADQiFAyKcUVjuRcaf6SiNQECTpzT674eMsUQ4lnGHckZQKQg9/t
	2kMgE8FgQH82dqJMxN/M4Sbje7lOPsdREBDzAjEom3Z8MlzB0Iwv9pIJK5NHExxkNrb74KlHwF8
	3j/UJmzq3J9z9pIJSukfQaPK3H8AX5j4kfbJtpOsn7tEjGfcZi0jM4xt3SRoxOSNmKhjxu7eY+o
	8EZ7sUiekhpf13tEgfxV5gweY1cYeXIOFn2owOCaJNOIwT3Dj6q34IqIfhAG1vDXp0ZtgGEGZ4b
	nPCUX6i5YwlJaWkv/g5csyXx6C//1+pxPuE3jX46S7KkcjWZbAC+/MqQHX9ovCAktzLdHeE7ZFR
	kl10+KG73/AxYBziJrr5hWWlDZX3CDNz2Ve84FlOqCgpKj+VYqY+2OMkPPv/CsegwqXHo++w=
X-Received: by 2002:a05:690c:6e83:b0:88a:4770:c2e9 with SMTP id
 00721157ae682-8b133cab00emr32482837b3.14.1792665028968; Thu, 22 Oct 2026
 03:30:28 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com>
 <20261021-g2ul_sci-v2-3-b4e038220018@bp.renesas.com> <sashiko-outbox-180298@kernel.org>
In-Reply-To: <sashiko-outbox-180298@kernel.org>
From: Biju Das <biju.das.au@gmail.com>
Date: Thu, 22 Oct 2026 11:29:57 +0100
X-Gm-Features: AclHuK9NxPFgx-jqOft8MHFpJQqezzJagWJDKOJP_AqiRF8xMdXQyhKNm1Uf3MY
Message-ID: <CADT+UeA_z=6o32GdhHD9KrmMpW3WRcujcED_ZvCGSoi38jrg+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] serial: sh-sci: Skip TDxE clear when hardware
 clears it automatically
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org, kvm@vger.kernel.org, 
	wsa+renesas@sang-engineering.com, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 2:22=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] serial: sh-sci: missing has_tdxe_auto_clear init in scix_early=
_console_setup()
> --
>
> commit 7c4175b5ac1e1b0c0d116921a097acf598dc7be1
> Author: Au Dang <au.dang.jx@renesas.com>
>
> serial: sh-sci: Skip TDxE clear when hardware clears it automatically
>
> This commit adds a tdxe_auto_clear flag to struct sci_of_data and propaga=
tes
> it to struct sci_port as has_tdxe_auto_clear to skip software clearing of
> TDxE in sci_transmit_chars() and sci_poll_put_char() on PORT_SCI variants=
.
>
> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> > index 58120b523ca1e..aa179c7874878 100644
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -913,7 +913,8 @@ static void sci_poll_put_char(struct uart_port *por=
t, unsigned char c)
> >       } while (!(status & SCxSR_TDxE(port)));
> >
> >       sci_serial_out(port, SCxTDR, c);
> > -     s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(po=
rt));
> > +     if (!s->has_tdxe_auto_clear)
> > +             s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR=
_TEND(port));
> >  }
> >  #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE ||
> >         CONFIG_SERIAL_SH_SCI_EARLYCON */
>
> [ ... ]
>
> > @@ -3791,6 +3794,7 @@ static struct plat_sci_port *sci_parse_dt(struct =
platform_device *pdev,
> >       sp->ops =3D data->ops;
> >       sp->port.ops =3D data->uart_ops;
> >       sp->params =3D data->params;
> > +     sp->has_tdxe_auto_clear =3D data->tdxe_auto_clear;
>
> [Severity: Medium]
> Should scix_early_console_setup() in drivers/tty/serial/sh-sci.c also cop=
y
> data->tdxe_auto_clear to sci_ports[0].has_tdxe_auto_clear?
>
> When earlycon is enabled on a renesas,sci port, sci_early_console_setup()=
 ->
> scix_early_console_setup() initializes sci_ports[0] from of_sci_sci, but
> leaves has_tdxe_auto_clear unset:
>
> drivers/tty/serial/sh-sci.c:scix_early_console_setup() {
>         ...
>         sci_ports[0].cfg =3D &port_cfg;
>         sci_ports[0].params =3D data->params;
>         sci_ports[0].ops =3D data->ops;
>         sci_ports[0].port.ops =3D data->uart_ops;
>         sci_uart_earlycon =3D true;
>         ...
> }
>
> During early console output via serial_console_write() ->
> uart_console_write() -> serial_console_putchar() -> sci_poll_put_char(),
> s->has_tdxe_auto_clear will still be false on sci_ports[0], causing
> s->ops->clear_SCxSR() to be called in software instead of being skipped.
>
> >
> >       sp->has_rtscts =3D of_property_read_bool(np, "uart-has-rtscts");
> >
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-g2ul_sci=
-v2-0-b4e038220018@bp.renesas.com?part=3D3

Modified patch based on above review.

From 0efbe7abe7fc1ec3354fcdc1f4c02b77eaac7904 Mon Sep 17 00:00:00 2001
From: Au Dang <au.dang.jx@renesas.com>
Date: Mon, 19 Oct 2026 18:01:11 +0100
Subject: [PATCH 3/4] serial: sh-sci: Skip TDxE clear when hardware clears i=
t
 automatically

On some SCI variants, the TDxE (Transmit Data Empty) flag in SCxSR is
cleared by hardware when data is written to TDR. Clearing it again from
software via clear_SCxSR() generates a spurious TXI interrupt, causing
the last character to be transmitted twice.

Add a tdxe_auto_clear flag to struct sci_of_data, propagate it to struct
sci_port as has_tdxe_auto_clear, and skip the clear_SCxSR() call in
sci_transmit_chars() and sci_poll_put_char() when it is set. Enable the
flag for the PORT_SCI (of_sci_sci) variant.

Signed-off-by: Au Dang <au.dang.jx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit header and description.
 * Replaced the PORT_SCI check with a has_tdxe_auto_clear flag in
   struct sci_port, set from the new tdxe_auto_clear field in
   struct sci_of_data.
---
 drivers/tty/serial/sh-sci-common.h | 2 ++
 drivers/tty/serial/sh-sci.c        | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci-common.h
b/drivers/tty/serial/sh-sci-common.h
index 273856fbc20b..b75e5e1d3075 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -108,6 +108,7 @@ struct sci_of_data {
  const struct sci_port_ops *ops;
  unsigned short regtype;
  unsigned short type;
+ bool tdxe_auto_clear;
 };

 struct sci_port {
@@ -163,6 +164,7 @@ struct sci_port {
  bool has_rtscts;
  bool autorts;
  bool tx_occurred;
+ bool has_tdxe_auto_clear;
 };

 #define to_sci_port(uart) container_of((uart), struct sci_port, port)
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6df25fef5a5f..1a4d9467d2be 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -913,7 +913,8 @@ static void sci_poll_put_char(struct uart_port
*port, unsigned char c)
  } while (!(status & SCxSR_TDxE(port)));

  sci_serial_out(port, SCxTDR, c);
- s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
+ if (!s->has_tdxe_auto_clear)
+ s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
 }
 #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE ||
    CONFIG_SERIAL_SH_SCI_EARLYCON */
@@ -1063,7 +1064,8 @@ static void sci_transmit_chars(struct uart_port *port=
)
  port->icount.tx++;
  } while (--count > 0);

- s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
+ if (!s->has_tdxe_auto_clear)
+ s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));

  if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
  uart_write_wakeup(port);
@@ -3664,6 +3666,7 @@ static const struct sci_of_data of_sci_sci =3D {
  .ops =3D &sci_port_ops,
  .uart_ops =3D &sci_uart_ops,
  .params =3D &sci_port_params[SCIx_SCI_REGTYPE],
+ .tdxe_auto_clear =3D true,
 };

 static const struct of_device_id of_sci_match[] __maybe_unused =3D {
@@ -3802,6 +3805,7 @@ static struct plat_sci_port *sci_parse_dt(struct
platform_device *pdev,
  sp->ops =3D data->ops;
  sp->port.ops =3D data->uart_ops;
  sp->params =3D data->params;
+ sp->has_tdxe_auto_clear =3D data->tdxe_auto_clear;

  sp->has_rtscts =3D of_property_read_bool(np, "uart-has-rtscts");

@@ -4088,6 +4092,7 @@ int __init scix_early_console_setup(struct
earlycon_device *device,
  sci_ports[0].params =3D data->params;
  sci_ports[0].ops =3D data->ops;
  sci_ports[0].port.ops =3D data->uart_ops;
+ sci_ports[0].has_tdxe_auto_clear =3D data->tdxe_auto_clear;
  sci_uart_earlycon =3D true;
  regs =3D sci_ports[0].params->common_regs;

--=20
2.43.0
