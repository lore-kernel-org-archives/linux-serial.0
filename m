Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7DA146588
	for <linux-serial@vger.kernel.org>; Thu,  8 Aug 2024 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154818; cv=none; b=HOgVh6D1yuW1S2LvQlay5UT68tVJs0dYCfwxZ77ZtQUMGHvWCiZgfJwZzvyEfuK+vnfxqA7dG96bxTwJ0fzc4ItZopskpKGqyjDHfTBfQ97Va8l069+L5/WtHrYutUVYiZ9uNfTkq0exmrZh8RCo6Dm3S/AYtYdaL0oAJZV1EJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154818; c=relaxed/simple;
	bh=uKE/q28/42g3RmG0pBS37MUPgGzTSdIM6qisOmOpT+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4BxrJKtXM9Pf3ptGZ+LvRzOHounHT5uzlfzMsHOX+BtRlCXdikVhWGno1xg97wg5epC0NJas67RiwVJaAhrF7vfpNaxsyZvU7dvfSbAv15yv4lyRHsfbUQKLf17M7kuSFJWlkFbO5PfpDY7sksCbAddL4VwXYsAUTTeCML89I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7i+eQDJ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7i+eQDJ"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f032cb782dso15737381fa.3
        for <linux-serial@vger.kernel.org>; Thu, 08 Aug 2024 15:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723154814; x=1723759614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKE/q28/42g3RmG0pBS37MUPgGzTSdIM6qisOmOpT+A=;
        b=J7i+eQDJXsU11IS3y9oMMw0DW4jxOBGHUWLuA9GJKnTJTLfKxUx511tpuDUeI+u9JP
         PPHB0x3Jf0bZ1RGikSnkwR4NVVQRdRGaykO8oRHma6UObQYG50KZOyJPx0vH7RMLr3Sv
         vkrkdjh+PenJjdborGORNukndJCxBfu5mwA4j4kwoldP7iVHg4Uvkcoot6/VW6ieynzo
         FVPcTOgSsBUoT+FLFjUf/U9KiyQb9WLPbTCWzWKKTnwNuypOlh3J8+qoe1yc423Mcasq
         Cm+DFRh97mjQlyO07RFd4rC96cl6lWGbr96VAbQEk8JqgcgMVAoqerQ3CZ0JLjZLKWEa
         bbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723154814; x=1723759614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKE/q28/42g3RmG0pBS37MUPgGzTSdIM6qisOmOpT+A=;
        b=tpO6wKOsNff45t32Wu8/ElswoVO9+pkcUD8QryJ86MptO4CfcYg2h9JsyzbLgUepC/
         WNO2RDkxH3jT4VVPzSMixhyJVlVRj+1XbUFVMarEnLj9sRexvYUgzgSlC5n5wfi+NfJ7
         EfMtbvOHFewajIBWp3JEW+kidjC6Ey7Wf7beGmmM8l2b6K/Iig0KfBLyuesnSYqM6zkL
         Xymlw+3iG3kxs6Tl6gM4YbxNbsmHtplzBsDUCLVDc+Cj0bzbvh+4HDx3eDUjg+p9HUvJ
         w6AnMlT0FAvaq2ngjeKt1rVHwbUYMH4MTMOQtqVNoFYgglnQjUDUJbw7xpHuHT53xivd
         0hwA==
X-Gm-Message-State: AOJu0YzjOSK392JfRDOaNbwakNR2hOu2yYtkjIpaVXCPux0HELCwqgDX
	lrl7WR118nnHwkHTeloqYGQTY5aCAKehcH2JrAHXqqye1CdYJ2vpPyQ55Pk4fFFtqwG/AvrVl4P
	sKB+AuYpIxewtcOR4piuWosLthKR/PPq1
X-Google-Smtp-Source: AGHT+IFGPsYZrYjYv5fQxWonUH6/0so+Y2CYhx8ppYx0iUljD7oYPm15AsThpx2ivALBpgZv+qP2qI4EXNcwmUqqcRQ=
X-Received: by 2002:a05:6512:230d:b0:52f:3ba9:3bfb with SMTP id
 2adb3069b0e04-530e5811f97mr2860499e87.6.1723154814006; Thu, 08 Aug 2024
 15:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6bfb7abc-0264-440d-b0d6-6dd6a8b64b5e@camlingroup.com> <b792ee31-6e47-418a-9619-3937a38d3054@camlingroup.com>
In-Reply-To: <b792ee31-6e47-418a-9619-3937a38d3054@camlingroup.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Aug 2024 01:06:17 +0300
Message-ID: <CAHp75VdxJ5uS4K5WF8cLWDdKEYXD0RjN1Pv4F3y84T2Da=-8yw@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: sc16is7xx: fix copy-paste errors in
 EFR_SWFLOWx_BIT macros
To: Lech Perczak <lech.perczak@camlingroup.com>
Cc: linux-serial@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 7:00=E2=80=AFPM Lech Perczak
<lech.perczak@camlingroup.com> wrote:
>
> Comments attached to bits 0 and 1 incorrectly referenced bits 2 and 3,
> which doesn't match the datasheet. Fix them

Missing period at the end.


>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Cc: Andy Shevchenko <andy@kernel.org>
>
> Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
> ---

Same comments as per patch 1.

Otherwise both patches LGTM.

--=20
With Best Regards,
Andy Shevchenko
