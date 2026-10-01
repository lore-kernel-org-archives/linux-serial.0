Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4130540B6D4
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 05:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790832482; cv=none; b=FGuSu0+bh5HVgpCSZ/RYb3Pwb6W6Wl2Ii6MaX/9GNqej2Gz8LpTChovwpcc0bJmc41lTNo4pHWOg85Y6kDfe6EJkHinkDsvQnyBSfQS+eoLGh23wItCFvINd1Lk16KjNGqVDwvGci9ilGCgj7Td+J1KWw1h0JB+DnvjiX1IM6yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790832482; c=relaxed/simple;
	bh=Spt+UFjBXJhc44j8DHEYV1c+HqSHqqXAG/TyMRpCf5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wf4hsd1ucVfqLVwokVXe2ZCcaYxgWIMtSA3snp4YKNOn8VXfit8Ugn01gxbG+op79n76AujKNCzydr2agXB+UnMZqqiIfphEpjqU2X/UIsPfRjG5M8feHH4WitLIoxIOqpcYz7CBJpYx6ULdJjeEzQiXUmeICVSZgFMnHxHBFUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoBehnhv; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoBehnhv"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso62687875e9.1
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 22:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790832478; x=1791437278; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IVL0YicU6s4vWnH0QGlqg5VqXOz3HA74QxakKY7UMwI=;
        b=BoBehnhvGnEwe6RqurJZxA57cvqIitsXMR5OWAilkmb9oVO/eR5GfMmbMMBwSv+GjZ
         AOy0N8/96rqwMgfGj9j7VmQLeII+N43MfI01JqOVjpXbABlpfAnEAIdWZiFzQ/+/C5Wj
         R3ak1GI0Ea/uBnAHw0NaVEmyWRSv92OzezGB9tu4R5Hw7ayYgKJwaWO5OXw5++Zcc84m
         3n9wNkKGXZX4yQduFkfim/DqxvC5f0LEeSXunHsijZA/CW4AKd7yVNdDPVSmjj1hqvDT
         aXE+O8HbKD8FLmceXY1y7QXaj24yGiIdXNpEwLmZ/abtDoE2igfwbPS1hgRvRaUrw0tC
         TT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790832478; x=1791437278;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IVL0YicU6s4vWnH0QGlqg5VqXOz3HA74QxakKY7UMwI=;
        b=fRXv5xTKnPWcQJ/zcrpFhvO6YJPfc0RvtPOjuGtq31aNCuYrP1Y8OalHbAITqdIz7v
         EtXoTASIqsuZ9yQ+YVa5WXSb5qNlRR0F4G7PG+zM32rk86L45jXbNFvbENL355TeexC8
         kuN2/FQKa2GySWzp7l7+HaSGu08LdzdmrLoIgZ1vCSAYdS4wP/SdrY9bITZTgGUJFKeE
         Sqiah0aSVSPcJtjRUWDlGsNE0f6xmp/Yq03/qMsPZw9cCenMeriPp66tUuwW/sbQq923
         FmNQ6ZMXMMJPfGiKjHcgB20WrpRdUa5SXcSPYbu3xkr0x/scTGEG2/1Wll9SfZaVQ1jT
         fD7A==
X-Forwarded-Encrypted: i=1; AKwUvBxcoTAaWTvmiPiOL0W3pSdETatyYRT8jVbXuihdcIE1+OJ98NLMpS4sgnNV0LI+wEGjATH7TesvJqQlbcU=@vger.kernel.org
X-Gm-Message-State: AFuF++nDMuAA/pyAQowRWonY9tBT3wKVEwEAN8gZ8eGdO4KNJlNnUeLL
	nGgRQsol6NPxKRPI5/btAIePxCjJCYHTDpOi5XNdbn8/+gl8u3yFyj0e
X-Gm-Gg: AYBFou3VIA8q4zd9DjvNQf1vQsX21rLMib5gxVochlqxBdvoUp3U6BHdmQJ2aeTbw59
	FK4A4nhxVIUw6xFLqTiHn7iyoUsDm3SQ2TSbphl4pInVPyoK/VWuoWGriK2dxg5/RJ3hBvjQB5n
	FrHGoNJjl0BJLE0BImllxUoIp8RiEhXHBAa7nKxrki8OO5DgYvjkbX580Ui629jWkY+8EZVpVqK
	9NiYmlGl5hM1UPiKRTEsLRKs9RzGIxqjHaAdxZXxfEZ028m8bpEYqh1Rpgl54U6Plg3QESt3uKD
	SLnmas/9Lu/sYM9XKkOEpabHw4TqRGCFxvtBXSeR0KFvHbllZ4nuyIibrcEosxmnHIo1cZZt8hY
	YxItLppqNhvl5/fRtkhLzo8IbSdfrQhK9sk4EiqDg8mQoehD0IlcNVckgkC/925KWTXX5tSK3y8
	z2u7zPkQyNXbo2S0gYDMjF5KBmAflL/k4afbUkVglqUaPu1c7PiqkM7XpLWx8afalSNCmn7jOnI
	u2PEyxkoB41GbVc+l02E6+swWb+GwPrwfedykfARaY=
X-Received: by 2002:a05:600c:4687:b0:4a0:3a3:33e2 with SMTP id 5b1f17b1804b1-4a01adde08dmr57434805e9.5.1790832478268;
        Wed, 30 Sep 2026 22:27:58 -0700 (PDT)
Received: from [127.0.1.1] ([92.241.26.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f979c05sm64944975e9.3.2026.09.30.22.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 22:27:57 -0700 (PDT)
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
In-Reply-To: <SEZPR01MB4208B8B4A5A7F48F7FFE0C9FA28A2@SEZPR01MB4208.apcprd01.prod.exchangelabs.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-7-4617c4463529@gmail.com>
 <CAD++jLkzcf7gJB82XT3-xb4jLujtWSNz1kT2r1-4N54rRfRNMA@mail.gmail.com>
 <1d81c2ef-7a5b-4306-83d2-ff96b0eb6a06@app.fastmail.com>
 <179076749140.3134070.3869742286743401078@gmail.com> <SEZPR01MB42087271C56AD1C7E926AF35A28A2@SEZPR01MB4208.apcprd01.prod.exchangelabs.com>
 <179082517588.138645.14615134489246049313@gmail.com> <SEZPR01MB4208B8B4A5A7F48F7FFE0C9FA28A2@SEZPR01MB4208.apcprd01.prod.exchangelabs.com>
Date: Thu, 01 Oct 2026 08:26:39 +0300
Message-ID: <179083239972.193541.4791387611943615705@gmail.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

On Thu, Oct 01, 2026 at 05:14:59AM +0000, Jason Li wrote:
> We agree with the approach of using a single UART driver since the
> CS75xx and CA series share the same UART hardware implementation.
> For the Device Tree compatible strings, we would prefer using the
> "cortina-access" vendor prefix for the CA SoCs (e.g.
> "cortina-access,<soc>-uart").
> We do not have concerns with using a neutral driver name such as
> cortina-uart. However, for DT bindings and related documentation
> describing the CA devices, we would prefer the wording "Cortina
> Access" to distinguish them from the legacy Cortina/Marvell branded
> devices.

Thanks, that works for me. So for v2:

- drivers/tty/serial/cortina-uart.c, SERIAL_CORTINA,
  SERIAL_CORTINA_CONSOLE;
- the CS75xx parts keep the existing "cortina" prefix
  ("cortina,cs7542-uart"), the CA parts get "cortina-access,<soc>-uart"
  when they are added;
- the binding and the Kconfig help name both families, as "Cortina
  Systems CS75xx" and "Cortina Access CAxxxx".

Arnd, this also answers the prefix question from patch 4 for me: I
would leave the CS75xx compatibles and the dts directory on "cortina"
then, and use "cortina-access" only for the parts that Cortina Access
made. Please shout if you or the DT maintainers see it differently.

Thanks,
Fil

