Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7459F39EF01
	for <linux-serial@vger.kernel.org>; Fri, 29 May 2026 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040434; cv=pass; b=FYRNUFL9Xo702zx3ralFzqR7O4cFbmxCpAyvU0eFv3I/PY6oklqK4U2FD+H7vHdnDxo+gFFFdvh/rjUid8DfD0vSjIxJGxnHJDQ8FNsn2BPBaTsg+RkJig+nVaTqTCkTFycewIvM6T6CjZLOtssuB7sp9rtTOpyD89RRjMyDfCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040434; c=relaxed/simple;
	bh=duOkskhLGyc1cCefsxmlm+EPu3FCiGb4lyASp/B1ezw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4ug7DLhrCLStZeXFGqFwKLdlIR8O3wI16Wk/TWSqt0KWOwLgYYct+ILxV1wbDr98/pofsPr6ebSFCDY6hzgzItDXfDUMKAXzB9feNAbBJ+bImRgc78/GBCRfaUM4inwEt6NLuOSGZbwygzWS1nlCnruI9cNDOTiVWxVB76yXT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pcf+Dq/g; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pcf+Dq/g"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa2691db86so14397434e87.3
        for <linux-serial@vger.kernel.org>; Fri, 29 May 2026 00:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780040432; cv=none;
        d=google.com; s=arc-20240605;
        b=MW2VpDtbSNoL4TR4kZfKwSApQJGMeLWe6ivl/zRFbvPnR46o83Y0zOA34rMRw4ZbHF
         ZQ6HQ1wvjo5mgrm1gtpxq4EUgkUqoX0FMn6UkC1pVPY05OM7OzPx4WMGwRpaNsXd78Oi
         GMgKQ8n3REeEqsPOqCVzcUpeCWMThw/rwbr3gOPZ20UQC7mtnYef/EanzIKhZwZCAZp6
         XPLxumICYXu+uL/5yN+G1z3ZXxkNSjD9ectkUYTiKpuKpjG53pwsZCDZ9ZuGl0k/Dq0t
         8xAc7NsROg6DdEJ2chy7WHE2+mHdRViN4jcFmklh5N3oQ395JfwcxxZr4kA9JUaTm/d3
         lvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j149X8gXwUQ+5tkgK+g5qHkOUSrSS7YQiLSxtBB0NMw=;
        fh=ol7PGr9O8EQx4oZPSD4RjQFXTxDGip+OYoIIuXaDWfk=;
        b=LW1ruCZmjb4l4oUY48QjIj8aY3BBY/fsMgLIvgBNK4YZ+n6U9t+yOYSV/GuBzNFXxh
         SESdKx6mQtACwK1L+1yS0KaMB63Fk8b0GAr+xSO+5TmXD4S3x9BfuNJMb66m+zn5amfQ
         gY6dmxddyHS+WcnxXG+uqo48J2P7eW+n/ih1Vc3iOwir6V65vXR8ZCosIBkPN/5GLzB+
         RSnEZt1Q0YJrSLx/0+lhj1GDyyUrfIRWNJKXXi+i/zryvbJY1Y8/tnMGiS9RBTbDFbMq
         krsVZSnHcNEXQS98fdcI4crNh7I8CfMI4p641vha4sbRfD6vxSkT2N6KTCn9ckAvbR/h
         N04Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780040432; x=1780645232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j149X8gXwUQ+5tkgK+g5qHkOUSrSS7YQiLSxtBB0NMw=;
        b=Pcf+Dq/gW1MdARCsIjzxrkSYZU8hiIeVUU3c7wRhQsrjLE1q0Q50rgkkUNwd6DSv/z
         dUEm/9dTpSpSA0gAEm/QGUSsCw6y2/u3G9oW7TpvPq6pXQ4yGaT7EMv3lBbocRJ0ANTd
         Dg9oLbKsaqu9QwC/247xr1iW9wOCLqOcQZCQGP8rVccsceR9u9ipzG4iDMgRTW+hjuuI
         HVGXNcKOUQdjXkEE0rH0Eo2J1kDHa8RNHiX209+5DBpZRDqw0cNI4aWAjn/RKoOc15eA
         mt0PvNVi3g6JiPVxDCG8LldoB2Y8MaWyLL20huZQD3J7rwiX3hgcRTt9DlLrk1BkgE13
         1mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780040432; x=1780645232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j149X8gXwUQ+5tkgK+g5qHkOUSrSS7YQiLSxtBB0NMw=;
        b=GQbC8Fv4p28WCStBVoaoW3Gm+jwA9fyTnvms1I4PDBPcSSaFjONaKMNKbxdwrOeBgi
         8jf3P4jMhFE40F6i75yc1gOhyWkljZXf6cr/W2f3cYy7kMf3hBLIzYlV8l5R0ccdOkJX
         rrk2NRxrrm+2bqoK7u8w7mVAlB4O2FbM1uJDIwPNHy6o0G1McqUihpMDBb1oIw0bJ4Vz
         nLTkhEQ1g/EiHeamRtVcQLMnTlHKJIGzTu5N3WUDvHsaU1vCaO0RvyC6pkSW2XX+VLep
         W0b5NRaoYlpiw4cJJLQLA1kFrIW3PhGJebMfD0NDrI6Pl4xAq6GTbZ/EVqMvYTFPDTaR
         9u4A==
X-Gm-Message-State: AOJu0YzwSgvGkmFSiNce9jXRQHNTmbao2VwuHAUhKPpDNzbcjylBo5Ac
	eMxuhRLOUQ77CCFMEMN9FMgKMT21SR+31IzFAC3rBTs4XLi4/2X2Vt19UI9MKQatYZM2vSkXIX/
	rma7JeIK+kn8cKHCoVR/+IvFkqzu7kvY=
X-Gm-Gg: Acq92OGRBgBMHE9tS4FvLvRpOi9J+xHZ0mInCK98nkJsustP/ul/5gFVTGZ1axbc31S
	eMFIkDglj3vCxB0ZweRPGtBW9D2D4HsBz/1PALmNRGBNDMBATMkSMIjBYmZH5W/TW8oJz7RclpX
	sgSgmdG8zPyM8R1WnwOC7oKQT4lkrrqaP0cwbTqXHvzj8of18VK/4V+JQ5cVKKBNYBnjCB3UCDG
	FTYSGRaTGpl+a4hjQ6WFpGXXiRk4X+Y+d9nAGp0SCO+rqh0iluPMNkBRjgQyKGPjFSLqUV0sYz2
	3FQK37vgi4gFLOBaVhIanYVuf5LzPya9NadJcPiv1kjs4ASYvUSHSMWL3R/wDXiT25RAnRmb5UT
	TMmvWK8fFnzjdLILiU2dZYZWJq6jx6mzxaYdi9zuDokMdJGuGIMeURUsMoH/UghOqGDxw
X-Received: by 2002:a05:6512:401d:b0:5a8:9986:8490 with SMTP id
 2adb3069b0e04-5aa5948ef29mr474317e87.20.1780040431328; Fri, 29 May 2026
 00:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528203011.137338-1-rosenp@gmail.com> <038ae6be-03f7-4e6a-8c1e-70cbcf8424cb@kernel.org>
In-Reply-To: <038ae6be-03f7-4e6a-8c1e-70cbcf8424cb@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 29 May 2026 00:40:19 -0700
X-Gm-Features: AVHnY4LCY9FWvT2VC_UvRSAi9rf7pxOk0uNbrtkA8fVCsHKkI-e-ZKd_4cJZWfM
Message-ID: <CAKxU2N8jaG-WHeEpJs_NPKLdB9LP+cxDMhZN_bzX1gnBAhGUzw@mail.gmail.com>
Subject: Re: [PATCH] serial: mxs-auart: fix 64-bit cast in probe
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 12:37=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> =
wrote:
>
> On 28. 05. 26, 22:30, Rosen Penev wrote:
> > of_device_get_match_data() returns a pointer. Casting it directly to
> > enum truncates on 64-bit platforms. Cast to unsigned long instead.
>
> This is a misleading commit log. It still truncates during the assignment=
.
>
> > Fixes compilation with W=3D1.
>
> Fixes a warning, not compilation, right?
compilation. I believe -Werror is passed.
>
> > Assisted-by: Opencode:Big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   drivers/tty/serial/mxs-auart.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-au=
art.c
> > index 697318dbb146..de97c0f74e7d 100644
> > --- a/drivers/tty/serial/mxs-auart.c
> > +++ b/drivers/tty/serial/mxs-auart.c
> > @@ -1598,7 +1598,7 @@ static int mxs_auart_probe(struct platform_device=
 *pdev)
> >               return -EINVAL;
> >       }
> >
> > -     s->devtype =3D (enum mxs_auart_type)of_device_get_match_data(&pde=
v->dev);
> > +     s->devtype =3D (unsigned long)of_device_get_match_data(&pdev->dev=
);
> >
> >       ret =3D mxs_get_clks(s, pdev);
> >       if (ret)
> > --
> > 2.54.0
> >
>
>
> --
> js
> suse labs
