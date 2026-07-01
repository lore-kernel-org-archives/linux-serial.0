Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40917245008
	for <linux-serial@vger.kernel.org>; Wed,  1 Jul 2026 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927709; cv=none; b=rPZG+8dr3XWSbUzCF63XozRKwfKWs8F60jTCJySZr2L/IB9o6i/YPt9BMUiDbYry3uw/oU3uj3uYOvluMP+nv8Zwv4UZK+Q0/41xD1+s+RxDHG4Q/y54jFtKBR2lDMnHpZnWzL/O34hfYTTQv0/c3w3Bz5/DSPV6Crfon/pjc2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927709; c=relaxed/simple;
	bh=/sFIIMwv1cwP6QuFYC8Bi6QyLRzPPMzGLuRnacUwDUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2D3gWSz2PDYEOWvxs8za1RBHCzo0DPQqCiaVkve7E1xiVLE223R81/miHdcx+fXy3Mtmm5n2yhC0+j1O9sighVChZEPQULfL0xqLMgSZZ+w8G6SlP0qk9gz8PF0Je+/n1PdDOsPschfgKxGxNPS5Ky0OuxiYkpkNN6oKMvuQ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIRmANSp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIRmANSp"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4703bc0a99aso529553f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 01 Jul 2026 10:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782927707; x=1783532507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgZ+RRPPPNkUcHKx4yOh/np63o+QAr4UfMkPtju0y+0=;
        b=MIRmANSpMmXXlyoF5YflIczMsBt1rwp26MWE8ORGPcoc6hMrvrpv8f3rGrkcHvEJxM
         jMHL+k9J+YC45TcB3vlle8NMHNlnPm5E1PsnzFbsJguqmURB8M2bNZE8usNSc1q4c1rD
         DQv9g1vp5m3rPnd5+KNaOunbvWsiHfsXu2ZTStIANeerPwi7Q0dG46uXHfA0hZOuvFyU
         byazA+VJu9Ak9AuPrE7xVsfIl0J1p1NIn0L1IY+MYMOM6ul5wtG7VQhVA8uu9MI0D/03
         ZDyTkbQt1krLbS+Z+1YvWg5wIlaydqOxp9dqzngEaSXNfVhkfzHZWm5Vvww3uj8QumhG
         kb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782927707; x=1783532507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RgZ+RRPPPNkUcHKx4yOh/np63o+QAr4UfMkPtju0y+0=;
        b=aZifUjpuLngScpcShmcdcyOjec1JM22QdPXfsqzL0F9qKl2hRB//85z/lsCfZxixk/
         wW0d4dhNjT11NCZQLEOelarR5ElzvG2ndrVz62BlGOajSp+XnCeIApLdtWw5K/fVFs2l
         Zy4fGJXnBA9ninvCzjxFXdOSiP+4oBLw00Mx+DLqG3N7Pm8B+R3T3bNqi3BFeVrD0z2d
         4zrcuGW+fVfd9KgO22orfmSIitvJRy6VliA3qV2rJl9SK3G4MXv8SITH7TXminKf9lNW
         DP3z0ATi5MZ2ygx95Lzjpilpx2SPeI13WHjBX4+OWgVPdmWhCj4/N+WyiBORWxPITMak
         QGeQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqsk4hg5/TDRp1H/QmQ67Fu36cDloZj26iwVNE+qZIX71Dj8IqOx9JUY/hhhcuO+7Z7xebFpJrSf+A93gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTBRascsiH17uS3leFnSHV4mfVz18P7Bqe8uuq0NGjdLajJgTt
	7ULnO7ONNr2myZ/FyxHFDYZ+CFmt077kncLWI1sEr+Z7d+IlaCG3YJoL
X-Gm-Gg: AfdE7clk5Ccchm2hcRxkihuQ1Ou2/wIP80/yKF7/hKI2VaetkGl9WhhJFG5N33WkVBy
	1LiW8eADB5jMR6ZfpnbLGBfOk9oMZx/h1g0F7I1dlu7EDXylqt43tKNXfy3yoOgDDCmtOl9KoOu
	IhHojHh9Q5Ba/s6IBWUY+Hk1/VhrKaCPQljwGrdzE27CNUQa9YXvPRPMtw4DoAOMqcon3y88kuV
	ewK5UDPB+nbpWxzaL4rO6UtmFhLH/Fzqz4SWKAStGmzfch49pg+HiVKK4DST11P9zST/e7+QBx4
	96fqs4KQvOfvfVo41vuXinSixoE2iwD806xMMDsvE6TRqbblojmrbQa+JvngBgb8FkzaPmzUDND
	s998GqNUQcxo4Wnkn9PhmdS6s2zBPNbzcT+hsVh/Y/RoqOK19ZVcjD8i5yPzyfGUu8KQzhFpANI
	S5esvX/mTw05GgvMLkNTKUYcvegK1B3NoBBERVk9EVkkl2rQ==
X-Received: by 2002:a05:6000:2893:b0:46f:f12b:e444 with SMTP id ffacd0b85a97d-47759098164mr4140611f8f.29.1782927706618;
        Wed, 01 Jul 2026 10:41:46 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477ddf0fb15sm1250276f8f.29.2026.07.01.10.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:41:46 -0700 (PDT)
Date: Wed, 1 Jul 2026 18:41:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
Cc: <Maarten.Brock@sttls.nl>, <linux-serial@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
 <jirislaby@kernel.org>, <hvilleneuve@dimonoff.com>,
 <tobias.gannert@ziehl-abegg.de>, <joachim.knorr@ziehl-abegg.de>
Subject: Re: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to
 half FIFO to prevent underruns
Message-ID: <20260701184144.62bac61e@pumpkin>
In-Reply-To: <20260701164056.951230-1-paultyson.mbewe@ziehl-abegg.de>
References: <GV2PR05MB1194183F888F21065CC596F3D83EC2@GV2PR05MB11941.eurprd05.prod.outlook.com>
	<418f9ae5-8827-475c-b465-1271a784fbf1.bc56e27e-ecd8-43ae-bb87-75bfd472a28d.88efbd1d-67dc-430a-adbe-b90700d161bb@emailsignatures365.codetwo.com>
	<20260701164056.951230-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Jul 2026 18:40:56 +0200
Paul Mbewe <paultyson.mbewe@ziehl-abegg.de> wrote:

> Hi David, Maarten,
>=20
> I rechecked this with ftrace, and I think the right explanation is
> narrower than my v1 commit message.
>=20
> The underrun trace shows the SC16IS7xx refill path running with the
> hardware TX FIFO already empty while the tty xmit FIFO still had data
> queued, for example:
>=20
> =C2=A0 sc16is7xx delayed refill: line=3D0 txlvl=3D64 pending=3D172
>=20
> So the conclusions for me are:
>=20
> =C2=A0 - The driver can catch up if the FIFO is only partially drained wh=
en
> =C2=A0=C2=A0=C2=A0 the THRI path runs. TXLVL will report more than the no=
minal trigger
> =C2=A0=C2=A0=C2=A0 amount and the driver can write more bytes.
>=20
> =C2=A0 - Once TXLVL is 64, the FIFO has already emptied and the TX gap has
> =C2=A0=C2=A0=C2=A0 already occurred.

Right, but there must be something happening after the previous time the
fifo was filled that makes this one happen too late.
Either the hardware ISR was very late or it didn't schedule the thread.

Thinks.....
Maybe you are getting a fifo empty interrupt (rather than the fifo threshol=
d)
interrupt, with the threshold one getting lost.
So what happens if the threshold is reached while the threaded ISR is still
running?
When that happens the ISR needs to loop, either in software or by re-enabli=
ng
a level-sensitive interrupt so that another hardware interrupt happens
immediately.
I'm not at all sure how that works with threaded ISR on the SPI interface.
Especially since you really don't want to read any more SPI registers
than absolutely necessary (you need to avoid PCIe reads as well!).

For a 'normal' ethernet driver rx path it is important to check the next
rx ring entry a second time after enabling the hardware interrupt.
Otherwise you miss a wakeup.
I think you are getting (effectively) the same problem.

You might need to use (say) ktime_get_ns() to work out how many bytes
were transmitted between the fifo space being read and the end of the
fifo writes to see if you need to do a second refill.
(Or, rather, to detect that you definitely don't need to do one.)

With the threshold set to 32 it is much less likely that it will be hit
during the fifo writes, so you are much less likely to lose an interrupt.
But scheduling delays could still make it happen.=20

	David

>=20
> =C2=A0 - The v1 explanation was wrong to describe a 32-free-space trigger=
 as
> =C2=A0=C2=A0=C2=A0 increasing the per-interrupt refill window. It does no=
t. With the
> =C2=A0=C2=A0=C2=A0 default trigger, the FIFO has about 56 character times=
 left when THRI
> =C2=A0=C2=A0=C2=A0 fires; with a 32-free-space trigger, it has about 32 c=
haracter times
> =C2=A0=C2=A0=C2=A0 left.
>=20
> =C2=A0 - As Maarten pointed out, the benefit is the other side of the
> =C2=A0=C2=A0=C2=A0 trade-off: the refill event rate is reduced by 4x, fro=
m roughly
> =C2=A0=C2=A0=C2=A0 1 refill per 8 transmitted bytes to 1 refill per 32 tr=
ansmitted bytes.
> =C2=A0=C2=A0=C2=A0
> =C2=A0 - On the tested SPI-backed system, that lower refill rate reduces =
the
> =C2=A0=C2=A0=C2=A0 IRQ/SPI load enough to avoid the observed underruns.
>=20
> The change is limited to SPI-attached parts so the I2C case is
> unaffected.
>=20
> For v2 I will:
>=20
> =C2=A0 - rework the commit message around Maarten's trade-off calculation:
> =C2=A0=C2=A0=C2=A0 4x fewer TX refill events, at the cost of reducing the=
 time-to-empty
> =C2=A0=C2=A0=C2=A0 margin from 56 to 32 character times;
> =C2=A0 - limit the TX trigger change to SPI-backed SC16IS7xx devices;
> =C2=A0 - leave the RX trigger level unchanged.
>=20
> If maintainers would prefer this to be board-configurable instead, I can
> look at a follow-up DT binding/property, but I would prefer to keep v2
> focused on the TX/SPI case.
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

