Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483C184529;
	Fri, 20 Sep 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726847992; cv=none; b=qqdWME5PKdE/w/4wh50S58rr7HdM0Ov0LdwvyI03fFitJPJ4AdISMi33JqMNbRkrvo1DJR8b+WnMnglyq5M88iqt7A48u+vGS2MFy7nGJqiH48Wkf/3CRjf89Ov/kuSP8lgHwGV4bYEAd0xxFaRfhXQVx+dECeupXdhdebAWPnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726847992; c=relaxed/simple;
	bh=NrvtUmVKMPdS19Qc9jCiERsOP8QlTsh/EdRB1HEzGys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTJagaz/SOx2QjyfDQd2ydSE5hLGAsXGYCntKpc9iltznVaDYT5+349SoE4JuAri7A2/u6VDHrjH8AlcrKHTtcY2yvzbW3qxS85v5kufLiKq8+3DEk961UbUYfmp3WPI42oPU2JxGqWRD6wXT8NVdpyty41re9VNpQ+jav9VLAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=ii1K6T5W; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="ii1K6T5W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726847983; x=1727452783; i=parker@finest.io;
	bh=wrGYpc01AWGZLGrC5c35iF2VBvUt7L4GDpkU5WRmA3s=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ii1K6T5WX5gQ7ICmHa6LNyWWdIUZ5+cSBjSHQ4gU8d+2qQ/meYMiBu52QBHQ0Py8
	 U/sf95LfEf1JSe7ZgzwWJZTL4XgcSKIJCbitt8yxvOSq23rRrCbic7xyFxVS1x8vb
	 8qU0EF/i2+YZgdY1GwzTR9ipzmpycBNshjriCB7oEg5c8bVmBVMDDhcIJzdycBDpY
	 JDPIZAS4VTKPWBrOXlpr1uPeym1TO5lppw2Gf/986xw/rtwuEiilFxwIvw8fexCwb
	 pBcNktpudzCj1q/b3sneVWGGk9qTOlXZb3O9MqQnzW4MK2Bno+y82rKRYhPvsRntY
	 gHfeYnymd2lXYZ7XcQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MWUKy-1sU6Td2eao-00Nk7P; Fri, 20 Sep 2024 17:59:43 +0200
Date: Fri, 20 Sep 2024 11:59:41 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Parker Newman
 <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_exar: Group CTI EEPROM offsets by
 device
Message-ID: <20240920115941.1d10f84d@SWDEV2.connecttech.local>
In-Reply-To: <Zu2ZfpnnY6z4BBG9@smile.fi.intel.com>
References: <20240920154430.3323820-1-andriy.shevchenko@linux.intel.com>
	<Zu2ZfpnnY6z4BBG9@smile.fi.intel.com>
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
X-Provags-ID: V03:K1:gPgB0A7drArX4nGZnl/hZ95PhL/BHRDrOR7xF+/d00ZtWeYLzEJ
 gDXFBlms9G0PauVc9sopVa17DFETkTNKbpIDiQy2nmtkF4fns4F7QVYYfBMY90HRdnB0J5/
 nltlErLvYCrhFPdrJSlKtcHsStazD4t+EyXECR/iIi+PvU3ypJ+jJSRGkDIY427bMjJKOH2
 CVdIMjTmbTwggjiWakVBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VknTNGBkkME=;gaHxzftQnYgo77PZWZFZ/DaZbRs
 s6hz9FwG+rnj+VgYvs/5mZA9QyyRkF2Y34n72Hx02wXTbbClDRwg1Ek+5vY4xGcm45xGggIbJ
 XOCV9oShKtEdelU5HDeGdk1JRL5fYhRyCk2QbJdmpxyjeUa/ifE3pBtYhYs+h1WQyJHO0BsJr
 Ae45oFathPesDYbgZMLp1aZj3Te5w+3XV+hv57QgkoyiWu9iR3GaFGU1uFmjknmB1O1ZvzwN6
 9mJW1j2ozMzeoCcr/Sm3Cj472LY49QUC47WY6yxEf7WSE4Onqa8iMIVY41NMFlaYIYJEXdf+q
 z/Ou20VU4tvZt1wVLUMduqpiAA7SR5h59XjZVX2IOPfRXVCsPMjk6Vq7uVzCCKvdDvge3VhDT
 Gd7Sfei2HSjs4pYF6YOq6TxxlcgMCPPyC06GKc78f3/sJW8R0f21h0Fb/l2kr96WIuVBEU5LL
 /0dZfii1I/u6oDp5sf4JVrmw/bYsOIfPSyBDxaov+jFubCjUsNu99VJyHlbBxZHqLJVIVwIhZ
 ho4ks6OVPPW64xnJTPIDWdMR0w1J2g24GXWJ9uNoS5PSLeCXJRFom7XFK0KvepaiZvsmkbWeo
 Fm5w9JM6yDwgRENrWKgmS8GLK0UjWK/TEOXXsB9yapiC2wp1KtatrOy0ii4g792QOcM04LWH0
 ARULZru1xYVhCbNxqBHpT0GhSI7rDKtTvJ8m9Mkd1S9UpeYC77YmJHhl1/IDXUA2YuOJ/rYik
 mQ2DqDQzhfk/e46fqiwR1p54mXg4P9eaQ==

On Fri, 20 Sep 2024 18:49:18 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Sep 20, 2024 at 06:43:24PM +0300, Andy Shevchenko wrote:
> > It's not obvious from the first glance that the list of the CTI EEPROM
> > offsets covers three different models, let's group them accordingly fo=
r
> > better readability.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >
> > Parker, feel free to append this one to your v3 as a last patch.
>

Will do.

> A bit more hints for usage of `b4`. As I described earlier you may use b=
4
> to gather the tags, but also to inject / append other patches to the ser=
ies.
>
> Like with this one, after you collected yours, just run
>
> 	b4 am -s $<message ID of this email thread>
>
> followed by
>
> 	git am ...
>
> as the tool hints you. It will take care about everything you need.
>

Thanks again for the tips!
-Parker
