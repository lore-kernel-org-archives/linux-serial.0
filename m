Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DE83594E
	for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737724173; cv=none; b=tjm86Bx77Cj0sg+X420rHJ1sDrVhpujI+DsusRpippxojTjwC5yISjRNvTJxOO3FAVKtrKg2prl2Mgg2WbCR1ipITM7t+y2RdYOtjz4G7S9M/grRmUDo61Oldn4jquoltH2itroIzlX6A7VQUx5chdNPVpP/9RjORu71akF8z5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737724173; c=relaxed/simple;
	bh=yCrlJlbItBjrfLiaqLm80WcGlm2FcQ+apXeAz8JbELk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MuFNSE3vnXaf+OFuRcZ9bL6tfEgVdeXk8YNXrrjgznKScAlm5whJVRE0fmM5Uc/WuptRuCVm9hz2lBkd8JiIA/9hs9R2+HCLbCifADojCzyT2qHb3vwDwzkgIEmMB46RJDcfl0fKeKgphGQvyglSQmtBdeJ6Xh7uMz67DBWUZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MjE8sE0w; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MjE8sE0w"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3862d161947so1137837f8f.3
        for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 05:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737724169; x=1738328969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBuWNY9e2imhLU4CHthcqXokG7xw5SfdmsxDVyhOZ1Y=;
        b=MjE8sE0wdwVCMYO1mjZ1Sx5aNM7Y7Da90khs1Uz+FYwft8C0ZBEqnfDmH/8JIb15pY
         xbeZyW8h/V1B0fFRZQawOGwuXS/dLmvstpDCbq+N6B72MFwebzxMRtOyBrXtZfIT4MFV
         nMmdx/9/sBiSxRLMCYmvMtqF3NQ5B20O8axIwXNDJvYjGgGnIsnXhgbwlspqwL56ju5y
         7fLX+WY+AMnutx5T8a1Fg5hTkAEHb6pl9Y137iv+JpBNdOFieRV3DSaYbC3CTOvMFTBQ
         YEYQ2FXcN2dvweay/morkapBHPKYxgG9UCrDewe4Pt805WepecmtY/SsZDc4mhj4pELV
         E+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737724169; x=1738328969;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBuWNY9e2imhLU4CHthcqXokG7xw5SfdmsxDVyhOZ1Y=;
        b=o1ans18Lvur1mzZ1oNWqdX78WJDD1bAFZdlyV/cnh7eLzTKcr28QBcYSdNmS3Az9B9
         caN4jlA3u1k8jyApvUrF5dkNV2WYc3oYdwSY+afHbaSQkaRtSV8RgsJfgsjeyyVhtW9d
         vlXK1OH+VBb//Xt9MIRUvYsfX/Lj9bT4FpzHBC9rQ9UcnhnghoKtCZY0c8CRkEex/OPy
         pJexhcIFrqSWTBmMPQ/b51PWVBWoe2N1rhsOnjgfVz8rN+rGAFi1Hcynx8Zp+SpShvwk
         h+MemZu/LaVxknFwrP818nzBruny33Fqx+l0SKaUEyELlMhlImiB3stNhJBSpqy5/5sc
         CzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbPSeI59nSWTcAC/k7/dXBWDR99OGBpVEuesN3sMqz7H+K3PPZhxWxqjzjw6cUE0rdwB0ltpb+txRoKkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHpy2b7rWYUrHX/gv0dzYFR6ZmVYNnQkkQH/if6GQvPHjFtAw8
	07q4yi26sb/DXw+L/TB/8zKTVHwGpnUrQwus19p4oYu/86pQ0qEHEfElPOo69a4=
X-Gm-Gg: ASbGncsPDCXskF4CUXuQ4rhaxNR93lWaUPXx9TAieztD3UEoX+kpzFd36c7T5NxL782
	EBFZGWHKXD0FWAwFz3QEZzffCFq+ZahNLo9+kN+hFVUB8IsoYOrpJd1MoIViIuKcDeIeG6pmQUf
	a1IudVNEa+TMvBS6iagS+VcrkpDeNoM+3Hdl/TEl9lI9XqEdfXWd6ZLAsXUknS7qr9Or12n4EhC
	6DEZbnEd5MD1kefLQ39nXzgyoEWBLOJWxnWAfKU4Pjb5yEgXIyzCzr+RuPuHp228fC2iTNsi6am
	6xo6ICBGem9y
X-Google-Smtp-Source: AGHT+IGicKm1LKpPKRiy6XF5hxGf7Afg8wmtZ1Qnf4egNtBChYxpJwD24XlOHnFBnlM3xlk66TMTPA==
X-Received: by 2002:a5d:4c92:0:b0:38b:f4dc:4483 with SMTP id ffacd0b85a97d-38bf5671cb2mr22914547f8f.29.1737724169230;
        Fri, 24 Jan 2025 05:09:29 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb02dsm2637796f8f.70.2025.01.24.05.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 05:09:28 -0800 (PST)
Message-ID: <3107a26c-c942-4d8c-ac50-935bb8912b85@tuxon.dev>
Date: Fri, 24 Jan 2025 15:09:27 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add
 overlay for SCIF1
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: magnus.damm@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 p.zabel@pengutronix.de, claudiu.beznea.uj@bp.renesas.com,
 wsa+renesas@sang-engineering.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250120130936.1080069-1-claudiu.beznea.uj@bp.renesas.com>
 <20250120130936.1080069-5-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUdq9XRpxAEmY3tG-cKHVrYfmbU4-YNRugSz5J5Qfkyzw@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdUdq9XRpxAEmY3tG-cKHVrYfmbU4-YNRugSz5J5Qfkyzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 24.01.2025 14:56, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Mon, Jan 20, 2025 at 2:09 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add DT overlay for SCIF1 (of the Renesas RZ/G3S SoC) routed through the
>> PMOD1_3A interface available on the Renesas RZ SMARC Carrier II board.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v4:
>> - rename overlay name to r9a08g045s33-smarc-pmod1-type-3a
>> - add note about the needed switches for SCIF1
>> - guard the scif1 node with #if SW_CONFIG3 == SW_ON && SW_OPT_MUX4 == SW_ON
>> - dropped the alias section from the overlay file and move it
>>   the board file
>> - document SW_OPT_MUX4 switch
> 
> Thanks for the update!
> 
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod1-type-3a.dtso
>> @@ -0,0 +1,48 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> Would you mind if I changed this to (GPL-2.0-only OR BSD-2-Clause) while
> applying?

Not at all. Thank you for taking care of it.

> 
>> +&pinctrl {
>> +       scif1_pins: scif1-pins {
>> +               pinmux = <RZG2L_PORT_PINMUX(14, 0, 1)>, /* TXD */
>> +                        <RZG2L_PORT_PINMUX(14, 1, 1)>, /* RXD */
>> +                        <RZG2L_PORT_PINMUX(16, 0, 1)>, /* CTS */
>> +                        <RZG2L_PORT_PINMUX(16, 1, 1)>; /* RTS */
> 
> CTS# and RTS#
> 
>> +       };
>> +};
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.15.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

