Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48699156F5F;
	Fri,  6 Sep 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631512; cv=none; b=QMMrtgx554trOeKGyxSsUD2HKWw3uFvI2pBtjRIH9+2/qL8nmO70psZhiW6XjIAeB+9yFIzIXBq7ml4DgGy0QIph6e5u3jRm8BcWghdcV8ZFD/d/9sMK13/jRLPudjaJhwna5PR3UAdTyQcsMt4A3CtDB6f3js1txuhaD/lCvFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631512; c=relaxed/simple;
	bh=qY3+B14GBIIFJBGWDvhJ6U35yjbaHf2wTguFXuxr7SI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cfezocmev+TnAeVAn5BLZ3fcg3PNu4yc1M66ol8RDbnyDfhlenMI/O93OM7XUX9H9W8DKOug1K+VyOTOGamzYfQQiClGuGQxi1Mq7ZuLZaAoK0MXXk7C69a7ZEfiqisDHG5iCb/uRMbcCaKZvGpCsFUH51/cOFus3tiFRnLG4yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=MKR5WGhj; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="MKR5WGhj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1725631509; x=1726236309; i=parker@finest.io;
	bh=FvEIc1kd/SLBsjKUr8msz1hzEsJdR3MUWGjJ7Yf9v9g=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MKR5WGhjL9Nf8jW2jyUnJAzBz+tpt1akzFMjbHrBLnk/Ep9kJ1G7RxMPJTC3E9r8
	 jEQctUcst3VPJDz+RvLpFdDgl0+T/6gmVkZzEZMekLEmNjXarFhRH2iPFQpVI9+H2
	 Z9LMmlf9GKB8GV8QDlArYF9q819AwvBFujgfyKXjcmq5XqpTS12QmutTZYVuBBFXA
	 WGr2SKXcsHsuzoffKE4pidCNQnBFcNOu1G61WXCIktcSQQKB2gyNRVowC6y+gULJm
	 knIoogyhZ+el773Wb+jUc4apGo+PBqBLojCgyshx4UEA66DT1zO2umahxoD7Onk0b
	 A5Bna6DLLE5YPtdTrA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MVMmB-1se9gu3BLz-00WCPS; Fri, 06 Sep 2024 15:51:43 +0200
Date: Fri, 6 Sep 2024 09:51:41 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <20240906095141.021318c8@SWDEV2.connecttech.local>
In-Reply-To: <Ztr5u2wEt8VF1IdI@black.fi.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
	<20240503143303.15bf82bc@SWDEV2.connecttech.local>
	<Ztr5u2wEt8VF1IdI@black.fi.intel.com>
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
X-Provags-ID: V03:K1:jbuEN7qYhKL+u2Q5zfcb9gO+afvs4U+drzVioJxQfRdsRZMzZty
 D7SF1ssEeOrIpyKr8gnqKmh69Ia7D3CEeTEbNN2kqsJPmuBe03SD/imiKE6A+zDXwX4oTBF
 XgQMiYtGYFvuDrRVepuDDkZisDroq6fuqMOzKyJmIUHmA0z/WxOC3G3p8fTKVcsgYdtmX/m
 m8OhqiAtjuXNAV5iRLGfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ff+vd29p42U=;IB2LxpD7UNZa4e86g5pLeO4pf0n
 RewUk4kCCjf6U1bw6VgJS4MZhWy/RFAKia8hkkktbY5xZN6i2/5p3wNM+gcklurAvBxkQfhun
 KgO5mu3PuEpQwRrCilZQYdBGbFTnn+pOL7cNjcjjPyzwhMkSKwXUwCF2AHCtQ9WsLpYw/wqDs
 hqkzRpfvTajMYexm+bQ4lHA6Jcg36/42H3IsdYkB9uzX4cixI1jGkcskQyr03gwQKWrGOTVlD
 nr42MucdiYBYaxLv6/uI5gv7hII+yC/QLRRoaXhi4vJq+66px7x9hHNyXAtnlaDCLYrfSSkTK
 dAkYi+T7T699Si+NjImY/Ton3pzPgYzq2bXd88JKyq7hQT0h7EWdbyAIl1Jf/GxTI/uy2706I
 ZrX4lUGytmCECbfWAq6jtkv8h23XZC4KbmT1srbCFlkezw2Iz5VACZkyoPvLvK9tHjYpq6tdL
 RVzWmiqU/KeBgnj5xBYWLph9jzMGnjXIp3BrMn7N6XEfFwoKXozQvLyXVDqiAxQvSZCyuldzT
 meVixa3/mvqUMn7kVIXrXh4Z0OFwpyCBOqUFsUZ0wSnPwWZ6ZRpcHp8/nuOhVCn8MlcRPB+R1
 Y+IDfPUvuOsQp8mY4UqWcEeTWsVxLlDsurSp6oyOXe6ciLoSud46QudifgxGZlm8E2VuG9ieh
 ARQ0fO8xgM/s1a/EmXV7UT9nNlV42bz97LSU6lcSDTYcnIX4NJN+EZ6BPhg9+p0ogKsnd3rAd
 Qn9c+koHVweJKjnOlBs+qa+NQaSuL+A2g==

On Fri, 6 Sep 2024 15:46:51 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, May 03, 2024 at 02:33:03PM -0400, Parker Newman wrote:
> > On Fri,  3 May 2024 20:15:52 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > After a rework for CONNTECH was done, the driver may need a bit of
> > > love in order to become less verbose (in terms of indentation and
> > > code duplication) and hence easier to read.
> > >
> > > This clean up series fixes a couple of (not so critical) issues and
> > > cleans up the recently added code. No functional change indented by
> > > the cleaning up part.
> > >
> > > Parker, please test this and give your formal Tested-by tag
> > > (you may do it by replying to this message if all patches are
> > >  successfully tested; more details about tags are available in
> > >  the Submitting Patches documentation).
> >
> > I was able to test the Connect Tech related code and everything is
> > work as expected. I can't test the non-CTI related changes but they
> > are pretty minor.
> >
> > Tested-by: Parker Newman <pnewman@connecttech.com>
>
> Sorry for blast from the past, but I have some instersting information
> for you. We now have spi-gpio and 93c46 eeprom drivers available to be
> used from others via software nodes, can you consider updating your code
> to replace custom bitbanging along with r/w ops by the instantiating the
> respective drivers?
>

Hi Andy,
The Exar UARTs don't actually use MPIO/GPIO for the EEPROM.
They have a dedicated "EEPROM interface" which is accessed by the
REGB (0x8E) register. It is a very simple bit-bang interface though,
one bit per signal.

I guess in theory I could either add  GPIO wrapper to toggle these bits
and use the spi-gpio driver but I am not sure if that really improves thin=
gs?
Maybe using the spi-bitbang driver directly is more appropriate?
What do you think?

Thanks,
Parker
