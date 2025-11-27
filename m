Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6BB334698
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259873; cv=none; b=uIE90ox6lxuPpKVGhq11ffxzLtbk2klqo5CucOV0lp7EdACcwpWwWXYM1GFV818ifs7atxWqdeWalOopZTg1J0IMAZQYXHJIfC1XSXjVWeXByQDUb0RIZK0SfI8kJKE3GQTo7i8YAMf2/qQvT9v/MyOtvSXe/SD44N1Ucn2AULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259873; c=relaxed/simple;
	bh=ladk689p2Y8k00NfW5QpkMPZIgCI9BT8rEOH8gBzA7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekrgIUy2Sb+Jxb4rQaWHWWFjjG/CBuNwnNOojyJoR1Wu3PrdOLYpYDbiXzqnJvapodHisdrbW3l2cYZAPodRUSsuCHLG6750x/wOhmWmJvz5/dJWoWCUomShT8X6Tj1f7NwJLVqCgiXl+GIq1GehesyHLbrheLrP1AbS4YRq5I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mT2IJR3f; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mT2IJR3f"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7355f6ef12so203423866b.3
        for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 08:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764259869; x=1764864669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfueEmXvJ4IoIPwxPQsIfZjF3SvSPLgK00r7p6jbi1Y=;
        b=mT2IJR3fd/M+eM2FoiS697WpBi/Y7alBWOHDWlZrU/3ow6g/Qr+q4dtUunnhHWEPuY
         EdTcGqzPfooqOP3wi4x4bduNirq5iubQ8XpyeXSFYMjTS+R46C4R1+l/ffY/gs3yzXwV
         GMEULkBncAvguu3axAitJcLlW8RqqQT4gp0ITZQxhePGfcs94zOrmhTCBb4vCpOozwAP
         F38rbW+Q+LqvIlE+UC/OBO0jkx38oryEIvR5SwoX7tXGmow1WbfWON1EglJQviPBLuX1
         UbCgaxjt4lxAjO5Opdgzaoa+440t3k9GCwu6YujEauVCRlsF+9PesHs2ospqqdVZKEE8
         K5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764259869; x=1764864669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GfueEmXvJ4IoIPwxPQsIfZjF3SvSPLgK00r7p6jbi1Y=;
        b=nI9/4v+nEjpMPravEXG32Q4DJEnwWN/Vk3o4k2Uk1fnxOPtyFH2X3Z/ArzyaHpUlah
         WY59K/06eKbao+IIGYryA84e9lJBdJe9i/Tz//YcysB3I5yZ0qeolTpTyjllpWvBActi
         8TD11qDR2MHja0kr5K394Eaq9wlTmtHi/e7WQyzplMEUCgF7cf/UPrYIwp5jieoIhJ9v
         6gJwU9vRQAqD4+7+QPgbl6lK6ds7SvjZGJIfjUUCJfkeI78FadNJpfFX/h4ujzBh2k4+
         bcsxss88PyhEFYES6vrcAMrWkFXLTcNzYjN0b6ee3fQKbamC7ttpuRI2zfg0/AeEYvuM
         iIuw==
X-Forwarded-Encrypted: i=1; AJvYcCUxzsdlHMizHM6Wre6UUX7cwrQ7WWgJo5ma29yz/7DCLlep49Rgm3JF4hsmX7fLM/eyPIQ4bzGktOXdj2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBRjGAlk9XySp78dvZqCl4gwmPnhrlf5wzvN2uz+mM5Y68gWPd
	Uak3AYNkyffHoV3799AlP0T0UXFdLRK7zInGT7vQp2vwrlYJ6SX4xWpaTGNYKT+2nSjSXYRp7/D
	1NB1hPnJxOYNOikpqprGfQc6B8lTUlVM=
X-Gm-Gg: ASbGncur/95JR3Nyrxx2LGyp1rBRHzOJW4OYmidtOCCPXT4YP96BVMi9/gAoLbNRI2d
	rhJoLw0IaDw8tE5NDLcPAO7tq2AWFdTjdZ6kLE/455p8cXD34vCj/0fOgfofACxT4chQ+dPzjiR
	005+wdEcyGc6mxHKU1932tj1kxkDAcwDKHGtm6K73OdEuuSQ07IN3yHh6aegya7oYW3JffaiLU3
	amzRUFb/XJ7mndn6C5p8l7jg6lD/PenAmsaLRhH0albleWuBDhNR/0JuyKHw8eRuwGNc7PS0SUJ
	Icd99opVZJl+bBYnsDe5UgOVIwcNKOTZ53tg/vUCLkUBveVQEUN4gAIKBG7DcEavR3aKn1o=
X-Google-Smtp-Source: AGHT+IHPjmtJ0YhnFRpAFPO7FW7GDKn/qLkUS4bZYR9r/p23OTOkGfgsg/KzIYgHWXF39SKHQ7TGRXRwHtlC86TBaBo=
X-Received: by 2002:a17:907:7f1b:b0:b73:7d96:5c97 with SMTP id
 a640c23a62f3a-b76716db9aemr2424152966b.34.1764259869080; Thu, 27 Nov 2025
 08:11:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127155452.42660-1-dev-josejavier.rodriguez@duagon.com> <20251127155452.42660-2-dev-josejavier.rodriguez@duagon.com>
In-Reply-To: <20251127155452.42660-2-dev-josejavier.rodriguez@duagon.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 27 Nov 2025 18:10:33 +0200
X-Gm-Features: AWmQ_bkZaNKY9PsNbF_lYOq5N8U5PsBQwE1WzozP3_OofEXzxp3swpNrRU_FPLQ
Message-ID: <CAHp75VeNtYJPmXtDfWEN3a184YXTKNems657UDeBKp4xpOGovQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mcb: Add missing modpost build support
To: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Cc: linus.walleij@linaro.org, brgl@kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, morbidrsa@gmail.com, 
	jth@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net, nathan@kernel.org, 
	nsc@kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 5:56=E2=80=AFPM Jose Javier Rodriguez Barbarin
<dev-josejavier.rodriguez@duagon.com> wrote:
>
> mcb bus is not prepared to autoload client drivers with the data defined =
on
> the drivers' MODULE_DEVICE_TABLE. modpost cannot access to mcb_table_id
> inside MODULE_DEVICE_TABLE so the data declared inside is ignored.
>
> Add modpost build support for accessing to the mcb_table_id coded on devi=
ce
> drivers' MODULE_DEVICE_TABLE.

...

>  static const struct devtable devtable[] =3D {

>         {"cpu", SIZE_cpu_feature, do_cpu_entry},
>         {"mei", SIZE_mei_cl_device_id, do_mei_entry},
>         {"rapidio", SIZE_rio_device_id, do_rio_entry},
> +       {"mcb", SIZE_mcb_device_id, do_mcb_entry},

Perhaps squeeze it to be more ordered (yes, I know that the table is
not so ordered, but given context suggests to put it after "mei").

>         {"ulpi", SIZE_ulpi_device_id, do_ulpi_entry},
>         {"hdaudio", SIZE_hda_device_id, do_hda_entry},
>         {"sdw", SIZE_sdw_device_id, do_sdw_entry},



--=20
With Best Regards,
Andy Shevchenko
