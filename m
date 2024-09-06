Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326521D27A3;
	Fri,  6 Sep 2024 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633251; cv=none; b=rC5my2YPxCXTnvKtV2AOzAfxLKj1SN5ZoO5kTswQvYvhvV3EJzPTRfzM59JHGHqcxKSCH30VD380oJZ1WXAPTUmZQ0mvT+Sry92DKI1d8A0x6FR/HORNLIzYs9DI5OIRX/bMhmaU+k2HkQ87NA2zVhRCjh3Dx4YHZNU/18THYjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633251; c=relaxed/simple;
	bh=leL/eXoSOkYWLsqWeoVYVZUWJvEPlTVwiqp/UcfgNfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNjvJhdUBCSFlCoj95C/B4rOqkC8iN5SmypWzNJb1RgrHu8dcKPw684I7Lh5dwBnZtJOZQsxKS1VV0ZmPAN11esMjtUJBNur6DeVrWqncPAGfDB7Q1DoB3QU5F8Kz8dUZcrpexXm2byi4FSEIjw1o0FvmwESJS83FnBAywdCr90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=wWR0epq6; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="wWR0epq6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1725633237; x=1726238037; i=parker@finest.io;
	bh=FmA+2X05d+UrhppdlrA1mjNB2wkHDBbIyEQS6gP+1No=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wWR0epq6VF8JN2bIHAvuucDgJNZmvaACaNxUX5ajHsrx/wE6GARtyoDmuVdXfNta
	 4Ch0ZlevVAYcFXs9Vvk5PfrNUoBVRb34HiJ7+tIzOEzg+Fz9Fz64FFbQn0wc3h+qH
	 CPCm1+tttHAqC8uF5UxxW50BoZ9XodhFtwV3WFuIAhRAL5cNvZzY8laKNmu67yln0
	 TyWP+kInitkGP7VAh1fosxsjIeVBdpIqV3DNVxJhw9Sh3VsYyyfe5DL9vudJ0epa2
	 df9/p2D/AFQomlRE4TnL/fp30Ikic67qcIbF1oU1saieUvxbgNqtB/A/zah9PEB7i
	 PtQZjZu4aNLlJlC+GA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MfWg9-1sNcEB3kuh-00R2rM; Fri, 06 Sep 2024 16:33:57 +0200
Date: Fri, 6 Sep 2024 10:33:54 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <20240906103354.0bf5f3b7@SWDEV2.connecttech.local>
In-Reply-To: <ZtsQrFgH86AkKgPp@smile.fi.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
	<20240503143303.15bf82bc@SWDEV2.connecttech.local>
	<Ztr5u2wEt8VF1IdI@black.fi.intel.com>
	<20240906095141.021318c8@SWDEV2.connecttech.local>
	<ZtsQrFgH86AkKgPp@smile.fi.intel.com>
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
X-Provags-ID: V03:K1:sVN0rM0jcj5boBO7Cil77tL8sr7fXEjf8hWkw69PVrbsDrVNTZs
 gLjbi1kRSpKopbu4qAF9BzFMXoIjAoSCA0lGsO6oabzHzaLSACd/NGD/+sFPsyGjeNp46x2
 Age02q2j0xY3Pn/jTZHoryPQ3RMmVoJdWM0Zeq9b78tGJbHFey9jzNhju/7rxoV6z93HlAS
 C3FYumwtLpnYCULmOod4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rRcfhwzIZTE=;KIDYM5bI+Z1h7l0yHm+wcHjbWNu
 tQrNKMM83nCxdRCT2g1D2Ik5OlgYIkygE8MUi9a/2KUdPtBJMoR4Zwv7dFq/+MBd1ztT2wP4k
 BDU3SfGWC4DNSkra+DUaYUngmHo61NDh6PJwFg/0M63fZ91QJ6Rvxoxj+AP8jtur4WXDmxEPa
 PnSuVxLn7/YYQ6AlZdQJ+lmxaSlP54C40bOvuGlgtetYP8RCcMHuz8QEk76fynMeIoDjtsU8E
 DFgy3jqGN0ASZVN7Mioy39YywLV+EHd4uU10wKGki7xGEIu6Gu5snNp1JjhUGdkvOqdKxYUsI
 PwZrNvdSXO8+RZLu/RQSeL7YKPxIHJmhAIH95VsJthfu3aTbERTi+AoK5z1NofYIL/X3v3/dJ
 G6g2g25a9v6+hc5nPj+I4On6GT7MLbgL+xxh6rIQGnKHlRFKZbb/ejhSOosZKWGv/fxyyH9YB
 nzoUHDi54tj0BNyxTC+bfBGAux6eeKLVk14eWqjJmC0Rw0UqWZpU1tm+5bNwsmKtHBnhjLS00
 4BP4y27hFc7ogDDm0PSjcotovCXE+OHoJserX5kKZtyfGiovxSs3ujTpTWfM7n2EryB2qeel6
 eqAGdreUsjjvhbDTSCDzf8auIukvmjrpmdS8H7/pNwUQHeKBVC1KXrH/sEtcxiNh7/2XWFM4u
 uZw4Sb9DyQb/NzTk9m2QC3seP8/jCNqJtSeB92/bELYkE/hV8qlFyPWe1tiVqNJF3mYCK+iAh
 /uRaXpYaboZJMmU7f9r/uSj54KrpGzGRg==

On Fri, 6 Sep 2024 17:24:44 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Sep 06, 2024 at 09:51:41AM -0400, Parker Newman wrote:
> > On Fri, 6 Sep 2024 15:46:51 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, May 03, 2024 at 02:33:03PM -0400, Parker Newman wrote:
> > > > On Fri,  3 May 2024 20:15:52 +0300
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > > After a rework for CONNTECH was done, the driver may need a bit =
of
> > > > > love in order to become less verbose (in terms of indentation an=
d
> > > > > code duplication) and hence easier to read.
> > > > >
> > > > > This clean up series fixes a couple of (not so critical) issues =
and
> > > > > cleans up the recently added code. No functional change indented=
 by
> > > > > the cleaning up part.
> > > > >
> > > > > Parker, please test this and give your formal Tested-by tag
> > > > > (you may do it by replying to this message if all patches are
> > > > >  successfully tested; more details about tags are available in
> > > > >  the Submitting Patches documentation).
> > > >
> > > > I was able to test the Connect Tech related code and everything is
> > > > work as expected. I can't test the non-CTI related changes but the=
y
> > > > are pretty minor.
> > > >
> > > > Tested-by: Parker Newman <pnewman@connecttech.com>
> > >
> > > Sorry for blast from the past, but I have some instersting informati=
on
> > > for you. We now have spi-gpio and 93c46 eeprom drivers available to =
be
> > > used from others via software nodes, can you consider updating your =
code
> > > to replace custom bitbanging along with r/w ops by the instantiating=
 the
> > > respective drivers?
> >
> > Hi Andy,
> > The Exar UARTs don't actually use MPIO/GPIO for the EEPROM.
> > They have a dedicated "EEPROM interface" which is accessed by the
> > REGB (0x8E) register. It is a very simple bit-bang interface though,
> > one bit per signal.
> >
> > I guess in theory I could either add  GPIO wrapper to toggle these bit=
s
> > and use the spi-gpio driver but I am not sure if that really improves =
things?
> > Maybe using the spi-bitbang driver directly is more appropriate?
> > What do you think?
>
> Yes, spi-bitbang seems better in this case.
>

I will try to make some time to implement this... Or if someone else from =
the
community wants to take this on in the mean time I am certainly happy to t=
est
and help out!
Parker
