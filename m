Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB621CA14
	for <linux-serial@vger.kernel.org>; Mon,  9 Dec 2024 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733746757; cv=none; b=GjS2F0Fz26krf+7k4uoQyPJKpWF2tqT/VZr8UPRW7RZhsu82WGJi3HbI2vdLg2tWk25GOHFkclHqkpWMeoyPCzwTtjE3Nete8/M2nYX9gQpHRkosW7DLhhRrfD/48sbuv4nsa2X8whZd61lN+QiYZ3O9BeyVYm5SiJsEBAE5Q/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733746757; c=relaxed/simple;
	bh=qp3Y/LVEDaO5z/Uqygu1OydOrQxYf2qFm0FiHDbtkyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArSGrtD95fQ2jkknRcXOSvUyEMj6LONrCGzzrVzH63H8qNbO1Yye7ZNXbixqw/JzhRLmyWmHlP8NtrDy77x5i8wR6/ZBoeto5Vp3z2GLwt00SbYFh/EINCKyx3knb4geOE0MxQ4TqyeowhGskMVcXlEu8RFL7grNC8jp4U7Gar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oW5nQr5Y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oW5nQr5Y"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a2033562so41288845e9.1
        for <linux-serial@vger.kernel.org>; Mon, 09 Dec 2024 04:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733746753; x=1734351553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6TXLCmeBtqwcjExK8OgP8zbYx9UMdL9nhBZ7RXb0/Q=;
        b=oW5nQr5Yf30W7urZDT5wpanMZilR8Twunai4VHFUvsjepHGAT8LKstFrEjEHhaesTM
         GHOZOIPXtf7WPvhAVK+v9wxUnQhoJMCuMYPofw6m4LcSq+T2V0iuKQ51wjZ3MiOAJrNd
         QXCRMRl2KxyxdqUmOdTSfYXlyYvnZJNnTAgpyRN7HtdLgalPK5/MowanG9mfPDRdSN6H
         lUIoc6kmQKEz869t3/DOOx3dF7Z2j8jin1zu598Vlgr2EXqlm1/waUuVq/uYVS6c43SQ
         lNohGV5tEg+m1UdvOhkcTC6qiQ6aYyyqrSwD7C21RTRxQAc7h6PAmXjkzQwMmQHDoPiO
         vJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733746753; x=1734351553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6TXLCmeBtqwcjExK8OgP8zbYx9UMdL9nhBZ7RXb0/Q=;
        b=q+QA/k2jSkhiEmjXlrANo8s/RfVfPslz8JD1McCshC0Yl8XJgrLGk1uWqxkJyjCdbd
         ZUIL1qIH4RXyPo/ds2wgNDMz6/Teb/y9YKhNK/QHAjGpphOfvXNEVLAjvw8sUCMmHSQ+
         fVNpdavHx6w0Kf+RecMlRCshDsLgEv2F++p6P6eooD/wnrvFxmXcuQgdjqWYY2BmnLUH
         qJoN509XlEPxMdsOGYtq76QTPCdQlDJNe18R21sTbNjJPjAC8NVSc67ndHY/gWNgoVrc
         Nu2lWcQWoxKeJbjxpbx8qaMK6DK/2fvZDCxEouN5JzrF70bwKjmx2LwhMVe2p+HXkE4e
         KeAw==
X-Forwarded-Encrypted: i=1; AJvYcCVag/bZ9XgCNEzzus4NMcfSoECy9dBu2GuqhxS4iZ904DrR+U3pHsBcalM9IjSWDfm/YhCxjRZM8btbsvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZGH4lLHKIcPys6FwNYCYVa9gnPJrL0Zrc1ILyJ2yHzANf/ChZ
	Zjn2gAOpkfoWvGODmOlkGj+a41HucgoUdLvENQkUYZzVe/9o4UIjnWN8aZDrDTE=
X-Gm-Gg: ASbGncur1wiLJfFifOkX/62y2zyKikpQSYKh8T/qgGtKKfO0B9VXhC99dbA2Q3Qlde1
	z8SiiJxBrksW6a06V8/1pbC5ScDBR6zMYIXTcevk98el20QuRUqZAvTCALzoTau+EwwQ4MprtGm
	lPH2BspycIMA/ZHmmPGl64aCML2n+ajbIJvC27ET+PVCHaql6A50iQ4E7s0vz5WM5P9uK8Ud95V
	CmNn632Xu9IGVR3scI/aSDOi2IhWAq5gDOjzuua7R4d5ToE3qZFwtTHgQ4=
X-Google-Smtp-Source: AGHT+IH6u6S3dLH84zc4slPIQPWBEWQFCdhlzXqKbsqdXDHKIEy3XG/pqMdZoy1Rfc/9UToO8A7ZbQ==
X-Received: by 2002:a05:600c:3491:b0:434:f3d8:62d0 with SMTP id 5b1f17b1804b1-434f3d866b3mr41984585e9.3.1733746752835;
        Mon, 09 Dec 2024 04:19:12 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434fc530a2dsm17998465e9.11.2024.12.09.04.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 04:19:12 -0800 (PST)
Message-ID: <e9667a36-180f-4e21-97d4-41cfc207c508@tuxon.dev>
Date: Mon, 9 Dec 2024 14:19:10 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add
 overlay for SCIF1
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: magnus.damm@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, p.zabel@pengutronix.de,
 lethal@linux-sh.org, g.liakhovetski@gmx.de,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-serial@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241115134401.3893008-1-claudiu.beznea.uj@bp.renesas.com>
 <20241115134401.3893008-9-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUskZAY6sw-dqKGfWpqhqnM9E_Jh+44ceybCeyASTf7vQ@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdUskZAY6sw-dqKGfWpqhqnM9E_Jh+44ceybCeyASTf7vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 09.12.2024 12:44, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, Nov 15, 2024 at 2:50 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add DT overlay for SCIF1 (of the Renesas RZ/G3S SoC) routed through the
>> PMOD1_3A interface available on the Renesas RZ SMARC Carrier II board.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod.dtso
>> @@ -0,0 +1,48 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Device Tree Source for the RZ/G3S SMARC Carrier II EVK PMOD parts
> 
> So you plan to describe all 3 PMOD interfaces in a single overlay?
> The board has:
>   1. PMOD0 - Type-2A,
>   2. PMOD1 - Tpye-3A,
>   3. PMOD1 - Type 6A.
> Wouldn't it be more convenient to have separate overlays for each port,
> so you can more easily use them as e.g. Type-1(A) (GPIO only)?

That would be better, indeed.

> 
> BTW, naming both the second and third port "PMOD1" in the schematics,
> and differentiating them by their type, was definitely a bad idea.
> How can you distinguish between Type-1(A) on the second or third port?
> 
>> + *
>> + * Copyright (C) 2024 Renesas Electronics Corp.
>> + *
>> + *
>> + * [Connection]
>> + *
>> + * SMARC Carrier II EVK
>> + * +--------------------------------------------+
>> + * |PMOD1_3A (PMOD1 PIN HEADER)                        |
>> + * |   SCIF1_CTS# (pin1)  (pin7)  PMOD1_GPIO10 |
>> + * |   SCIF1_TXD  (pin2)  (pin8)  PMOD1_GPIO11 |
>> + * |   SCIF1_RXD  (pin3)  (pin9)  PMOD1_GPIO12 |
>> + * |   SCIF1_RTS# (pin4)  (pin10) PMOD1_GPIO13 |
>> + * |   GND        (pin5)  (pin11) GND          |
>> + * |   PWR_PMOD1  (pin6)  (pin12) GND          |
>> + * +--------------------------------------------+
> 
> This depends not only on CONFIG_SW3 (for RXD only), but also on
> SW_OPT_MUX4 (SW_SER0_PMOD=L gates all 4 SCIF1 signals).

You're right!

> While including "rzg3s-smarc-switches.h" for (out-of-tree) overlay
> configfs is not really needed, please document the switches in the
> comments.  

Sure!

> As this is included in r9a08g045s33-smarc-pmod.dtb, you
> may still want to include "rzg3s-smarc-switches.h".

OK, I'll handle it in the next version.


> 
>> + *
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
>> +
>> +&{/} {
>> +       aliases {
>> +               serial0 = "/soc/serial@1004bc00";
> 
> Note that configuring aliases doesn't work in dynamic overlays
> (but we don't care in upstream).
> However, this is also wired on the Carrier board to the M2 slot when
> SW_SER0_PMOD is low. so I think it makes sense to have the alias
> unconditionally in rzg3s-smarc.dtsi instead.

OK, I'll move it there.

Thank you for your review,
Claudiu

> 
>> +       };
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
