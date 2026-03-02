Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32955386420
	for <linux-serial@vger.kernel.org>; Mon,  2 Mar 2026 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484560; cv=pass; b=d8FPEEBLoGtpvSWXx+x3/vya1e83m/S+H69sBl2scK3VBZcenQmv8UX1J9FYe63cq2KaP6bLR0eqMj64lBJ8g1MrV3bMyirve1qU1zJHPNpD3RcyxarDZwjsH8sUaLILmk5ZzmjSqS3C4Q6MVrkG1YYuofOY7uCoc7bJyH4UlRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484560; c=relaxed/simple;
	bh=cyH4XlAxExvFjyU90KL9v8Os8YItCUBGdVDa5Zw1Ozg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tt8gT/NWoXyRwA/l5qv1eRP1SI4cZBsFCy3VZaQQ14B/hP6f1YHPpu+QvEPkm3i7AY53GS/Ygg7pKeDokf2ghps4W1y8GftmHtH+B5XqPLHjbwdIcErojBXHYqGQbw6fjjsBIIgbbbgkv5I+35NfK8jhqCbuFN38EBbYO36skrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=k7PO/phr; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="k7PO/phr"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c6e1f417918so1440249a12.3
        for <linux-serial@vger.kernel.org>; Mon, 02 Mar 2026 12:49:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772484558; cv=none;
        d=google.com; s=arc-20240605;
        b=T9yrHgAqo3xAT8yMfVefAbP9E7ALpSepx6vjikS4NOnpqSKDpgPCjxaViw0qbuOwh+
         8cZu+z3tlz+6mldE8SC27uFnq3EyIoETxknMthiqeyhFP9p8B+sGJeNrENA5jsWVByh2
         UPSGS8l3bagySIgdeF0dUR1YF3SCs4XLdratgKvY0nYFqVWxlcZkeKi0ioJ1WW8s7vAw
         lTmLxuIO3dXGMyoy6wCyYBLPqpFf/cVMRSYbt55j1apzeg/GgNw2fcj6ji92CGYKlH6R
         /aH9FZ8RaQRIqWsmRgAQT1tdSyvqqA1YDVIgianWRfuIUg24xAdiPkJBiyDG+Qb43yu6
         ItfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cyH4XlAxExvFjyU90KL9v8Os8YItCUBGdVDa5Zw1Ozg=;
        fh=SeO2VEwtyoczCcvY+6D3NE3LQTmuFC2ejvAWw06vKZc=;
        b=ZymEgUVMFjLoY4wh07xuNua2YiccrN55HI4U+r0QqSB+KvyfVJb+75v6sRpppwAfsO
         dSjPfnOAGx6aZON7Pv03Q8d8/DwjbzFoqQA7VADCfcuT6NgKqZ34jLGJE4UjDfxUjaSM
         vzElYproDomnfSFuvl49VvlbgasOD7Yiys0f7E/1+Fz9trT/idd6VWfOfqThsrpKny/v
         4vUX12gq6QyM6epMXi9Mqbh68JmagRHuGAHsXrCOAB5URS6keA0l/c0I+oLW6t4qh8tl
         m+5qijX3KwOGez9TamWpEAYI/D07nCfenzIdD70kWojAcdy5TOR+6JxRgo/sgX2dscsW
         09nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772484558; x=1773089358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyH4XlAxExvFjyU90KL9v8Os8YItCUBGdVDa5Zw1Ozg=;
        b=k7PO/phr20zejQujWa2NpQHSiDGnGT2OwaVIWw/jv8lg5Z62QNmLEv9vBfO/Vw9MTh
         v+iGyBiJqW1ykVYyspRQ1xWfH/LK/7+VF/MGLv9GmsplJksAf8JLzXZSWeXrDCc1vqEy
         l5JxLB54D4xZLwAHHps/muGITl3wX2Hmlwom/oieRBUjXOENT+O8kMwdlNM4ZjXaaAXa
         bYRSBSQjGasUMre3FygBSFthr6p3eNZ9qUGXckjZ8aN+DUTtTk/4+Eq76DkzW6G/tMbX
         NsFuojI/YQ6sxz4nQw/abKyAhV5DO/fszGIJDQEbNQXgXnfV4oq/fl5bAKvin/GiHnE1
         xESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772484558; x=1773089358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyH4XlAxExvFjyU90KL9v8Os8YItCUBGdVDa5Zw1Ozg=;
        b=kyc+hk1KGauavVAHs5XOkQpz0KhLpgKV73y907dKDkal0g+B16MaEX8hQbu7+25zTj
         01kgrcispNUnoOHh6242sGmFEhUWpfoEnZZkNUclxMi+33lK0GZ1wxLWpViR66pzJ1lL
         uH4suFSq6JP+3oh0pZMcyS66ZDcwrx/7+JU+9rbWwHQjkGs4f35Jc8e7LzNJnTjK6lAW
         LqMxMhD89x5vet7B1nuavXoHU8aZshyxZunIxPYoluUboZRpPAkee4YancPfJ8RKW9Z+
         i2qoThVLWlTxl4t/wxahXYDrjljE04esHPdewbFaKhgf0pJic96/GKlx49DAYO4sC7uj
         c85g==
X-Forwarded-Encrypted: i=1; AJvYcCVeDa74j5PjHBvKj8J4rZuRloQGKJK1USXK/DdCUZHVAI9QshTKzmQ6uGfmVM5YrK7Btho8i52Oeu34/Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt5bs4iyWbkEQa9NpoXQzl3iOvOFETYQZqoTY4g1Aaw+cjZ0Cq
	LGeI96jpku7kcbM6rAUA0BadKTY/hh4ZJe36yYABbsbvZRjzp2iBNmXvYa4LT+ee3pRAv9/LPNR
	WJ996Mek/xs4OIpdemT8zWStlZx/snbo=
X-Gm-Gg: ATEYQzz3kG376EPKeG1DKSXFg6J43kgSBX00UWsKZN3VMkXPZvkrV+6i72MwDvpfRmg
	4WOT3WYPYSlXNgR2/zI9EJAIoYdu/vXujEgHM3FT1KtMw1ScM/LlMqj9q36LzSnALrTPgty7b/7
	Y1UaUG1vWd4B4hVjGRLPZST5rsUSlwbZxtK9F7cP2a/tk4AFxTy005WBqR7yyxlTqSPtIyPGpGg
	rstl9Qejhy3Ji43CN2bG1v3GfQ2OHpOTojlVZS0Csr6o0y8sfOspW02KY/iZrZF1o++cCzRPdAb
	intSOAfVhdAwCswQBYkyRQCIsLa18Vz1iRA+h/3Ihp9FimilC80=
X-Received: by 2002:a17:902:d58b:b0:2ae:5655:b16 with SMTP id
 d9443c01a7336-2ae56551006mr30904985ad.21.1772484558371; Mon, 02 Mar 2026
 12:49:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228-a9-baisc-dts-v2-0-47489d5cc1a8@amlogic.com> <20260228-a9-baisc-dts-v2-3-47489d5cc1a8@amlogic.com>
In-Reply-To: <20260228-a9-baisc-dts-v2-3-47489d5cc1a8@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 2 Mar 2026 21:49:07 +0100
X-Gm-Features: AaiRm52vtoxByONz8aPJPqxZwiZKHaI1xY4O5j-m2jy43emEUvOKpokAtRMTsc0
Message-ID: <CAFBinCBo1-at-TqZC5Gbunos4k_KTikPS_yAW5z0NLcnzpuSBA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: add support for A9 based Amlogic BY401
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 8:56=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>
> Add basic support for the A9 based Amlogic BY401 board, which describes
> the following components: CPU, GIC, IRQ, Timer and UART.
> These are capable of booting up into the serial console.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
