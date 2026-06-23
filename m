Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A6B3D75C7
	for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227285; cv=none; b=KMViBXY87xjKIWfSlvCllFFWxaVE+hM1Wo609uqrSJ97xCIXoEJMznOwJ4vechaXcWdXnoMPnrRZ1OCKOt4FZoS4AI+/EUNaNmMPgzmrpzYneUaQHRewJyX5dJ/CAiKrFQEd8wjq5e+dRxi5OCsAzaZ7ypcEWQ2zS3HTA2elL6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227285; c=relaxed/simple;
	bh=SlP3OuYEBzuGdMMIjS1qmezcAULyg5X1I7qTIwQCuBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TR/DlTcma1PYAAfSvKUbwIfmfDlUWPCam3kpUymxmb+ye28R0AfkMroCo9iTHQUjzQcXbwf5Wih3QCL6PccGv4j5nEqfQvoSt00L0d9yUtZuaCVZhzA20PAZpugiwBDQEyIkvOOLglRpihJQXjZk2mT+Mgv+wWOyEAXDNNcAdhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQLnqMVm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQLnqMVm"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490a76757e5so36454175e9.2
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782227282; x=1782832082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+TAOPYwpBx1xjEypw6OnbYeTT5cz9GLufF0SvVZoFU=;
        b=LQLnqMVmnyM5miywLEvdP936u26uVAt1JfTLHo8tir0KvncWE+3JeOFXD6cuYYbk+3
         pnQyswNPC/a74VVuJRbpXv1I61zs/9YGM6fJjslzyhORMlJt95+sClwYtDY6M4yUQm17
         eeL5h0MyFMiaSjAHP2CAykmp/W1ben+MTjgnczdp0IYAYnPAN52GaAXT7HVbpqDLJ97Y
         r6sfLVwRGOr1IYDt0Wl7AaQkI+E3TBGwWsu6U+PQA9G4iHIpeB5ecHCoHZYwjvwhRJ86
         aM4SpX5BgZutaxwVHbYQL/2xd6QwCiabkHf00jeXf3QnAJ1y9LDqqAjjKnTQcVMrUX40
         dUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782227282; x=1782832082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v+TAOPYwpBx1xjEypw6OnbYeTT5cz9GLufF0SvVZoFU=;
        b=a5NkkMX2XObgxHv/yfvGoQqIzSzHOqwxbUqg+zRA+383YdYxnLWeg4+lQkjPpXnecK
         IvBPwq89+htzQYgHPs+dt4uQAcoYF6gz3vSfwgLq+wV3RX72Z3526dmAofcb2R8jEvUz
         wLWVAhrMGPjX7kiJ3zOONBHjgJmZO00shUhcyLZxJHVKr6vfUY078URs0OFlAGW1tuT1
         qpFW6/EG+fD9b4ikorcoNQY32zMKKRNIT/PSb6CSf09Y0vlgRVUZxDOyqY78MEsV921U
         anPOuz6Y+9dWY0BHkjcXpDr4Co7VavDQ2cgxUv2iRUKsPnjngXucbitQgmeMPjb79qP0
         1+oQ==
X-Gm-Message-State: AOJu0YxTelK+vfLDqJUpvmoOgq7Cx4CAOJINgsLPYHciu40Ykgn3a8/K
	bFBe7KvynQbLPzXTrg2NW0wJ5VhX/Zbbp50RUqptXZK72LDrHHrYR9+T
X-Gm-Gg: AfdE7clCYuvHjcJLvAPcQyP6j7tXBvLucm1XUSzXakmzrZm4FAdcXg0lc8odCDxj8sG
	UgDxuIsM4DHD12JXYPuqn5ZbHgIW188P2ZrsnMKWOjTsmr9E9ICNUct1EFsfyRSDOmuPzHGNjoj
	Hi2ISYMfDCywIZtSamv43CHdn9vtu5kd4BK3jRsbfs6NpakSBMN7tWlH7rrALjlQ/PAe0ZElPX1
	coO2RHzbjYVDzBuTF5CErH1qcYBaYLzozgS0AR9F+7QR28+g3LuNyIPpP7HjlnsNB0CcL+LqxZw
	AarWQ/JeR0x+I2/g5mNThy0LIT7ERAKliEy2QtMsPnZaC+ph4gwB+tqWzBq28VnZR+LY0MBNsGw
	i6GqVzOC2SaeDCvtVuqFZpx0mM4fdMzPiRYvl2TksB+db/NgKFzmMuQCh6MYRqEZBhJlNkRxwVk
	aEdxfql3/u+75UFgqwuvRIbzLcEo2zW7e8e84YPFltO/Qd+00ivQ==
X-Received: by 2002:a05:600c:46d4:b0:492:348:ba08 with SMTP id 5b1f17b1804b1-4925b3940e2mr51736015e9.16.1782227281802;
        Tue, 23 Jun 2026 08:08:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240f054e3sm383554275e9.2.2026.06.23.08.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:08:00 -0700 (PDT)
Date: Tue, 23 Jun 2026 16:07:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
Cc: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
 <hvilleneuve@dimonoff.com>, <stable@vger.kernel.org>,
 <tobias.gannert@ziehl-abegg.de>, <joachim.knorr@ziehl-abegg.de>
Subject: Re: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to
 half FIFO to prevent underruns
Message-ID: <20260623160759.506f456e@pumpkin>
In-Reply-To: <20260623140155.13258-1-paultyson.mbewe@ziehl-abegg.de>
References: <20260623134536.24dca506@pumpkin>
	<418f9ae5-8827-475c-b465-1271a784fbf1.bc56e27e-ecd8-43ae-bb87-75bfd472a28d.6a1433c9-1357-466c-bc0d-bc945bfc6062@emailsignatures365.codetwo.com>
	<20260623140155.13258-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jun 2026 16:01:55 +0200
Paul Mbewe <paultyson.mbewe@ziehl-abegg.de> wrote:

> Hi David,
>=20
> Thanks for the detailed review.
>=20
> According to the SC16IS7xx datasheet, the TX trigger level is defined
> in terms of free FIFO spaces, not remaining data. So with the default
> configuration (FCR[5:4] =3D 00), the THRI interrupt fires when the FIFO
> has 8 free entries, i.e. when it still contains 56 bytes.
>=20
> While this in theory leaves enough data in the FIFO, in practice the
> system has to service many small refill cycles (~8 bytes per interrupt).
> On slow SPI hosts, each cycle involves threaded interrupt handling and
> multiple SPI transactions, and the cumulative latency plus scheduling
> jitter can exceed the available margin between refills under load.

But that cost/time is much the same regardless of the trigger level.
Changing the level from 8 to 32 significantly reduces the allowable
latency.

> Increasing the trigger level to 32 free spaces reduces the number of
> refill cycles significantly (from ~8 per FIFO load to ~2), and increases
> the amount of data written per cycle. This reduces scheduling pressure
> and, in practice, avoids the FIFO draining to empty between bursts.

But shouldn't it should all catch up.
The isr thread should start finding more than 8 bytes space in the fifo,
write enough bytes to fill it and the next interrupt should happen about
8 byte times after the previous one finishes.
That does rely on nothing 'going wrong' between the hardware interrupt
and the isr thread.

What priority does the isr thread run at?
If it isn't running at an RT priority then the scheduler might decide
to reduce its priority which could easily generate what you are seeing.

I'll agree that changing the threshold reduces system load - so should
give extra time for 'other work'.
But I don't really see why it be the correct way to stop underruns.

	David

>=20
> The current commit message focuses too much on the "refill window" and
> does not explain this aspect clearly. I can rephrase it to better
> describe the interaction between trigger level, refill granularity and
> system latency.
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

