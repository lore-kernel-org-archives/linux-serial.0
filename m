Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9143E5A01
	for <linux-serial@vger.kernel.org>; Tue,  7 Jul 2026 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446631; cv=none; b=HneRbQwoVeXicegTdCb6TTZc7TbYuTDRX1NsAM7s8SD50V+wgwya59AH0lid+04T66tQiU9Fmp4jrpnIivZUU7XXsLd1dThAbHqAk2kIWavuvNdw3QiahaAVJ3xUBC+I18KpVYMvzqZDJIaU1Fiu6olRzU2uN3oRvJoVkzvZ6Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446631; c=relaxed/simple;
	bh=ItSfkmnlK6BHWdpxMHBvTF/ysEYEUmQQQU27gwke/l8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTKYV38y0KohKByH7lg+J1EfKiRP/I+jy/I1Km2dTJtEuNRdOKV7iq4ZkNE0p9yFI2iOTSqN5r90WHSsM8PhyK1Pv3TVOZ6ghTlamcFbcLMlEmx8NAd1AvNVowv6RsQL/IQFkf+qjgeMV71r/W8mmjwD3zbcrsLUuqChJWIwn7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzBImRtM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzBImRtM"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so29836435e9.1
        for <linux-serial@vger.kernel.org>; Tue, 07 Jul 2026 10:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783446628; x=1784051428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cRE02Adizye6h3/KW0gtqPZj1uT3Ybf4N/0s4ldktFE=;
        b=CzBImRtMIDf8vTK827S3/lPEdmwGgaxu54g7fknJ5TEnF2BfruR8mI8F2fyxUhYkDm
         DvyDz5T+YDXJvXAczZUaN7dEoI5LaCCoGKsY+uRkwgtz1hZHLyZMcETaWpJQriifLA0D
         yJmNVfTY8zL4qkHRKKj/j1EcSohqkd9H4GXxTFpiyXbQ7kFTx+6c8hUNk/PGm+jlsjKs
         n72/UGsUCJBxnp96fCtRIMwD1Q5x1OkwBS2tO4etQSLYKwsxazzQi/Rpw08sshuB6H+2
         czwdgGma6Va+nk2KfMk0emPApPU+W3ZNJomQdM/kPfsbzCCgEMMxaaWGMCuKXGW3u88P
         lSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783446628; x=1784051428;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRE02Adizye6h3/KW0gtqPZj1uT3Ybf4N/0s4ldktFE=;
        b=rKt/sl+jtC8S3OTsK7a/Ak2Bv1R/c9ZBdh6qtn7Z9SSQLCC1AUMoWX5cHUZHwjXTUl
         oG4qaV/+EMj3S3Mj58ZtS9hw4rWALNcNl/wemK9UF4+EwFvZK1qVtnAhyPRc+j/NOBra
         tm+oFgnLOOJAZm1/ggoFeI6MSlEaAcFzTNXmlp6uB16sXbjOC+uW+P3HO73yuYqyf5oX
         zHOGSAYf2q67FatlNq6zUtgC9R7Kw8ocs3WAXen5FQuXuOCh+32KOX7KlmnCteZ1DoLw
         iY2WwamIs3ztKl0EOByVQrA+k8v9oZ5Wr1gRKhKaQ9xNMr5QtLr3R8bJyPD14imVRiZy
         W73Q==
X-Forwarded-Encrypted: i=1; AHgh+RrQrVKdqbi9SfMfKdqSP5AKcMz1x3NzL+2tVTr9MaPL/ix3lMMYp0OIgKHJ7pl9cla/7b8pW78pwuxU5jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMEwTQQMtPrtboIBJx9HAe0x3qNC/oeNfDj9cnBjkyq2o8jesv
	zFa7N1UJH1mwcxWC56KULpYKSt1kDit9vWILQvTRmuajClHc2N2wVD+u
X-Gm-Gg: AfdE7claTVxi1326EaIbDHafvNdylCtNW/1zEnFe1BhsoSHc2vm/rqv88PS72FV2DtR
	PERUoTtl144pfQEqcjC/QjmiJHik82onYbQcesjnsV09jB3OP6aO4XtZMz6AYsdtihKV0+0x39n
	apAO7ZZE4/WL4vkczP8vzcAAoadW+lXAaYeVefFnxx3YXY6gw+hmwZhfasBiVgdcyKNWXrAMaO8
	MykyfZjmJBVYPqawTgc8wOdzE4sXQhU+q4PFbkPjefn9/HFGnbqsm85cyqoZG0nWTBORJqsvvG6
	gaQTfkKHeRWl1zHfixXdKfqJK8EEE28NgGnt7ACWXoTcoT0gSsQ8faML1JlGzaZxprj8jXB/guL
	M8P059MOS9luJAqYWkzdGWxGuYMx8W+prObBrkKeYvjgXI3TlUCAj0e6zx4wqxrEimlovCbQAep
	9H+eaqCUOR+RijC/SjBJ3LfZ8kyGmGCkzFsoa1vyqF+PDhLJzhNYRJdVug
X-Received: by 2002:a05:600c:8283:b0:493:b8cd:2555 with SMTP id 5b1f17b1804b1-493df066947mr72993875e9.3.1783446627922;
        Tue, 07 Jul 2026 10:50:27 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0ec6e64sm127359695e9.0.2026.07.07.10.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 10:50:27 -0700 (PDT)
Date: Tue, 7 Jul 2026 18:50:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
Cc: <Maarten.Brock@sttls.nl>, <crescentcy.hsieh@moxa.com>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
 <hvilleneuve@dimonoff.com>, <tobias.gannert@ziehl-abegg.de>,
 <joachim.knorr@ziehl-abegg.de>
Subject: Re: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to
 half FIFO to prevent underruns
Message-ID: <20260707185025.2645b7b4@pumpkin>
In-Reply-To: <20260707150344.353068-1-paultyson.mbewe@ziehl-abegg.de>
References: <418f9ae5-8827-475c-b465-1271a784fbf1.bc56e27e-ecd8-43ae-bb87-75bfd472a28d.b2c59f9a-984f-45fd-b27f-021ecf433626@emailsignatures365.codetwo.com>
	<20260707150344.353068-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Jul 2026 17:03:44 +0200
Paul Mbewe <paultyson.mbewe@ziehl-abegg.de> wrote:

> Hi David, Maarten,
>=20
> Thanks, I double-checked this with finer TXLVL instrumentation, and the
> root cause is clearer now: the failures are stale-TXLVL under-fills, not a
> separate THRI re-arm issue.
>=20
> > You need the refill path to be much faster then the drain path.
>=20
> Agreed. The issue is that sc16is7xx reads TXLVL once and sizes the FIFO
> write from that value. On this SPI-backed path, hardirq/softirq activity,
> RT scheduling and the synchronous SPI transfer wait can delay the refill
> while the UART continues draining. So the TXLVL value can become stale
> before the write completes.
>=20
> One failing example:
>=20
> =C2=A0 tx_start=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 txlvl=3D9=C2=A0 txlvl=
_read_us=3D580
> =C2=A0 tx_pre_write=C2=A0=C2=A0 sent=3D9=C2=A0=C2=A0 pre_write_us=3D16
> =C2=A0 tx_segment=C2=A0=C2=A0=C2=A0=C2=A0 sent=3D9=C2=A0=C2=A0 seg_us=3D3=
64
> =C2=A0 tx_post_write=C2=A0 txlvl_before=3D9 sent=3D9 txlvl_after=3D12 pen=
ding_after=3D29
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 post_gap_us=3D12 post_txlvl_us=3D130
>=20
> Here TXLVL is free space, and the trigger is 8 free spaces. The driver
> read 9 free spaces and wrote 9 bytes, but the post-write read still saw
> 12 free spaces with data pending. Even allowing for the post-write read
> window, the FIFO was not reliably pushed below the trigger, so no new
> threshold crossing was expected. All failing samples I have checked show
> the same pattern.

That now makes sense.

One extra thing you might check.
Does filling the tx buffer clear the IER bit?
If it does you can save a slow read by doing the tx-refill first (when
there it tc data pending).

You might also be able to leave the tx interrupt permanently enabled.
It seems to be triggered by crossing the threshold rather than being
based on space in the fifo.

Did you try putting the second scope channel of the spi clock/data
to get the scope to show you the pattern of transfers and the latencies?

	David
