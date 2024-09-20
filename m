Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67313BBC1;
	Fri, 20 Sep 2024 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726844969; cv=none; b=SjSE0rLz52Qq75h9XENQisYNhwZkEqIIB2pvUDMjTyPUaH2CnKkucg21QsqoQuYhpA7VeNyn5TTgcFdds+GOx3qu/hu6AUMAU+/Hnkk4/kB8zCBEZRq6iMfwPZu8dZqIs5V4mnztWtaxLaSxSJW0wzMol8ARX9EJlZSnZtO0Ycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726844969; c=relaxed/simple;
	bh=rdhZvUrRYqnq10ejxQHRUp3m5b2pphh1v/aFv8MI8FE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g8192gKbtFy64gdnrJXvmSWgAQ5yE3ynBQ2IiZIfIi4+FxkalVuwrF2aGPzi4W/t6JEMHbpILPdH/l8W1hWTivS8iCGJEROH2siHtanq1VVQm73JStwXzBFBYjrKm1iO12Qm09stQldJbjCuLI2qKk30Tjr9yVORUldJ286vy5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=fk2X3rrO; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="fk2X3rrO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726844955; x=1727449755; i=parker@finest.io;
	bh=rdhZvUrRYqnq10ejxQHRUp3m5b2pphh1v/aFv8MI8FE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fk2X3rrO9v8yCTX4Wh2tpc3l02XEC6ND8kgRPnrj3b6QUI6d5fhxDD4+K30XgCIN
	 hLJ5yxsg6vwGvXXmaKuYN9JMxXk6x83iDNLdEGeO2RS2wBPmq5gNFbR+bj/eJhz1X
	 ndCGAVhaL4HadcR2UzkypIEfd5Fe5vN6M4M+R04ytITR4uHJMSC/iOEzoILduuOAi
	 yxET+QcrSdB5f9GdO2YGif6KwUKtbEMNXRkOwNBm68AGc71fe3tAIwHYzbPx/PNT0
	 Z262IU+M2UMUx7l3jcvod3HH3d7ef1xAQc2QCCMixJKOwAwOoxfs8W5MC+0HszRcE
	 sc7e7RpyXxyutA+igQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0Me9Ie-1sbmYn2RKg-00VTsi; Fri, 20 Sep 2024 17:09:15 +0200
Date: Fri, 20 Sep 2024 11:09:13 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Parker Newman
 <pnewman@connecttech.com>
Subject: Re: [PATCH v2 3/4] serial: 8250_exar: Replace custom EEPROM read
 with eeprom_93cx6
Message-ID: <20240920110913.66f768d0@SWDEV2.connecttech.local>
In-Reply-To: <Zu2M5Y_scTkhSyzx@smile.fi.intel.com>
References: <cover.1726838531.git.pnewman@connecttech.com>
	<87719d2113970b6ff4979329fb96346a0aca9775.1726838531.git.pnewman@connecttech.com>
	<Zu2M5Y_scTkhSyzx@smile.fi.intel.com>
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
X-Provags-ID: V03:K1:OVnDAoKanvoUIzsp8vHHjIK9LXZlm9qNDbkeITT3yUhXmXwm8Ar
 2TE+df48TWAtOjLSltJNTHw657a5rm8UXRXlSWfkdhDSlnjwc2bmtHQlpqXSO5m9zur1jwF
 WzkiJQmxCAMh1SJwvEX9NlfTfsqLahu3ftwc1XMtWt2lCelXTv9zCkMpFjitwN2URZdl24D
 9X1LXAFWthrVGqUorcW/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5C+7VOKP7bM=;6vHrg+s2129rPTyjBYq+3utQSDL
 3Qp0AiWI6ELmrQbtoB+sRYCCOeraI9qt6tD9aSVv+SC/W2N2eeuzaj0NgvA6jkKS6+pzxx37u
 op9jN4MRSNImuMdLmjEPUy0vHGNcDOZVxNQoFWHX3HT8ApjpQFwkNgPhhk5fxM8cVLUbmKAFv
 7dgAFfWF+RzCGPfPLuK71MDBN5RFNhdpDDZWEur3K0zz6XROgklR5QIwCuIQgCzpnC1Q2dPiW
 R0eiepi582F0lqQgxehXBbdQvuwQeXmvedHdpCeQE5JOQYstryHh4ROQKxDRFGnEQyjQR1/hH
 GhZ3T7+Rg2TOJItck4sA2d827tVLhx1I6sMGpk8XWFOxWbqyfeUYN3d9bblrJsg1O1mDfrt+i
 wN0tZYtmEwlhS3iGw7z8cgYC4YG5lPa/LakfHDluftk9v2eTQKyTY+2RQZzxPaN43/6L/OhUN
 WmIe1z/yIbn66gGMNXGutqKLMTGVyUGX7sQJ5fNjohnIof4PmuJP6FLIuKQ5IBAWdeANut33O
 U/ksGl/vUVM6R7l6NUvUT/gd1LUnONmNTJAp9XSNcBShGCx2iu5MaYMhKYA8XH/jbKxv8LNcm
 632Xdido0moTM+A1qDCmP9+4GQAGsQrqbPm+5HVjs6CkGC+bA+SIjktkjDZoR4BQ03Aru1lmV
 DZYmD9pLPkVHCtM0yPzzfoc8R5NDK8Kwr+7Moq46t/eroGBloYvr+cMvIbnS4mQ9mZB4OwF3g
 LRC0hJG8fH3RAgLLkeptVKaaSFTzmNxiw==

On Fri, 20 Sep 2024 17:55:33 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Sep 20, 2024 at 10:03:23AM -0400, Parker Newman wrote:
> > From: Parker Newman <pnewman@connecttech.com>
> >
> > Replace the custom 93cx6 EEPROM read functions with the eeprom_93cx6
> > driver. This removes duplicate code and improves code readability.
> >
> > exar_ee_read() calls are replaced with eeprom_93cx6_read() or
> > eeprom_93cx6_multiread().
> >
> > Add "select EEPROM_93CX6" to config SERIAL_8250_EXAR to ensure
> > eeprom_93cx6 driver is also compiled when 8250_exar driver is selected=
.
> >
> > Note: Old exar_ee_read() and associated functions are removed in next
> > patch in this series.
>
> Looks perfect!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Let's wait for others and CIs to test all this and then after v6.12-rc1
> is out (presumably within ~ten days) rebase your series (as I suggested
> in another reply) and send a v3.
>

Sounds good, I will wait for v6.12-rc1, rebase and send v3 with the
changes you (or others) suggested. I promise I won't forget the Reviewed-b=
y
tags this time :).

> Good work!
>

Thanks and thanks for the help!
-Parker
