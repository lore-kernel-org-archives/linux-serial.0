Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A6D3DBD65
	for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786690815; cv=none; b=SVskm2/cx+u2dElS3j7JjmQ5dpLyn13/symOq36OUk32JpzBgiZ6m11esCRF9DtZTy3cm+Fr5QnGSWVqgUdYEnc504LDV2wZatSEVgrc1EiJGj+5cwmp9r1Z+bsB/K0puAl5vxk0w0k0qok0ky2+85t1ArrEUt1TnxDVZly/0bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786690815; c=relaxed/simple;
	bh=QDHTWER7gaZGVxdnix6HF1IV6R/NU/zTyMo3McscTZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pojwe8TMLn/GXepHQmgFAHEq1NhVADz+7m0aNLeqm1bQrYq8zOUhqpLehr6Tj+cdcqKJqIV536olk/oPXt0SSFcuC/mrX+lEV+c/50yziGodupJ50WXK9yIdV/4HwENp8MvR8XbslMEX9YZahIUsVXl/d1l00SESt693gNZQ+T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFpNzmn9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFpNzmn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316EC1F00ADF
	for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 07:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786690809;
	bh=QDHTWER7gaZGVxdnix6HF1IV6R/NU/zTyMo3McscTZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MFpNzmn9PY3nk07mgfQgps8YiGSp8vz7TLyKh5WxFd9sUXmWYMosTQyYpfp+6HsLB
	 L0rYre2gQ5JSq5+vBGfCnJ1JY795bIae/pd/y0oCZln2bwQM/RxxjhoSDyQ43L4t0P
	 1I9h2m61dqxoBJAm+HN1jwfKGpX3gPNx3UPbBnhYROc7CtC2fdO0jtoFKc01HoO1qq
	 0UKQsVFfSRAnoLBkjAWNcPpYWMstZR9Rbg9vweR5t01LJneoKnTHKbc23J3YflAAIk
	 sH963A3ORbYT+01BVGRgfkDXq1yiX+N9Z9N9ZSg9sIq5TsHaCQYS6a/Ge7d6fbl/D0
	 IC/Xhvhi6V/MQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b0f19bea2fso686519e87.1
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 00:00:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpHsz5KHWZFBezejs40mIqRJrtruJAbJTDs5KaJ/8DvRVAyoZeT0sM6UPSOZvKu3QR5Fc0MrErBk5KOtAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwagDMkuIGuS7dERyb+T2w9qr/Lrg68FBfP4FjnKbcWDM1xbhSC
	7lccJ0RjdmaHQ+NuDXtYLBoBbDwmRujcvGqhE0kWtwVivyIAMAQo2VrKKomPVO32NdxxEoV0iOK
	ZpMTUiZbNJi8kX8MER6p/dzk9ArXv0r0=
X-Received: by 2002:ac2:4f0c:0:b0:5b0:eda:de1b with SMTP id
 2adb3069b0e04-5b45915d0f8mr422711e87.16.1786690807955; Fri, 14 Aug 2026
 00:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813-cv75-v3-c-v3-0-9352b3fd6026@ambarella.com> <20260813-cv75-v3-c-v3-2-9352b3fd6026@ambarella.com>
In-Reply-To: <20260813-cv75-v3-c-v3-2-9352b3fd6026@ambarella.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 14 Aug 2026 08:59:55 +0200
X-Gmail-Original-Message-ID: <CAD++jLngKLVtojVtmVkYkdLLZrUojper2H4UEA-jK9gcvCSbMQ@mail.gmail.com>
X-Gm-Features: AcwNN1X41Lg0pGS5rN1f6LITo8FZUmbNN0ilERFfy_O7IWKV3Rive9omrkTS7bk
Message-ID: <CAD++jLngKLVtojVtmVkYkdLLZrUojper2H4UEA-jK9gcvCSbMQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] serial: 8250_dw: add Ambarella CV75 quirks
To: longzhao@ambarella.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 12:35=E2=80=AFPM Long Zhao via B4 Relay
<devnull+longzhao.ambarella.com@kernel.org> wrote:

> From: Long Zhao <longzhao@ambarella.com>
>
> Add CV75 platform data with an ETOI IER mask and skip-set-rate so the
> DesignWare 8250 driver can drive the Ambarella UART for console use.
>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

I see this approach was successful! :)
Look into the Sashiko comment abour lockless write to UART_IER
but from my PoV this is fine:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
