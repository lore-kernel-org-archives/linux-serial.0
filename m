Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEE6194ADF;
	Mon, 17 Jun 2024 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621714; cv=none; b=GUID6Lb/FHyA8vgr7p1FCpGBqWZzX1j0NBAqHf0tWuxS/wWod0Ct/uyGiIE7pUKreYq5k5xKyST/Xr1tlXM7WyBA0Q+LYhgtjYo31Zh0tY4QMSP3YNNwHLQr0DCNy8DPcGA8th+FThKWqtJa3fANJvCR1Orp+v/sG5p8dAAGNhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621714; c=relaxed/simple;
	bh=aww+GRz1G+zdXDSLQYOikf/6y6UCPSbXlRG5aOMYsZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoRVg4WhE8qeo59CuiDjIEgkTwadYP7k3ghUofF2IkIvXqRHFtxbBaUUBN2P2syld1Z8IMDS2CZbiieQrKFcCnQxfnEcHYKnjp5QcqACJDdnOuBk/BQG43S0aWCcdfGWQzNfQsEvw4wzsRiKcTWaG6mIPPyGE12T/l8UrADsYBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GR4HB3n1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR4HB3n1"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f11a2d18aso553075166b.2;
        Mon, 17 Jun 2024 03:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718621711; x=1719226511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aww+GRz1G+zdXDSLQYOikf/6y6UCPSbXlRG5aOMYsZY=;
        b=GR4HB3n1xicgyD9FH2mCaMepQ8F1SHFmyAy1uCnbH6dBDfuOKARbcw66Vyjpab/4ie
         e90X9ThIDPPaTGFJQ0AqUi/tZvYmeuFnIYEXwHljTbMSumra42gfqpUu4lZArcLeRB5w
         JOy0bLIRIfVOKG5DfdpLmYYfHBGjFTIJj4jV9BPi3eWCdBdu1M25zKvH8dYI6Wn3TKLg
         OJ8fAnE+qBFFpM3fnQcRNXePHxY1HRi/J1n6bMThnv/a4jAkAHGmHjeaBYZnt9/A6ytj
         ncDNdzO7LRk1+bY+HU2zvFSCiKJdTg98vsNrSgHt83FLZyYfTfYL93uSbiaD3st+cFV7
         ubNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718621711; x=1719226511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aww+GRz1G+zdXDSLQYOikf/6y6UCPSbXlRG5aOMYsZY=;
        b=XFIIcJjxqdm6y8aFdFYeATaYmq1kd+oiXaDBqQEqns9UWU1JkN55zmEyA6HyZOwNAk
         9Ef1RwLsqQlNq2lh5PC53hS1bW3TAg+9HYYd8Faf+U2UrHRmGUxyAd8/qmxdv+iWvJUO
         HI7Css8aS/9SIPPRlxBmBNydHlN1zBmEJ7qZvelZDCvitsmpu1LBPjy6oSrI/SpNj7gA
         2AVLYWr7oMgiKM407nd8MzsDxEXYPAU9EsiAGE+bvJFrmpwio8ke6ee4DeyQs3U1M9Ww
         ug023sveUcAgDet+ZKFLVEnyKXYTLv6LCJMjUz0ybJtb9lrtQNXECtyiFJ1XpmydkIr2
         9vKA==
X-Forwarded-Encrypted: i=1; AJvYcCUC7GtbCG4u4QobBB+60tDNeJ5ttw3N7tWihne0q00tTzWCD/EaTJSWmWfmhOZFXXHOESMPK2SGj2zWZZZf+KQ4D8l2MQNFr5ZaZ4hcKAfoUsJd/wcFttpQ9mqCC8GUlQw3EvlBO9CwBmKI
X-Gm-Message-State: AOJu0YwtZNvr0L8yAWu1/EB+b/AX68C1ONJ8wDnXLoMHMaqRX5EK3/YM
	jsC3hgz+8cIEqT3NzQCPQssL0lLc/PkQSTsOC4K69emJFHO/neo4hR0d8+t8VI12gFTVNCBAmwq
	1QHfPBKs7wAYjd3C1XRn/QZRRWHw=
X-Google-Smtp-Source: AGHT+IGnKZ/yGWVHcYepGYcyp37kPuPQstZNz+gE5Sney0NwBAUmsg8axI6Pzi4ShY+hA5Xm2dDGfETFxzop0DXpBPI=
X-Received: by 2002:a17:907:76c2:b0:a6f:5b98:bfa5 with SMTP id
 a640c23a62f3a-a6f60dc3636mr630445366b.52.1718621710656; Mon, 17 Jun 2024
 03:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617063058.18866-1-crescentcy.hsieh@moxa.com>
In-Reply-To: <20240617063058.18866-1-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 17 Jun 2024 12:54:34 +0200
Message-ID: <CAHp75VfAOqyeMF6wbHenDSpmOL8AFQFDjjL1zRfOqLOXdUahQA@mail.gmail.com>
Subject: Re: [PATCH v2] tty: serial: 8250: Fix port count mismatch with the device
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 8:31=E2=80=AFAM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Normally, the number of ports is indicated by the third digit of the
> device ID on Moxa PCI serial boards. For example, `0x1121` indicates a
> device with 2 ports.
>
> However, `CP116E_A_A` and `CP116E_A_B` are exceptions; they have 8
> ports, but the third digit of the device ID is `6`.
>
> This patch introduces a function to retrieve the number of ports on Moxa
> PCI serial boards, addressing the issue described above.

Now it makes sense to me.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
