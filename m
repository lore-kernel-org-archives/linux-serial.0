Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D4829D26B
	for <linux-serial@vger.kernel.org>; Wed,  3 Dec 2025 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764753568; cv=none; b=hem1uwoHhki10VuQmJudq/3288wROYe39ao5BDEryGW4HlLyKb3Rtw2LZ0LfoGBkrobxFJHCTGUorq06XDt693HO7PNuUOfHOZhIW23KNPmuFIwBJtv1fhlLbg23rQXhvAVp/e/d7SpFX19zkE3aqIu9g9xICPFjqbrqOZ51Pr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764753568; c=relaxed/simple;
	bh=bQO34IA5Vx+tC4Tj8PYkQ2pWdLquBHcyabooOpyvR9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZkA/p7SWov4UFaf0HLmlm2Q2RCLpDesfwqxLIlHB052YYLHR9k+qtf9D8XrvPlBawS8Eur/EJtyNNSlMvmZ5zrsdMg41pjRG0ZccGuP0IXS3slaQrDZ1JIxAWBnAcLhxWeZs7iDXgOA0pKhH540T4JS5xNTseUDazmFdacEnSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMx1Y3Td; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMx1Y3Td"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so12170612a12.1
        for <linux-serial@vger.kernel.org>; Wed, 03 Dec 2025 01:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764753565; x=1765358365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQO34IA5Vx+tC4Tj8PYkQ2pWdLquBHcyabooOpyvR9w=;
        b=HMx1Y3Td2xWKKgGsMtyN/vY3eSMSVX+rPLPybVNk/PGU7E6rkqvcEZwLyB7Ny4/wML
         McxhQ4q+D4/dsh5iMPETLV25QwoCFxsajmzGagOkugR466x616gH38iHKLEO1nuszKxW
         juSp1e5pLxTrFSo/oNulBee36lyulJvcaYpzjME0DLUf8OD2XzAscMg2wHWkWxqmWU4k
         Dfbd5LhHJevUTz78E8Q2cuxjCvs0varE8h0OIvPk/nE4xvaAWmM8gr7M87YjS3B/QIf1
         Zj1EL1Kt9Yu6tnpOGyNw2fJgFSBZCjR+bjJ7Rgu6h52JN/LSiqQ/1X+1EzVTO5vPOAED
         rqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764753565; x=1765358365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bQO34IA5Vx+tC4Tj8PYkQ2pWdLquBHcyabooOpyvR9w=;
        b=EAEZgpvR3Jlg1Wpcf3dpUsksBwaMWpD4Mj0kovGHeVPBXGOq/QRc8mcqthNL6rjxh0
         t6eJqUyrgJRKeVfAt2HnN3bOd6ALuhJntIiS+DSWIB1VSzXH6gCcJ64gG7dCdJI88qkU
         lM1cJ0iaeLO+ZFtpIyJxjrJCS7IwBOPiYFIKv+GdSBp0uQlrUJymNkWpC8dtORw4jFLP
         bs44LozVbqdMNarbTQC8pljvGEB+3bzi8l4tislwqSxILFWQCXKmRGkgkZFmURSGLzhg
         ouoLdCiSWmzw+zy07hYoLwak4p3Lio670Ml+WygDmyHkNQ+DFb++LYGrHnGUK7WzTa9+
         fq4w==
X-Forwarded-Encrypted: i=1; AJvYcCVrhbq7jrwJ5w6hKVuA3CgtWn5pYcxBQ2IvK2ITbeqFx/iQQO1ecxLergabSJZEJ6M7EMglGSXx0hrSFD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyuAihFnLNeyKqnMc3Jxmx/cqdyzQE7+tiY1RUnrf5TMbUu51M
	AfJaEZ8y35SRf6phlHkGIVbgZz0nGmlGgOjqsfjpnAssGx0r57b5JKmy8uHwd8cv+lr4q9/GOaD
	XK8QnaFWVOMWxjjjzvkoTB4TohJBsZus=
X-Gm-Gg: ASbGncvYxviAK3rF3gv0QsDe2VTFeg3F5Pe1HXl7+rPfPCCtU8h9w1eRC5RuycBi0dr
	ewpK8s8zoVhjaVTRdNKOhsWAg8o9XT9R5LJfMJU4zQxv5ifG5LZYYKrF8D2FJhfxJQ7tSfsc4vQ
	XfgzX+82SJg/CdPt9odWkINXGThuaaeqLiQJxS67Hdr503zwdMMjj9XsikKsnkXGxLLy7n1g4Dh
	KehqRWsAbcipGBnpXgiA/U2plEyFiaPAvnUcBGEcY2KILfjw38bluEDbqImElVnob7RU7XwR+dO
	hOb43tuwyQHT7eLAu/0AMRDKGylBQgm4DxTODq3yJnVxB33ZkUE8c++E9iVEUBirvvlA4gc=
X-Google-Smtp-Source: AGHT+IEiPFQ88ebuQvBWGK806660ERWyDRAl6I6Bgu7rm1lFZjecpniizlkJEybMX5xF+Q9/72tDUJnOZPlGclftVPI=
X-Received: by 2002:a17:907:3c8e:b0:b72:5fac:d05a with SMTP id
 a640c23a62f3a-b79dc520fe1mr134685966b.37.1764753564880; Wed, 03 Dec 2025
 01:19:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
 <20251130104222.63077-10-crescentcy.hsieh@moxa.com> <CAHp75VeDsVt0GQYUFxLM+obfmqXBPa3hM3YMsFbc26uzWZG-SQ@mail.gmail.com>
 <aS-mTGjGtn1gQuvI@moxa-ThinkCentre-M90t>
In-Reply-To: <aS-mTGjGtn1gQuvI@moxa-ThinkCentre-M90t>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 Dec 2025 11:18:48 +0200
X-Gm-Features: AWmQ_bkIgpehsMEsT6PC2ES7JRw86YC1zvBKj-p40eQcFqa8i35TVIz177zsjCk
Message-ID: <CAHp75Vchgj=GXgY4uoDQ3YD7wqTbwWmm+BM=UW1MHt3qxUwEvw@mail.gmail.com>
Subject: Re: [PATCH v1 09/31] serial: 8250: split 8250_mxpcie from 8250_pci
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 4:54=E2=80=AFAM Crescent Hsieh <crescentcy.hsieh@mox=
a.com> wrote:
>
> On Sun, Nov 30, 2025 at 09:22:20PM +0200, Andy Shevchenko wrote:
> > On Sun, Nov 30, 2025 at 12:44=E2=80=AFPM Crescent Hsieh
> > <crescentcy.hsieh@moxa.com> wrote:
> > > +#include <linux/module.h>
> > > +#include <linux/pci.h>
> >
> > This needs more headers to be included
> >
> > bitfield.h
> > bits.h
> > dev_printk.h
> > device/devres.h
> > ioport.h
> > types.h
>
> May I ask a clarification: my understanding was to include headers only
> when the corresponding symbols are directly used.

Yes, and that's what I have checked (I spent some time reading the
whole patch, but I might even miss something, so this list might be
not comprehensive).

> Is the intention here to avoid relying on implicit includes and to make
> the driver=E2=80=99s dependencies explicit?

Yes.


--=20
With Best Regards,
Andy Shevchenko
