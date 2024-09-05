Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A785A2260C
	for <linux-serial@vger.kernel.org>; Thu,  5 Sep 2024 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524122; cv=none; b=ac1L59/MKTjPdB0gF4e1IXxf6oPneDbay9k+KT8wRTj1daDIzeYmAP5P3fa1ULtaQmK/BebsceIAzcrRFMWOBHBg8Vvc4aOCKUlIWDSc4mdhf44zeBypHYqkxmiVG80T/01HLTwUiR68D1SZnqf6bTdiA4aiayLktr5ocrS4LLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524122; c=relaxed/simple;
	bh=dQ8610Cw6mgrRJPKrCubMWei2BND80AgoPNcBjStR5g=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date; b=qvnB+KXO5dmeYeDf5HR5dEfD8kXNgbZG2kd5OjF4JBUZQ0+3hcQesyDeCOT4oWcsAtKMRdCdzg37XHwKebH7E01hKKwulUJEaoflc+MbzNkTEMotE3+YMXzzjFelKFCB+Yu+h0tN8vhvHvue+LTqEIyR6a0o7coQpwfqAzb/YoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=radisson97@web.de header.b=vpDHrTNf; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=radisson97@web.de header.b="vpDHrTNf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725524112; x=1726128912; i=radisson97@web.de;
	bh=dQ8610Cw6mgrRJPKrCubMWei2BND80AgoPNcBjStR5g=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vpDHrTNfa3CJBL6HhctW9uCHKkQf3ruyCgxwzwPXT8nVx15XuLR9lITL9bA5h+rT
	 1OpljIdJWP5Kv1svoQwp4HSy7lKHhK3yYBt2FeqA+NgiP7ID0OgfWz9jkFUEXQirF
	 y1vovQ5ACJTvCfxi76OTdcBapW3bz7iuo71wo6/GZFinrbq1H8sLNg/JReApfH/Iw
	 9F8wx9j2m0Ku2a9UGzYylWkCCdOOgH1+OR/wvo7rGDQdxZfY293K94Y27I2BRmwNb
	 W7xuJeOkgyrtG81IneWdM1y7EHZmz8Jg0sRCbyClR2qaKHSPLmoAhnKeTmh1HsTlI
	 HegzU4AT9XI6XL6STw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [193.174.231.68] ([193.174.231.68]) by msvc-mesg-web109 (via
 HTTP); Thu, 5 Sep 2024 10:15:12 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-385b45db-ce89-419e-a226-4e10351f0c0d-1725524112044@msvc-mesg-web108>
From: Radisson97@web.de
To: linux-serial@vger.kernel.org
Subject: possible regression with rs485 usage
Content-Type: text/plain; charset=UTF-8
Importance: normal
Sensitivity: Normal
Date: Thu, 5 Sep 2024 10:15:12 +0200
X-Priority: 3
X-Provags-ID: V03:K1:LMQBdxXAnY5raIyNCSue5h/MTmgcjxy/nSvdmocT5nYz2K1OEN6xP5c/g28Z1HN2wy2qH
 AtKngzWYBMM/DTue2A63ejV4xoswfDIT7OKrAMHK81/h2FazW+syNPJFwsDnJBmREZ6s/UWemKhB
 Gaj9/qbzJ0uCcBz3Lomak0/gcd03rrMsFT6ML/FwcG9FQrwuita4eMEGMD3/GLZ6zu3Ir3ZfAX5o
 OiGtg3essJ+lqMHFysSRdeekFyH4JNZu0X9n/0EGGrxYhQlk871WnjXc2Wbk/sHzcoiCOYQ5vDZS
 Zw=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0FRdnLCDcPU=;C2DR5b1+opDrYo8EGzd3EjYqMff
 e9tCXdbnrWiLlngtAyMrc9a4azv/IcI249fDJG0F9TcLkQO19QqV0SwQIqOGwd5MJJG6nIXQx
 C/p7VwdJu3G8C6Eli8sHoj2ugdaVquFCVZHjyE60B7D+waGF4RjMbWksuA3fADZW7z/VGSrpk
 ty/4tJrs53qn2e6zigPZloAJaUz66ERLvpx3QD0L9zcx4j7g5r9jFQw5aphlByIv2a6R6aTbo
 kChshjXPP0IocCSPgHGSW426tGjgJoDjvX6l4jl+IlpWjzEoSJNZTOGZRLkPEhN7GFX/Xnydl
 sO2sV93b1d637aajbDVJMZc5ULrH78v07j1PEw9jw7lhaNvqpTRCGhJn+8I8bm1YIl6TvAG+k
 L3fvzr6yl43smN73fRuUl0lTStvaOEcmQP96q/gIxa5F2mgfcHZBxupC9dgsAb+1U0r31defC
 mu09dBG+K0NBvauxAYCmgxFC8WWidaD15FL5B0lp+308HfcINKZZgLD6DcvZmDXacBbj7hazP
 M+CLY65jwMTDtBa3V31x+H74exdqTb6gW6NpvWP7VioqVVkVla4AcpfHHUlmXzPzP3paabUWX
 SINXxn3PNnLgpzMe3dK9d2jeMbB3gpDa+F3K0NKWmXRHkBmo8RDcH9xZYPjHt1wMooArcdp6k
 dk1/wujlvYTcfm2WSWncMnjqR1RTAPeQwluhUqyy4g==
Content-Transfer-Encoding: quoted-printable

Hi, i am new to this list because i have a strange problem.

We have an embedded board based on the omap3-design with a rs485.
With kernel 3.5 it works fine. Since 3.5 is ancient we are noe trying
to get a new kernel up an running what is 5.8.

I turns out that the rs485 has issues (it seems a lot of ppl have
the same issue also with other boards). We enable the rs485 via ioctl()
and nothing seems to work. Several restarts, playing with Marcin Niestroyj=
's
rs485config it suddenly works. (yes hardware is ok, works with older kerne=
l).

Can someone give me a hind where i should search. I am not a kernel expert
and there have been a lot of small changes that i do not understand. I am =
pretty
sure that it is not a major issue (famous last words) but i am out of clue
where to search.

CU
