Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20D7350D53
	for <linux-serial@vger.kernel.org>; Wed, 24 Dec 2025 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766584888; cv=none; b=dpFKlI5lorRkDD2jXjTmdWNb2JiwmLWBoOC/G0hk5bXtOav9PySxQX4PrQoUe1Llredu3XmoiueUsg478DmL3UqklJRYP2jFttAjKOXrXBjfhtOrWcRr5fR3AI3zC372tBO9pbrq3fQR+FsUv95DltU8ugs+VI8uHDnnvzaZLdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766584888; c=relaxed/simple;
	bh=I7+JGBFRKWqyrnVXzLUaDYsKdcEDRxDNeUF16RxUnpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rro0LrI96CtmXjOPEw60MI8aoVTaAVbmUrKMi07l+Wwf1wf0QnxY6Y1d/L15njAYd4qs5+PZ0YAMPaBzupd103Wa+G4aPrVps9nrxvaGgfz504RW7kIo9oXM2bUYAt0OUAzhWqejnLVYq+QPcqFd4SeQy3UKueNWBi2Z6v3Xy20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=OwOktS97; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="OwOktS97"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64d4d8b3ad7so4618877a12.2
        for <linux-serial@vger.kernel.org>; Wed, 24 Dec 2025 06:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766584884; x=1767189684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7+JGBFRKWqyrnVXzLUaDYsKdcEDRxDNeUF16RxUnpo=;
        b=OwOktS970iZyjTToJrv3vpFIp+TVfoApn5xuvs/UTEwPPJRn+MEeHzVu/i5cdpLGVT
         c0Qd3a6PUuoevDp7TY7TY2CybeAVSC7N8/jEA5T/5hFTwdqieiluHy54dP4zknESaAGB
         bNizDukwvsJqgYnyjKPfBCH5tc6upXcXTkq41BQxwzaYcJAi6GMbJAHalK3kUHPjUC6H
         RPJtAND8ymrvcy8Nq2bqkNF6MRBftJGGzwdXE15I5yysfQ8A66e79CCa10L9imyAbH/P
         V4ZeStIKcTcR1gknTPgWu9Lclta6kc8pRDXW8YZMteJrXRcw5mrBiaS3bHY8ZvKq8k3r
         7TAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766584884; x=1767189684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I7+JGBFRKWqyrnVXzLUaDYsKdcEDRxDNeUF16RxUnpo=;
        b=aGX6GYpS4nTPzqgtQhxhWRcZnF/0i1Il9wdIBehyowm20ZLHmAaHYlnJA4lm8ZXHlk
         nRFDxadk3xTBoOFjqnD/mrr2k8NoWj2oxCkj2l+4dHfRqhI29dsM0VG0bkhTrToEn2NJ
         rYOJIp1MfsTEgoW2vTW/LQDfgQKmqAPUYHDUi+nu/BL/TuCq2mFo14HVHwn8xKgMIHrq
         eYPY45XjsY9/o5j3IL4A6b5xdlOkXjG4iJ8qaqmiO5hMhZlmsoaBtbnzOndiuODb0uo1
         xmSt6pXomyqdqF908wsmNpYtWwRUlsXiw26exygzCWUwTodzJbXl3lKCkkS4j7+nfa+U
         5Jrw==
X-Forwarded-Encrypted: i=1; AJvYcCVtxK/ZqRFp6wBUxGimKIs9DXBBKVyJ8OABlHRH970UZZj98wUze6K96pl+veKE1z9HWkRBHbjIpTqiX3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPsLqnkwssQ0FJ8BUIy14G2DMMQdX0hEGkH1I/g4woDppFlXfX
	ELbZ/XV7b6nhvNHYZ6+j1shHOHfkaP0/6dxm2Q6Nc4brMQO4bB+xRfnUVgPq4Ob1Rr26M4SEo3Z
	NXo5J2mhroFOSIwvsjt9K9LH0MczNpUKaPnHJMDv/Zg==
X-Gm-Gg: AY/fxX50wwrOuFVJvbUh8kBUme/TYicNBeh+fK+Y4yPQmjYINCm7w1xDVKFjQ1F85hO
	Wk7tKqtfvaEYUAMx9CH4DzXxIIPfKCOKgR+hl5hb84LetgOKyIodqR12AkCmbblWT3kQmT/348E
	0WfyyrfsIv9kVQigUylh5cwWlMnjVkNsTB8c6RK6iMCnSvrAFYajoUOfYzM3ToRn0msxihZW/1H
	qlDLIF3W3VnOKaEdGF6aAgcu/Hx6Kvy2oBoFwdohieLBbqxDaN2KHa4pqtgBfyBDsquQAV4zwHB
	3LCU2aORvZw5bxlXtTTkdY9/i595YexR4p1aXjYbb5w94C9Q1A==
X-Google-Smtp-Source: AGHT+IHCXMeYFxQVcU8rJRtC/cDnDm53nQPvIw0Xbx77plqQqDjE4I50qoqJy3GeuDjgR14U8tTAxFKyl0h6HDv3chw=
X-Received: by 2002:a17:907:6e91:b0:b73:8639:334a with SMTP id
 a640c23a62f3a-b8036ebd999mr1821689366b.13.1766584883876; Wed, 24 Dec 2025
 06:01:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223201921.1332786-1-robert.marko@sartura.hr>
 <20251223201921.1332786-2-robert.marko@sartura.hr> <20251224-berserk-mackerel-of-snow-4cae54@quoll>
 <CA+HBbNGym6Q9b166n-P=h_JssOHm0yfyL73JZ+G9P81muK=g4A@mail.gmail.com> <78bf252c-fd5e-4a36-b1a3-ca8ed26fde7a@kernel.org>
In-Reply-To: <78bf252c-fd5e-4a36-b1a3-ca8ed26fde7a@kernel.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Wed, 24 Dec 2025 15:01:13 +0100
X-Gm-Features: AQt7F2owdEGYn8vQgdJCyQRcW10NeJzDUOJWapd16DEqGEP6zPqPRLNSqy5Q0Bc
Message-ID: <CA+HBbNG+ZVD6grGDp32Ninx7H1AyEbGvP0nwc0zUv94tOV8hYg@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] include: dt-bindings: add LAN969x clock bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, herbert@gondor.apana.org.au, davem@davemloft.net, 
	vkoul@kernel.org, andi.shyti@kernel.org, lee@kernel.org, 
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linusw@kernel.org, Steen.Hegelund@microchip.com, 
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com, olivia@selenic.com, 
	radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.org, 
	mturquette@baylibre.com, sboyd@kernel.org, lars.povlsen@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org, netdev@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-clk@vger.kernel.org, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 2:05=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 24/12/2025 11:30, Robert Marko wrote:
> > On Wed, Dec 24, 2025 at 11:21=E2=80=AFAM Krzysztof Kozlowski <krzk@kern=
el.org> wrote:
> >>
> >> On Tue, Dec 23, 2025 at 09:16:12PM +0100, Robert Marko wrote:
> >>> Add the required LAN969x clock bindings.
> >>
> >> I do not see clock bindings actually here. Where is the actual binding=
?
> >> Commit msg does not help me at all to understand why you are doing thi=
s
> >> without actual required bindings.
> >
> > I guess it is a bit confusing, there is no schema here, these are the
> > clock indexes that
> > reside in dt-bindings and are used by the SoC DTSI.
>
> I understand as not used by drivers? Then no ABI and there is no point
> in putting them into bindings.

It is not included by the driver directly, but it requires these exact
indexes to be passed
so its effectively ABI.
LAN966x does the same, but they differ in number of clocks and their indexe=
s.

Regards,
Robert

>
> Best regards,
> Krzysztof



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
