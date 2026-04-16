Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF57337BB0
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776364264; cv=pass; b=NNm9s0Ox+oMWRuAYQs7z7xxrV4IZH5v/BOoMujuHR93cvXFX1XR1qIk2IMXaumjN/uAKIZ8QrFcZlEZ1j3+S82EY7nnPu6TSq9UTSjW1gRZdN81WqDibtNitx9V3rciUgm51pbY3HnkuHHPOZejV/dgPJ/aAqsWsojok4Krn1Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776364264; c=relaxed/simple;
	bh=9V/NgIDqmCWSet4JAHeO+a1W69OUhcxvhFFm3LJqtGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thmzsCZlTuQeShdU39PLF2Ezi1CBkOQNWSPOwI0Dr0jYbtNdceDjQYWcaCUeD54DPm+/w5FbTGvs5c2nON9UEo1L5HOu/Sj1X/HBdC5tZXIMZlbQ4tOGWTeO453JMGZPstrt6Rvp5gqXwWjPxpLjDiBt4T0OhB+l5U5wG0vqBg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6BBGJjH; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6BBGJjH"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b982b0889d8so1238654266b.2
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 11:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776364262; cv=none;
        d=google.com; s=arc-20240605;
        b=g/8LgS2EgCpq6CqcpVSG7ot961+AtlGoXUBsDg6vwFWdlkCqh0AmWwvzZ60peJsFsj
         NO70FZewcnWMMbIRzt3rBPmmcUDTE09hEkNEOoYHcQy8kaYszi7XvxkM4ipJXfIybTph
         FFl0z7JN6AI8V7Pf2yPsGBF5ZaJSNWu3l2PPt69pPBBhdUc61LmsTjwvu5OxkFIrRUz5
         LqXcAx8GvtK6YcmbwavUG2+u10JXN/0ErTnBfsoRu+5Z8an+3bH8FaPIcDeDTydYMVd8
         UF0vJgX/1xwJVSzgXz1ZafJmjdBe3S1oXEcete/oM9A7hK/mPsqcVpnDvIFvbCL2BTYj
         QHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uSfq+N7c4C45PaJOL/Ig3bRso+t9UaVHLgxuUSqhJ1I=;
        fh=B5B9kN+urLjMC1ap6EPWgtgxyPuRb8+wr4HehCKRArU=;
        b=LPxZuEc3o9NxgDK9ex4Pv3411hUE3AYk7jbDV+IpaNVPSxgCkYr4wZNCVinYGjtsf0
         fktI8WC583+ppVKIWQKZSfBX1rOF1PuI+NA2Zkfn0AhUz0RObA9fmeN/3xROuMEdWFpz
         7Uon/jBvV7/wtsLafiCRYn70NqdOvZwIvlkfE2ikHHm8ZT23xeuEYIZhv3U/BxuHac82
         Qk/RgMMBJCdbXR5AwK1YT6xkGyHZTVmloVyPcKC5FVyscQTCmgcczFm3wyFmwbnl0yQB
         PvuY5XwW+9BSdk330xHF3upEX8SVXqCnYZmLqVl9k9FC0u4zgUejkNddYzg4eWejaaBX
         5M+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776364262; x=1776969062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSfq+N7c4C45PaJOL/Ig3bRso+t9UaVHLgxuUSqhJ1I=;
        b=N6BBGJjHLKlkV8rHRZnosmdb/Pinlusht5StyFjePtVPoMheQPaclk8duUHmirxftt
         qUc8u0GZ5UBNxy7FjImHY6d43ON2NWeEH7TuYz0UhQwxV3B4+K89it2uouu1xs1AhFrM
         2X1ZOjQprgjdSpzaeEpI/37p42NPlyj+VIkKDFTNI+JJHV24HP9wqNBN53/z5BvuB1ce
         fxCUdSJ9pxtEs2Nhe+TNDteIhFhdkvkIzwtH+pWpenMiRBJCGC+jyrB6Qbn0XyTKIobd
         qERwtFsHZd66ISEatB1lRQ7IR6ZpeHUDP7abry3F/ds+6fZEPd07gZVmigQ1TSQq7KLG
         D7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776364262; x=1776969062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uSfq+N7c4C45PaJOL/Ig3bRso+t9UaVHLgxuUSqhJ1I=;
        b=c9R7VX+GHoNrCeNPY8BKSNzyzq4qM4pNkL34lKILXp7qd0ziRYNZD1uMfehWms0TpA
         zo0W3TZmW+kFBm48E9w2Lj/GZ4Q9Mqo5SMI+920vHI65kkA51GvmatWwXoE2C3o6/I0z
         W+lobVEmLeKA/BK2zp1p2ojtN+80PwyhMiZRFgKrJ8Nf6Zk9QaIXGNhS7f1w4NcQH/GG
         MiaJX3hnKuY56IS3R/pWFrV+nC5UfeYlT36IzABFdG1Ry3XwS8xr6CtcvbaG78Nser2K
         wO/+mERmUB07RHXYoC+tiRa0JSqQSd69tF2KfR05XAsVUrvW1xbW27K8zDmaSCOZMtTS
         DL5w==
X-Forwarded-Encrypted: i=1; AFNElJ+K9MDAE9aeYPNREEnL4wfrij4v11XWJSGrlnlkkSGg6LIuu6l4/waXa0aownnSjqiaHYEFDBQLYk78HSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9T2OcAXHzXSiS+5Qg7YtfKkdJvzhSpH4MaTXO6Y7rEb+qThSs
	LdXVw7fz8/kOCbpN4ISi4aZZZun3CiJs8yLNYnqTjx8E4MV0MNq6VWGnKuyiMr2Yh34VlHmhjAP
	2mGUMo9OAY9k2EQqi7DHurvB2r0le9fU=
X-Gm-Gg: AeBDievtoNejnBIz4UGOFqv2u4G7DdYch/C8DLckuJoTgSeN2mzkL5wz77TZjmtzJCu
	tzUQy5QWOxk8C2qA+ThJF6H2DLl6ZbpS+Rjd3TtlRqBR2cLMnKj1SCf+e46//vyU3228dbdJMcn
	de1fxNltgCX1BbYBAXfvZavLy6w/L/ollQatCB40bYty2riHDwwYbOz7Yp/j25Cei4/VxFzUcLI
	QnVr8phcGKQAZFB+UnaYdmr8wm7KccGwcySjQnnBxiqKichpEoSlDoAo8isuULkW5ShmD8vJej/
	dVyyUG/4cs+jsZhLAqFScwBPJmA510Dk1or5IEp3Br/st80Olkc/D27SqSN4+BMpTaIua8MqW7W
	zn8Wl68wRMlk3zQpp6Q==
X-Received: by 2002:a17:907:8b95:b0:b9c:2c55:3384 with SMTP id
 a640c23a62f3a-ba3dd7a7032mr27712766b.31.1776364261722; Thu, 16 Apr 2026
 11:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHp75Vc7sdDT+nWZX7u7aSsUhUquYNAiYo9HrxHhjXnGz5g55Q@mail.gmail.com>
 <20260416113200.38244-1-fushuai.wang@linux.dev>
In-Reply-To: <20260416113200.38244-1-fushuai.wang@linux.dev>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 16 Apr 2026 21:30:25 +0300
X-Gm-Features: AQROBzBq8G626U-dI8hSgPQ5GvJRB9HGPnluAuocrhQTXhKIW1aaqQq5dKOqtzM
Message-ID: <CAHp75VfyArBYG6p17A__hASERs6-rAp9U_NV68u5OOCUU_qoxA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: Clear CON_PRINTBUFFER on port re-registration
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com, 
	jirislaby@kernel.org, kees@kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, osama.abdelkader@gmail.com, 
	wangfushuai@baidu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 2:32=E2=80=AFPM Fushuai Wang <fushuai.wang@linux.de=
v> wrote:

> >> >> When two PnP devices map to the same physical port, the serial8250 =
driver
> >> >> removes and re-registers the console structure for the same port.
> >> >
> >> > Is it a real device out of there? Can you share what that is?
> >>
> >> Yes, it's a real device.
> >> In my Intel(R) Xeon(R) 6971P-C machine, the boot log shows:
> >>         [   17.242984] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud=
 =3D 115200) is a 16550A
> >>         [   17.251352] printk: console [ttyS0] disabled
> >
> >>         [   17.257934] serial 00:04: Runtime PM usage count underflow!
> >
> > This is strange, what kernel version is this?
>
> Please ingore this. I just test the patch in kernel 6.6. And this log
> has nothing to do with this problem. It was fixed in patch ed2761958ad7
> ("tty: serial: 8250: Fix another runtime PM usage counter underflow").

Thanks for clarification.

> >>         [   17.258360] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud=
 =3D 115200) is a 16550A
> >>         [   17.258516] printk: console [ttyS0] enabled
> >>         [   29.643013] serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3, base=
_baud =3D 115200) is a 16550A
> >>
> >> The issue occurs when BIOS "Serial Device" option is set to BMC:
> >>           Setup Question  =3D Serial Device
> >>           Help String     =3D Sets the Serial Device used to output bi=
os serial log
> >>           Token   =3D 9003   // Do NOT change this line
> >>           Offset  =3D 2F8
> >
> > Is it an IO port?
>
> No, Offset =3D 2F8 is the offset in BIOS configuration space, not the I/O=
 port.
>
> >>           Width   =3D 01
> >>           BIOS Default =3D[01]BMC
> >>           Options =3D *[01]BMC       // Move "*" to desired Option
> >>                     [02]S3M
> >>
> >> So 00:05 may be the BMC serial port device. From ACPI paths:
> >>         /sys/bus/pnp/devices/00:04/firmware_node/path: \_SB_.LPC0.UAR1
> >>         /sys/bus/pnp/devices/00:05/firmware_node/path: \_SB_.UAR1
> >
> > Do I understand correctly that both devices refer to the same physical
> > device?! How on earth is it supposed to work?
>
> Not exactly the same physical device, but they map to the same I/O port (=
0x3f8).
> They are different PnP devices with different ACPI paths:
>
>   00:04: \_SB_.LPC0.UAR1  (LPC COM1)
>   00:05: \_SB_.UAR1       (BMC serial port)
>
> When BIOS "Serial Device" option is set to BMC, both 00:04 and 00:05 are =
mapped to
> the same physical I/O port 0x3f8. And then:
>
>   1.00:04 is probed first and registers the console for port 0x3f8
>   2.00:05 is detected and also needs to use port 0x3f8

This is simply wrong. Do we ever support such a FW configuration?
Why on earth are there two devices for the same resource exposed to
the OS? It smells like a bug in BIOS.

>   3.Since port 0x3f8 is already in use, the driver must remove 00:04 firs=
t before
>     adding 00:05
>   4.This process involves console re-registration, which causes the entir=
e
>     log buffer to be reprinted
>
> Sorry if my explanation is not clear - I don't work with serial subsystem=
 often. :-)

Now it's elaborated well enough.

--=20
With Best Regards,
Andy Shevchenko
