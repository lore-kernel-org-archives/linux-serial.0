Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFFA3803FA
	for <linux-serial@vger.kernel.org>; Sun, 31 May 2026 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780214439; cv=pass; b=N2ZmROifpvotciCEOBh5LzUVWlxkVBZlCuyYpSvAkUqfoWemwAp5TG6W9ieGQiH0TQEkZ6xJsLmc+egwkUIQwfrVsr3UcF8qt+toLFRHa5oj5CUAeimUu1E0g2Hp+nhaAuKXaE9lf/GrS2mpGK0xy2CSPvU4RG66+MCEv+mCR2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780214439; c=relaxed/simple;
	bh=5EOku21r4shcDKnfEd+sX/o8iz8eGlTM8QXuTu8JouA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXNpNmUGkvNVCgCuxhK0xIa53gCftDaSqlqmHNL20lJjYhboYHKw5a+JveWxdNQquFVPE3goDjZVHHcxyph5ealAIwi2hFHoK0OTkmTxX5SYgj7vXKvicjwZ6rgVA8f0ilU2+B2REY9TXJY7XwKLd6eTMp3Ik0q56Qfts/4Y6gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkcGMDEN; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkcGMDEN"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-687e7edaafeso15016394a12.1
        for <linux-serial@vger.kernel.org>; Sun, 31 May 2026 01:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780214433; cv=none;
        d=google.com; s=arc-20240605;
        b=TDeTSE+J7grtJBYN5CqssAVpu5u5kn0OrhcIBOC40ZS+G3OY+Th/ruYDDkJDfnLkUG
         Ftijr06R3gMjWxzwdCwHVHyl/uwDwXuLQ4rIoXdHzRaTf2oOOflVmfL+sMiRTx785kTj
         3I4MDaiPJUCARmQJjPlrjV084JXZAWjO/EhlfpmNY0kL/icf+nKWAqXIQXo6A1Q3EJ5F
         3qSTlgseJvl71jlcPIRMfCTH9YUwDS2n1Et8MAXtqpaSlDt+CmqS4Tb839xB9/uMRGmJ
         ka2+M/MKNX0qjOXCPsA5olhAg15O+ZZ0z6mVbD/067tnsGXTB2YUZnWkbNzyWpHwMiRX
         pcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nildDfl0lwt1rEp0UvoHwGy0UqbjD9j3If0RBiN1My8=;
        fh=O9wYL0kJZOzGTjTpARDvzMwwq062vuKldWOpKyzeTbA=;
        b=TzLNHukz58IFGVoZ/hCbLb6Ihz8YHrqR+BlYmpotb5ngnsGloXVaExXlhkzmXSNmtk
         csZS6kmK+yBALcNVZ22xagA3B4zZlRiEfcP3todxbIJZUD+cUbQ6uF+5WAQaMj221oQW
         WYjNCtrbWPNpcR9RjsdpmNoYWZTXhRCZnQdFKSzbJZWs3I3u/tXZPvvFm6VRDnd3dVTT
         iGIKd8GZmNb5jAwjGTIUlICIKXdz1PehjTxckVLJbgm2QgO972qkJeHOGi9WRxCuHd4J
         amMBzoE3L5XxTjD1dC1auSM5lxhAtmCPSxpbL1qssn4rfYaBBgz6FhLHYrw6Zg9+rD5y
         zYiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780214433; x=1780819233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nildDfl0lwt1rEp0UvoHwGy0UqbjD9j3If0RBiN1My8=;
        b=TkcGMDENI/Ke5JBfFgm5ijbcBiU1HIbTIMHekD6/dB/9pwSqKE3Z+jgrNSfZjHc2C/
         ZzQK3gs2kVcMNjqNQbKg4pluyzLAGyw7bwNXgxpp9EiqM+BbDMFnknPa1XAkNzWGJLMu
         aJXbSmfdGMZNQiXAj5Vkz2nP9dMR+jzFLj2oiQUZnv71WoQdOD+f+Pzn4+12SFOVdQFn
         VdCL+0Jvm6Iivq5vVAqgLFLEnSodf9mzI9yPGz2RXOSWcRQGhbD3KNkO+3ovgTDOFYpA
         s65//5aiEpHiicctdFgNqz+/6z7QBTpZjX08vBWE6aIaxMdDQ/S0IhpJ6lrr71zcqgjO
         69rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780214433; x=1780819233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nildDfl0lwt1rEp0UvoHwGy0UqbjD9j3If0RBiN1My8=;
        b=XVxVrmfTweSw70lsZVBGTwV9Z1mrTAp7ldYVbpa+F7Xu3T5kH/LqqrueO9aoMOLJ2t
         b0OG0kGflNZvTaOs5yvqF8LJDKv04bb1++qrbeb6PA9cyw1SiH0q0vmT01oba77gOFAJ
         7pqZaWBqgqy8aYaQqtjRO33OXpjib2viDX0UVQdlNs0BQPFhjzw8UUrTc5WTK6+rU/iK
         n2sDVjUDXh2W8hGB3nJmZ5GXThzdW15vXquURN3ORAm6yqEhwSmiQO+6L+e5lMTvyW9s
         QQxBm2nmWDheOLjfzFZ+H6wruZvd5YLM/CspDuQEZNn+iUga+KGxA9Yorj4Ch5Lbq9QP
         ANew==
X-Gm-Message-State: AOJu0Yx+J/R6Ng0dOjIilA8ExoVRRbOhZXeTNp/Qx19wTOs11idSidQp
	UdBQD+TTj+Qpu4yso7Gb7gC5cD/zO2j9v33S00wS7kaNAQVdagFImP6GR0HvkbCE3Tw50L/YQKW
	Xu9FcOT5SCQxJthy6zdm3zWBgDUa/Pmc=
X-Gm-Gg: Acq92OFEnSsLqVtObcaSr1TrNVYhpvRqoT9ur9szbqj92ukbW8zrefzUZ1BAAyG2SUx
	Mo2jU+TiWPBSAjZ5bJalZKfx0f9n2OhQfA5teAMzNr1h6ZhMVGBIhiYw7/d04DCQ+2AHbbTnoWh
	fwqA27merE1rvNq23vlY5kCoxWxt7Cb5hFyaujKxHaHrvoEBRx0bWNOCgW3x3vJWOaBliY8SBFp
	sDNUgB9ZmL7FX08geMcF9ANHBl5cuyawT24KKEXyo0BLGcT/gLCtSRTbTUymAoKXQMtreYiW0fo
	S+3gdVGMpG6M1wPNP/UJNH7EY4oXBZpnRgtv836vbK9WdFgaFbaYVKpwSBc/bcowO4UnSMaz6ps
	xROW4arWsz8qDJdOAzoP1MS2UcBbFH6II/bCcO5LAOdVB9S02dcj9CRgTTk530KcbXRvQ
X-Received: by 2002:a17:907:c07:b0:bd5:1576:dc7d with SMTP id
 a640c23a62f3a-beab3452ff3mr329934466b.36.1780214432977; Sun, 31 May 2026
 01:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530195525.5059-1-rosenp@gmail.com> <2026053127-nastily-fool-88eb@gregkh>
In-Reply-To: <2026053127-nastily-fool-88eb@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 31 May 2026 01:00:21 -0700
X-Gm-Features: AVHnY4LlC_u5ovIg85l_0nDDUJ11KqTPCviOKI2YGvc9iXS0Genvxl2UzGnGAVE
Message-ID: <CAKxU2N8bNT+irM-gOk9SM5DHPbcbh7zvNM7n4wF5+q4TSEMkSA@mail.gmail.com>
Subject: Re: [PATCHv2] serial: mxs-auart: fix probe error paths and clock handling
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 12:52=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, May 30, 2026 at 12:55:03PM -0700, Rosen Penev wrote:
> > Sashiko reported three pre-existing bugs in the mxs-auart driver:
> >
> > - For non-ASM9260 variants, mxs_get_clks() obtained the clock but never
> >   prepared/enabled it, leaving register accesses in probe at risk of
> >   faulting if the bootloader had gated the clock.
> > - The error path and remove function used pdev->id instead of
> >   s->port.line to clear the auart_port[] slot.  For DT-probed devices
> >   pdev->id is -1, causing an out-of-bounds write and leaving a dangling
> >   pointer in the array.
> > - The probe error path called iounmap() while the IRQ was still
> >   registered. An interrupt during that window would dereference the
> >   unmapped membase.
>
> This should still be broken up into smaller pieces, don't you think?
>
> Whenever you have to list the different things you do in a patch, that's
> a huge hint to do so.
I'll do so. Although I doubt the bot will be happy either way.
>
> thanks,
>
> greg k-h
