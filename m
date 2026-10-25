Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.222.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792949894;
	b=DXEwFlk0D9ove6U0Fbif7IZQxP0QBQc+LPpD/tu3rN2Zk+L6/T9xrBjCbql9zdJIHA3C
	 4QUeN4lGalGd8nSvA+d8gQJHt1UL8wMwr06iW6C2Zv5kj2OpUgr4P3wKZuCDFCzrcLb+R
	 op6jjvZtZHR8r9JezDSV95CmFzmLoXrcyfMSUr7j+gfeCSo0vFnQjd9kUvUwSxlESnikC
	 sDZvxRamZQY58UkifCUQ4e0eRY0zayn/XhPl6MV+jkUWQRzmH/f3SMIt/WjoPQVTfqfob
	 QgykDVhdTVc9MbfhUaxD5AWRaSCXPmPZ1wCCvtB6tIn9a3cb+OTlOMffoYKTI8awCyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792949894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HnZXVXFJcjscxnrsOc4diI+ORhtNKVuKMIKyqdM2PuM=;
	b=NKSAQ26lL7cdCXwLl2JplMSdalv68uFZ5Ou4Pzpk+VRiTBBccvZUpba4DBDM46nbjswx
	 BVGz+dmlFlc7eCzc0An6ZW3Um0xJuzvcVcz6nDtiQTcQ3nzeXpBTsY+TOP7k1GZ338Ocy
	 XtEaMn0XyJPzAITIsCOO7+ttVPo0JLqx39b+1XHCy62ViIEWGng3FcdvpF7TK2tobu10/
	 tLxGgc728LRh090QmBykJqTNRtTewuS3O14SIG/Dry3qz/yODJRDJ/8JYRsIlwwaEeYGV
	 Y00OPoFadtl5LemG1xgLKxtvbIGFXF6S15ogy9T0FkVd6AGG7zL7V17JCruofXioxBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nIkPcrj4;
	arc=fail smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00D606A31B
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 17:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D00D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nIkPcrj4
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-99071945aa7so1351896241.3
        for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 10:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792949893; cv=none;
        d=google.com; s=arc-20260327;
        b=NxHpE8YBZWYYZepyEMmLeUKwTkV1bLZaaHtVB4t66SyX84Jxmmj5mjOOEGKE/ui85g
         U/mxY8uHkczXzU0R7rny+Tj+hon+mXfmpKpCtjoU3LY3ldbJ9c8OIO8WcqthRS1A0650
         AadcD9lxP3VMCJMOH/TrQYe2ek6ZcXsPX8/8tbHi7UtxYDXo2NRL8CYrTucG81kUa6bm
         8qFzYrz9aqp8nGJXsxkwJD6aYsDCrg7Rtp7he74mY4K0g6hyUz+f4oNdKbhYjt20wH72
         deQNi3OC0PWGAv1Z72kRL1Q7M4lpXpaB27xwWCNszCeNuOPmcy46OpzR3yvy0it00MnU
         ktdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HnZXVXFJcjscxnrsOc4diI+ORhtNKVuKMIKyqdM2PuM=;
        fh=HZfVLYEPZdDfOJZhabNgR0swGgbib2VczEPf15sW1rI=;
        b=H1EjmrwHo/cTmm88kulclnxaZ6ahnMpmxvRe2HJaYupVNrxRp0bl7TL5aVK0H/ikd6
         eUtL2J0H99mMeoKiXrdjChP7dbKjIVMfBP61vUndSZyHQ2Ik1dg9IOyY9bTpC3jHeYEw
         7uEmuVF65ujYB78AwLUpfgnlLoltLHTlByhyS8NDBY+UUJe/Mf/h816+QxszjWFEqzuU
         S+jEuztDYrBKFsG3toiiSRuCFL0l72d3Bv5fEk85NTdkn85REwWiKpTu7XNV41dX2H7m
         qla3q8EocgCfHg8DUaVFuuTCIoieqoEyP0y46UamuSw5KF3WqXvA4AcBsSB+Nvz45AYy
         e0Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792949893; x=1793554693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HnZXVXFJcjscxnrsOc4diI+ORhtNKVuKMIKyqdM2PuM=;
        b=nIkPcrj4adrfpAUrnBjpXJhXo/oI3cDEOj8KZyAVt8jj+1EStmwZqQx6GSUr11keuw
         w87YVz9pZMNT+G+C1BdlQnlBHofrKt1dh4OOzzwiKPq71UzNF+gAcValpDFmvoB7lG8G
         nmBVsbkZc3GW7xmnz2JnQCeo4huxSWLe3l9ead1ZSSoGlt80L5FzQomyf4dzsYjT/gUB
         9XpTqLaQv5GCGA1NfIwCYuxaQ6d8ANH3T28JrOdK4QsmRTtjeytvJHDrtiTQfRxvWNX1
         LR41TNA2Ed4NX5bRprt64EWmwRD+zEUUvdkH6Ro6UX+A8eaE+uCMUFZZkL9piVK9nvUq
         JNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792949893; x=1793554693;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HnZXVXFJcjscxnrsOc4diI+ORhtNKVuKMIKyqdM2PuM=;
        b=dklMN2gmq6Jhg5Cz75jHrT/VYSFvRg9V9B2jqDsXgTTW3IRwzPWAqkSnuFTKWn7ndC
         cnAkZkfmGxLdLk3yAqjjifHz7cA4fBhmrRdPg/NWjpQZ7CoL2ByI5VF0Vsm+zD0TSyox
         Kas1RqqLHpPoh0CTEPXQkp9jJIpRZJcx2q5LWXpsWWkOHZIHwNt983ay3INStkx40V4e
         kYgYTqASxpJxttuFrq8k+0v5WQIdGs+uSOMve6m4axtTfXTIaHkj4TKXidWXxpmWoTrk
         XQnZ6mqfD+N6P3Gd9Gt+chNQ3ePzOFFVsoNi8q0N1GVPN5dVj311C6hKjgnRxxc1A1RJ
         UFuA==
X-Forwarded-Encrypted: i=1; AKwUvBzhaZBLysmqXNdI2VFjAmGVt9a9TqVYVvMN6mkNcgbxLlrMqaDNqAmGSKbdvRaHjTeuxjgn38+QM9jKhK4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1nhXGwpfv4BVB2oldSOClVjCrmGBVUQ08Lyw/SAZhDKrZEdsQ
	OZCzR9iC5S3Q693O2zA6Qv8sf9lR8Ey7wPuFZ/rZXOoPlVphXpgqExGGwb3QPXoPyjDupiuoFaV
	9DkjCAZvMBHxZ7yoHA9dX2uRNV+cLjsed5daW6uM=
X-Gm-Gg: AYBFou1wEwrnJBFbwItWMtGc1kii2xe/N2cPjAKSZYJK6KQ8qiUN+eB0VKvFk6Cjogz
	4HOOSZKV5A+ebLm40LbaFlxfMcnl7RMoLEOUL1YJ7sUgUROLilLCqTP1ZSAwzVaoY/7VOU4fCxw
	6Y7Kl4lgRi8hcVGAVCbZSlPf9uqXtTlvUDLavXht5AyunAc1Xd75oNokTtFcehkn81oV00Z7GeK
	yjXCKhDqj9pd7r0pSBi4/ukl8iXeVejcAgoWwlA0dvPFja8PxdrbCgJGqgxoih4CJzUoUj5Zshb
	78KpejNGNMItsU5le0RuCIfDij/RLYI7/RI/ORI1YtDOC9eZ0R3fTHkdtn/Wzmlo3KjUxYV13Wi
	i3zwNwyC/OYXCVkJe59gMv1/5JOzKCJvPzPmREIXqLhkvwppoSQV3Dos/VveFnTQKKFiT8hCR9r
	QuQHinPZi8ZzqdwgYjo8HSphgOcVKVtur7NX79IgMJqzmO1VpjIOnI4KTm3wFQVCtZbMEcrfGiH
	VBNqAwkbbUZrtPWvSkkVdo3fZ7oOytv6hxb1b67Y7pPa+G4u90=
X-Received: by 2002:a05:6102:c8f:b0:7c0:4d52:8cc9 with SMTP id
 ada2fe7eead31-7ce5cc8d55dmr1213666137.14.1792949893405; Sun, 25 Oct 2026
 10:38:13 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com>
 <20261023-submit-h616-uart-fifo-v1-v1-2-e4a3bae2eba8@gmail.com>
 <atseYvQUYvpMFEIM@ashevche-desk.local> <CADvTj4pRW9q6VyQ=nLi8q0mMF8LgccfO4eqAeqgzzgOkDno1dw@mail.gmail.com>
 <CAGb2v65LVm1GV2kV4bVO8YJd16tkubHOvXUtbJ3uuBw2O3TBsA@mail.gmail.com>
 <atywVnHU5NsP_gOP@ashevche-desk.local> <CAGb2v64P2rM0VnFh0NfNhi+3_xGPYkxt2j+2hmBMu5ZvugHRow@mail.gmail.com>
 <aty37_xHO-QRa7hQ@ashevche-desk.local> <CAGb2v66jqrrix903k2OT-z0kV-9XWm6LpXmHQsCyLL5P6uXD7Q@mail.gmail.com>
In-Reply-To: <CAGb2v66jqrrix903k2OT-z0kV-9XWm6LpXmHQsCyLL5P6uXD7Q@mail.gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 25 Oct 2026 11:38:00 -0600
X-Gm-Features: AclHuK9ADptacPxgJpmNc7NJsHyAAEhwuFjXIctIvJ_VhKssk-2-2xQxAyeIEHs
Message-ID: <CADvTj4p1vxCUsNk98Q=TRkvtZQ4LzXNY9V-2GT30aspRGUgrsw@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: 8250_dw: configure the Allwinner H616 UART
To: wens@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 8:10=E2=80=AFAM Chen-Yu Tsai <wens@kernel.org> wrot=
e:
>
> On Sat, Oct 24, 2026 at 10:51=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Sat, Oct 24, 2026 at 10:41:55PM +0900, Chen-Yu Tsai wrote:
> > > On Sat, Oct 24, 2026 at 10:19=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Sat, Oct 24, 2026 at 10:10:33PM +0900, Chen-Yu Tsai wrote:
> > > > > On Sat, Oct 24, 2026 at 12:12=E2=80=AFAM James Hilliard
> > > > > <james.hilliard1@gmail.com> wrote:
> > > > > > On Fri, Oct 23, 2026 at 2:44=E2=80=AFAM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Fri, Oct 23, 2026 at 01:33:50AM -0600, James Hilliard wrot=
e:
> >
> > ...
> >
> > > > > > > >       /* Internal 8250 only */
> > > > > > > >       UART_PORT_AIROHA                =3D 124,
> > > > > > > >       UART_PORT_AIROHA_HS             =3D 125,
> > > > > > > > +     UART_PORT_DW_APB_256    =3D 126,
> > > > > > >
> > > > > > > Why? Besides the poorly chosen name, what prevents us from mo=
difying the
> > > > > > > corresponding parameters at probe time by leaving the one of =
the existing
> > > > > > > types?
> > > > > >
> > > > > > The new type was primarily a way to reuse the core's FIFO confi=
guration
> > > > > > table, including the RX trigger mapping. H616 uses thresholds o=
f 1, 64,
> > > > > > 128 and 254 bytes, whereas PORT_16550A maps the same FCR bits t=
o 1, 4, 8
> > > > > > and 14 bytes. Overriding only fifosize and tx_loadsz would leav=
e
> > > > > > rx_trig_bytes reporting and selecting the wrong thresholds.
> > > > > >
> > > > > > The core already has get_rxtrig/set_rxtrig callbacks, though. I=
'll rework
> > > > > > this to retain PORT_16550A, supply the H616 FIFO parameters dur=
ing setup,
> > > > > > and use those callbacks for the correct trigger mapping.
> > > > >
> > > > > Please consider just taking the FIFO size from the DT. On some ch=
ips
> > > > > not every UART has the same size FIFO, so we already need to deal=
 with
> > > > > it.
> > > > >
> > > > > Also, FIFO size is a standard UART DT property, though somehow no=
t included
> > > > > for dw-uart.
> > > >
> > > > FWIW, it supports all standard properties for UART.
> > > > Check what uart_read_port_properties() does.
> > >
> > > Ah, that's nice. I hacked up something [1] in the past to get it to
> > > work, but that was probably before you added the helper. I never got
> > > around to splitting up the commits and sending it out.
> >
> > Hmm... The helper is in the kernel for the past 2.5 years.
> > Maybe you rebased it and it lost original dates?
>
> I had been carrying the changes locally without committing them. I only
> committed them recently to back them up remotely. So yeah, the dates are
> not accurate.
>
> > But if it's not working, we need to address that, I believe it should w=
ork out
> > of the box, because the same function is used across dozen of serial dr=
ivers.
>
> The new helper probably works fine. I can rework my code to use the value=
s
> given by the helpers and give it a try sometime next week.

I've incorporated that approach into v3[0]. The H616 DTS supplies
fifo-size =3D <256>, and the driver uses the value populated by
uart_read_port_properties() for the transmit load and receive-trigger
mapping.

[0] https://lore.kernel.org/all/20261024-submit-h616-uart-fifo-v1-v3-4-286f=
c1b8c3c1@gmail.com/T/

>
> > It might be an issue in 8250_dw.c, but I can't tell for sure.
> >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/wens/linux.git/co=
mmit/?id=3De7e0741fa04f349ad9f94a4059e32467a30ef5d9
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
