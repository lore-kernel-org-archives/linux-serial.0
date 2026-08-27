Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C044252D9
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858220; cv=none; b=r7Br+nY6utHbTrM+7l3cD7mnPMmmFsKXb71RtGuYIzeN+eMOVDy8gP+IAiVTtlhz422V7kDNyFImtkJqESaaOAXfKqiGGa01vGequL3KRbAA3ZG/2F2ZjIqmb1mvkzArZwXRGOsl7pI4CPEq2fU+EdfbP+0VyZI1C1SpfTBqiCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858220; c=relaxed/simple;
	bh=W65090XdDBw7UhVDTVjxJFTTrT5+H9xvtxq4LX1QU9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwAG9tindStV3eIsz/hc+j52Bx+xrzaBDAaVR90NSKo5YgjEGkSRSvtGPy83uXrdPN/Ea/5c/CRJpq1Ao1JoY9ktz8EpayZAGtMXPTI012D1jJlWlgoGluwQcdFCDrYhtoKr+3A1wtQJItcXB5759WusuL+QBIkWauCW9jGnggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW8W0t6t; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW8W0t6t"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47fe89fb333so119588f8f.3
        for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 12:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787858214; x=1788463014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W65090XdDBw7UhVDTVjxJFTTrT5+H9xvtxq4LX1QU9A=;
        b=GW8W0t6twdwAwLTLmEFFYso9t53eB4DYNG5Jl6InpAiPhtoLrqulQ8Q7HYCexTRJnl
         qpq9hsFycSUNuqH3FuzZH9BJUbKOsoLuNsg3RrQENKG2zv4Gbzd7oaB7UM2TXRIEqkrG
         ABVoR8qctgtdkXDboWNhbuW0lKmnyLJHWWMVy2FZqbLoJoDnVTMvksZmXPSEhbv8Q7k6
         ljmEb9l5sJOrGtphawVzDsVaNBGCRtg056ovub4SBtU4JP/jmNh5OtWPCj3axfQVCQEj
         bG2YCQvk0ifJiH/PCn8hvTpe1Cqb9RX+wCaiHO7wEB43GnTzieKamLmA/jzbBtCaMMNZ
         zg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787858214; x=1788463014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W65090XdDBw7UhVDTVjxJFTTrT5+H9xvtxq4LX1QU9A=;
        b=koHrPi/6PYLiOTAXDVbEs3kKbBD4DDNHmX1tFh+u225X0RNWFThl+FfE1j4i+WuemS
         iuUef7fqvKCr5sfKKfC0xYUuNtreoywaSrkC40tpnXJT5BX7gpqaoU9XxJCxDy3GT3g+
         PNi6SKFIWXuBEzbf4dob67RRtoCXJ018DPSAqYtb90ZsdJfJ3eQqIS7gzMumYbrovm2b
         RZxu2cFAyKlSDvSL3UK+sUlCyUHbx3608kxLfAtw5G2TIm3g52GZ5eBfWoB936bd8ztH
         0lPf+wW5dYwqpQg33t7+HtlIgrX+Feg/WJX6C/6hIH/Ob4I17B7WVmcXTpMmPTM8wMVY
         15AQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq3s7EJvIXm6KxWbFzSitOXRLl8/9vIwFQWtWChAxcPDfkHmQzwgYbRsGffL43gIWBT1Aeo++KRZ1tSP6U=@vger.kernel.org
X-Gm-Message-State: AFuF++mvQ0pvg7Pb8T+EtfuEvuOaKR43JxusA8DkRuluE2v8A7/nnGtr
	PG5k516I51uhhTS4QQQdEnR4fHF6Z37L2b59210iGjrdWyIwujnK7Efa
X-Gm-Gg: AR+sD12yUMbVvK1F7imC+c/K7ipnJwHo68thBJcMW0coJfTAGzssVO7oDadlp0APJMI
	KvFmovLNx2ra20NWPeB75B2b2+5LTlyx84NnNj2PD9qYAeJk3rmoz/Bvjt3+7e2/bTCq1fKXyZm
	ltq2dkAS9za6Bnn6RtS8hU4uemWyBRgdk9kIzF83lphEbbye3ljsRooniyy+pxC994Z/KahOetZ
	7oYdzJHKE8+2kePEL1Bj0AKTSIY85gpvJj+zgtFNpNS/D218t8ZHV7QfFvm9iTKv7kS+YUF5IWV
	uV9Y7/fHC8Zv6N8EBX6TkFK7Lh4DHBLSfdKuTC37tpyrfjAc65jmx+nu7vOpcZWAcrvZQhVEEY3
	/Kum4UDi0KuXJAnwN8EMFtQ5Cl5RXrFEV0yVgDRst4WJzf3g0SaW3B5yEyh9C48ECNpeJXutHox
	DcWP5xgatB+cBJrXzbsBSb0p9C6s3CJ3cbySjyGyeZlL8EJf/In8FOQpQjBjI=
X-Received: by 2002:a05:6000:2489:b0:482:e4bc:51a8 with SMTP id ffacd0b85a97d-482f7992e40mr1312918f8f.7.1787858213511;
        Thu, 27 Aug 2026 12:16:53 -0700 (PDT)
Received: from m2.. ([37.142.156.156])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-482e27aa050sm10505002f8f.12.2026.08.27.12.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 12:16:53 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: linusw@kernel.org
Cc: bentiss@kernel.org,
	brgl@kernel.org,
	brunoceg1@gmail.com,
	contact@christina-quast.de,
	daniel.beer@igorinstitute.com,
	germain.hebert@ca.abb.com,
	gregkh@linuxfoundation.org,
	jikos@kernel.org,
	jirislaby@kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	michael.zaidman@gmail.com,
	rio@r26.me
Subject: Re: [PATCH 01/13] HID: ft260: add serial driver
Date: Thu, 27 Aug 2026 22:16:40 +0300
Message-ID: <20260827191640.11725-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAD++jLmCVfG4AQ_pTkYouGCcKgN-eh0wsRGQby9dPvZVFMpMDQ@mail.gmail.com>
References: <CAD++jLmCVfG4AQ_pTkYouGCcKgN-eh0wsRGQby9dPvZVFMpMDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 at 09:49 +0200, Linus Walleij wrote:
> What kind of "enum" is this that re-assigns 0x00, 0x01 etc to
> several enumerators?
>
> Either this is four different enums or you should just do a
> series of #defines instead if they are all really coming from
> the same place, because using an enum like this does not
> make sense: it's like numering pears, apples, oranges
> and peaches in the same enum or something.
>
> Also use the UART_ infix as mentioned in the GPIO patch
> so you don't need to immediately change it in the next
> patch.

Agreed. v2 will use #defines with the UART_ infix in this
patch so the GPIO patch does not rename them.

On Tue, 25 Aug 2026 at 10:12 +0200, Linus Walleij wrote:
> You need to CC the TTY maintainers and linux-serial on patches like this,
> just keep in mind when resending, thanks!

Will CC linux-serial and the TTY maintainers on v2.

Thanks,
Michael
