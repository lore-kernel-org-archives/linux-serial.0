Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D897260F
	for <linux-serial@vger.kernel.org>; Mon,  1 Dec 2025 02:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764557197; cv=none; b=dYM8eg1tLa6q8bpmSYcC1PZogU+5CBx29Zn2DkP4kj4MZwSJ8/IKOdpzgYe4AJScst/J5t4IIjwz8qNWxrZH5fxa2OdLiZhSUXP+1wjavH0Vq67AP14OmGssnupui+GJjibT+cWnoW2xGoFSJPt5j8V/mHQKJNeeXnpuvgTUo7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764557197; c=relaxed/simple;
	bh=nKBNat6U5xwzAg1nF2yWfPoEGCqqgApVsDS4GBhtOJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZhJjBWJU2vVTBw2XpLAZPgB5ahQotG7KXDdbWQ28eH/Tltz9i1+8SK9rdLh6BDB85PkK4hwDaAwEskxomq0ZS03gldZ+x+bP2ZufF6pAiu6CbfJx7XIvj3M+pRy9NtiZFXP2ALtRfYo8hekPJK1UMSolLR+NVVadCRsFFt2p0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy0KQBG4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy0KQBG4"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so6999900a12.0
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 18:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764557194; x=1765161994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKBNat6U5xwzAg1nF2yWfPoEGCqqgApVsDS4GBhtOJ8=;
        b=Oy0KQBG4IG2LkSCEVrCZ8DzBJmk4tFq2DZMPXo+7PYQBDZGWvHMLuFHfO7LMl+heZ8
         gaVW4dFNPLZ7SPutlhFCqiuiUnopyxDCr1iPh+l7EdjV7UHIAls+FEwufCbjudH0I80w
         C106FJ0J4CQ8mx52o0B0o+PrsG+UaPs6DUL1crML6beQIuKeEXsVvitIqqcL1p4W/dPA
         c9asnIy9r38q5nR5LT5D7dtgIC64UM8Pws5DhLFvxA7ajN+79oZWnR2DFGWSmc0wWAGI
         ASMZuYXAFoAPz8xFguaeTtdc9VhoRaKJ2BJIOWHIbVwhNPkfcgVjSsE+5Dik2MnZxRPO
         yqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764557194; x=1765161994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nKBNat6U5xwzAg1nF2yWfPoEGCqqgApVsDS4GBhtOJ8=;
        b=Bc2kDQKNmhA7vULvoqrwBNcIqFbx310OqXzVswXKerpw1bS0fd2QnxRpZbTaxcU8+f
         SLeE3Y3b6xEWU0HzDuxxCqRthpKiYxlelaQELsNcyFYSzfl+OBpJ28ijiptszf99vIJ8
         EjhGJeaNY3nomvBbi4mvnVl8bNTTTAxkdW5QtNsjOm7oWVdzJnu2igTtESD4RLEVWVth
         ap5HtoXH19iyHpqjPr+rBROxOQ4t+X8EpId8aZ86bfA37Gh30xpUBZtyQyStAYssI7uD
         /mJGRzrec53UYRMIhuSazDZVetntPO2S1JuVgwsI2JzvhDfC/jzvlH2BQjb4wVAU47vv
         n5OA==
X-Forwarded-Encrypted: i=1; AJvYcCWLaDSkhhbxxjs8QMvql5Nt4RhSYuv9bSKlwgZwi/ZqAQ7MULN5pVvtytU8DaZLUr/f4Ck0IQqlauGFPm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz50DbHyE5oJX4n2rFDXRTYn/LYT3s5ywBTuFMSBRd35s23nRll
	5DAaCgmKDlAFMyvrTrFk6JEs+R7Ng+fjDUzmx87q5FH/e7RMGbbupBDFtE/nCOVTDbs4v4xYOfl
	BWMezsnOcvnUYCgTlM1fQCMjfBBO5CnY=
X-Gm-Gg: ASbGncuNakHtOUCCLYQlTcnn8WKQSj6+SrlCcBywn7D1oLBvxDPJiTwKJytrYRbqC3x
	mgQ/9mL9pZ1wksQtlfmxV28EUZqv99mBMcXZdnZ1soJpqwNhq0Uik/wR4CcQgBjLcSf68L5ZmxR
	dAK6o08U6gZyMnkyVtIAZl/4/gzuSWF+XSnLm/PW2+UsL6wzauHR8S7TsE+nyBAwQDyNEH+cOCx
	I61rZXsVsZoWpJcGFFnfdWidlupjC/fzGuz0iF1MUixrvWyfOkZObV/jxjIbXlN6MDIFOJ8f7Gh
	Qv7UsLXUKPrdm/dT4zTtzVEFc3PaJD5vxkVvrv7MIg9o2LeDRcCc5QpAG1q2jDKxZcabYXs=
X-Google-Smtp-Source: AGHT+IGMDks347hHLbDEt9bg/DL7MjEdAxFSJSqWQSPYzVwSqNaPExyMkvLNJi9moLbGZg5B5tqIyx9rybS7D991V4I=
X-Received: by 2002:a17:906:4fc7:b0:b73:4fbb:37a8 with SMTP id
 a640c23a62f3a-b76715159f4mr4171451566b.12.1764557194054; Sun, 30 Nov 2025
 18:46:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-32-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-32-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 04:45:58 +0200
X-Gm-Features: AWmQ_bnXsQ8ncLIlTLT7G2_pcLSxknkSANTRKMwPJ8ZWf6dKs97lrbP6bKyayWA
Message-ID: <CAHp75Vd4Fr9j3XF3Mxte8NDw_cE+_cyhWh=xs6YMQDTrmn=XnQ@mail.gmail.com>
Subject: Re: [PATCH v1 31/31] serial: 8250_mxpcie: add RS485-2W auto-adjust
 sysfs control
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:46=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Moxa CP118E/CP138E/CP134EL/CP116E boards support a hardware "auto mode"
> in RS485-2W where the CPLD can automatically configure terminator and
> pull-state based on the selected baud rate and line condition. This mode
> is not meant to be kept enabled continuously =E2=80=94 instead, it is tri=
ggered
> for a short period (about 2s) to let the hardware calibrate itself.
>
> This patch adds a write-only sysfs attribute that requests a one-shot
> hardware auto-adjust of terminator and pull-state. Writing a supported
> baud rate value (one of 9600, 19200, 38400, 57600, 115200, 230400,
> 460800, or 921600) into the attribute programs the CPLD baud code and
> runs a temporary AUTO mode cycle (about 2s) on RS485-2W ports of the
> supported boards. Invalid interfaces or devices are rejected.

I'm not going to review this, the patch series is already quite big. I
suggest you to start from the small things in a different series E.g.,
the first series is just converting MOXA from custom to 8250-based
(assuming all features are kept working while ABI is being broken,
which has to be explained in the commit message(s) / cover letter of
that series), the second one is about splitting 8250_pci to the other
Moxa case. When this is done, we may go forward with the additional
features.

--=20
With Best Regards,
Andy Shevchenko
