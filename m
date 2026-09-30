Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C061C4A2053
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767501; cv=none; b=JWzF0hpXo3p9WSzOy0MBdgie889h4IoZGGo1ZVBqtmXd/mULaKLQTg4Y1E0CVK0pbWrEcjmYqa4xD3PsY1Elk4fjC4LEodJhVRko4tWT8Ih/f8gSZbFxUfKzQ0QDQgEkt+kU13litNQC6uRmP6WbBRbgxY/JzZMEkhk3KXLpv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767501; c=relaxed/simple;
	bh=poceB6zKoYQu2FsWNzDmrgG3238OZ8RROO5Gpc1RH5Y=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type:Cc; b=jGcuDWUzV7W+tvPztwVTGf3p9X7Y9Uu5xByl/SssWuJAplPIi1Zacjpj5y2dqZuBhB/4j+jeTxW1ofO6GTeeuvvUR8ViM01Ft/XPUg9f4WL6kJo38tf8MS0xr+PyJdwovm4MAkVRiOB9KsdGbN5dcM+G+LUXfwcem4fyy7G/lvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOJ7klXv; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOJ7klXv"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a00d8bec5aso11792165e9.2
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 04:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790767494; x=1791372294; darn=vger.kernel.org;
        h=cc:content-type:mime-version:content-transfer-encoding:message-id
         :date:references:in-reply-to:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=poceB6zKoYQu2FsWNzDmrgG3238OZ8RROO5Gpc1RH5Y=;
        b=iOJ7klXv3A5wy5m2b5K38Pa1IoXSzcyv6XZmgtoDkKETifN3ukEcVNNJSmQbvnjUXo
         0NufnfzepqEUvUI//pAO0zFiBJduntesl9v3P8bICfVtclhjLfOO0tPH2SJg/79stKIf
         iyP7YHtHVwBRAgfN+Rpme27lJ1MB5KjCEKAxGIWl1ETYyd9dciRuJ1rjEZXM2dBj+S72
         4CLoNkZVnoPsJIh1bTuEanZ3Or4AtlpxxLO+9iaeHA/ennOjUnCRkamrcdnS0uVWiwRR
         vGOTLDnyPaJ/M+uTjEUQqpzXMZGblOzFtH6it/8SnGiZ+SXueGFLrzFlrAzrXeQQZWmr
         WLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790767494; x=1791372294;
        h=cc:content-type:mime-version:content-transfer-encoding:message-id
         :date:references:in-reply-to:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=poceB6zKoYQu2FsWNzDmrgG3238OZ8RROO5Gpc1RH5Y=;
        b=KYLjSDP7EZaGXr7wEz7P3q+kdfJx9rt3aQert67UR//2yfo1FKypr+WH5fLfjbGDGw
         6mgYCsq8LUmmopIU+nOFV35A8bo7JZCzorbvC+8aSchvuQNEik3t0rHqyIbQY3vAzo4D
         zk/M59QzLZneTT1gOiOD5vvMC1MkYiUcu1VS8SvfUJRcWhRHhYAhTdBF6jTUxmkJddc9
         yzvio9zilmg17VGsGPrH6zU090Pa14ca6qqfhN7GQ1LImAjhpqW9rvb1RI+dsedd+0Av
         bl5qWzGPFoS9xnZWNyFq1rv0RQ58cBShlcukWQ/Imk0Z7xhHX3GzNdGmG4zu/LywS3rv
         CaBw==
X-Forwarded-Encrypted: i=1; AKwUvBzb6OOmFiUuAty2FXrti2CZv052eOpGB1OJGM9ibiCTjjhyAX4AirbOvcoO0Q2EcCN0aePMLbUbpZoqTT0=@vger.kernel.org
X-Gm-Message-State: AFuF++lnNFYXCry3e+DfcO8qfZDS5mArpwwcQINpuheRkud88z7R+LP8
	6mI6unCOm2CnRN67wzEhDM33AgbpT14O+vPSMulSaicYWQ8sp7TkB8Kf
X-Gm-Gg: AYBFou1sTkqlaLi3vZ6ezll+6VaDy5xwG14WbU6zoR7QYz/VLOK0gtGHqxm+ap75o3s
	5T0Om2T21wuRMd0U+9BOr8HWpRg0kZyyaUMxGjqIK7SfDF1LbgenIcO0jp/a7uxOLoSRoGkEiCu
	hyorV5N6KbQbUYH2nPnPsCX1+/2wWm0b2OGLbNVGukcWg/EoTlJbb4rwZ/ZsLf7tjMYAvyVDv7p
	VBhmnUqAt6pE0cNRydUfSpt7DvdhRpZKs5y8i3WAsXKdwoqetenEy7OoP4Od/jHEH2VTBDph1fc
	AGibAPUg6NijbUKibWbX0StfVdMawaDyQTesKPDkb/0MSJtM+/2KwxSEylC47TW9KJCtKKMChWC
	f/d1PJdDY9Yo3oNIY1yBeKV1my6DJA8JatyOIMWUnLCQA1h6IDWBZ80tOD9PPlSc11yRLutwshv
	lujwYDBZFfvUagE82tCv0snq2uP1Mihoq3vxxQTZlNzFY1hIFjApAroie5A5mY1GvQ42fhbE1zF
	g0Z4FinXPxbszdJ8DrrxDaY07GLft84
X-Received: by 2002:a05:600c:3b0c:b0:49c:fc6e:a3dc with SMTP id 5b1f17b1804b1-4a01aff4fb5mr16519855e9.27.1790767494156;
        Wed, 30 Sep 2026 04:24:54 -0700 (PDT)
Received: from [127.0.1.1] ([92.241.26.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01cd002bcsm3626105e9.4.2026.09.30.04.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:24:53 -0700 (PDT)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject:
 Re: [PATCH RFC 07/10] tty: serial: Add Cortina Systems CS75xx UART driver
In-Reply-To: <1d81c2ef-7a5b-4306-83d2-ff96b0eb6a06@app.fastmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-7-4617c4463529@gmail.com>
 <CAD++jLkzcf7gJB82XT3-xb4jLujtWSNz1kT2r1-4N54rRfRNMA@mail.gmail.com>
 <1d81c2ef-7a5b-4306-83d2-ff96b0eb6a06@app.fastmail.com>
Date: Wed, 30 Sep 2026 14:24:51 +0300
Message-ID: <179076749140.3134070.3869742286743401078@gmail.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"
Cc: Linus Walleij <linusw@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Drew Fustini <fustini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Jason Li <jason.li@cortina-access.com>,
 Jason Li <jason.li@cortina-access.com>

On Wed, Sep 30, 2026 at 01:08:07PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 30, 2026, at 12:57, Linus Walleij wrote:
>> Look at this in your Linux tree:
>> git log -p b61c8bf4694b5115766849378dcb8787ff54e65e
>>
>> This is essentially a resurrection of that driver.
>
> Jason actually came back this summer to try again, see
> https://lore.kernel.org/linux-arm-kernel/20260610112821.3030099-1-jason.li@cortina-access.com/

Thanks, I was not aware of either. Comparing the two, it is the same
IP: the offsets of CFG, RX_SAMPLE, TX_DAT, RX_DAT, INFO, IE and INT
and the bit layout of CFG, INFO and the interrupt registers are
identical. The Cortina Access version additionally has a flow control
register at 0x04, RT_TUNE at 0x0c, STATUS at 0x2c and three more
interrupt causes (break, RX underrun, TX overrun).

>> Anyways, clearly this driver is not just for CS75xx so name it
>> cortina-uart.c simply, and update symbols accordingly. Kconfig
>> should be SERIAL_CORTINA etc.
>
> I think we clearly want a driver that works for both the Cortina
> Systems CS75xx and the Cortina Access CA82xx, hopefully that
> would also support the ones inbetween (CS80xx, CA81xx).

Agreed. For v2 I will rename it to drivers/tty/serial/cortina-uart.c
with SERIAL_CORTINA and SERIAL_CORTINA_CONSOLE, and name the binding
so that it can take the other parts. I would keep SoC specific
compatibles ("cortina,cs7542-uart", later e.g.
"cortina-access,ca8289-uart"), so that the flow control and the extra
interrupt causes can be enabled per compatible.

I can only test on the CS7542. Jason, would you be fine with adding
the CA82xx on top of this driver instead of a separate one? I am happy
to add the compatible and the bits you need if you can test them.

Thanks,
Fil

