Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793178300;
	b=roSuxWzUiCgpmqtQsUixml8fspqVO7a6xC62wvIHr/+08k4pEDvJ4nSYVFwfavZPl4PZ
	 a+sTLuCVizno6Q7mIlhDYihpPfDt9Jnm5OhOsXmmmgs2RmaFtQKFVSy1F6vzBMwVrmMc/
	 xNLb824ullZC3joZNq70/JYVN3WhAOE9/jnbR/GjiM4zDiYSDIMayG1s65SuQdW9/4fIQ
	 OnQQBpy/4yB8gAR69X1TcDb9bBaC66qdeMbLVxgvstNMWSqRS099tQC8H5Qx2DPPjn8Qe
	 muhelfDF1l2XsVP7KLV+c8rllp7Vfn9Ts2K8GIQHEj9HM+DBB9P9BVEBq+p0SIXlIJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YMPvQ0y2/UErW4qcLjewTviEOS5UzV5x/LnfQYGS5D0=;
	b=zvTX+96Zby8w7SvZf+W9qGaLhlLaoowLb/++O/CZAuE2XODn9p0FhfWIedGXObDRLo11
	 yYHkZzzpTOj3k3Z2FdrxMtcjhMz0GHyLT+kEmWOvJRAx4+XoPyC/tX5w9YrMcDlDlBKDQ
	 fr/yWLF6xf3bd9iOZqz6jnucleXAcTg8HflJsECERfp0AfaBtYHVp/z1DBPCw1WxXmFYi
	 dKDCOee21hhFJNUOaNdHiWq8zH+yZ+B30MOqAvFTjK1VLozSspZHhtEdG323zV+TmOw9n
	 vZHNubjlxxOa6okU3hKtsEhtCpLiwrzCjNG+cL3/5Mlz/N4Me6EgUD0Avtw+Q4wlQPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Zv/eaVA6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854D606A31E
	for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 09:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3854D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zv/eaVA6
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so1536414e0c.0
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 02:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793178299; cv=none;
        d=google.com; s=arc-20260327;
        b=ZnRrBCzI/fEVBJsVoByAfeu15P43adi8fORkGC9Z7gEcQrsxmzo+WrTSVOlIig+Ju+
         R7tCAZpslc+g9LbbhkmdNvMG07QvqB6Mr17ljGFmNR2Wz2vuf/6zpe7f/ofVp3OUztkc
         E07NZzSYxhIcNozz52k/P5EQ7Cm40ZoxyhyknJikwD75x7qgVNHh/QXfqOQQkPcpwdLn
         3uZCKIzrgZvCi2uK3bU+BV4svOdpiU+Es/PaoZzgnYiNSVktB/3KnJMrRw1Po+zs0+SK
         xqbGbZ3y+WHfR056Ox0zujVuWmQaQkS1085P7+Am7Eej0EmYDzfcn3v/YqXyVB/xsmzs
         azHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YMPvQ0y2/UErW4qcLjewTviEOS5UzV5x/LnfQYGS5D0=;
        fh=GbshSB8EFMSYnbxm2RyaPRTpCjQzKnhBAtCUlPAH2wA=;
        b=sD0rkOTg6Tc0pfq7Sp/eHfUc2NTDjglU1avIoidL77cm56bYuXKDWTKxwF0yBggeLa
         DZzKaudR+/iUr50prWq1l4VIPLSsw+KqxGR+yMvMAnWmvYrrft77b5A3kyXAS5w6m1eq
         VrA8hSZbXfRRA6R0Ecm+i3Xf56ZWDoOzoPFXYUCs4cyZXFfy49TEm0BtsmFs/R2AGNFN
         0CABwc4LC9w6mov7h1DgwQMROcUg9KgSLv3YYUAW3CN4X0rfvljWbBV/1OCbDTX2hoCp
         g+FIR5KW0RfmYMpgZSIvx+QGRr6lT/+ATM//7pY+lXHTtEqNedO1fleZliC44W54/H+S
         3ySw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793178299; x=1793783099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YMPvQ0y2/UErW4qcLjewTviEOS5UzV5x/LnfQYGS5D0=;
        b=Zv/eaVA6lrScHL0q/Ho4LyoktOdLdPByjB2bkcl06fB/h4jrdPpHRQn4RynI0+1vbm
         D608JUJSXkkjPmHjkN3xUz/Qkn9L7ybWzyU1M7GphHIut/eiffBKweAlIujSMiMXcl0Q
         kshmlA/BuKTG0gjOgHX22dv12nDGGvfGWLpoqTECiH7jFdZ7zNrCM6eLeGBJmO/XIthK
         QuaImLqrlR1dzi5MSG26GJXW8YTU829VLyctOC52BFf2xgZm/o/mFR/JpzebWFU64weD
         MZMgys49V0tVh2K+uzJphy1r1Gtxc9ufNvmdUP4mrgiph/INC6Ft/KLMMJ19EA7gY0UB
         f6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793178299; x=1793783099;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YMPvQ0y2/UErW4qcLjewTviEOS5UzV5x/LnfQYGS5D0=;
        b=gcZI2/vZsVFAFLY/aHNs/r4V240opxzwRjISvG1+tLTcJsFF/mpOeca0kOKWHVIvDz
         PItm/+rL62mwH5dfoRbNVT/aUHxCs//2UBt9TCpLOPuTCYskY+Q08JT4zSQ8okgiDTAb
         wqUMZrGbvL07iIUeL1QALEIVDw944aBFxv+sEX3C5AbIspLW6KyzjrlxqIiiSNZYyRht
         zjKlsRq0p3lxKYoI3wsq1999LDKU60UEaoUwrwHOH+yMP1kV9Zosi1T2fmROUOo01qCq
         Pqw5tM2Ob5VRLN7hM/2wv+3+9BsxD+R92i4WNYB98f6W8DjJfH9/L5+ry1HLaTGpcvFE
         hRvw==
X-Forwarded-Encrypted: i=1; AKwUvBwWMZdrKvWSAJAPF0ndLhh/gg4Ag4wJ91zJsMSARlbchw/Q2qpH40PwzxZElTs83cMpoewKvToxILSARRQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6qD7UmBegmDdsdbBc9c+zX5QtclmbGSwbp7mHUq2WryPp4Lve
	yFyI2NAXCGiQheYPUnesNQIGaoYKD+Jj9COib2sw84wkeeah0v2EpIDkOAi6MeZ2Bxhg+Kq84ZZ
	OU7GFgRm+B/8GcDje3XWZ7IlpB1Es/xHLBDLt
X-Gm-Gg: AYBFou0LRtISNuUnK7guZ5aGgTXePvdMuyMv+sPRLSczPyIuTstONlkL8wNU6/ad37y
	8q/cho1KEd+5plB9hSHX9M25tbHaoi8ibObiPT0mT/3XVlkUdsz0ZxEjVXhIKojt9o+EKQicl88
	FfCkd/vFGMJsa07w03P0Mt+HOhwRskPL0v2tvC2NRXB7owtLwsCKs3RrQ3RP9DAUwx47NNIXpzc
	7Wuf/WpwrnIRTkc2rEqzTl6dBUfwKUadejaDYfApNpNjLGy9byPp0eOa8Ic1jFiRKTqYD9wyBuU
	IR26qR0pXECTn6qzm4YZml6GqhrbZdRV/EAQqT9bAkc8CEdAeZFaZ1CZqItdkTMI5+HXAYeD+U4
	J+48HBoTmgpfOhUCKnnOTXfjq4usbl3U2yFHnWimqgfkcgGBXjrOS6X6ssBRFfvN5gaqlFaxHJZ
	i0p963q+S3oaa17xAultoyO8TaZSvytP/+U1hXlYryyW3MRnNKhWWkkEyjFBh6wvZbC7QCaywQk
	ME1gzsD/KsSmW2WLicGeGjzBSMHDA==
X-Received: by 2002:a05:6122:3a11:b0:5e9:5e79:aa5 with SMTP id
 71dfb90a1353d-5ec4fffa0b3mr263672e0c.7.1793178299127; Wed, 28 Oct 2026
 02:04:59 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com> <10f350ff-8f82-4a3c-beea-4a02d0d179f9@arm.com>
In-Reply-To: <10f350ff-8f82-4a3c-beea-4a02d0d179f9@arm.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 28 Oct 2026 03:04:48 -0600
X-Gm-Features: AclHuK-gFIc4OLdQpz2xuDakOfWjCmV7F0pKVxznmCh4UQXGFX7ZPx8S3KT4ikY
Message-ID: <CADvTj4oSo7gXsqoLndTChgC0oaUGB9SB-4B4a1gEkx6XDFD7Tg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] serial: 8250_dw: describe the Allwinner H616 UART configuration
To: Andre Przywara <andre.przywara@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 2:57=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> Hi,
>
> On 10/28/26 00:05, James Hilliard wrote:
> > H616 has 256-byte UART FIFOs, but lacks the DesignWare component parame=
ter
> > register used to discover their capacity. Its debug-divisor and RS485
> > registers also overlap offsets used to probe optional DesignWare featur=
es.
>
> that affects almost all Allwinner SoCs, not just the H616, so should be
> solved universally, not just for one SoC.

Some Allwinner SoC's can read fifo size from a non-standard
register from the looks of it.

This approach at least allows for just adding SoC appropriate
compatibles with their fifo-size tied to the compatible. Or the
fifo-size can be pulled via that FCC register on the fly and
reuse the code paths here probably by tying that logic to
the compatibles as well.

>
> IIUC Chen-Yu has a patch to attribute the right FIFO size, in each
> .dtsi, which I consider the best solution to this problem.
>
> I'd say we wait for -rc1 and then work on top of his patch.
>
> Cheers,
> Andre
>
> >
> > Add an H616 compatible for the integration-specific setup. Keep the
> > existing 16550A port type and describe its fixed FIFO depth in platform
> > data. Use common Allwinner helpers to configure the transmit load and
> > receive thresholds from that depth. Configure automatic flow control,
> > preserve the BUSY-safe integer divisor path and keep the UART gate enab=
led
> > during termios changes. The H616 configuration uses PIO.
> >
> > The series first introduces platform setup callbacks and a shared RX
> > trigger conversion helper, then adds the binding, H616 setup and SoC DT=
S
> > changes. Based on tty-next at 6b4b543fa187 with the posted RX
> > trigger callback-lifetime fix [0] and DW BUSY-safe divisor fix v4 [1].
> > Platform setup runs before installing the BUSY-safe divisor setter.
> >
> > [0] https://lore.kernel.org/r/20261024-submit-serial-8250-rxtrig-lifeti=
me-v1-v1-1-731b78d5003d@gmail.com
> > [1] https://lore.kernel.org/r/20261027-submit-serial-8250-dw-divisor-v1=
-v4-1-41714a75e15a@gmail.com
> >
> > Assisted-by: Codex:gpt-6-astra
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes in v4:
> > - Introduce common Allwinner setup helpers with the fixed FIFO depth
> >    supplied by compatible-specific platform data.
> > - Rebase onto tty-next at 6b4b543fa187 and the posted DW divisor v4 fix=
,
> >    installing the BUSY-safe setter after platform setup.
> > - Use an early return for FIFO-less DMA setup, following Andy's review.
> > - Default to generic setup when platform data has no setup callback.
> > - Select Octeon's optional-register discovery with IS_ENABLED() in its
> >    setup helper, preserving the existing 32-bit and 64-bit behavior.
> > - Extract the shared 8250 bytes-to-FCR conversion, including the
> >    unsupported-table check, into a preparatory patch and use it for
> >    H616, following Andy's review.
> > - Set the fixed 256-byte FIFO depth in H616 platform data and omit
> >    fifo-size from its binding and DTS, following Krzysztof's review.
> > - Precompute the Allwinner RX thresholds during setup and retain the
> >    sunxi FIFO-depth helper for filling the table. Use named FCR encodin=
gs
> >    in the helper, following Jiri's review.
> > - Share threshold-table initialization and callback assignment through
> >    a sunxi RX trigger setup helper.
> > - Group and comment the H616 trigger and RS485 setup.
> > - Link to v3: https://patch.msgid.link/20261024-submit-h616-uart-fifo-v=
1-v3-0-286fc1b8c3c1@gmail.com
> >
> > Changes in v3:
> > - Introduce a platform-data setup callback in a preparatory patch,
> >    replacing skip_autocfg and preserving the existing Octeon setup.
> > - Describe each H616 UART's FIFO capacity with the standard fifo-size D=
T
> >    property and use the value already read by uart_read_port_properties=
().
> > - Derive the Allwinner RX trigger thresholds from the FIFO depth.
> > - Use an unsigned trigger index and conditional runtime PM guard,
> >    preserving error propagation when the device cannot resume.
> > - Rebase onto tty-next, replacing the earlier DMA prerequisites with th=
e
> >    posted RX trigger callback-lifetime fix.
> > - Separate DMA enablement into follow-up work, retaining PIO operation
> >    for the H616 FIFO configuration.
> > - Link to v2: https://lore.kernel.org/r/20261023-submit-h616-uart-fifo-=
v1-v2-0-af0593504635@gmail.com
> >
> > Changes in v2:
> > - Keep PORT_16550A and set the FIFO size, transmit load and capabilitie=
s
> >    during setup, following Andy's review.
> > - Select H616 setup through the matched platform-data pointer and remov=
e
> >    the type and DMA burst-size platform-data members.
> > - Use get_rxtrig/set_rxtrig for the 1/64/128/254-byte receive threshold=
s,
> >    with port locking and runtime PM around register updates. Keep the
> >    standard half-full FCR default, selecting 128 bytes on H616.
> > - Advertise UART_CAP_AFE so CRTSCTS enables hardware automatic flow con=
trol.
> > - Rebase onto next-20261023 and declare the posted sun6i pause/lifetime
> >    fixes and their prerequisites for DMA enablement.
> > - Link to v1: https://lore.kernel.org/r/20261023-submit-h616-uart-fifo-=
v1-v1-0-e4a3bae2eba8@gmail.com
> >
> > To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > To: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > To: Jiri Slaby <jirislaby@kernel.org>
> > To: Rob Herring <robh@kernel.org>
> > To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > To: Conor Dooley <conor+dt@kernel.org>
> > To: Chen-Yu Tsai <wens@kernel.org>
> > To: Jernej Skrabec <jernej.skrabec@gmail.com>
> > To: Samuel Holland <samuel@sholland.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-serial@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-sunxi@lists.linux.dev
> >
> > ---
> > James Hilliard (5):
> >        serial: 8250_dw: select port setup through platform data
> >        serial: 8250: share the RX trigger conversion helper
> >        dt-bindings: serial: snps-dw-apb-uart: add Allwinner H616
> >        serial: 8250_dw: configure the Allwinner H616 UART
> >        arm64: dts: allwinner: h616: describe the UART integration
> >
> >   .../bindings/serial/snps-dw-apb-uart.yaml          |   1 +
> >   arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi     |  12 +-
> >   drivers/tty/serial/8250/8250.h                     |  16 +++
> >   drivers/tty/serial/8250/8250_dw.c                  | 138 ++++++++++++=
+++++++--
> >   drivers/tty/serial/8250/8250_port.c                |  12 +-
> >   5 files changed, 151 insertions(+), 28 deletions(-)
> > ---
> > base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
> > change-id: 20261022-submit-h616-uart-fifo-v1-c5afcdfe5cb0
> > prerequisite-message-id: <20261027-submit-serial-8250-dw-divisor-v1-v4-=
1-41714a75e15a@gmail.com>
> > prerequisite-patch-id: d8219673210dac82d3adab41578ff2f76f5862c9
> > prerequisite-message-id: <20261024-submit-serial-8250-rxtrig-lifetime-v=
1-v1-1-731b78d5003d@gmail.com>
> > prerequisite-patch-id: 9a9395c715c2bf7bbcae5bdd16a339d7f2af6269
> >
> > Best regards,
> > --
> > James Hilliard <james.hilliard1@gmail.com>
>
