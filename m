Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A802930C153
	for <linux-serial@vger.kernel.org>; Thu, 18 Jun 2026 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781800802; cv=pass; b=kUdooPuRZcxPjBNoxxbNYpWHpe2OLrc5hd/sTrRI8CLezPdPxEMxyaFL2yAHUQNOuctzl1KjqEr3o+gWq1GoV8977D/LtkZF3ltBinB99XX4OsehqOv7RoEPxMIfkX8l1zZNkoMPYvBuidXQXhlC84z64cwZRslwg65hznvylRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781800802; c=relaxed/simple;
	bh=ZWeYY5EsOw054i6YP8butqMMDZMCJ6MTBzBqPzct8FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osBFwBJQBlp+A7Z+PrpVaVNIT9dWMSAt4IoeenVC/SdTjZ2UASgiHLfbJeEBF9qot9FY3IdFpcEqsinWyx8q2RF6QH/HfhtgWkwpMCz7Rv0xd7J6t3GOi7zVBZk6Jgt0x9qWJBATRQLmOjiHbAFbP+mgzd0EaP1FTxRUdD89EGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIEYXuLB; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIEYXuLB"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bf84a2b2077so147861766b.2
        for <linux-serial@vger.kernel.org>; Thu, 18 Jun 2026 09:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781800799; cv=none;
        d=google.com; s=arc-20240605;
        b=f2uiguG0tZtEDySN7ZJS1GT59PNVIEReQBkUoF1Zlx52CeavJmPMRV4wrgfD0PYLLT
         lxIknpgv1cp17wDoKSHjFcMBmVINaZBbwjLrn0dpGYPXPQRVt+GjUCnLRhxADzK+pYfY
         yTqxg7u8o7UBK/wxohpRA79RR4tedS0TGzE9rYY3Ti3uexqYmpcuq1arvDnqmZl23286
         QUkdjFJ4rT3Y2I9XBxWJ/eP8HHDExVgUvP1c0TwWlHaA1uwE0u4ED94o/HH0h+BsESa9
         M0D3CKq6HwBhX9rzGyOX/U05ANOAbv3FSoGZr/2KOMCUHeEH0xMalVBeWYrjIVjyYtk1
         cdQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3ylNEn1iXKNRmHKldiN/3uxktuPUhP+JK50i2MvPfZc=;
        fh=0yKNLOPeCGPNqcBSbLUCI0ketEwyPmwLPQ20XleiKpw=;
        b=KoRY3AQoXgjCLBMpf5R+ugloDAtDJ+0he9W3W1PIq5ytjBwvseomEAM+xA8jccfBpd
         qNgzQksGXTc86xy2ndSmHj15TB8hOAa1P0iW67HHVj/xtt0xkPnesDc3z55tMM/yTtfZ
         Itqh/9jNb7czn4WDFjY32tBPKSOC1QeIoNN+sOuHubdVJ7zFSqKlBUqCu3xw3bgYT4+z
         DpJYeSbEzt706G4TpW4MkjE0zkK07FadC5jqZ6O899ZNN63NXca63u1uQK87fT+Q3kDK
         WoM5x+tDQWnIXBJdpFNkx0XxSYyfyxyuFogBLFD3e90h/xIxnZEaoLhFG3Kozg7jNofQ
         KRdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781800799; x=1782405599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ylNEn1iXKNRmHKldiN/3uxktuPUhP+JK50i2MvPfZc=;
        b=OIEYXuLBn9OH+WzDdtCldsuCe5vlWnaCMxv2VU7f4Ksqu+CHEsqaYq/NquzC/OG1SP
         p+Wqdp0d38j3FDwxksRV8e6w0UO9iCCeeLo+h6n6qXApvlkxnPmDOmZIuAvJSXCjyeMN
         YYD8tt7eCT7dttuaDAu725sWZY5BMHlPcQOjUr59W6dlV2RnYjmW/XBp2QWMRBR3htTs
         pQYga3WpTt09UEOKXMCPW4jN4CwGQYuFD0+XTE+6tPRWS0GN99H08XYk5NAAcuEH77fy
         /zXjeWJomJon6boDE4Kr6mTKlvK4/SrMeXQUd/nxgovgPfklahi/VNKci3F5Imsxiuqt
         XHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781800799; x=1782405599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ylNEn1iXKNRmHKldiN/3uxktuPUhP+JK50i2MvPfZc=;
        b=W6E1VYeSsJg/H+VXaXqE0aWSVDBjxDCZQgS6cCL3mPhwWW6Xx0rzuPLecqmXbAA3e/
         ue00/CPCkrH598h1jvC2ehHVXoj1EcIJRNJizMHam6qzqcYajpSo1xRzPmc3zL6Gh0KP
         m5ZlAXR+ZnAMYnGEQTRGPp8sLf2f3ElLHZ82fY2LjfRJ2Z0kMIPNMq+mjeCbX5Yo6+5p
         Qoeay97yak1ipJEI4koDFz9Lq+TH5oSEzNwqfHP5V3Oc0hiwAYO9QEd8I4sK+4Viqg4Z
         Nd//SLEVAOPSy7h/xhgathkYn5dKgWj2EhITqk9gXNYDmeLpkEoAfkFgo3hngrC9UsFK
         qbJw==
X-Forwarded-Encrypted: i=1; AFNElJ/e7Feu/KTg9ZeydI1gaQzvCz3Aktp+7HwcB+jzMNwgCPqdKMdK8tU36RV8xUXcCFmyKs33oZZlkTiB8mw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+zt+33c3Y47Wb+UnpeQ27Pdh55XxUTojUsIHYJZ4iL5hesAB
	rAgPeqL6utWLa05WlE+evrQTRScTNNb9bAGco220XCEIUBg6LYoC5xOUnenNIKn0q/J7ERqBvga
	yRgTPAympONTFeW6lXqg3Q3pOewuQB28=
X-Gm-Gg: AfdE7ckEsWUXZExwlZfYgP+8uCHPHW7Bb7Xypz5ix9zhW4h3malGyg3ejAOz9yeXD0B
	aH4ACX8FG/vOG7r0JwaV8iNKCgbbalcoO1j9ehO1tRiAmmJ9FTFPiUjSXVPWKQyn5BZEytvpgGw
	CoKCm4mEX51GyLPpnxgwSeDOW3BAsULA1Oy1tG1N88hvaAG5cEfSZmY+XwS6cmdgRwQukprp2Q2
	2HPGyn0CRBYjEK/VanPqlF4WjRE/9hKDqFgQE9pPT+ShuGRLu4kWAV5h4VpBVnnst2RGlEa0gIN
	/DZKoeOr+MUjoqBqtwxiXWaS3RWiHajk3BaUTuvt
X-Received: by 2002:a17:907:981:b0:bf8:b1ed:43e0 with SMTP id
 a640c23a62f3a-c05a4f0705dmr601383266b.18.1781800798876; Thu, 18 Jun 2026
 09:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616173240.3665059-1-bestswngs@gmail.com> <DU0PR10MB538744C92335756B7F125867E0E42@DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DU0PR10MB538744C92335756B7F125867E0E42@DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM>
From: Weiming Shi <bestswngs@gmail.com>
Date: Fri, 19 Jun 2026 00:39:21 +0800
X-Gm-Features: AVVi8Ce0NUYYVksQhe4auyimCwK5nbJIygcAYXk976ZZ9WY7yLA2_V9yD9NVioM
Message-ID: <CANgPUi24wvQ4CLMozb3EBAC-5QKWiMHWpoCQgsBHkG+vZjHALg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] tty: n_gsm: fix gsm_queue() UAF and add a base
 regression test
To: "Starke, Daniel" <daniel.starke@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Xiang Mei <xmei5@asu.edu>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Starke, Daniel <daniel.starke@siemens.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=88=
17=E6=97=A5=E5=91=A8=E4=B8=89 15:26=E5=86=99=E9=81=93=EF=BC=9A
>
> > The receive worker walks gsm->dlci[] without gsm->mutex while a
> > concurrent GSMIOC_SETCONF -> gsm_cleanup_mux() frees the DLCIs, so the
> > control handlers can dereference a freed gsm_dlci. v1's NULL check only
> > narrowed the window; v2 fixes the use-after-free itself.
> >
> > The fix pins each DLCI the dispatch dereferences with its existing
> > tty_port reference (option 2), so the data path stays lock-free. See th=
e
> > patch 1 commit message for details, including why the late destructor
> > uses cmpxchg() so it cannot wipe a re-created mux (Daniel's teardown
> > concern).
> >
> > Changes since v1:
> >  - Fix the UAF by reference-pinning instead of a NULL check in the
> >    handlers; no gsm->mutex in the data path (Greg, Daniel).
> >  - Pin every DLCI the dispatch touches, not just the addressed one:
> >    MSC/RLS/PN operate on gsm->dlci[k] named in the payload.
> >  - Add a base selftest (patch 2), as Greg asked.
> >
> > Verification (KASAN, panic_on_warn=3D1): the originally reported splat =
is
> > the gsm_control_reply() / CMD_TEST path (see the Link in patch 1). A
> > reproducer targeting the MSC handler crashes the unpatched kernel and
> > survives 270 race rounds on v2. The selftest passes on both the clean
> > and patched kernel (pass:3 fail:0 skip:0).
> >
> > Weiming Shi (2):
> >   tty: n_gsm: fix use-after-free in gsm_queue() control frame dispatch
> >   selftests: tty: add base regression test for n_gsm line discipline
>
> So now there is a race on device node level. We have the old virtual
> gsmttys still waiting for the current pending operations to finish while
> the reconfiguration of the ldisc triggers a recreation of these. How is
> this handled?
>
A pending gsmtty operation stays bound to the old object. gsmtty_install()
takes a dlci_get() and the gsmtty ops use tty->driver_data, not gsm->dlci[]=
,
so an open fd keeps its own reference and never reaches the recreated dlci
(a fresh gsm_dlci_alloc()). On teardown gsm_dlci_release() does
tty_vhangup(), which unblocks the pending ops, and sets DLCI_CLOSED, which
every gsmtty op checks first.

This is the existing tty_port refcount, and the receive path here uses the
same dlci_get/put, so I don't think the pin adds a device-node race. But
you know this hardware better than I do; if there's a path I'm missing,
point me at it.

> PATCH 1/2:
>
> > -     if (addr =3D=3D 0 || addr >=3D NUM_DLCI || gsm->dlci[addr] =3D=3D=
 NULL)
> > +     if (addr =3D=3D 0)
> >               return;
> > -     dlci =3D gsm->dlci[addr];
>
> Control octets can be transmitted on non-control DLCIs in convergence lay=
er
> type 2. You do not guard against invalid DLCIs anymore. Same for paramete=
r
> negotiation and RLS.
>

The checks aren't dropped, just folded into gsm_dlci_open_get(), which
returns NULL for addr >=3D NUM_DLCI and for an empty slot. But hiding them
in the lookup makes the diff read like the guard is gone, which was a bad
call. For v4, maybe we should keep the addr checks at the call sites and
et the helper only do the locked lookup and pin, so the guard stays
visible where the DLCI is used? Does that match what you'd expect?

> > Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> > Cc: stable@vger.kernel.org
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Link: https://lore.kernel.org/all/DJ7OKN8EMAK8.22CE0B8NZXD73@gmail.com/
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>
> This whole worker separation was added later, not in e1eaea46bb40. Maybe
> worth updating to the corresponding commit.

I'll find the commit that moved the eceive side onto the worker and
point Fixes: at that.

> Also, the code comments have a strong AI flavor but AI use was only
> disclosed for PATCH 2/2.

Sorry, I missed that tag. v4 will add

Thanks for the careful review.

>
> Best regards,
> Daniel Starke
