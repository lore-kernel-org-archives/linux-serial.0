Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C946D544
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156654; cv=none; b=bAWU9uyC8LG7kE7fiF0V+66hrqxhpA7rx94H2ZXVFx7CYqqDuEMURv9iFJcMvj8ng243dCZDpR0Aty7cLCxw63TxYxRCCtQLTGfP7oFExpwb04vsdluCJ2aeeZcyO286h8HvsQk33pMyrpeWvS+2nzEbq7nio/1W95QgJ/VKGGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156654; c=relaxed/simple;
	bh=972BnS86W6QOavz34L61+TBk0DmhvqVC2zFod9PkusY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=r2Dbsed0abCIaPKfhMRRUYh5+1+TcSTljLdyZUQPte2M3TqT003EvZ3JRlP8LlrpR0ywRQ/G4ls2zaYWPOY+DvUU5mqQhib/Qf1yVmGMHW9QTYCKbf/MzjBAInDDJLyj1D3hb7iCTWTNKF/bmKY7gBfXiJVYj7THHqFv87JY/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Zl/DdgPP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ccvG3SZp; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Zl/DdgPP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ccvG3SZp"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B57D01400090
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 09:17:32 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 16 Oct 2026 09:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792156648;
	 x=1792243048; bh=W68fWyUt0RqgzohdtV/Be5eCqN0axXdNamgwFcm1kWg=; b=
	Zl/DdgPPJEHSBxcFPz4ZC06k6gpE4Gcuq/B5qE+9f+8l076MhCKuRRJwgMkf1QMI
	Z0yy1TfzIHZmvRxQ1zuuyqowLV7GkLDQlgSbx1MLiz21V7UlnbIQ4whj8oO3lhN/
	YkXdkrNw82didVE8loVmbS2GC6R49YuE84fdrYdGzEtUgpYqT1PkiA0x8pJUq0aP
	kMxdAaSc++E2QSPIdTaUajnAc/fSK3vTBCywJWisDIiQsK0S541/0foYCgYxqU6K
	XA+cM0/9Xj5FXPPS/+hkaFtEHtRArh/Ga0SQ8hEy9L6A8JUxFcBBLV3Nyeqj3BEW
	g5+WthFjmdk8B4rV01Smvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792156648; x=
	1792243048; bh=W68fWyUt0RqgzohdtV/Be5eCqN0axXdNamgwFcm1kWg=; b=c
	cvG3SZpHtQxs4NT5HMWUR31SOzXLYX86IAo8Y9R6fgMQQ8IpLrQTUqttPjqMV4Hu
	AYTo8ifTMO5F6B2UUkp7UOKAteJaou9CdfYA3+8a7FRXdecM4SIg+cNgt0PuDTQh
	Q7/IlxxTm5bYJXPoplSinKJWxf/3dyCq3tzlk7Vcp0IQrTwBukQfJK8pK6VHW4vn
	eZj4mMeaa7KSwihWipBRT4fxwRuNHLEGhJA/GgGVBqQFI1kRtC2+jXImgnlMfIoN
	zJoMYiMfDWdErEjB74eCfsD98G4tgFkywMOiHOWYDaRLZRj6HxMpzTId1zTiqo6/
	MdZDPCB6e2H4+DSkajp9A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792156648; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:KZWp0/KHEDeny0Xi729a5XrlQU6DYMDXjrk7wgq3NdkXNIB
	O5tArerMaItBdgdir3K4cJD/sFx7J8Uyxkkan6nsmNHYdAvC59tyL4kwbVGi9KOD
	il8CFyTQfKa8aBxcBLjBS3YZoIble1QIHX7y+T2c2NGIof6oNnBc8PyFg58pmD5t
	JpH0Mit3jQT9H9ykGDyepAhU6oyTg5E4pEb1NZN6Sl8W+Y3ZUVNwaFwCzx+LtBrs
	HYa4+8gixVvRIcElh4ha+eB0TVfFcVyGsI+ibnowcq91FaH5wm6kB6/qHE1/PRa0
	lCMHj+qwAmTqCuBPGbptEat+K6X6wvh4mkaFopg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:GJg7u/ORzO4WgLlQXUweuEi2kkGgedegRGXMGcZssAg=:972BnS86W6QOavz34L61+TBk0DmhvqVC2zFod9PkusY=;
X-ME-Sender: <xms:4yPSauoiu4jENIqFZ-abIR6-tkOQWHHD1gvMLv5Q7R-7eYzFjBPYvA>
    <xme:4yPSanftUlBSEMlSLvifhnBOpdJelZ8fi6pj_-eDnRpmPNWtlys3K9_K-d6MlX6mV
    c8b950iS2QzGNjS_MPhc8oZ7YAhAj4ILgGA7271oemlC0JvUx0bWLo3>
X-ME-Proxy-Cause: dmFkZTGPmXvGMY0yIONbWQUWjnk+A+PreQlAAykNq5ZIAcOQxkwSM5UmMl3pv0nTtKClj+
    Emxqw5/hrqYNd+5+UzkdOL3q7KEKQHioxgqCo4dN4+0WuCrUNvZvzn1sMTXw1pJ7cMiQ5t
    02gUayOCdQM+CjoVj1UUWaMI6GrUK/qt5YD7pcTjLCL65ieF3MitObr5YkcTPmamJlIfyf
    0Sn7+OLVegmgwivxqtTiJoRD3euOb5q48xVrUIOSmaB+q13akV2DpPLKv0JdJdueToanMq
    MRXQxBVezouhVc/OR/Q6JgbfhPUSm3/9tmrt1oFtQo9J74ztHCT4yS1Jd72v6fY8FsN3DJ
    AfMKWEzwORYKI5ZvJxRldZ/F6zjEiF87SBOcljLZ6tv3f/UVAWlBUJbwOQ3+SBGa/9oQhX
    VZLz/CLJgh5EFqyjK61lOB1VyVEF7mG0XLrGXKvkZ+4C3Eak/MZj8ajky6Q2aAfZTBapO1
    f3zI7gvv5VsHd66WFuMbTZvAvavI4y0PK5ajgkOzxIDGg/Y2rghER3zqLsO8HHdr4ZmGGr
    iroT9I53X1aQn8U14NPpSZqwKY1Yr1BB2J2nxlPcvLsO2HOEy2J97xUiGYSN8u0DCypfnn
    4apYg8VoEnV+ou9tOE6G7UTD1FCZRxCf0vkYQ6n+Np4sOe7LDiRu9Vsufp6g
X-ME-Proxy: <xmx:5SPSau1TAi1iCv3D22MRhB1fFr79mAcrte93UnkbdkXq3X0eW1W0kA>
    <xmx:5SPSavUvWYhNO57jV0FKTRztemXAqG3Om2yGjE5uP5Wu28mhEh8gog>
    <xmx:5SPSagPNOdJV4DCMVqqqKmKxVKUzBDwE44OqwqFvSVUL8Grlpp2IqA>
    <xmx:5SPSai3PdQDthJO1rR213LIHaje5f_6yvKraBlQkjyze4cfwL8aYFg>
    <xmx:6CPSaltb81-tFSENaVCMTFkfkMCKpS7-Iybc8SFjMcUL6moLhn_OyUEI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 85D0332A008F; Fri, 16 Oct 2026 09:17:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A0hUf3a_Z_uw
Date: Fri, 16 Oct 2026 15:14:54 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Arnd Bergmann" <arnd@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Hugo Villeneuve" <hvilleneuve@dimonoff.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Message-Id: <033a1d9f-f8cd-4097-a8f6-da01494eff34@app.fastmail.com>
In-Reply-To: <20261016130328.1037616-2-arnd@kernel.org>
References: <20261016130328.1037616-1-arnd@kernel.org>
 <20261016130328.1037616-2-arnd@kernel.org>
Subject: Re: [PATCH 2/2] [v2] serial: 8250: remove obsolete and broken PORT_RSA support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 16, 2026, at 14:59, Arnd Bergmann wrote:
> Link: 
> http://translate.google.com/translate?hl=en&sl=ja&u=http://www.iodata.jp/products/network/rsadv2s.htm
> Link: 
> https://lore.kernel.org/all/1309211120-2803-6-git-send-email-arnd@arndb.de/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: rebased my own patch after 15 years
> ---
>  drivers/tty/serial/8250/8250.h          |  17 --
>  drivers/tty/serial/8250/8250_core.c     |   6 -
>  drivers/tty/serial/8250/8250_platform.c |   4 -
>  drivers/tty/serial/8250/8250_port.c     |   8 -
>  drivers/tty/serial/8250/8250_rsa.c      | 209 ------------------------
>  drivers/tty/serial/8250/Kconfig         |  11 --
>  include/uapi/linux/serial_reg.h         |  51 ------

I had this one in my testing tree for several years but it
looks like I lost the necessary Makefile change, and
the corresponding change to drivers/tty/serial/sunsu.c.

    Arnd
