Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90F3BBFD2
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790825212; cv=none; b=QJZAh6EwreLLzvsGxPsyMY18TmMw3SxJbfuiAOYNX+UVhCEE/myg2OS/X4yPlUx3tlovaqoveP+fHcp8r7mOEHKnuiOgZeQ8oIH5W5Z2hlt440x3vZ0ggYEgWeGLHqP81fbtXRacQDCJZmZyhT44zhxQ6dY4Bn/azTPDuPHj9pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790825212; c=relaxed/simple;
	bh=XAY1dTOwRRbIO6ceOMbhJ+KO+bFWSEcRZxVi+y6APPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i0zHpwt6skW3Xee8azLMyiu17soCrUyMgtADKzEOpi98k5YZ+La0lgDqd0/W6OWT77PEmhovOJon+7jSUL6WEbI/CmQICmDtsjOzedjQtuE5sR7NHGt0y4eD2jsfr3UECNgiG4Bp+ghMYGvdKqpJjQtcdygrDsoJvUcimonH5eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vt7/9bIp; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vt7/9bIp"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a003bd18e5so22038905e9.0
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 20:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790825193; x=1791429993; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAY1dTOwRRbIO6ceOMbhJ+KO+bFWSEcRZxVi+y6APPk=;
        b=Vt7/9bIp+E0SZTfy4mgg0XSjYauA2f1f5EO8QS6+UqZK3MNAJbqZZgJOqE18V1gfPH
         ec0iKwUVFHkO9zRp7O3IO29/cfNgD6cP7n7uwC/WhnF/V323RWWTTHmfL/yli3K5zp2t
         AgeF9jrsTXgyaExadk+EXmV8sAkqPczfKH0/YXulc5vczfVnO/PENxMpxwG6ZmiLFwqP
         kTEYZaJNIlEgjK8YXxB0HGSR/1lxwTyvVPchVesZysILd/AoWOh+KoBwq0bMdfhxleAs
         dcukfn2gtosf9FTFSMuWlixeegnkXlcoTuPTfrgvIqDLkkLOVEeYGCLebOGfijI9cvRY
         Khhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790825193; x=1791429993;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XAY1dTOwRRbIO6ceOMbhJ+KO+bFWSEcRZxVi+y6APPk=;
        b=Crgh6x00g8CIZbatePwkYpiPGU+WRVgx4h+JiY7+XQb62HJLwgRTQFAzEvtoWrwsDE
         Ms6qceLCUjjL+tAHTwix6IkdTr1J6hPz/L0zbZKgKAuX1g6POdBn719khyU1hKFzGD7E
         wa6KykKkb+R7huaPAUCjIqfr36d4ulkp/6SFpL355cXjE0A4ItxzmTKVLpULsWgGBJIl
         sdJ4bnUyWmkMdeNaWZgrVTxmRJtvS9YPEwmCpvNbmGx06IzQbRsClk8q+uDsTR0U8twC
         L5XPbMxdTbSrQr/nrEPZGsIWdy4MVAhi6H/2W/DuQYo/Yeq7Bj/8tvW9bdu2+EbF+XNt
         ZZ5g==
X-Forwarded-Encrypted: i=1; AKwUvBwEvWu5zA9+3q83wOjgdt7mKtODAfrhFIS9+O6N81eBi+4tYR9LW0XLnIpdbIsFoa2zBUzLr+e66I5wpLc=@vger.kernel.org
X-Gm-Message-State: AFuF++ntvg5KeqBocJDztoP5kQvZwidkOYivWWWz+lxvLj8vktXCdfZt
	zfbyQtI6r2GmG/OVNEzgmvmkJUMgihcGlMyPpD3Jt9FLxW0YLNFltaVy
X-Gm-Gg: AYBFou1yf1HR9BymK0MSG+6aQ7iiDBG6p3slOOsclogZMoDrsZOcOTlB4v4abbsDaJQ
	cSUCBkQHbBrgiPnw6ofM64go2z1AndIMowv1/INgW3xCl9F9lud3fN73JTZlhxWSylIBJp4p2Np
	o0LA84f+DIsRFgRIhpOnZM1tKdjqhFry95f/+NYJiwZ4sfcxjdaiHe55CPvelBpr17ZRbamFfIq
	vA9e+4w9X0ZKhkcqGlqGsDFhXigdv/XKPZl03DOrj7IWNYaHmi3zfF+J+99jhwOX6QyCeLGRCb2
	rS0TnyIRCYetjcWOIzfPRbfO2nSv6745JFlqOiYWAp7Z76Npao5xDApBb0DaLaoydnTbLRZKZKj
	WAPiumoY947GysrcnbW3Ro3vVfGSaJVdaH9OKDIM03L0XnpG6sglW4hQPJRyn5q7eNNiSivTURV
	/dqRIC/hUb6pfanHE85H5stogDGnQLRzN7s694v7akSn2xDVj/QT2AuQlhsw3eGPaz2dwOXSR8B
	lfMb7AkoKLxTUFYv0THm9R4Lb86xpp7Dg==
X-Received: by 2002:a05:600c:6815:b0:49f:f963:7093 with SMTP id 5b1f17b1804b1-4a01b00d679mr55372455e9.23.1790825193330;
        Wed, 30 Sep 2026 20:26:33 -0700 (PDT)
Received: from [127.0.1.1] ([92.241.26.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f9851efsm36483535e9.8.2026.09.30.20.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 20:26:32 -0700 (PDT)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Jason Li <jason.li@cortina-access.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Drew Fustini <fustini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject:
 RE: [PATCH RFC 07/10] tty: serial: Add Cortina Systems CS75xx UART driver
In-Reply-To: <SEZPR01MB42087271C56AD1C7E926AF35A28A2@SEZPR01MB4208.apcprd01.prod.exchangelabs.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-7-4617c4463529@gmail.com>
 <CAD++jLkzcf7gJB82XT3-xb4jLujtWSNz1kT2r1-4N54rRfRNMA@mail.gmail.com>
 <1d81c2ef-7a5b-4306-83d2-ff96b0eb6a06@app.fastmail.com>
 <179076749140.3134070.3869742286743401078@gmail.com> <SEZPR01MB42087271C56AD1C7E926AF35A28A2@SEZPR01MB4208.apcprd01.prod.exchangelabs.com>
Date: Thu, 01 Oct 2026 06:26:15 +0300
Message-ID: <179082517588.138645.14615134489246049313@gmail.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

On Thu, Oct 01, 2026 at 03:17:28AM +0000, Jason Li wrote:
> Yes, they are actually same HW logic. But the brand name of CSxxxx is
> owned by Marvell instead of Cortina-Access now.
> Will there any legal issue if unify them as one driver?

Thanks for confirming that it is the same logic.

I am not a lawyer, but I do not see a problem here. The part numbers
only show up as compatible strings, Kconfig help text and comments
that say which hardware the code runs on, and the kernel does that
for chips of companies that were bought or split up all the time. The
driver itself is GPL code; your additions would be under the GPL as
well, with your own copyright line. Nothing in it uses a trademark to
name the product.

The plan for v2 is a neutral name: drivers/tty/serial/cortina-uart.c,
SERIAL_CORTINA, port type "CORTINA", and a binding with one
compatible per SoC ("cortina,cs7542-uart" for mine, a
"cortina-access,..." one for yours). If Cortina Access would rather
have the CA parts described differently in the help text or the
binding title, tell me what wording you prefer and I will use it.

Thanks,
Fil

