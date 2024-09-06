Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475AE1B85CA;
	Fri,  6 Sep 2024 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725647944; cv=none; b=g7pP+3Ko4jnPkfwCcFiJ7HnLvdOoLyGPqNwXUNd1vU+s90i/DUC3a+RQT92kTxYAeg1PcfLIb7CQ9zAdV0AW+7j+0XsEePigFXSZkTAhVA6RdrOnT+gFEAjkCY1ld/OpMGFEUgUcyBpfQZO6Rqew3xhIh5cdUVEmQgEyXwPWwOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725647944; c=relaxed/simple;
	bh=yPsiablW7v2+Y/1/4kVxtqn8UUHXMty+93REfIQpSBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MM6DvaGP8S7lPGeBFO9tsSUkSd/UuAhi2RH71t7SHHzuY2qJ7KdmJT/XSp27h4Yc8eoCvkPst1dNi8efCfvPgPlBT4xFBPnPcTvsE96bBcqC8nexo1leYLcLAv7lxpoB0u3/HA9ZViBMGRvjJtTQ75e+pzjI0zWjv3LAgMzWSGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=xLzbyESs; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="xLzbyESs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1725647933; x=1726252733; i=parker@finest.io;
	bh=XRDSTIIsV2NZmDdeOuh3im7vzjDEzcqFnqtO/PSkD5I=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=xLzbyESsukgkXcie6Q+n7AxrzZ3UgL9kAUfhFWoVj9VYaMe+MnCd4Rwhyayed2fI
	 pCJx3QDGt4GAQlGtpYr3PejS/+jD2/tcg6vvCIF2ZW+eilu1YgqWGr7No1DegbZzm
	 +6FX9duJP2oO1MO8LVNmtt6giGz0+79TVBwS+xFs1ZpUXt5LHQy7isUHyNTCb0RdH
	 rqhas3p7wqsnPNmyPXGljKwRtUKwFxKs/PQS5jgOy4Sx+ARVJbSgzsxWdySbbsq7J
	 XoAAM/qQlQibjA7mFM/BlBZjf9TtEv4Fres5hznxOrynp4nveAT16xo8XMg/zIpmK
	 drn7vHJxW4nw6+M/ZQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MAxJS-1swZTN1Vi8-002Clm; Fri, 06 Sep 2024 20:38:53 +0200
Date: Fri, 6 Sep 2024 14:38:51 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <20240906143851.21c97ef9@SWDEV2.connecttech.local>
In-Reply-To: <ZtsU0nfAFssevmmz@smile.fi.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
	<20240503143303.15bf82bc@SWDEV2.connecttech.local>
	<Ztr5u2wEt8VF1IdI@black.fi.intel.com>
	<20240906095141.021318c8@SWDEV2.connecttech.local>
	<ZtsQrFgH86AkKgPp@smile.fi.intel.com>
	<20240906103354.0bf5f3b7@SWDEV2.connecttech.local>
	<ZtsU0nfAFssevmmz@smile.fi.intel.com>
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
X-Provags-ID: V03:K1:iQB6M/+7TyKL2ZDIrzuiacTNDI+h/vhjuz60c6EJtZ0f11tHZRx
 e6IHVpX0BKKu9uJOeMr2+6AbT/WiXWyz+A5aQGjzpgjLguJcLhBt7nxFOTpOXUEzc8Naq53
 lB99kaG15QNNUnUDX2Y1hb3pWqOAy/JHyI9H+Hla++MtOaOk5oMEAlSrtqtMFHr+VDHjHb5
 6tF/SsDQ9g5Z6xZW0nJqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:crcRF3cpUJY=;EC2i0H+YJ512p8UG9eiHglZOkoi
 SNZYMtSpZS1oUA38Wq0GfHP8Y9+77E+1TUnZO8vOXkrEK9zvvj4ITr0TPyV+JBnNN1Necfw+r
 RdjwKl8aNxwTftDBaMADCa7j3vKrGalAfM+s/O82fgI9wTuBQbT13ij1V5D9ambPELw8Vnxix
 vRjXSnrqg+6L2X9kkPOxZgsnqrU8hCd2Hhx2YuS4yxxcbd+97Q6Vs1t7+/Y81KUqqKV7nsP+r
 UYEPGBEzfgOshs0RfauoZXOj55uQKG0ziYRNysN4kx2X8iCO34ZRpYE9BkeSZXXDDjZ0OBYXd
 KvxOV5VNs+bi8eaSNFIdlOAVGVfv/z1kEkbhU+YsnSe9Kw4XUftUUTYFod9CHmvliVSISkRi0
 jKR43MejQW6g+ZzWG0KRgmdq3UCX6gfWbMbJxUYX5D28pY1rZ4lsf9TE8X8GuIu0PrcaQwV0i
 fQWVnU3UqOyXo4bQuDagt2LF3Ay75/1n/gf9bQBNdpf4zUkMZoe9urEnrI1UdUM4OuaJf+u4u
 F29ypmZX1lCHsqj1vtp2Wv/bVZw3RJthm0VTPwwgL1hBlkKyS2roYC2H1h7HKAuoIaqfV4MtY
 vBAB6LPjNs3rqBDfoW+qgp7H9fDih0oFY3jtAQzjp5lcQcgpNkIoEgfHbf6n1QPV3RASDCXuZ
 QgSZFSQ3Licp11gYB4+y2Qd1da+DrIyiys/5D6jv0iSiOrGx/AS+PzvDyermmzt+V6feEbrj+
 tauLumOmUaIWA0Nw9zQj6PTe8hbePKxUQ==

On Fri, 6 Sep 2024 17:42:26 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Sep 06, 2024 at 10:33:54AM -0400, Parker Newman wrote:
> > On Fri, 6 Sep 2024 17:24:44 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Sep 06, 2024 at 09:51:41AM -0400, Parker Newman wrote:
> > > > On Fri, 6 Sep 2024 15:46:51 +0300
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Fri, May 03, 2024 at 02:33:03PM -0400, Parker Newman wrote:
>
> ...
>
> > > > > Sorry for blast from the past, but I have some instersting infor=
mation
> > > > > for you. We now have spi-gpio and 93c46 eeprom drivers available=
 to be
> > > > > used from others via software nodes, can you consider updating y=
our code
> > > > > to replace custom bitbanging along with r/w ops by the instantia=
ting the
> > > > > respective drivers?
> > > >
> > > > Hi Andy,
> > > > The Exar UARTs don't actually use MPIO/GPIO for the EEPROM.
> > > > They have a dedicated "EEPROM interface" which is accessed by the
> > > > REGB (0x8E) register. It is a very simple bit-bang interface thoug=
h,
> > > > one bit per signal.
> > > >
> > > > I guess in theory I could either add  GPIO wrapper to toggle these=
 bits
> > > > and use the spi-gpio driver but I am not sure if that really impro=
ves things?
> > > > Maybe using the spi-bitbang driver directly is more appropriate?
> > > > What do you think?
> > >
> > > Yes, spi-bitbang seems better in this case.
> >
> > I will try to make some time to implement this... Or if someone else f=
rom the
> > community wants to take this on in the mean time I am certainly happy =
to test
> > and help out!
>
> Sure, I shared this thought due to having lack of time to look myself,
> but I prepared the above mentioned drivers to make them work in this cas=
e.
> (If you are curios, see the Git history for the last few releases with
>  --author=3D"Andy Shevchenko")
>

Looking into it a bit more I think we could just use the eeprom_93cx6
driver without any SPI layer. Just need to add simple register_read()
and register_write() functions to read/write the REB register.

That should be a pretty easy change to make, I can try to make that
change soon unless anyone has any objections to that method?

Thanks,
Parker
