Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0A2367DF
	for <linux-serial@vger.kernel.org>; Tue, 30 Jun 2026 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789770; cv=pass; b=a5UuQU+1BTw4AhcyjszSkQ4SYzy+ypwbZMSC1yoMf58Q/yOU0wiaoGIBRx/+WvfgJxifgoYRyfvozo3OujdyARBr7zb76wnZGGo9MKKi3FnoyZojBVyLRPjJsiNEfsj3yWH0hJBPzbZRyCkfrSvmD9qWk2nIyqdF7TFQEBlp7LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789770; c=relaxed/simple;
	bh=exeKnUHavp/OKrHftRTzlqh9NDuuC1kbg/uZzf/tCB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhSD1JOxygr+VvIdzuy4tGyFa7O0FvqCkiwrgwsvK2sykyS4uaJEYTiaitrBHBKJ2kECW1viEa/mZ7GWEWv26j98meLXSbgZaDUiBltjhHKoPmlE3h8bIAut5IuB6TLzmvzcTg3ZIXAn0V3ve90dAND+DLGnfGLUo4/MoYqKY8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKZBjU08; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKZBjU08"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so6871641a12.2
        for <linux-serial@vger.kernel.org>; Mon, 29 Jun 2026 20:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782789764; cv=none;
        d=google.com; s=arc-20260327;
        b=MzdrXTj2R6mneMtjkWPoDTKMdCv9XuMcNPvX3iC81UjJlEe8QANL9dDvAAnVUmYw4G
         V3oP6zvpY9oMamMpgUrr6SalOMOC7hLGxwpiMwGc/523+xEMIciol3oalH3tc7jBlt6B
         T+upVEb5FL2895VySnDfpOfoUyRrCY2dHtaNhmpLeJzH6GPGoZczCqO2hocH4YPD5bun
         d8cfPIc0Yzg1fP6Fe9lw92LIu6URIfulZy3WtCuAv9Q9opDfp7OTM69v9PTHB12xHFiR
         2hceMgqVwW37mYxkXJrOdePH7EcIwRABncuxmoeVnUnYIXK4gKEQjGoGqQqLLU2wp3a5
         8Quw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5t0Z8YH1W6ojWYQbuId+EJuIef6/fECfTrP9ygzO3Us=;
        fh=zsqo88KEtf5YQGBzCMBENfIF6O9bFYRhq1syo0//hg8=;
        b=D4TCm8TE/jRYstBU31Gz2RVMB23XUHmohYWLeCRu9TkjCLf1xevBCqqSmxeMt+fK9G
         Ocl4IG9dD2Bobt3M8+moQ7V/qsLqljsDCA31x7Olop4a6RZG8IF7qMsgLHYlvyeRkOHv
         4xFkgNOofg8dEcPhOqdW18taJfKyGRHCHnkGmgj4sAaQNGqShD3SGmi/f72gBqsiKg6S
         Oj4NGDPhZ5wUXrJsag9vtCDgJzVlU4OcsAu/3EpCAU4J9S84R9zB2ka4mol62H7GJKjM
         cnGU9pjmvoIlD2555X6sf/NDI5vtCNtby0iC2EtIvg46vmArZ+RqFmIyeBKFQuddAIex
         +n7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782789764; x=1783394564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5t0Z8YH1W6ojWYQbuId+EJuIef6/fECfTrP9ygzO3Us=;
        b=KKZBjU08ki+m75JYuFallJjK1SVF4oL3LQd63eE7arBAhbPTHBWorc9XCoG4rx1HsU
         4jdhFYf33l2h3R1A+eyBL6sBbHdPOD9mb4i4UlB9dmNAv6vQNfY98ki5vJzw7Jgj9m0p
         iPQD24K6EXvbV+tNtN3l+kMsfGnbkqMnYrrgXLTAg1uRpJ7ziZNI3Zwj+PfZ6f/ZpOqh
         xF+H9lRRW/q4HN4jexSIOnFGbbNaF7ySiWyFT9Ud7MTBcv01I2AbEHeg97KchOqtIo3H
         FB18R8VueODaFGN4P2ITXl+GfRqFjzORIv43PFpmA3yFlEPqa9qNylLhpkq/lPC/hakj
         1vuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782789764; x=1783394564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5t0Z8YH1W6ojWYQbuId+EJuIef6/fECfTrP9ygzO3Us=;
        b=flQnsXGEhxXNcRCsRJpL0Wb6pMA+rBWkUIwfbTaJ4N3TaCyCcP+xMfH6DlVh+ym04X
         YkS/Ak0B7nHAU0zJD5/1UrfUi1Eez66+bNfECq+ML8JfkqT3WmIVwW/pP3J7tSW8uTFr
         deReohauzdc+AVugR8PJClbbKROPvLka2Nlsgk/HGoXgahE6OJinuS3Lcgr5C8OCYTi3
         FwsGsJTwmN+gu53wM/WtbR85O6GqW/jg/BPCo1eZFlGapwAa7Xk19d2GSgkR7xBEtEMH
         3Z6t9qa722tanm9ZUfQLEQB3WkJTK6zymrUAsBI8wZo0W2Qb5yEbpsCSSKEjB5GASisc
         PPng==
X-Forwarded-Encrypted: i=1; AHgh+RpuaVExbhaUzwjZrkV9e33Ty226rE4InppkVyKcl+pfcMMx+psJUM5tZb0Lo5RKgLWNjWtnmvKSRBTlQaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo0uQUT613y+C+1tIAwwcfOPgWbBKwASF9XTkQRZ/tP4ILFDH9
	2Vfkoy0cYFBj7TraLE1LRh26702bIpZPi3PZi7EGIiMKqJesOY2+XJrr7BAwBU51YXv2/TNNepc
	w+PumsvyC+YsxQD/7nwWyzTgJhxz+Rsg=
X-Gm-Gg: AfdE7ckNSXW0ngyiadEFGh/y4OMJkI3CWeTKCXcVeAyQfX82a2nYRNWqByz+w6P7wXC
	qubYKG/cyJREbtt6t7dXrn0NL+F8FO5cyZJAoJBw+nWxmpbNjaYdsL5X+wm1aM64VXZMLlqYOZL
	zyoNe2MRsf2gMCYfKTQlQuyfiBUqjELCMYNo9WndD2Vd0IYe3dIpRjL79/PHdb387Hddlv2JZSW
	BDryOr+Gl43k8i66htJFhZmOw3HKfhDStpZm2gDAiRCm6pY8H45k4FflSy8TrVCS3dJI1YBPabQ
	bF0Jr8XieMZ/wv9FHTNHG/Na6VwX
X-Received: by 2002:a17:907:c9a0:b0:c12:696b:dd78 with SMTP id
 a640c23a62f3a-c1287289985mr52985166b.39.1782789763503; Mon, 29 Jun 2026
 20:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616173240.3665059-1-bestswngs@gmail.com> <DU0PR10MB538744C92335756B7F125867E0E42@DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM>
 <CANgPUi24wvQ4CLMozb3EBAC-5QKWiMHWpoCQgsBHkG+vZjHALg@mail.gmail.com> <DU0PR10MB5387B831C4F2240AC3B03984E0E22@DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DU0PR10MB5387B831C4F2240AC3B03984E0E22@DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM>
From: Weiming Shi <bestswngs@gmail.com>
Date: Tue, 30 Jun 2026 11:22:05 +0800
X-Gm-Features: AVVi8CfJQcYoiMZR5w6DvUVzxIeWsToljnaZvTXs1mfyEV4ivv6qkONI3rTb7GA
Message-ID: <CANgPUi1ZWrv2ahDcPjWKsgaZikYMLntCxR9cV7TAVHpXxQFwxQ@mail.gmail.com>
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
19=E6=97=A5=E5=91=A8=E4=BA=94 15:14=E5=86=99=E9=81=93=EF=BC=9A
>
> > > > The receive worker walks gsm->dlci[] without gsm->mutex while a
> > > > concurrent GSMIOC_SETCONF -> gsm_cleanup_mux() frees the DLCIs, so =
the
> > > > control handlers can dereference a freed gsm_dlci. v1's NULL check =
only
> > > > narrowed the window; v2 fixes the use-after-free itself.
> > > >
> > > > The fix pins each DLCI the dispatch dereferences with its existing
> > > > tty_port reference (option 2), so the data path stays lock-free. Se=
e the
> > > > patch 1 commit message for details, including why the late destruct=
or
> > > > uses cmpxchg() so it cannot wipe a re-created mux (Daniel's teardow=
n
> > > > concern).
> > > >
> > > > Changes since v1:
> > > >  - Fix the UAF by reference-pinning instead of a NULL check in the
> > > >    handlers; no gsm->mutex in the data path (Greg, Daniel).
> > > >  - Pin every DLCI the dispatch touches, not just the addressed one:
> > > >    MSC/RLS/PN operate on gsm->dlci[k] named in the payload.
> > > >  - Add a base selftest (patch 2), as Greg asked.
> > > >
> > > > Verification (KASAN, panic_on_warn=3D1): the originally reported sp=
lat is
> > > > the gsm_control_reply() / CMD_TEST path (see the Link in patch 1). =
A
> > > > reproducer targeting the MSC handler crashes the unpatched kernel a=
nd
> > > > survives 270 race rounds on v2. The selftest passes on both the cle=
an
> > > > and patched kernel (pass:3 fail:0 skip:0).
> > > >
> > > > Weiming Shi (2):
> > > >   tty: n_gsm: fix use-after-free in gsm_queue() control frame dispa=
tch
> > > >   selftests: tty: add base regression test for n_gsm line disciplin=
e
> > >
> > > So now there is a race on device node level. We have the old virtual
> > > gsmttys still waiting for the current pending operations to finish wh=
ile
> > > the reconfiguration of the ldisc triggers a recreation of these. How =
is
> > > this handled?
> > >
> > A pending gsmtty operation stays bound to the old object. gsmtty_instal=
l()
> > takes a dlci_get() and the gsmtty ops use tty->driver_data, not gsm->dl=
ci[],
> > so an open fd keeps its own reference and never reaches the recreated d=
lci
> > (a fresh gsm_dlci_alloc()). On teardown gsm_dlci_release() does
> > tty_vhangup(), which unblocks the pending ops, and sets DLCI_CLOSED, wh=
ich
> > every gsmtty op checks first.
> >
> > This is the existing tty_port refcount, and the receive path here uses =
the
> > same dlci_get/put, so I don't think the pin adds a device-node race. Bu=
t
> > you know this hardware better than I do; if there's a path I'm missing,
> > point me at it.
>
> Sounds right. Thank you for the explanation. My tty internals understandi=
ng
> is rather shallow.
>
> > > PATCH 1/2:
> > >
> > > > -     if (addr =3D=3D 0 || addr >=3D NUM_DLCI || gsm->dlci[addr] =
=3D=3D NULL)
> > > > +     if (addr =3D=3D 0)
> > > >               return;
> > > > -     dlci =3D gsm->dlci[addr];
> > >
> > > Control octets can be transmitted on non-control DLCIs in convergence=
 layer
> > > type 2. You do not guard against invalid DLCIs anymore. Same for para=
meter
> > > negotiation and RLS.
> > >
> >
> > The checks aren't dropped, just folded into gsm_dlci_open_get(), which
> > returns NULL for addr >=3D NUM_DLCI and for an empty slot. But hiding t=
hem
> > in the lookup makes the diff read like the guard is gone, which was a b=
ad
> > call. For v4, maybe we should keep the addr checks at the call sites an=
d
> > et the helper only do the locked lookup and pin, so the guard stays
> > visible where the DLCI is used? Does that match what you'd expect?
>
> Let's revisit the code for gsm_control_modem for example:
>         len =3D gsm_read_ea_val(&addr, data, cl);
>         if (len < 1)
>                 return;
>
>         addr >>=3D 1;
>         /* Closed port, or invalid ? */
>         if (addr =3D=3D 0 || addr >=3D NUM_DLCI || gsm->dlci[addr] =3D=3D=
 NULL)
>                 return;
>         dlci =3D gsm->dlci[addr];
> Without the addr >=3D NUM_DLCI part you access the dlci array at a possib=
le
> out of bounds index if the received data was broken. Let us keep input da=
ta
> validation at system boundaries. You also risk dereferencing a null
> pointer if the requested DLCI has not been allocated, i.e. opened, yet.
> Hence, both checks should be kept in place.
>
> Best regards,
> Daniel Starke

HI,
v3 has been sent. If there are any issues, please let me know.

Best regards,
Weiming Shi
