Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48D53F166D
	for <linux-serial@vger.kernel.org>; Thu,  7 May 2026 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169372; cv=pass; b=rFHzb5GPDHK5bFSw9mkCvlSDj6qXVp3CqZoErkczHNPG10K6X77H0UHZHYdG1ABr2uGm81wlIw35xpcZHcEb+XyI8etFOptgR+Xc/I31fHueGzEbzS14a/g8oLsvGjMTFF0EdiuQh6jlTT1nODvO/frPvId5TJVQo5d/Bsb9COE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169372; c=relaxed/simple;
	bh=pzVUaiZiI462LSeAjzmpXCABHbm2I68wOvx3INAMRKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YweTWxBG9pWO0qayggaS6nh26MvdverqNZwFjUAOPEOyKVR2kxrEhXeMkrZCtfr8K484ajiHqvkAUjxbyrrIKtsAbeCLkOScdV6MoX48msx4IzArf9Fjo+6Li3YAp8d9mWKf6iEoI+5i/Pt21GBMVhVxOLys5D2Q28b4A1mFW2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpPOEKhk; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpPOEKhk"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9358dd7f79so174582066b.1
        for <linux-serial@vger.kernel.org>; Thu, 07 May 2026 08:56:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778169369; cv=none;
        d=google.com; s=arc-20240605;
        b=Z32sUwo3YFIwWi8M+GEi6y4NwK61ruJtOeVGFtJ084C1ciFuvCuaHFWbn8fiCcIHeR
         cS+G918EVimLF4d0KFv82PrMaabZexUhHIOEJrB7CecjcuTBbi8I3rP74fQqFYeW0PXT
         psZwM/j0UkuMr8IbQ0Ro0nq7XQOSp9Nl6k78/TXQUT3a3HW/uKRTmFhj7AUlBcJ+vCUt
         cx/Ud1fwMKqUyX3mOwFj8aij+AKKFuGHtdO+4NIYlQdeN7Oo/8f8jaCVjmzOocm9yigE
         R3lFXOBcUVbcdW07mHxOZVrnZqlPI7UKldJ1wKnK9cOYPDgYF+JOoxb1abKemou+DLQS
         70ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tZnLb1HQGSLjbJmS8evDaKXMNv8pyjgwaBOs2Nqrmp0=;
        fh=TwpSndFb28GJvBx6vIAq2u7EREhFTEHmyLN5vb/M4N4=;
        b=Ep3uGD1f6JNFbYjeYK9rpBHrPO4DW5v/bpBMBHTKkpQCa1DiUq0Z93DD1jE5O5OdUZ
         N7OzK299LYaTiiZCWzrXLVuooyTIq572ff6EtEPuPCskeNxNHzqzpjFQPVeyvmCJ0HkJ
         JHqA+KhNS1rS/tNO7jazYd5ezo59Nv8rdo44gGMqzpSV6gFaVH3UWSrf0nLZUR6WiUIJ
         sGg/K8/uV2qjyQCHR8oCzS3WJAxB8x0TfL6ur6TG22dv7oOw/jQOwCHYdkMWX8QHJmWr
         UK9ZjyLf03eoOH9/E5EZbgbhp4gwykm8zEEj+frMu4z+QBb2Qqa/NW/leMTy84mIEJXo
         /VXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778169369; x=1778774169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZnLb1HQGSLjbJmS8evDaKXMNv8pyjgwaBOs2Nqrmp0=;
        b=JpPOEKhkJThWK+T/4GtR3HqRYy+3d8Yn49pi79Afi3Nmi6CJ2cRklk4YCbCoFbAH9k
         QSTWKEihHHx7pqR9vCmf+tB8fEJ8ILPBLIzLjdlEFxFVomqyQH8p5l/EQLh56gZh3NSH
         kwB/NTjRbCuDCKAh9npf9SN5g4+pobJB0j+AK4cXGHAWkA8T2IyRg6JUbi8ny1CYiCrC
         qKhcJTwKim067Z8FcLuojlmVrCTramYvA/MgLawg9XKkUwralCwzeNIdtUwmhKv9IH9e
         Pz/g3YJVB4TYdUnjHM2lKtX1ve8lEAH6wtG0bKWxN3vh8tWDQikI00O/XXIHdmXrHhov
         3Jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169369; x=1778774169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tZnLb1HQGSLjbJmS8evDaKXMNv8pyjgwaBOs2Nqrmp0=;
        b=RmuQM+i6Dho43ldyOXfy4vayK1CZRGrnB1jDi0tByhCVajOjklKAgqwtMxf3/7SjUj
         6wBj6JuoM2qarb+4JgRD76ETNtXblOBlGrcT1wzf01dWnC37WiK/H2i9ofUSd1LnbMQy
         7ZGXWpBaKtXk7ZY3DxWwiDc435CfjQR8NrCWvPSsgmImAifZyjOXDywYRLAYyimqTs0A
         4UWfTnEMaf740jHX/HSZR/awp91Bbq1hHJFinSYpmyzNk4Jzg0EhIDGeVVds1iTH8f2K
         1WRwi4c2JcvafNpQ3OWLtaUFfrAC7xa2Uw/2hcFpyucur16SMCtABXSvAM9QdnBFsSQi
         1puA==
X-Forwarded-Encrypted: i=1; AFNElJ9yN9Gj27HZWmoNgd1BAlzton/zQLL6syxrl2QG0gO8eIhCXtSD30xM9l7cLcQeBx/uEk8X64R/SVxGcdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXz6Ds4DMYuxQTgRvZAghOa5VXZZoqBoHdH+2DpNJ6nkJlxoA+
	1WrlW78krlbDMYDXGM3Ljw/DLtKG3lwKQtUXU2UVv27epWqOi3e0O4uokk6Z5iLLl0p4C37XhmB
	66ZVBQbt/2Pn3O9JEVFB7xdfmJLy3s0M=
X-Gm-Gg: AeBDieszLyy9EEHTdnMjX1E6J5i+nz3uJX5mjx1JSeswCc5UBJHVyB4VXi5h4iRR13L
	+aJR90s6zhD/nzyDfnH69m1v7okQY6BkdRISNoL7AcKvWKFUdBW/aUtPTOKQwe1J4Pv/6hqeXSa
	DGJi5dKeZ1UvxfCyjziDbhlRtFitJSeKDLRLzLZOCJp094OkuiEvDDoDZut158Y8M7EoDxkuyF9
	Mzyt42d2CXU+ESfgPF8uQr+JDIQflmZyualZ+U691BQNbb+qg8GpQB97wLXRirqS5QYFnI6zIpS
	rZk9rLYrByW9iXFth2RIgsrwnaafPg1uJTqbU/Wfe4J2N5YaLI/4dGO52nTHH7UjF6rHwA==
X-Received: by 2002:a17:907:26c1:b0:bc9:ef67:3ea9 with SMTP id
 a640c23a62f3a-bc9ef673eeemr134499366b.37.1778169368665; Thu, 07 May 2026
 08:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506124643.128021-1-geert+renesas@glider.be>
In-Reply-To: <20260506124643.128021-1-geert+renesas@glider.be>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 7 May 2026 16:55:41 +0100
X-Gm-Features: AVHnY4J3gSuHJu_9IGGrqCXhoyZ3XPxDCslG6bnaa_Q7FaNolHXC1lQvxolbGqU
Message-ID: <CA+V-a8uO2L-Ha49+PxRV49Y5RWzvaVA1PGwigtcwPQS51u=+hA@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Remove plat_sci_port.flags
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 1:52=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The last setter of p->flags was removed in commit 37744feebc086908
> ("sh: remove sh5 support") in v5.8.
>
> Link: https://lore.kernel.org/CAMuHMdXs94k3-7YD-yO7p2=3D+u8waYGAz8mpP5LDb=
Mf3szt4V-w@mail.gmail.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/sh-sci.c | 2 +-
>  include/linux/serial_sci.h  | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 6c819b6b24258d36..a35230d57540384c 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3369,7 +3369,7 @@ static int sci_init_single(struct platform_device *=
dev,
>         }
>
>         port->type              =3D SCI_PUBLIC_PORT_ID(p->type);
> -       port->flags             =3D UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | =
p->flags;
> +       port->flags             =3D UPF_FIXED_PORT | UPF_BOOT_AUTOCONF;
>         port->fifosize          =3D sci_port->params->fifosize;
>
>         if (p->type =3D=3D PORT_SCI && !dev->dev.of_node) {
> diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
> index 0f2f50b8d28e2743..36c795d61f7e8457 100644
> --- a/include/linux/serial_sci.h
> +++ b/include/linux/serial_sci.h
> @@ -51,7 +51,6 @@ struct plat_sci_port_ops {
>   */
>  struct plat_sci_port {
>         unsigned int    type;                   /* SCI / SCIF / IRDA / HS=
CIF */
> -       upf_t           flags;                  /* UPF_* flags */
>
>         unsigned int    sampling_rate;
>         unsigned int    scscr;                  /* SCSCR initialization *=
/
> --
> 2.43.0
>
>
