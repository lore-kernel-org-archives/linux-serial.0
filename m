Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161F1FCD0C
	for <linux-serial@vger.kernel.org>; Mon, 27 Jan 2025 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737967507; cv=none; b=T7Hox5du1V0A2Wf5ZSmY/Lbo0lbxs9zr79sBC8rKbEoXlIxnD+khLkt6SuZDA4tXIWLxILLkCGeVEtg0M46CIAbGw/UTJRZ/ruK/EV2zVnmKtqE5BkIW8y73QTtU6gLFOuERhvuy8EzLJUSB63ox8Dqc/vCtGP4DpV29d+ozFcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737967507; c=relaxed/simple;
	bh=DRgRHg2H9HZndRrP19dAAUkF/GOcikF2Dd4jfd5iTPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l38iZShPeugvnTApmh48l5czJDjoNAnt5qhpi21zltwdrQR+mG7pLKFuJuZXu1R4AIZuvcuXVrUb/w7I1RT7kjr5nbI04EY2lXeeSrZ7Fu777XW1dnv26n1NibjE3n5I/ckaOlLyTBi9IkOPLPidobFjIjJCBnSTRe4Fm/NJjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pdj5lU+D; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pdj5lU+D"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385e0e224cbso2326231f8f.2
        for <linux-serial@vger.kernel.org>; Mon, 27 Jan 2025 00:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737967504; x=1738572304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bz2kSYLl3e38VCG/b+eXaZea6pK/eL1ZVqCIQrW1rHw=;
        b=pdj5lU+DvNs15tLNvzWQp3FHPJNjXDjVDe2GnZ7On2VpyXlGi94/xA5UGKaq2JF9Ru
         wsRJZawYHzhwInDGtpodNfD1gOdY58gWSL7egw4DhN/8aedkXx+bb3SnrJVnRokoFwSK
         XKegrU/qbEN8nalAZYwhgqPQZ0YQ3FhZ2USQoVdhr12lgxbPt1Svvv9riynDRoO4cJ7V
         ckL/TKTRF2yW8/2U4a8Gy3mSgOxUrHFN4tdApSL5CvbJHVG2nwK1jg3v4affA7vRiioj
         Gh+EQH5mpCJP5+i6stSeyO/jLg42MYLZjepLSoxc3W8L33j7eD0PmzlpU9Rx9jH08BtJ
         FsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737967504; x=1738572304;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bz2kSYLl3e38VCG/b+eXaZea6pK/eL1ZVqCIQrW1rHw=;
        b=q+wZrt517umyXOT5qck6geYGr/9PxoiBxRHj/WqgexIFb/eUimj8uozJTIIVD+isFs
         UhpyCH3AK010Ax5jjLvNyh5sMGfGBZUTY6Wu5nsQz3ZU3/LSzVG+eoCA6oRX1rNN3OFY
         2yRwvZIHPDMbPK0L9U62XTeHr9cxglHgXNNwexpLpRLbW+2WtLoK6moSLWtPi1n5Pao+
         hdsIZd+h9QT8BaDoCQc7ornbGdieNQ2XF8CVsVLV0EC5X5Zf6MFmLS/Gx93j/66w9jIV
         amiykAgQiSiGWBusQIa0mzaTOILLgyzyONiWN7VxhqNzB5cJZPdHE225QvqhC0gRd6ba
         cPXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Zr72RCnZnugGs6twlO2DL/9j0NjYOtBIpI4iUm+sd41pZS62Nw1YRiAdiSv7TU5UXgMF1GSVh8v+a5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTeM8Dukzmpeq1TmYgLwMaR+30v8/fiVYrLfVBxmXKkpYWxomx
	B83BhHFA7/U4xsxZs0EuUr7Q3e4KcNbcxvCawuVVRQbrH4OkLufur+8T43Z/juWSU6xDA2jltWQ
	U
X-Gm-Gg: ASbGncu6ZKluAlPZQzxxCOs4qGnPCN+fplZuEIB+gnHPImKbkDWvxmjn0/0tWGPuJvj
	2O+91/YhLm8WJQ3mGi+Td412zvhtF9uWh4zEKLePf2a5OGJwgmdd94fru805/5ONJizHqd6/7EY
	p0dDf8qpKNe0kalGc/f3yF2hm827OjVoj5yArgQoUCs3pd+4wrrf+FBn7sH3wRMinCgu6zKgSCW
	IkHeNx7sl9ieJwpN60if7giBKGKXdKoShVWlzZFc6C5bYLnvosXRJBeW8xAYxiJxmDDjrJVSNws
	0rLb1LQhtLgj
X-Google-Smtp-Source: AGHT+IGWqfhgnm7mqqj6MlWyyva4ixlrWco+wQr8HSdWnEWxXD9z+L+c1tqnICNsQrM+oKfyIH0FqQ==
X-Received: by 2002:a05:6000:18ab:b0:37e:d2b7:acd5 with SMTP id ffacd0b85a97d-38bf5655900mr33401129f8f.8.1737967504213;
        Mon, 27 Jan 2025 00:45:04 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d6b2sm10635095f8f.34.2025.01.27.00.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 00:45:03 -0800 (PST)
Message-ID: <4074b42d-fb49-45ee-9f38-31a105ce6a67@tuxon.dev>
Date: Mon, 27 Jan 2025 10:45:02 +0200
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
 <CAMuHMdVjvKmR-0ZiYGiAwXf6dfx9O9HtG2JXht9iDwV7oKdwDQ@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdVjvKmR-0ZiYGiAwXf6dfx9O9HtG2JXht9iDwV7oKdwDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 24.01.2025 21:15, Geert Uytterhoeven wrote:
> On Mon, Jan 20, 2025 at 2:09 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add DT overlay for SCIF1 (of the Renesas RZ/G3S SoC) routed through the
>> PMOD1_3A interface available on the Renesas RZ SMARC Carrier II board.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
>> --- a/arch/arm64/boot/dts/renesas/Makefile
>> +++ b/arch/arm64/boot/dts/renesas/Makefile
>> @@ -143,6 +143,9 @@ r9a07g054l2-smarc-cru-csi-ov5645-dtbs := r9a07g054l2-smarc.dtb r9a07g054l2-smarc
>>  dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc-cru-csi-ov5645.dtb
>>
>>  dtb-$(CONFIG_ARCH_R9A08G045) += r9a08g045s33-smarc.dtb
>> +dtb-$(CONFIG_ARCH_R9A07G043) += r9a08g045s33-smarc-pmod1-type-3a.dtbo
>> +r9a08g045s33-smarc-pmod1-type-3a-dtbs := r9a08g045s33-smarc.dtb r9a08g045s33-smarc-pmod1-type-3a.dtbo
>> +dtb-$(CONFIG_ARCH_R9A07G043) += r9a08g045s33-smarc-pmod1-type-3a.dtb
> 
> s/7G043/8G045/ while applying...

Sorry about that! Thank you for handling it.

> 
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

