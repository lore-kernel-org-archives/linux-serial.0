Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4673457E51
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790836165; cv=none; b=PUyW+PZuOG5K28ItPD0gExZ15tq2mN+mj/yEx0Cyh3zt9GyX4qLy9atiUk3AypcxPV6IwV8GdwwZd/vNr5p9SCUF+UH294Q+hXs9xSdu9gvd6msM10eYFbsP5dGk5a7i6l9ipZaQTJ6qBTLF/uRFwxDwEzq3SqMKgX1ppoYS2XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790836165; c=relaxed/simple;
	bh=YmUdotlXBym7+M7DTZqezt6CY+s7rUVFUXVNY2HpXtE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DAIr1Z+wp2r4iu0SyGi/D/Sf/ByesVst3SWDjf5iFQOwdodp5NbPAEK8Pk0FJpGCMNy1zRXPb7e3dF01JrM0URunJLBUaHWKZ0PKtDf7MXlqdMAZnGGdtb9S1EyHqo7Lvv4eW3vObMiaMYRngwCXYacESWPAWhUJpZAZ42uLvCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imDGyIpb; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imDGyIpb"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so3566239f8f.1
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 23:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790836162; x=1791440962; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YmUdotlXBym7+M7DTZqezt6CY+s7rUVFUXVNY2HpXtE=;
        b=imDGyIpbLhdUCU6ZwJGdYV3V+BvxbPFAcSw6ihdWmf2fEq9XdbWImKLW9aDqi3oWaK
         R/qsRtLntGVTEeBu0JLxT/dAh2E7s8RGeS5rCZHang7j4ZpakzNow1IT7k1y2P5Lkr0/
         mxIhjMCRx23xjUDHcpyrVPH2InyW05zwgojKkfo5bEf/+MDxE/EndNmHCnOG4iZuEgVY
         mlko2i/6pTi4nOU+JxYxGZHztZcWjGOincDmcCgyByLKbiNChjJKXxvKLOh13bF9TcXz
         nrwOjYD086YVcWyA+pj2rf0+4rVOht/Jve8FIhCH0O48ddKNgUb0z5P0VDOokudP12Ll
         s/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790836162; x=1791440962;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YmUdotlXBym7+M7DTZqezt6CY+s7rUVFUXVNY2HpXtE=;
        b=p7krt69X/n2j1kNEDx8ACFLNjaSAFdfvOpbd+D9uvP3/ZATrBCSdPxS6fTZM17riwn
         TIPm14YVO+ugiB7LTPRfchad36783QkGp68p+/8KYvVYMf3gAQQTBzmxLBXk0cnR2bSs
         JnfShKZjQBfFAkTiTn6JUcHPSWifkvGmozttKOaEc2VfUJbDho5iYNoLUfGBBYKG1IT7
         +3jdZft/DEOpbqWFSG7SHPwW/ThAdYCnWTPr9jA0amxQEjCNj9bKTB7wIGDRH2cAD8mT
         qx7coydwIarNCa+B9p0isJCPqDjrOS3YvUQeX63u8CY+TbpoezWFrW6EYWo2QacvCcMw
         cWuw==
X-Forwarded-Encrypted: i=1; AKwUvBxVb7v720c1VisKoULnQ1J74+6eB/5DcoXzIdc23EeMbPgzclzqNt5k812zrXADxXJqN/MlFZ9VsMKJdtY=@vger.kernel.org
X-Gm-Message-State: AFuF++lUlRqybBdgF1kdGpDJk1tlV5XxkBYuTOPeCpwkiJB438XJvQoW
	io+G9WC3d1IFyq4+iFlck/KN248shX1cnjt5o9n36/3QEfPFZ2rJYKNx
X-Gm-Gg: AYBFou1cLzcWDPwAsIx1M1kCbcTqK/81OuZbsk7Og6Jb4s6Vc3cAd59wU4MHLWEljzc
	OYrqlebO81vMz9gnhhNBmogfInWAKIUSO83Bo7SYXFUFIiP8zwV4CVoOR9YcX94lxpCRT4sZtwv
	ZX6dIT4CJG5tbyQLSfdjWUIm53O80i2OqqUeK5ZbXcxaTUcc3lxGKnaWOFs1hBfGSODbCc/PjH6
	kh6y3sROrkANeiLxaLcgOg1/HBuBJwssiwQSVr+TBwogkGUHPRS0d3krfM4IbyC++j2jWFWFsru
	tvRZKveFT+c6K0dz7PrG1GGjUffiNKqg5A4W3gv2Tt9pusUqGmeuQ97Ar0sGFG22/0CbVKjhNTK
	ed23kNwmZfGZDLV1KTlBYUwtYdqpcZOUD9TNtTryqpebY9+8lOuBuNvZpkTehOmWhUvEi88nySY
	JOHxgH+GGVypW4ogbjXraYbI0wUpngD3an6/7cLmXQS6EbWLakWp5MOCFCQzfXnWtvkq924cM0k
	LkMXZohCwT9n7E8SLNEUlN7o3PKGGcm
X-Received: by 2002:a05:600c:6088:b0:49f:fd66:5fec with SMTP id 5b1f17b1804b1-4a01ab4d57dmr54370375e9.0.1790836162047;
        Wed, 30 Sep 2026 23:29:22 -0700 (PDT)
Received: from [127.0.1.1] ([92.241.26.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b068ff891sm4026217f8f.9.2026.09.30.23.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 23:29:21 -0700 (PDT)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Li <jason.li@cortina-access.com>, Linus Walleij <linusw@kernel.org>,
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
 Re: [PATCH RFC 07/10] tty: serial: Add Cortina Systems CS75xx UART driver
In-Reply-To: <3ddf4b8e-14b7-442b-9d4f-5167875e3d64@app.fastmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-7-4617c4463529@gmail.com>
 <CAD++jLkzcf7gJB82XT3-xb4jLujtWSNz1kT2r1-4N54rRfRNMA@mail.gmail.com>
 <1d81c2ef-7a5b-4306-83d2-ff96b0eb6a06@app.fastmail.com>
 <179076749140.3134070.3869742286743401078@gmail.com> <SEZPR01MB42087271C56AD1C7E926AF35A28A2@SEZPR01MB4208.apcprd01.prod.exchangelabs.com>
 <179082517588.138645.14615134489246049313@gmail.com> <SEZPR01MB4208B8B4A5A7F48F7FFE0C9FA28A2@SEZPR01MB4208.apcprd01.prod.exchangelabs.com>
 <179083239972.193541.4791387611943615705@gmail.com>
 <3ddf4b8e-14b7-442b-9d4f-5167875e3d64@app.fastmail.com>
Date: Thu, 01 Oct 2026 09:29:19 +0300
Message-ID: <179083615914.311026.2458351803214458859@gmail.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

On Thu, Oct 01, 2026 at 08:18:56AM +0200, Arnd Bergmann wrote:
> No objections from me either way, but I don't quite understand what
> that will mean for the older parts that that are still sold by
> Cortina Access: cs8032, cs8022 and cs8124. If someone later adds
> DT support for those, would we use 'cortina,cs8032' or
> 'cortina-access,cs8032'?

I would go by the part number, the way fsl/nxp is handled: the parts
that came out of Cortina Systems with a CSxxxx number keep "cortina",
so "cortina,cs8032", and the CAxxxx parts that Cortina Access designed
use "cortina-access". That gives a rule a later submitter can apply
without knowing who sells the chip today.

Jason, if Cortina Access would rather see its current CS80xx/CS81xx
parts under "cortina-access", now would be the time to say so; I have
no stake in those and only need a rule for the CS75xx.

Thanks,
Fil

