Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792914506;
	b=cyQlAv2U47e9JFJO3OTTH4YmVC1u3fj2qUYRXS3z3n+o4BzAioMXCIOXYdd8f/EcIJZ0
	 lJ8bhWCiAWUAstD6ik2WSlIiEaGWoX/PtoWNICNctFQCsrSv5ym/FEoePaRGFyuY6uRKQ
	 +EJSCX3ZsypnsSxgbA5cdfIWx72bw9tGDjOoRtkbvbWOifmAM+8l8ir0vgmzgGaecXqJD
	 xXgeJTXAiyYoZQ9B3ca7VEpM6s6HAms2hPaq2c/bv7KTUnC4m0g4NY8FTcxFjck3u4+Ru
	 duo2ow2AjF/XkQ3VOomcjBKqwm+BuxiL1IPgJrJyirJxWeEVE17rHwgD33kR2tJ7f9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792914506;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=+rbPkZ37ljscrYpT1ljQdPAJd8n8EslTW1gepYQS2WM=;
	b=mVI/vxDSvY3Wjc/6Z5T4NvxyIQDD1d1p3J9gpEntxzaq6cKSCSfx5IImf9NyF8UHlS6b
	 9rWZN4oRZlHqdZ/q6HVehh6FcL5GWHVJJ1cqAl+b8wgXsWHsSdSuVxV19TDEPulMhhLbS
	 u1D1EwMh1fn1av1pWvZc56kAziMksmDYz1YeWzy+krsZQic7mDifsoCJI6PuvkohgZBxm
	 ljRCpAg+ATjoUwOePCHqQSDvz31Kcfc2gnzsyIHnfMxJJbeXZlJB1FR0s2Pk1fC3dT/wY
	 TwWzZN0LjMypNaaT7NQ1g+jt/fINWdvtC5wJun7s6c4Of0PKA2ohLIg46W6as4bK3Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="Mf/6q4+L";
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5F5606A31A;
	Sun, 25 Oct 2026 07:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B5F5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Mf/6q4+L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1792914495; x=1793519295; i=deller@gmx.de;
	bh=+rbPkZ37ljscrYpT1ljQdPAJd8n8EslTW1gepYQS2WM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Mf/6q4+L3mfzHqnpKqLuEHHoaleXe3+JMofuQbcdEduleCvc4cjNNsT5GA4GihKH
	 B61FsF9IaT6lVT40NS+PY5oOZiUKPrKFPkZjbdc58L9GINNbjFhaNjlbIjQ8XM45Y
	 t2YnSCMGpDyVchlC/7Wcp1oSh9u6ZQXG9e+aOQ7y8o/BEu4eN+7N4HETi6LM/VTDi
	 B6J1adZIWAPww/kI3BsZbS+xDErgzyinQvIzyfPuR3uvhuy9KUuCSkDKHCTmA8ZS1
	 dY75ml59EjXKY5jKcRWAoQzme0tcFT5MlautygM/38Luj0pHE0ZATxTELvoA48G4P
	 U0UO4sDRzNO5WlykAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3W0-1x0c1B0vpG-00TENt; Sun, 25
 Oct 2026 08:48:15 +0100
Message-ID: <68342b92-0e12-4aa1-a215-efb623418696@gmx.de>
Date: Sun, 25 Oct 2026 08:48:13 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] vt: Remove old-style con_blank
To: Greg KH <gregkh@linuxfoundation.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: jirislaby@kernel.org, James.Bottomley@hansenpartnership.com,
 simona@ffwll.ch, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
References: <20261023132448.115747-1-tzimmermann@suse.de>
 <20261023132448.115747-8-tzimmermann@suse.de>
 <2026102312-chute-proud-204a@gregkh>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <2026102312-chute-proud-204a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GIlaxuVC9w22cH7BocYXzK6DRcEFv2HWJKeaEXAq7KWGfldKQRc
 L8GD14fWWTSOkI2Hts3EqEO852cqIEGI7YY1duBJLYzAoBnWlMAZNQLhyiJigX86/7T0UGG
 bW/b15hrWV1yAdirCVJ0UBeXhTZaBe0mT/X1QOgdqlwD7rgg5ycC/1Cgyluf7A/GHe5Ja34
 w/3oGRiiKYkUR6jPU1e1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fHMNiKTf5R0=;0fr0BQrtjLsuKhl+8jhsGQ2nhM9
 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

On 10/23/26 15:37, Greg KH wrote:
> On Fri, Oct 23, 2026 at 03:16:17PM +0200, Thomas Zimmermann wrote:
>> All consoles implement the new con_blank plus con_unblank. Remove
>> the old semantics from con_blank. Always pass a VESA blank mode to
>> the blank parameter.
>>
>> v3:
>> - keep con_blank's mode_switch parameter
>=20
> Shouldn't the "v3:" stuff go below the --- line?
Series applied to fbdev git tree.
While at it, I dropped the v3: stuff lines, so no need to resend.

Helge
