Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB673DCDAE
	for <linux-serial@vger.kernel.org>; Tue, 19 May 2026 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177460; cv=pass; b=DrFqr5uYKWnKP0YyKN4DDieodLljFp4fjCTKR/217+1bY9lDQfbGfdspnC5l9FaeFLEIoFIF7eT+Vd0ev4tQ1dixf+6GrhQqoJ2Zp9Uu/hyYx6p1JqrCb3OWuqIbGqe9TGFacYe9ixniY5bH+HOaEWrE6BxwsdgDtgDpuyFRJcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177460; c=relaxed/simple;
	bh=nmXYpp/OTyRPxntq09LeKIcHKRP/4XyxYpopb7Xp/58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQRSfpxQL2wypY+BmV0DHh0dNaNkt/QP1orprckVOb4soKi2Y+2fqfT/cvP54+NBCEJH2HTlbVOsf/gRiP1hD7RL6bBiyvuAgahbcOwjJQ/CGWTMwjnwjms/hDFWOgcVB4fmWT2QCWacVIRhMdkddyA+PfFfwM1dO2NYxvqKu0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rc9S4n0q; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rc9S4n0q"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67bce1840f1so5683070a12.3
        for <linux-serial@vger.kernel.org>; Tue, 19 May 2026 00:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779177458; cv=none;
        d=google.com; s=arc-20240605;
        b=jPDaa2i+5iG3dpmav7vqqkK+lFBz1e8E7OMbFHENHMqAlEiNtVYgX06OMumPyRFZvM
         4OTw/bH4/hYHPec1srHTicwqXT69UMbDloL5HEeNJWhQdhnaeTly4jGkDQi8yhS9QxdM
         IAbAG5oInNphgdGreSNNW3+HsDHBormBFmdwYWJxTvojBTltJZm5B+FpoMGWeSnrXVYb
         7jH803zWKtfxVjRgVa+bbb+UYcaJYx7ztMGDtL6pVavl/jRj0pmxhGTF6PTnqZIljzej
         Jm89qdCVHAiCVCkqEMOEeWzDwGomiAeh8b5e0rSOdFb7sU4BEVsdt0D45WAjRzqz5s+p
         ea6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KWVJa+M4YYrIvLHjtXumgZPH3I6/cPuh+38R6XULQ/8=;
        fh=K5Bry+3RDN/Vuea4Z7rpZAi/ivCCNheqwG0KJPjmgOI=;
        b=XT9OLVZ8S+BhocYblcMCqq/4LTC1azyf1dx7Ro1LDCkkI3XAED/Ix91bFH4NE7F6x6
         evLwJ2nfwWZjen+X4smRnDoOEFLbyokSrCBDUBk+LC0QkW8PAeuv8T0QCFMh2tH5BYI7
         UTNoGFWVYxNjhDIxfCJWtGkB4O1Ls8znjTgzt0BNLs8LrA3rTQbdcL3NLWB4uH71LGEV
         viyck9CL4OZ2SWEUUpPmd7+SKGncVHXngzoYSf2VCtL+sFi+XK1xYHx4l83Lcza3Rud3
         B4Wj5wjj+qECgm4xhhxVJaelFx8LXB3qKORB2baYhXiVpxtGs2Q0Rw83hgCtnVlLpiKT
         FD5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779177458; x=1779782258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWVJa+M4YYrIvLHjtXumgZPH3I6/cPuh+38R6XULQ/8=;
        b=rc9S4n0qH25Hz5OKcwflH+wTQBKlwVedUi23YVN2IqqqVeX5fu2k4ilZFzsXq8CU4h
         +JIUR22Px+g+oaEdAlATqQ+u1NCWG46O8SuzGG6Gg2zdouiHHaj003J9wHhOl7wfHUiR
         y8gNYQVQSgmL7K1BDbCeP4SR+Rx3flLvgFTQZFoman6gVBK55ShHTEjX6lZZ+MeQyx5z
         kjUEA9nKWq2RFrsfnZgpPtmRIAk3gnyTP/WB5t+569Clr2eM7gfmw45Lw8e/hucSfkoX
         nJ0svxD7cL4svoTFgc22qYHOuRbdeY2WWO8k10ywZ6Uaxe3MRDl97DAFrLzKmRQUhWfu
         +AUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177458; x=1779782258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KWVJa+M4YYrIvLHjtXumgZPH3I6/cPuh+38R6XULQ/8=;
        b=VjV0LLdsc89hABLx24Ym0W17QeRj4w4VkGBb4C1+xQhW4guy7wdoneuX2Ib+vfL7kA
         FeW5VzzyE0Y+LNDV4w2DTXqogEh7ww55Ddrwvgexpe6fyo8Snh5aXQ8Ug8V1mngB3kq6
         y4uUSzIlSnnsofuLJgdU3kbesJXRqa33v2fI7iYoiH3tD0jBBtAZKC79tgdqwWh481zR
         tDj6JBrP2+uhOrnRwd2++SsX03olbqqbs845bit1ySMw3WZK1exNjXASc1ev1gxw0WDb
         yyGodF66qqRIGTEIu+JYzddQ/Pz/N6XhQeUiiMnXq2wkWEI45ygK3QFSN2kX9f59AFyd
         r4Bw==
X-Forwarded-Encrypted: i=1; AFNElJ/2wGbHunxM3m62stPhH0qChMwXKUjJjSEGEvlndMje2QQfWulvfA7AvCbDLB8KAG4sR2frUYrJUZiqt0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgXr4L3n/r9xUIjzORFI8R8SDUucSZq4OOiqVdfnSMLLb3Xlbm
	q4aEuGd9bK5ICYDTT7nCtQ9e6SN6ZLIBEqeLx4y+I3ydYu5lEzPL8/cT4QZzYfP/G3BLsKCI2yS
	m6Q3m/1zOV+7VTr6bf9HjjrmKZLmTsfs=
X-Gm-Gg: Acq92OHAuG3/nQWAOTw/lg22++196JzC+wKnbw6NPfSYQV4/w/0PiXN2BTms8SOAF5N
	XnqnWHFPrpSvRhuJK2+dxppWACGLbO0S21iVEwyeh6GKqnUzUnA2kb9KimF6h0TF7CbA5hnDX+L
	nx0YZ6U/zouMvDjnPtsmlWk+F2rmMyvPxrmgh9v4/ZTAccVGeyziP9x6Vo/gMIRn38lLlLHNC00
	9nWdmlsXPOeoQowqdRZQvN7eQxVts+l62oXoxAeEBSmMjln44ZulvTJsWATwSwWrsAbFiXcwcoK
	CCKbLqQz5x5TLoomN0fOG7Xapu0HJtyNJ/xS7RcmHLLt5+v92oX7uuCUHRC9hwRTEzwi2+GgWSo
	Xc3nIw/s=
X-Received: by 2002:a17:907:9802:b0:bce:804f:f199 with SMTP id
 a640c23a62f3a-bd517aaf35emr971409466b.40.1779177457478; Tue, 19 May 2026
 00:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
 <20260504084900.22380-2-crescentcy.hsieh@moxa.com> <CAHp75VfFMLnLDP0V3U=4zG4Ayj71-ZgVkJsVtgNE=52tGQ963w@mail.gmail.com>
 <agsLvCVll66tPoFA@moxa-ThinkCentre-M90t>
In-Reply-To: <agsLvCVll66tPoFA@moxa-ThinkCentre-M90t>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 May 2026 10:57:01 +0300
X-Gm-Features: AVHnY4KYcjHiyjvVv-81QCmkeRchDf6SmJOUfBlrK4cqvqXrVBFWmTG0gV8avPQ
Message-ID: <CAHp75Ve20GcUkstYrd8CfW9Ui80cZ3QnstN=sWk86UACwJnAHA@mail.gmail.com>
Subject: Re: [PATCH 01/15] serial: 8250: split Moxa PCIe serial board support
 out of 8250_pci
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, fangpingfp.cheng@moxa.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 3:53=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
> On Mon, May 04, 2026 at 04:27:44PM +0300, Andy Shevchenko wrote:
> > On Mon, May 4, 2026 at 11:49=E2=80=AFAM Crescent Hsieh
> > <crescentcy.hsieh@moxa.com> wrote:
> > > +static void mxpcie8250_remove(struct pci_dev *pdev)
> > > +{
> > > +       struct mxpcie8250 *priv =3D dev_get_drvdata(&pdev->dev);
> >
> > platform_get_drvdata() IIRC
>
> In a previous patchset, dev_get_drvdata() was suggested for similar
> cases [1].

The case is not similar, while looking familiar. Here we have a PCI
device already given as a parameter (sorry, I mixed it with platform
in my previous reply), and there the uart_port, from which you take
device, convert to PCI and use pci_get_drvdata(). There it's a detour
as one may use dev_get_drvdata(port->dev) without PCI being involved.

> Since 8250_mxpcie is a PCI driver, could you clarify what you would
> prefer here for retrieving the private data? I was not sure whether the
> intention was to use dev_get_drvdata(), pci_get_drvdata(), or something
> else, since platform_get_drvdata() does not seem to match this driver
> type.

pci_get_drvdata().

> [1]
> https://lore.kernel.org/all/CAHp75VcPanVWaLi39Wf-pq8nA+xbeJUs=3Dv1BACz-+S=
ns0BVyWg@mail.gmail.com/

--=20
With Best Regards,
Andy Shevchenko
