Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC654654
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334588; cv=pass; b=SQMxgRLFKpIqWYUlzQJW7155sl4aMxzB5xfFAA4+d2F2Pd/ZlQV0/8wjR9CuNcwvzLa+8p3Jq/K+vLmNWAMjSM0WaKA5aA2HWwy1L8V0o1qm0YaqTWkbEuWAzftJiO9jealsHDCf/90RPSlRqlu+CWzrwGVgUA1C3ELMGyHB/XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334588; c=relaxed/simple;
	bh=TzogUDUTqbV/03Phk3+L8sopP75CKM3ToRNk2IR2eZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bcd1E927JGXM21BIlRMaA7N0qUiugTXcSZzsnoONEil4K5MRbLPK/mTG8uz3IF+gjajI+f/07vDszrF/NLgtsM9qUWXOMdLJ5Os6HNr4dQ8WgN9E9aBZp122tOHE0Xi4w1D0N7pp/KEfilUdrdmxWMsSKft7nh8FTeoCgLC9QY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScjQL8NW; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScjQL8NW"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9358dd7f79so1228061566b.1
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 03:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776334585; cv=none;
        d=google.com; s=arc-20240605;
        b=XoNwdv6ISehjDwWxLe0U1NsMwlCPkTuKxhbKaizjDC57v43LAOG3vPLgVhiG1dhGWV
         7D7W99bd+og5ch5rMUO2hdeNKcC19IFwJZBj0q0QYwvlVq11pvJ3tQwurTi1SjRv3onJ
         IIbkceoygdYYmhElNnhcPdPdVOkvwy7C9MH2eBdZ1DN7XCt4dbYKLccaSFno67JJItg+
         9ljDp5nKYWA5jhE0PtSlnZbz90LRMDugmos3NtNRInH+bKl4Ca6xKJH1ihwyEaxvNUY5
         xteiwAu3pF23a0QvVPcqwRXG1mRXLVGduFrtenrnv98FrFIHs5/mBUzBBfzJrasGgqdf
         5ohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i+jU199mJBfmceQMXikX0vU+NtJjiP+WxsnDiqfprmg=;
        fh=zxIIt8f0ibKI7Kuwq0j8bq8lfoTS7GrF7zLuTu5TXic=;
        b=Way028HZwVdXXxckH1IGl0zNEjXa899zMnBN6sB+8k9MhjpsFW7SzilTsICl/ee5As
         VT/pjAC9FKtATo3ZrHEObm8yTQhNHKgKFwcZ2BjHqdo5tpCh1M90kGM+Edgffr58PzTU
         QJKfmMsPEjITK0qilQFRP2Fie3k5p7j5wJYf/b70WFBM/xH1+EiUUurhtphAwNO4Mnpe
         6gW95wcvcvRPgOWxw1Y7QxzjCY5A+0FBgn3bAif7pRr9xl6F/ngIUIG5IyoqZkAcKcrZ
         ZbUNP4uzjW0UBtK+UmuuqEh6kYRFPdb/P2pg9cFfiVEgrqc/UJwsUPVJ8/qSXFccmuaw
         GB5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776334585; x=1776939385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+jU199mJBfmceQMXikX0vU+NtJjiP+WxsnDiqfprmg=;
        b=ScjQL8NWAxmyOf0XAInb/PL9VMATya2zZ8BGU/A1EWiYVbe4VIptt9zZ4Vi8/AwA2A
         q5YEmzv39LIwWIpE2glGjugH6gI2zC0fw2yN3ufZKrXmLbk4ymZkYslVgMkhW1CQ6xM8
         4IshdLvB9oDBDjQlnaVXPzewlWGkd67IrYFh3t9padt+2W2IyuvxSzN4vT0azZB/ppTq
         47bA+0Jx8+Dk0mkaoiOVp2AftEefetzrZkYtsLoF3qoVM/0xenrQ1PhxdCq1+CEkwoeU
         l/UUFbJtiS/kjbeMU87Yw4BHwmKR3l4swY8nq7Fxs4WT7Q5YOEJeEf1fZ11PlalbVij1
         nuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776334585; x=1776939385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i+jU199mJBfmceQMXikX0vU+NtJjiP+WxsnDiqfprmg=;
        b=mPXmcZf2/MvkQLlM9T/0+aiUUwDc0hbhLlTkcYfR4Nxzpcps/lZxxcMbRMpIDKrrsI
         KaxYwObmDobv1t3mWhHexrG+HAXGeGAfqwGchOkSWC0NYSsnw4WNdQ7zvvXJtafKW6ON
         tbjwbZxCP30llYN6ppAwJpq6tNNQPCgtlHuX5tk5bSqZWKQNYVaKGVODMBP/B1EmWq0h
         QqTKk09Qo9odFO9u6RWCRBuPMDJZyACcDEr9DXG6NXKyq6G56M++B3tlV3NpwO4CtAMG
         994gkoj2QE+hRTrIo5TYx5c7dVVNfeOJE13ejzwqWF1+MseyS+PWqIsfsnctys3G5J55
         jl/g==
X-Forwarded-Encrypted: i=1; AFNElJ+osRkjNNxTm2PzN1w57I4PD9OReOb6aiYBLyCtdrcUEQvbrpA0Bb6wR3K8Zy20msIAtaznduDRYRboRcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwveoI3+IlDyAIIv1/z00g48BXGT99+FGkFewz7Xy22D2ZZJhaD
	Go9BMJmUvlb3KJ5X59iso+oLBidQw9Ekp2Y91ZtwNupzodoBCWfT66p6sup+ohUS/TpZN8k7Ezk
	0EB8whj2jk7mE2WeLm4yCyTnsJZYTL00=
X-Gm-Gg: AeBDievsXDycAGu9RMyZg8C0hQsUYcKivg5W+DI2/AQJS08VtVpF+eNyCBCIDXDxeqp
	WrWzbIy3aGvHXn/IxyaKhV1kI5AIIHXK04tkLQwDUTsSkMDwKnaFVEArRd/hmqSAPrb8qJ6wisD
	VAp2U5HllROaPdylxr/IdijgQgl4wuwXR0xPhQEk/+3Z/+O0w323Q2HtyF3vshyD+trfpkneycm
	H4LryWnEUAViy3q4FMVS45CEiLD6t/I35oMx6eM8xJLBV1XJq1lXfyf+H7L/5hLRqwY2FEPL1xv
	82H5t2fyeWa+DmcgbGPRXHzt0CIi8B6x0UKRGlG9jUmkbZIgxYVJWzUs8MDruYkEC5Uu6yAGYBg
	aMsfIAv//GzlAgsJLgg==
X-Received: by 2002:a17:907:268b:b0:b98:2542:6135 with SMTP id
 a640c23a62f3a-b9d7243f5d8mr1418590366b.3.1776334585073; Thu, 16 Apr 2026
 03:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHp75Vfrw6jLWOm6gC3gjMnUrvyd5nxvS16sJj5TP_JxaDSDNQ@mail.gmail.com>
 <20260416100254.30581-1-fushuai.wang@linux.dev>
In-Reply-To: <20260416100254.30581-1-fushuai.wang@linux.dev>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 16 Apr 2026 13:15:48 +0300
X-Gm-Features: AQROBzBRKRVbsJ3DwIPYeVJ1D_RabueCq3fY_DvbS2vQ3udqkvZUGA8OC8svfMY
Message-ID: <CAHp75Vc7sdDT+nWZX7u7aSsUhUquYNAiYo9HrxHhjXnGz5g55Q@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: Clear CON_PRINTBUFFER on port re-registration
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com, 
	jirislaby@kernel.org, kees@kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, osama.abdelkader@gmail.com, 
	wangfushuai@baidu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 1:03=E2=80=AFPM Fushuai Wang <fushuai.wang@linux.de=
v> wrote:

> >> When two PnP devices map to the same physical port, the serial8250 dri=
ver
> >> removes and re-registers the console structure for the same port.
> >
> > Is it a real device out of there? Can you share what that is?
>
> Yes, it's a real device.
> In my Intel(R) Xeon(R) 6971P-C machine, the boot log shows:
>         [   17.242984] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =
=3D 115200) is a 16550A
>         [   17.251352] printk: console [ttyS0] disabled

>         [   17.257934] serial 00:04: Runtime PM usage count underflow!

This is strange, what kernel version is this?

>         [   17.258360] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =
=3D 115200) is a 16550A
>         [   17.258516] printk: console [ttyS0] enabled
>         [   29.643013] serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3, base_ba=
ud =3D 115200) is a 16550A
>
> The issue occurs when BIOS "Serial Device" option is set to BMC:
>           Setup Question  =3D Serial Device
>           Help String     =3D Sets the Serial Device used to output bios =
serial log
>           Token   =3D 9003   // Do NOT change this line

>           Offset  =3D 2F8

Is it an IO port?

>           Width   =3D 01
>           BIOS Default =3D[01]BMC
>           Options =3D *[01]BMC       // Move "*" to desired Option
>                     [02]S3M
>
> So 00:05 may be the BMC serial port device. From ACPI paths:
>         /sys/bus/pnp/devices/00:04/firmware_node/path: \_SB_.LPC0.UAR1
>         /sys/bus/pnp/devices/00:05/firmware_node/path: \_SB_.UAR1

Do I understand correctly that both devices refer to the same physical
device?! How on earth is it supposed to work?

> >> During re-registration, the console structure still has CON_PRINTBUFFE=
R set
> >> from the initial registration, which causes console_init_seq() to set
> >> console->seq to syslog_seq. This results in re-printing the entire
> >> system log buffer, which may lead to RCU stall on slow serial consoles=
.
> >>
> >> Clear CON_PRINTBUFFER when re-registering a port to prevent duplicate
> >> log printing.
> >
> >Seems like the Fixes tag is missing.
>
> Yes, I will add Fixes tag lately.

--=20
With Best Regards,
Andy Shevchenko
