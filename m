Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBCD126C01;
	Fri, 13 Sep 2024 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254761; cv=none; b=C3J4tAZnv8iabrMEljKAhQFXBVQh2dQQXJ9RpKg7doOU0jvlK0GkdvNzElTJHDYpwzgBBf3AkXxuiEK8UWdCxNd9i8Gwoq/OXF3PpPeh9YpkgDHmkp8fweusuJ9qsAtI56FmW0TNpG7uTQr/lOFZSFFi41QXaF8sRpjJ6o2l+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254761; c=relaxed/simple;
	bh=i/WaPSFd1chhL2mX04X6RMIpG+jLWmtttFyp9XWK2ns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bF6tm+u31hAmj6niHFNKwamj/5as3S3HMIS+KWvcJM17U9ojKXWJOtrNx3ZJjoPMtD1I1yHNM/F/k3lSogeAHeIKQvFRSMakfJUfCTWmRYweCxRmozkfdt6Adklohseul4QRmswc9K5fFvB2Hwsg7DvvqfMhWkKC3CnwOFzHYpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=VMzpyeRN; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="VMzpyeRN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726254750; x=1726859550; i=parker@finest.io;
	bh=dVQ9rbg+bDpJXJkFTaMWlx9VfHsJREbbaLMzU4KTkSs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VMzpyeRNOQmqBwiChX3m5oke9v8FWEQDihqtZnSWSiXNe6xdyXvwteRhI7SVNRxQ
	 CeTiL7aEu07jlxXLSv+uVGZC43ZobKt8infaCIFqiYULvKcuHJZCvmIpoKRgwpZts
	 cadQZhKYXFmVS3tFKRpDzxwzGsU5x+hgJ8nQwkBiwbDyENFByK5w+p6z3NFmt2m4y
	 UcGy4rrHcV4/YEmC9T90c8jcFKtnNXfvDzgxcbTCGFFJg95dxFS3CmdJfb2DYo1s5
	 CYH+tHAc9t2gQDYsxJqqkznJMZ5OzQsaTTsmPSP+pjeHEfZnj2pb671kjQzH1PALh
	 /prAZKpHMlvsJuXF/Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LtZ1G-1roS9y2cDs-00yWpV; Fri, 13 Sep 2024 21:12:30 +0200
Date: Fri, 13 Sep 2024 15:12:28 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Parker Newman
 <pnewman@connecttech.com>
Subject: Re: [PATCH v1 3/6] misc: eeprom: eeprom_93cx6: Replace
 printk(KERN_ERR ...) with pr_err()
Message-ID: <20240913151228.2b312e9b@SWDEV2.connecttech.local>
In-Reply-To: <ZuR8PawGrcDxCioi@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
	<127dcc7f60d15a1cc9007c9e5b06a1aa2b170e19.1726237379.git.pnewman@connecttech.com>
	<ZuR8PawGrcDxCioi@smile.fi.intel.com>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pi22FxzqxwJEmtkGCaJx+76+eCuRmwhpcgHleOBQ6l0G+YnqCOZ
 2UOLuKyeBKC/5yq72+/O6Guggptgaue87OwBXyyJgBHjOi6RXA8PZOTq2X0Gxq855+77yDo
 PSPvXoXZ95MOP9RZwpaHdElYIhPWUuzrmKIamvwjUd6gokcvsAT9VQlU18ShuSpoS5I1Hgi
 7HaV4BXENsiy8rPrSwwAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:It7dLGnhpkY=;f5hJPByBkGaRzYFI0ZHca8Ptrsh
 OWU2f8xOnOPZnHzpN+KXzIwvA7YHEoo0tIAT3rSGEkmeRZ6ZXxKQiWOln/VyuZgbQDL4UATtn
 rTWnXNAlfHLkFYWTx78iWwRf5ydoQlzwSUHlZhQAR1v2DfqPxNtkft76QbSG3PeJX7/8GzpzP
 O8NQUpFoUEbv3JllIPMYiTvT+MDa1rjHA7Qe5l+Ooa/egJJiJDUZVS5WRwZawlan/LrBIyN3f
 slSAFNdKCreXeJzus9a1jiFRX44UPnG+leMw+N/Ka4VxmlTgJooqTADzfKSxocyja2EZaSPG+
 z83FEkepBZG7AzHnSG9QhawTv+2VYNJlc2AgxYnPpBq73xduJE9m6zZxgMEJKeP1ABFgsoeLY
 dlOdUXD3/24bmfjKxCNEWx+pKzEhEuZh2SbKUvEu/7bm868vuPKdwWdk+u5A2HqLLiiNGVuCA
 n0mskd7xsvhMZF5Nu37hwve1cyR6C5s+NS3FpRN1qNtFHdhDJaV3EcmWMSSYNX/uc83MK/ukt
 2OyQXYXqT00RvI4qg82v0CJcrBzLUF4LS4jSWcymkHondHZ/uC2O2ftMXHLDMdDJcSNo7O4nA
 2C55iTKj0SY77tBX5kBVtbKklCXefRK2UFET6cTDSRiF7i8fPiRVzvT+AoAb1fq24Mp2Twb/C
 /SJ8bzkX24wmzUnV59FVaDz+7qu3Lmebsdjlgz1nO2IR8gVB9iY1t1crCoMXJx9cX/0hMs/ng
 gQBllGD4J2bcNJ1KvOzFyZIIUwv5rWENA==

On Fri, 13 Sep 2024 20:54:05 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Sep 13, 2024 at 10:55:40AM -0400, Parker Newman wrote:
> > From: Parker Newman <pnewman@connecttech.com>
> >
> > Replace printk(KERN_ERR ...) with pr_err() to improve readability.
> >
> > Fixes checkpatch warning:
> >
> > WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
> > dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
> > +			printk(KERN_ERR "%s: timeout\n", __func__);
>
> First of all, you probably want pr_fmt() to be defined.

Good point, I will add.

> Second, I would replace the entire while loop by the read_poll_timeout()=
 macro
> from iopoll.h (note to use "true" for sleep before check and drop that o=
ne from
> before the loop in the driver).

Good idea.

> Naturally the pr_err() change can be combined with read_poll_timeout(), =
but
> if you go with pr_fmt() perhaps it still makes sense to have separate ch=
anges.
> I dunno which one is better, up to you.
>

Sorry if I am miss-reading but do you mean the pr_err() and pr_fmt() can b=
e combined
and the read_poll_timeout() change should be made in a separate patch afte=
r?

Or should I be adding the pr_fmt() define in its own patch, followed by th=
e pr_err()
and read_poll_timeout() in a patch?

Thanks,
Parker
