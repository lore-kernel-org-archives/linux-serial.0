Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BE32472AA
	for <linux-serial@vger.kernel.org>; Sun, 22 Mar 2026 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774164763; cv=pass; b=idg7LyoNPYOU9ulbTdrRUrb53Cfn+8uFaidfPH/S3NPhk92CUE7D7WUpKnXUBTbD+Xn8PJ/D0wLUz9HA2pK/QCNR8kwenTgwuUGcNgyKFWB8PJyDZZO6iSzHv8R8fUyvwz8FvLZ1eghiUO5jFmgsJEtfiB89Lxd5N0TNivkTXwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774164763; c=relaxed/simple;
	bh=5Qx2hgHzbpjpbk7V5p0sgMIub6qbeGS12bDrqjCfrs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oo6crmtPAvW+6OqGK/in/zpav6w6/gzUeWCBwGwg9pTdqKkPNGmyuGxfHpJqsfnbGWJT/Xzr286uvoO+2kCBMkvxGHpv0HfIEml7HWrb5b+B4PIXug0IJJ72XksqLwKXMvUbNHcGRfzdpLB1v9Em00/3eCEleUlibuhFab+u6Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehuAJtaY; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehuAJtaY"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-89c5d795248so43900826d6.2
        for <linux-serial@vger.kernel.org>; Sun, 22 Mar 2026 00:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774164761; cv=none;
        d=google.com; s=arc-20240605;
        b=IoA71+rZYtbikMGDhGqzDUEbwmI5AqYzyM/o8MWULjcIGPZhJwoCAdkiWapIACzF6m
         zl7iiz9c7vwCZjcxfOhUeqB9q7EcAm5GynGPvnmdRg1gfhGILk+lSJbHRuXxqIr9cgmD
         LHWSXXc8AgkTqxepG9SCtLHeN5WWhKclaSHwjO5ya8HMXtgGFxWko/iH00nnEzRZkmcT
         Vly1lWQdE6uPZ2MBLBHv7URaC6vZygW2yUlokhmtMnWAYPcsBw2Re7EEwrCiwIA5b0OX
         rFFdqFpEJyNCNDx591UnQvI75EUc2iVtx8MGtOpo9kgMxnA+dmubfyFr62PIGdgBlbUn
         xS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2G5N2eT1Tm/wEMF99qtQUnZiqqScw1nqj5jePVwU4B8=;
        fh=8KRxYGpatPj7n8Hux2jxdXsvPCClBNskSmQPHVL1JkA=;
        b=Fl11sGdxvyqMfOlMjQ8xoOYHD4+/ItKy8JBwctxn7FSEFQbY1ajoHP6I3a7X6tcd6p
         SXcfTYfkf1OUHO1v7K+Fhv5rTEEBXx1xqfY76Cobg8+fz5Nx1KBOy7+wLAg8Gse/465q
         HybC7cFU4DUkTedG1XzCwrPw+4eI+pFSuAPINaeZD/OQYZDZXfQWpJYb0Rgm7KJqrdmG
         ONQa7k9BNsvq7sP/dw9EEtObzJyhEEahHX2rvRcs6GimuYvMCeg5ATj8oyhsjFDy6HSr
         xFjpB55HO/61cQyyYv6cTRK9yixZH4f5PjJLwyab49ixLiyG+0arfUNcR4mvFT3+Iek5
         ZsBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774164761; x=1774769561; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2G5N2eT1Tm/wEMF99qtQUnZiqqScw1nqj5jePVwU4B8=;
        b=ehuAJtaYhazyFBKaLry+9cTMzv2+F5t7atbBAFG4SJpPk6h0iU8ss3vtNduopIqA/T
         sZ2WZ935eTNDIR2GlanxZoslO9xflg9kvY1VE5cr0pcevCUwVPFt27Kwr0SfKaiU1oLN
         f4aOBvR8E47tpQBoVEkA07n5mj0Mil1mxGdop2DrMwRxKUV2ZLbXRN8UK7oEm2gQk5xc
         w4oxM9s+Kcy1Io3Ohi6XtQP2Oosag9VrAOdkw+NMQE/TjZ4B9xpzAYUN4kObmfTfrDa1
         4nhKBha0K0SmVr0GyAOKRcK5liPeKY10jqATcqMV6zF/kqMPtEXM0b+5o80J9H1r8DeZ
         y1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774164761; x=1774769561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G5N2eT1Tm/wEMF99qtQUnZiqqScw1nqj5jePVwU4B8=;
        b=jFUaY5mITD9mCvb/nSdG0FhMGBdmm/yNBu5JhDjcTsfO38bJ+J34Mmu8r61mOrnxSy
         3ZoX1i0ZgfEM5oDo+xc1Vb8XzWRvKXGTE5qyxmHt9dikJZLDgsINOR7llAYSQW8Ral0h
         U+fQ4qhZChUsRmAkfOLuIuiIdYWUuMd6YI5qhaQgCCxiqP2GrjVONMIZCnzkuf61u3kO
         IqON0n0CKgkU80WcPZT5iRiOlBCm0MKlOcwRwTOnfLxGoSvFIavk3SPeYRQHspdxOmvi
         DVk8QlNnzWMHVzWcgH9wSnQre24csCiESrGluF0fl/77wa935+A/CXOF6qWOrdRZHJ+g
         da7A==
X-Forwarded-Encrypted: i=1; AJvYcCVkJzbd2ZtHvmJnbMW5jEvRTUaGb5NKfmx/Sf7/ONmtWpEyVswl34FIHQXRKtMkyQhkvWuRmWgEj3Eyzss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH6zPn2RY2w29+jxfj2B6NB0giV9KGOg/VIO1tBJ00rXLY5twA
	Bf0RV3dzuxLgA4jBme3rhLo/jsJlz7DlP+vv2i25Mjwt62TRm5jUCmgthQYxNUzYc1E96x/iq4R
	gmTXwO4IuLn38+90DheE1o3kyUQNCmTE=
X-Gm-Gg: ATEYQzwAAeNIQOwuEu8YVfnRibYj7nto4PG8gr5KUMXO9yPV+fmFLMgnank1EZEzGZy
	aMFR8QyosUml9ydW+wL1I1GExoOFM4ICLm5jhPe4eohCz346kRd7Zx6c9Bil90CivYGmPMAI0jc
	bHYPPxHREadxY+aP5Z7eVQEeqWlf8zShYD0AsMcoNpQkmJJFnm8XmTcA0IF2ec7AbJUSH++/OY0
	F9G91129Uzv7zwoQ1iFMYdo8TCGD5gTYOhLBP5EJtoHwFI3G/uquWtbDIuCWYLUpFNPy86yaE/T
	IvqoIw==
X-Received: by 2002:a05:6214:3d99:b0:89c:4ec3:5271 with SMTP id
 6a1803df08f44-89c859d07b5mr135951406d6.4.1774164761449; Sun, 22 Mar 2026
 00:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321062312.4290-1-yuhaocheng035@gmail.com> <2026032123-earplugs-stunning-0c6f@gregkh>
In-Reply-To: <2026032123-earplugs-stunning-0c6f@gregkh>
From: Haocheng Yu <yuhaocheng035@gmail.com>
Date: Sun, 22 Mar 2026 15:32:29 +0800
X-Gm-Features: AaiRm53rU6jztnfB1ILACGatKWeXBOyTSfhaoV5ckHWgfSZU3Y17bMP9oTLUkSQ
Message-ID: <CAAoXzSrJMWqOt5phWxsJfVovXTnLEtT40k5wnFWGJP0z2YYm-w@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: Fix slab-out-of-bounds write in do_con_write
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Calixte Pernot <calixte.pernot@grenoble-inp.org>
Content-Type: text/plain; charset="UTF-8"

I only ran my fuzzer on v6.18, so I'm unsure what commit caused the issue.

I tried analyzing the cause, but the crash report provided limited information.
I tried directly analyzing the code, but a possible race condition
with vc_do_resize()
is unlikely due to the console_lock, and the state.x out-of-bounds
issue is invalidated
by the restrictions in gotoxy(). Furthermore, no reproducer were
provided, making it
difficult to verify some of my hypotheses.

My initial thought was that although the specific cause was uncertain,
since scr_writew()
causes slab-out-of-bounds writes, adding a check before scr_writew()
would solve the
problem. After reading your explanation, I realize my thinking was
quite naive. Therefore,
I think I may not be able to provide a better patch at the moment.
Please ignore this patch.

BTW, I ran `./scripts/checkpatch.pl --strict` indeed, but it didn't
warn me about the variable
created. I'll pay attention next time.

Anyway, thanks for reviewing my patch.

Best regards,
Haocheng

> What commit caused this problem to show up?
>
> And without more information, or a reproducer, I'm a bit loath to take
> this change.
>
> > ---
> >  drivers/tty/vt/vt.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 6e0089b85c27..95d860f09837 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -3138,6 +3138,13 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
> >                             (tc &  0xff);
> >               tc |= (vc_attr << 8) & ~himask;
> >
> > +             unsigned long end = vc->vc_origin + vc->vc_screenbuf_size;
>
> Ideally do not create new variables in the middle of a function,
> checkpatch should have warned about this.
>
> > +
> > +             if (WARN_ON_ONCE(vc->vc_screenbuf_size < 2 ||
> > +                              end < vc->vc_origin ||
> > +                              vc->vc_pos < vc->vc_origin ||
> > +                              vc->vc_pos > end - 2))
>
> That's not good, if panic-on-warn is enabled, as it is in a few billion
> Linux systems, you just rebooted the machine, turning a simple overwrite
> into a denial-of-service, not fixing anything at all, but making it
> worse :(
>
> > +                     return -1;
>
> Do not make up error numbers :(
>
> thanks,
>
> greg k-h
