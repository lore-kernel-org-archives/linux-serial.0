Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8534388C
	for <linux-serial@vger.kernel.org>; Fri,  3 Jul 2026 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111025; cv=none; b=cDW90hADGpkwyqTtjYcSjUvAlzI/c34IUMG+/JaZodRWpMDOVfnfWC8LM6dirYm5X16B2x/VA9swb3ZRuuAZV5JieugPMDdOpuMtmVupNvdv8r9Bm018PBZFLRESUyMywb7UTCNJ2UcNvfLIoDs6H7ahwil5ZdXw77BMSZTB56c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111025; c=relaxed/simple;
	bh=jkaPcArWTTDI99dDBwodpAIBLuRjLYwgbVN2zt5AZ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkP8wdN5DuyRZq8K2ZzU/iz5gbDk4+X6/DcTZoLPDKMbzWI/6bBDmD37LI9icnBv019FoeJnb/vVHPO+sy/SEGy5UZTTX7zOz/j6UngNloMWuSLhGIbVxtf1ijO4Zde3ZQG28rB3mLmLfwyK+hvOg6RZrnOAnTFe58IMpg/d8z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8wvTQlm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8wvTQlm"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b1710405so5402715e9.2
        for <linux-serial@vger.kernel.org>; Fri, 03 Jul 2026 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783111022; x=1783715822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uS4KO3VWgNCWCtT07tlIBJnLTsi+A6JzIOvJ/o/1Xzs=;
        b=g8wvTQlmnonLqd0ZY3I/VvsHOY66Q9F3CTQD/a125KSAugjm/B8rghac5ppg9L1nH4
         2+FrWP2WElWu2Np87L99XDB+F+Q0K7STdbKuuQfRSDazAf+ERbgc/H1XRo0wTUrF1EZD
         k/Qn/kxqnapvY10gJ5kll7Au/4dEmANelYm3eoOuj3kzYKgn1F4K7nBXPQdjxtCt3X1+
         /uu2vLeCDyKV2kwC1y9OOc5c+qNQXscxqXbNLQTh1T845jiYkP8v5I1R6lgYbuY3lQwK
         SLDOP+hhl0vhI/6Ttc+/DQ391X7SSW+3x7nDsTyxUntiUOjagHapV/i7n9J8UJlszlcB
         XgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783111022; x=1783715822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uS4KO3VWgNCWCtT07tlIBJnLTsi+A6JzIOvJ/o/1Xzs=;
        b=Klab0x5ppK5Lj5P49oXiY160g7UwbA44VYszlcaAnBajcUZlRf4uniHPQx7esoRDRz
         g3BPi87lWk9TqXoeYChEpQvi95E2PCtySckxrsG3oTLISkdpbWaMYlXkBRD738+dPi3w
         kqOqDNQPaKBKisjk1zaAxh1ilLt59ttot7Q3kJIdI7oELlF5DFC4dzQ+0Wjov5PwoNny
         0exFeStlYiBNQAat7cu3/TaJuz9izwsmPjPYU0EecsNBRmqfKCWyCgkI0WVVsa5xLwHU
         xIEimdmm3tOmsIz9kEX/ZLkIAejp/r8Pmb7XY+6ZehqDwRe++oSoeUjR9y6mgJBvQzpU
         JsIw==
X-Forwarded-Encrypted: i=1; AFNElJ/NvhZEWpLqN97ME+8Ja8Rle+k0jQu83vms2zPJo3olqxks2grunmyBGE6JSV2bPIzB+jTrniBuJp87PQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxrv9OfqAvRBGdw+7f/sSR2nBsA6pg1KmLsU72RwMG5RRdl+KL
	fJmdvtvf/bTMA+Jr3uDRaGbpPFDIT26PUgjQDI9/2BzdyrENWuz9sluC
X-Gm-Gg: AfdE7cmItInEBYhah7rpevG7pbcua5dEN7QwOvpgN4PQwWe4YbeBWbt1QetAruV7EKt
	9PvZRh/OL+9q/aZzITNypZLZEf8ouEC5pw1AB1ZeD3E4vUa+iDuiSz6eV+Nbgstih39Gn9TvVHr
	1FVqtJ4TuNCu9pnurEHmqAoU6brm3TrALE6YKKajq7gCfu5Egxs3QKnZY91Vb9alqYK+mNtS2BR
	wPUQUDq+xOQQeBP8wdOPKl1Kj51RpvtO+XxjZxcg+aDRjiUnVQ+0qVCSd5/oK5v1mlBLRaATEAt
	A5B6nX1TYGOH9VSR6LsW9ZaOScy4wEe66XI4cgWakXshfPBigghPCJ26BC4ZF46cmlnL/6seALY
	Xtv1ehjVNrp92HTY1N+ARGgX7+yp4Y0TXo11WuO6rw9YB41/sA/au9N8O7d4rEwy7LQsaME0kwd
	VSlocY8P60UCjVgtKWBmDbQ1kfGMMMftrU+ozu62XprJ8RYQ==
X-Received: by 2002:a05:600c:215:b0:493:c389:d43c with SMTP id 5b1f17b1804b1-493d11fd6a1mr5003315e9.34.1783111021847;
        Fri, 03 Jul 2026 13:37:01 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdb62d3sm86496655e9.8.2026.07.03.13.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 13:37:01 -0700 (PDT)
Date: Fri, 3 Jul 2026 21:36:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
Cc: <Maarten.Brock@sttls.nl>, <crescentcy.hsieh@moxa.com>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
 <hvilleneuve@dimonoff.com>, <tobias.gannert@ziehl-abegg.de>,
 <joachim.knorr@ziehl-abegg.de>
Subject: Re: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to
 half FIFO to prevent underruns
Message-ID: <20260703213659.0ef977a8@pumpkin>
In-Reply-To: <20260703181939.502838-1-paultyson.mbewe@ziehl-abegg.de>
References: <20260702222446.0e06a21c@pumpkin>
	<418f9ae5-8827-475c-b465-1271a784fbf1.bc56e27e-ecd8-43ae-bb87-75bfd472a28d.bfca7e88-826e-468a-bbc5-dac7c685d36a@emailsignatures365.codetwo.com>
	<20260703181939.502838-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Jul 2026 20:19:39 +0200
Paul Mbewe <paultyson.mbewe@ziehl-abegg.de> wrote:

> Hi David, Maarten,
>=20
> short status update before v2.
>=20
> David, your ethernet-rx double-check analogy reinforced the direction I
> had started investigating from the ftrace data. With ftrace plus a scope
> on the INT line, I now see two refill-latency modes:
>=20
> =C2=A0 1. Under-fill, common case.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 sc16is7xx reads TXLVL once and writes that many =
bytes. On a slow SPI
> =C2=A0=C2=A0=C2=A0=C2=A0 write, the wire can drain about as fast as the d=
river fills. The FIFO
> =C2=A0=C2=A0=C2=A0=C2=A0 free space then stays at or above the trigger le=
vel, no new threshold
> =C2=A0=C2=A0=C2=A0=C2=A0 crossing occurs, and no further THRI is generate=
d until the FIFO is
> =C2=A0=C2=A0=C2=A0=C2=A0 empty.

That doesn't sound very good at all.
You need the refill path to be much faster then the drain path.
It might be worth testing at a much lower baud rate to see how it
'should' operate.
(I've run serial code at 'single digit' baud rates in the past, needed
to see exactly how the zilog scc handled sending crc at the end of
hdlc frames and just how broken its reporting of received aborts was.)=20
That path also sounds like it doesn't depend on the fifo trigger level.

One thing I did notice is that the initial write doesn't loop and only
puts one block of data into the fifo.
The isr isn't enabled until the end (and by a diffrent thread).
The block of data also isn't guaranteed to fill the hardware fifo,
it only contains data to the end of the software ring buffer - so
might only be 1 byte.
After a partial write to the fifo, the code ought to try to get more
data from the ring buffer before doing anything else.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 The scope confirms that the INT line stays deass=
erted in this case,

Are you sure?
I'd expect it to be active low and asserted throughout.
I think the 'threaded ISR' code masks the interrupt on the interrupt
controller until the ISR thread finishes.
(I've NFI how this actually works, especially if PCIe MSI(-X) interrupts
are involved.)

> =C2=A0=C2=A0=C2=A0=C2=A0 so this is not a lost SoC edge. max310x avoids t=
his pattern by
> =C2=A0=C2=A0=C2=A0=C2=A0 re-reading the FIFO level each refill iteration =
and filling until the
> =C2=A0=C2=A0=C2=A0=C2=A0 xmit FIFO is empty or the hardware FIFO is full.=
 I am testing the same
> =C2=A0=C2=A0=C2=A0=C2=A0 refill pattern for sc16is7xx.

I'd look up what causes the IIR to report THRI.
It might be based in the fifo level (and whether the ISR is enabled),
but might be cleared by reads and set when the fifo crosses the level.
It seems odd that you are seeing THRI read multiple times but the IRQ
line is inactive, perhaps the IRQ line gets pulsed - that will make life ha=
rd.

There is a timing window between the read of the IIR that return 'nothing t=
o do'
and the system re-enabling the hardware interrupt when the threaded ISR fin=
ishes.
The hardware interrupt has to fire at that point.

I also noticed that the code seems to be doing slow RMW cycles at the end of
every tx to enable/disable the tx interrupt.
The read shouldn't be needed (the driver knows the current value) and the w=
rite
is almost certainly not needed unless the value has changed.
The whole operation is also deferred to a different worker - that can't hel=
p.


>=20
> =C2=A0 2. Preempted refill, rarer case.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Some traces show the IRQ thread being delayed du=
ring the refill path.
> =C2=A0=C2=A0=C2=A0=C2=A0 In those cases the FIFO does appear to be pushed=
 below the trigger,
> =C2=A0=C2=A0=C2=A0=C2=A0 but the next THRI still does not arrive until th=
e FIFO is empty. That
> =C2=A0=C2=A0=C2=A0=C2=A0 looks closer to your "threshold reached while th=
e threaded ISR is
> =C2=A0=C2=A0=C2=A0=C2=A0 still running and the re-arm is lost" case.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 I want to see whether this still survives the TX=
LVL re-read fix before
> =C2=A0=C2=A0=C2=A0=C2=A0 adding a TX watchdog.
>=20
> On your specific questions:
>=20
> =C2=A0 - The trailing sc16is7xx_ier_set(THRI) is a 1->1 update mid-messag=
e. The
> =C2=A0=C2=A0=C2=A0 bit is already set, so it does not create a fresh even=
t. The driver
> =C2=A0=C2=A0=C2=A0 relies on the FIFO being refilled far enough for the c=
hip to produce a
> =C2=A0=C2=A0=C2=A0 new threshold crossing.

So you mean the the chip is generating 'threshold crossing' interrupt
rather than a 'threshold level' one.
That relies on the driver filling the fifo enough.
Given it only writes the bytes that are contiguous in the ring buffer
it might only write one byte.

> =C2=A0 - trigger=3D32 is not a wider refill window. It gives about 4x few=
er
> =C2=A0=C2=A0=C2=A0 refills, lowering IRQ/SPI load and reducing exposure t=
o these latency
> =C2=A0=C2=A0=C2=A0 outliers. I will keep it as a separate load-reduction =
patch with the
> =C2=A0=C2=A0=C2=A0 corrected wording, no longer as the root fix.

That was my original thought.
Something subtle makes it happen less often, but whatever it is can
still happen.
OTOH if the interrupt latency is 'good enough' for trigger=3D32 the reduced
system/isr load is probably a good idea.

	David

>=20
> Maarten, I will drop the SPI-only guard. I also agree that configurable
> RX/TX trigger levels belong with Crescent's rx_trig_bytes work as a
> follow-up, rather than blocking this underrun fix.
>=20
> I will follow up with the A/B numbers on Monday.
>=20
> Thanks,
> Paul
>=20
> _______________________________________=C2=A0
>=20
> ZIEHL-ABEGG=C2=A0
>=20
> Executive Board: Joachim Ley (Chairman), Marco Altherr, Wolfgang Mayer
> Supervisory Board: Dennis Ziehl (Chairman)=C2=A0
>=20
> Court of Registry: District Court Stuttgart HRB 746188
> Company Seat: K=C3=BCnzelsau, Germany=C2=A0
>=20
> Der Inhalt dieser E-Mail und/oder jegliche Anh=C3=A4nge k=C3=B6nnen vertr=
auliche Mitteilungen enthalten und sind ausschlie=C3=9Flich f=C3=BCr den be=
zeichneten Adressaten bestimmt.
> Wenn Sie nicht der vorgesehene Adressat dieser E-Mail oder dessen Vertret=
er sein sollten, so beachten Sie bitte, dass jede Form der Kenntnisnahme, V=
er=C3=B6ffentlichung,
> Vervielf=C3=A4ltigung oder Weitergabe des Inhalts dieser E-Mail einschlie=
=C3=9Flich Anh=C3=A4ngen unzul=C3=A4ssig ist.
> Wir bitten Sie, sich in diesem Fall mit dem Absender der E-Mail in Verbin=
dung zu setzen.=C2=A0
>=20
> The content of this e-mail and/or attachments may contain confidential in=
formation and is intended solely for the named recipient.
> If you are not the intended recipient of this e-mail or on its distributi=
on list, please note that any type of disclosure, publication,
> copying or distribution of the content of this e-mail including attachmen=
ts is strictly forbidden.
> In this case, we would kindly ask you to notify the sender of the e-mail.

