Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3604F1EC4CA
	for <linux-serial@vger.kernel.org>; Sat, 21 Dec 2024 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734772585; cv=none; b=coByINsH8+UgUR89alRopnewKaHvpRsxII0jMdSem+U5ylSjrMUK5nRAG1QWH98oqd/vBTB12tyZQPKWmvqSPhLBehItDbkFL7HJma7v0rYtCGnk1Av1wzfB7TF7R7tYEWzpGIbsdFxs0n6MXfTIVEpmZ8pZwaaPoqvJPlvqnVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734772585; c=relaxed/simple;
	bh=EFzshZOaAHiXln3S9ny1EvTjPXRIIhUR6sm1JxbAkRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOTqIk2qnhwBZ2Jl3JfR4YYmK+wBalQ165mBxfFnUKr0KJKG7CZZMQJSjE+930RAchcs+b9l119LZVI7cQmd6zRBqhlvXFg/GZK3SaWvsv4snFfKFXvtQOd/D/PZxM7ci1/Q56mY+qWRGKjzM2PP8YruUHNQTfXHhZFr6QOr9tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AaaEw4HT; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AaaEw4HT"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso420922466b.3
        for <linux-serial@vger.kernel.org>; Sat, 21 Dec 2024 01:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734772581; x=1735377381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7y7OwDWmkLJB5LcPl9h/nsEPz8MIspvq4TozD4gpmk=;
        b=AaaEw4HTDMfytB9HwBt0eWNJjpz4oJU5Z7jCa430vzzohZOH+IovJvc2FHKbfbYV9d
         0FegVBtNUNeF2C4XTApYm41EmIhzHH659pP3IsNIcCI5+l1AwD4KC/9wi76NY0frdQBv
         XuCupPu71j6ubiSsUKM2XkbOQLeEwK6IOboCyRbEfTYGmnOblNtz9eOp04+DnOmnrD7y
         xG6VRejVU2l2Z7GrQcT6CH36g4oTBn33h0jJbYKdRL4HP+tfpOjSNdxaXwAGvXJYp2GX
         Uow1AfxUqPfcVKMAwLRAn8BO1X+TS1fvH5/assHfrwdW289HP0uztUJ2YexYQIzjRLP0
         SZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734772581; x=1735377381;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7y7OwDWmkLJB5LcPl9h/nsEPz8MIspvq4TozD4gpmk=;
        b=E1lVP0hXnIuoQxDhPNQEwsa3HuRrQMUfxecp+dS4FPoRC8xfBdeagoJjTnj4dSlTXt
         zLSVCGZEFHxvLp+flpfeeIXpvmTXHm5IHUVESxCZzjgMojNNsrSJ2GAYnbXTTFjWr6AY
         tDjRXMPjraS+x5H9qQRWk1spkDzMSz4gx7viacnsU0lqkVtS5ztKb22iCXTKuM6jroJm
         U+o5bG3Nlti7g6eFgMjzy1ihYKZ+C4MYdQqgTEOjtSr5BwlcYzWmXtSK6G7eg6TOon0k
         Kyyj5vGjaCuMjiLdq4gMY/9VMQMTevKT9fw6f4V7psV2p99l0qu0w8/nWB5jYORxNETf
         FGpw==
X-Forwarded-Encrypted: i=1; AJvYcCXun7YDijWcjXz7V2AlZsrJ/fS5atvwCTChRr4gwOuybkJ9NZmYCo/8EWVuWUnH7nF7Uyn7qRzLb8CpbwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqZR6wnvcdDoVAZB/CV9XMUjYTiqujmG2qlBYbmb4+BVdo36ff
	YZNXBSoLx097dOYS2lEWQMA3baf9Aw2v3BeHe69NE+cfdPlVH2lvxGZcaFVCZyI=
X-Gm-Gg: ASbGncvo9aMlOzqvyPZFZNPFI94AZ8+SEr6+Z9rQ8jLx4kXY1QcEllAF1+Y7/uCMrIS
	pigfe1f905nv7RdrWaVoiTuz6hYtsUZ+jXcy0aHG7pt3bUQyARu1JpOglWJWksGHMvhDJ4PLN0G
	9x3Rkn4b8Ip4Uv0oDtgaHZGk53GHvv0eacBfLBrbPJwrPSa6cfuL7F+OUo6kSDyf24XxrmkjInD
	6fONzFxkE5ZqqrvSJoPYZsL7ZirsfmpYbV+RHXYyTxiL2Vi+qr6njLsr8imwmJezg==
X-Google-Smtp-Source: AGHT+IH6Mir6kvKhmopEih92UvP+T0jN4L75qV3Wl9MZkk+P+O1n54beK06Tmw3gpGrq/IpPTKrwPQ==
X-Received: by 2002:a17:907:94c6:b0:aa6:79fa:b47d with SMTP id a640c23a62f3a-aac2703375bmr565246966b.1.1734772581479;
        Sat, 21 Dec 2024 01:16:21 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f065391sm259457366b.178.2024.12.21.01.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 01:16:20 -0800 (PST)
Message-ID: <316408fc-156d-4c80-b62e-bcf1c4bd3c08@tuxon.dev>
Date: Sat, 21 Dec 2024 11:16:19 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 1/6] serial: sh-sci: Check if TX data was written to
 device in .tx_empty()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 wsa+renesas@sang-engineering.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 lethal@linux-sh.org, g.liakhovetski@gmx.de, groeck@chromium.org,
 mka@chromium.org, ulrich.hecht+renesas@gmail.com,
 ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
 <20241204155806.3781200-2-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWv-+gWkH2K0r740BaKLwnTm7RdOTd71DkWMDR0A52qEA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdWv-+gWkH2K0r740BaKLwnTm7RdOTd71DkWMDR0A52qEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 19.12.2024 11:46, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Wed, Dec 4, 2024 at 4:58 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> On the Renesas RZ/G3S, when doing suspend to RAM, the uart_suspend_port()
>> is called. The uart_suspend_port() calls 3 times the
>> struct uart_port::ops::tx_empty() before shutting down the port.
>>
>> According to the documentation, the struct uart_port::ops::tx_empty()
>> API tests whether the transmitter FIFO and shifter for the port is
>> empty.
>>
>> The Renesas RZ/G3S SCIFA IP reports the number of data units stored in the
>> transmit FIFO through the FDR (FIFO Data Count Register). The data units
>> in the FIFOs are written in the shift register and transmitted from there.
>> The TEND bit in the Serial Status Register reports if the data was
>> transmitted from the shift register.
>>
>> In the previous code, in the tx_empty() API implemented by the sh-sci
>> driver, it is considered that the TX is empty if the hardware reports the
>> TEND bit set and the number of data units in the FIFO is zero.
>>
>> According to the HW manual, the TEND bit has the following meaning:
>>
>> 0: Transmission is in the waiting state or in progress.
>> 1: Transmission is completed.
>>
>> It has been noticed that when opening the serial device w/o using it and
>> then switch to a power saving mode, the tx_empty() call in the
>> uart_port_suspend() function fails, leading to the "Unable to drain
>> transmitter" message being printed on the console. This is because the
>> TEND=0 if nothing has been transmitted and the FIFOs are empty. As the
>> TEND=0 has double meaning (waiting state, in progress) we can't
>> determined the scenario described above.
>>
>> Add a software workaround for this. This sets a variable if any data has
>> been sent on the serial console (when using PIO) or if the DMA callback has
>> been called (meaning something has been transmitted). In the tx_empty()
>> API the status of the DMA transaction is also checked and if it is
>> completed or in progress the code falls back in checking the hardware
>> registers instead of relying on the software variable.
>>
>> Fixes: 73a19e4c0301 ("serial: sh-sci: Add DMA support.")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Thanks for your patch, which is now commit 7cc0e0a43a910524 ("serial:
> sh-sci: Check if TX data was written to device in .tx_empty()") in
> v6.13-rc3.
> 
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -885,6 +887,7 @@ static void sci_transmit_chars(struct uart_port *port)
>>                 }
>>
>>                 sci_serial_out(port, SCxTDR, c);
>> +               s->tx_occurred = true;
> And you cannot use the existing port->icount.tx below, as that is not
> reset to zero on sci_startup(), right?

I missed that the driver is incrementing the port->icount.tx . I'm not sure
we can use it though, as it is not reset on sci_startup(), as you pointed out.

Thank you,
Claudiu
