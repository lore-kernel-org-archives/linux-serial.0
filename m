Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C8315853E;
	Mon, 16 Sep 2024 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500071; cv=none; b=l6IScVG7z/5CiLX/SpZfN398ZrQMiDnqrN7embQiTxo91+Hnu2rdGFXVo/NahkuvdSJL7Jk87pno0b3T9GkFUkS3HNxQwAn0BiRzgpqkvli1Kh4uC+JS/p3VvbWuBG01SLOLHsC0YFVKWshQ6ijMNH61N9/pVXW3XgSHrT2tPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500071; c=relaxed/simple;
	bh=PY0xJxQ4hwk1+xou1p24LXNwzkAJahCidlWqhzdjA30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcdWCRGOJqIGKkJW2Y58Mqk50iy0ftap5k7eRUsnJAkrISwaPZSGHncAbp+ca2hKidihY/stiAaMDbc3uO9CWEuqUOywk42jx4e59ZsoZurRBE2kPWef+3uTQdDSduL7lwfQDaxlzLdUfK+jZ0U24yy+J2Kxdh5mb1u/ksotHMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=gMEibFmb; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="gMEibFmb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726500059; x=1727104859; i=parker@finest.io;
	bh=FstobPROtwQJKqY+r15ubuze1htAwesjXp6QUZIwGNs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gMEibFmb2Cy7Vi40O9XGk6Rs8wE5yaPw2Xc+gMbxKDIQ7TW83nWeERulqe44PEDf
	 sKil1RcIdi1ImAREGNu/90xQt/Tg5wwG0D0Uqrq3MVLPDHuQ/0Wo5p9vWpCOqiFW2
	 dZwn1RBFUiPDmcQ2x2JRm7DyOZSfLI/2bG++Gr3byFaWqzi/zU4xBD84aJ/ehvemB
	 gcchWgYtuortKHX2V84Bds+FLfeiHdB0IPxu9VI4QxI4Y2jWhZyTadWWIcHXwJwfD
	 iTZzTN8SbyZ8Ysxa9k10/XgMuNEwKrDinktDKHChf7XJPNqO8FtsXH6osJkRRY3Ui
	 hUYuE4RF63RjZcTr4A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MPWEB-1suuUc0TEv-00BWkH; Mon, 16 Sep 2024 17:20:59 +0200
Date: Mon, 16 Sep 2024 11:20:56 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Parker Newman
 <pnewman@connecttech.com>
Subject: Re: [PATCH v1 3/6] misc: eeprom: eeprom_93cx6: Replace
 printk(KERN_ERR ...) with pr_err()
Message-ID: <20240916112056.25193a17@SWDEV2.connecttech.local>
In-Reply-To: <ZugiB0GoNF50OdYC@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
	<127dcc7f60d15a1cc9007c9e5b06a1aa2b170e19.1726237379.git.pnewman@connecttech.com>
	<2024091438-charity-borough-54b3@gregkh>
	<ZugAeVWeMZGtjYme@smile.fi.intel.com>
	<2024091632-oboe-subfloor-afc8@gregkh>
	<ZugJT4nl1l04biJd@smile.fi.intel.com>
	<20240916080410.464c2b5f@SWDEV2.connecttech.local>
	<ZugiB0GoNF50OdYC@smile.fi.intel.com>
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
X-Provags-ID: V03:K1:gH10NaUTvJhE5B2C4x27JHgAL3aF/ejqtSkT/C1KsAx9vRYiJHC
 QaJ2X4+oyIETHnpSzKsSrr6CXaz725RmxczHTyPCGDL37eu7vtfq5SYB90j2l0isKerQask
 7CJ7osjNRJzim4YZHBDNrgIWHn4KIu3ShjpAM0gLqyhMTylCi4f/bJwpIaAXg4qE09P0LiE
 HYIGNZWzv6jcFwHgK0SBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mDMYxQpDzXw=;q65vlWOx09SJxoqHqOHURw5mYZc
 YB6l3BdEc1ow2QLLEYFrGbjsD/5plx2BtadjGrgXSDX2tff5qFGb3+kp1xI5JQ/IozOpKimZm
 /oG+dxdk2Eo7l8aApwl8Bu1iPZ6L3JXv8vgCimfIezQq937OWsaXgAHI+K5R1nbRTOywBf3Ke
 MTKw7kSk2Pb7kNVtX2IrAHW0xjVgCvvjXcvWHOU57KskEPGrgNmB46UfqLY5a4FRdsBqWWgBM
 K1BOTrWulWFLWyOI/413vPhK/EbUuA9Te1IICdO01Pi+zuMujVuhotNXbpDgzifeqJI0uHfyE
 uD++3bkbgb9SK7MO0at8ZbIVqJLIHPdTVoic7qedgi20iAYlSxcjDWVYq180t6kE0kFJ9AC0R
 G+g//YJTSJ9CMAD2ObOtdkZjjjw5/64da8Jb7twyalUcleL6ZuEu0MXmRxUK9P+bNuSCU1R3f
 8aNWbSKsywlaYWywodQB1zgwL6+3Mp8YhJA9biDDKmR9FHlsDj6YhTgx3/fxBbnmZ1OJ6K//H
 kSngo4UvC8CgsPb1bH8Nr8lvG5qEue1dR1VCHYKfOuiu/vjd0X94VG0FtwNAamSm6mkt2F9Oi
 CNM4v3Gj5ue7iWQhkPrHaKF+JLiU4WS81Jsue6YpgoT5HGJoHTxGuEH+4Qbdoq1NrROMNxZ6x
 JghzqzDI4PYVHkqvQj8JDIC8s4IHs91wNoz0neNgLiKDN5S/j6KyaTeoXUPvK6rIeXcBCNzEz
 3bnINlo0JLw5IMnVZVCnC/+CNinmjOSlg==

On Mon, 16 Sep 2024 15:18:15 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Sep 16, 2024 at 08:04:10AM -0400, Parker Newman wrote:
> > On Mon, 16 Sep 2024 13:32:47 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Sep 16, 2024 at 12:25:52PM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Sep 16, 2024 at 12:55:05PM +0300, Andy Shevchenko wrote:
> > > > > On Sat, Sep 14, 2024 at 08:58:50PM +0200, Greg Kroah-Hartman wro=
te:
> > > > > > On Fri, Sep 13, 2024 at 10:55:40AM -0400, Parker Newman wrote:
>
> ...
>
> > > > > > > -			printk(KERN_ERR "%s: timeout\n", __func__);
> > > > > > > +			pr_err("%s: timeout\n", __func__);
> > > > > >
> > > > > > It's a device, please use dev_err().
> > > > >
> > > > > The problem is that this library doesn't know about this fact. I=
.e. it would
> > > > > need a new member just for this message. Instead, maybe drop the=
 message as we
> > > > > anyway get a unique enough error code?
> > > >
> > > > Fair enough, although adding real device pointers would be good to=
 do in
> > > > the future...
> > >
> > > Let's then do it when it will be the real need? Because I don't thin=
k this
> > > message is _so_ important. I believe one of the upper layers (whiche=
ver calls
> > > this function) should propagate the error code up to the user space.=
 If it's
> > > not the case _that_ has to be fixed.
> > >
> > > TL;DR: Let's remove the message for now.
> >
> > I can remove the message or leave it as is and drop this patch from th=
e series.
> > One could make the argument that any error indication it is better tha=
n none
> > in this case.
>
> I think you can drop the message and make the patch to be last in the se=
ries,
> so it can be easily abandoned (in case that decision will be made) witho=
ut
> throttling the rest. At the same time in the commit message explain that=
 with
> move to read_poll_timeout() we drop the seems redundant message. I'm fin=
e with
> that approach. But at the end of the day it's not that critical to the m=
ain
> purpose, i.e. cleaning up the Exar serial driver.
>

I don't think read_poll_timeout() will work directly because eeprom->regis=
ter_read()
does not return a value. I could add a "is write complete" wrapper functio=
n
to work around that I guess. However, I think I will just drop this patch =
from
the series as fixing it properly will be a big change and like you said it=
s not
critical to the main patch.
