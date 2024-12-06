Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B68E148832
	for <linux-serial@vger.kernel.org>; Fri,  6 Dec 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498826; cv=none; b=K5K8ljTGt5LgE/NmikvNIXNSLmhiS0fahv738jjGHLfrKARdKVBXoY2ChUosDY/JyrHwFVWbgC6w7wcC6U9Mjbyl34ZfnvPoIiQM3olo47a+lT1N/CPaG6xwD28tL99TroywwwI23QLCqFi8ckhMIJZtfmBv3tWAuRwuPPJ26Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498826; c=relaxed/simple;
	bh=DZ4iBJ/iWM8KSa7H29avWC680AIZt2rf5AWA6M/3SAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ingcxOe+Bqa9LyGweG0brQmazW6AryuyiV3RIMWmKjJPrcaR4qxiOVkWPKkrG5NA6bfyzzqrHF8DCih1t9GzMUyFT43byK3uS0xsXYsJcH1/9UV41WvmZT1PwpLy8PKOMxLAyQmj9y248nhsT7CqzjNxvd1pq01yWF/d/Xa4HR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lWc1IZGV; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lWc1IZGV"
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso22687451fa.1
        for <linux-serial@vger.kernel.org>; Fri, 06 Dec 2024 07:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733498823; x=1734103623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZUn4bZBalbJgAp7xW/bITYcNU46rh/GtC4lpWqRHs4=;
        b=lWc1IZGVzgOULjBdDUf0VtaAnKBv0FVAimNIfEeHXlM2QTWDx2jh6GPeqb0pXGqnfv
         xh6ReG38HIO5eZf3Yp6EncXUJEBwcu3jKSiuirc7LRnqmeJ9F9k2W5MejbCY9ETw1i1Z
         52yzARay2ZoyTNtsbHW/ZGDChD5OxraA+1o/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733498823; x=1734103623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZUn4bZBalbJgAp7xW/bITYcNU46rh/GtC4lpWqRHs4=;
        b=bUPa06cUZHoT5RxF5NyG+qy/e+KrtYPtJZRIP9tQKrSRJAIdfPDi9qUX2KJDo/rOdt
         Fq2DPeAfuOB3TdT+YwAPGAkYdoZIUGUUwHzOq13mBhPL9dqRWujg/6mzgnB6khMizEqa
         A1VVzDMhFJ1ThzZk790qK20t9lk3DT+dfTpVkk+wAdufk32eTFpcP9indBDabs+RbMDO
         ffKUwbW0jUTzdaREty8ZrfFv7ZSrYo4PkF1SatLAa/zI+bct3qH3acrD4cSdtLi3vMzo
         Gz+2GnmovXNI4oEnQfLn2yQ9iwmTLUEcV+SxeSihxjSAzZLTqIcJ+dPnunhGlFZ7Gxbl
         YR0w==
X-Forwarded-Encrypted: i=1; AJvYcCWGWBbY8c0z1aSbvwLH7A5zK3TBP9PgcpRUJj8T/8uztearJsvGAtCAsXBsAUYFkNflcU/3oDsvQgpVDLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Gd1kSdwX8j+e4TvPts3uGOOlD+7bWNoC5u8NaAjnw96bPZql
	XFZpofc/JCpzxa+drJM57hbJuPCeymU+cHbjVcT0hkI1r9g9Dv5LS3cRlryNhYIrCLCzqqvpuki
	DS79X
X-Gm-Gg: ASbGncse0m9YRYEvF5OiODzBao2FlA7PbBJrqPH4N9eG2SiE2LSBq1E9y6XI978Icyg
	PsJwJllKhkmy1oH5jC25lG4rssXFgU8Suqq4x+cF03kKQsQCle09X4+NIteAStI0Aikjxq3nXgP
	94FuDT2cZ+Q8zCsapWXE0a73kIYtnkTSiuwqgz37zi58/Ry+7iPYVKa6BwS630jYaaCdpe85Ibs
	WzOTNquMVU3c1zbkBCFmZGr0nNOQLdMpRaNEFkq0ANDB26tVaDEboSQa0XE/A7pO3yj39cKBEIE
	++0Cu8Bp2cSFhHXVrg==
X-Google-Smtp-Source: AGHT+IGDEydqfBHk0e7Ak9VSbuNx6ltDBZXZTKklR0CTEz4RumhnlBac0JaJQcboguQEhRjSvcfIAQ==
X-Received: by 2002:a05:6512:3051:b0:53e:398c:bf9e with SMTP id 2adb3069b0e04-53e398cc127mr174948e87.55.1733498822750;
        Fri, 06 Dec 2024 07:27:02 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ba9fcsm532332e87.113.2024.12.06.07.27.02
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 07:27:02 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3003c82c95cso1369131fa.3
        for <linux-serial@vger.kernel.org>; Fri, 06 Dec 2024 07:27:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSAUzKIC0wFEG12t0EfKrX4q1Jo9qMQBwa5oQmXMTYx9uANF/gklwLLWQy6zfdQYV4RuIx4ERYQTtzcng=@vger.kernel.org
X-Received: by 2002:a05:651c:2119:b0:300:18ed:4313 with SMTP id
 38308e7fff4ca-3002f8bd5ecmr10190331fa.9.1733498821759; Fri, 06 Dec 2024
 07:27:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206003100.38142-1-rdunlap@infradead.org>
In-Reply-To: <20241206003100.38142-1-rdunlap@infradead.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 6 Dec 2024 07:26:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WzC=AA7MVX_qN1fsPL3Y8JA__0_cL5UWGoea0kJj5PVQ@mail.gmail.com>
Message-ID: <CAD=FV=WzC=AA7MVX_qN1fsPL3Y8JA__0_cL5UWGoea0kJj5PVQ@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: move dev-tools debugging files to process/debugging/
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, 
	Sebastian Fricke <sebastian.fricke@collabora.com>, Jonathan Corbet <corbet@lwn.net>, 
	workflows@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>, 
	Daniel Thompson <danielt@kernel.org>, linux-debuggers@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Hu Haowen <2023002089@link.tyut.edu.cn>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 5, 2024 at 4:31=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> Move gdb and kgdb debugging documentation to the dedicated
> debugging directory (Documentation/process/debugging/).
> Adjust the index.rst files to follow the file movement.
> Adjust files that refer to these moved files to follow the file movement.
> Update location of kgdb.rst in MAINTAINERS file.
>
> Note: translations are not updated.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sebastian Fricke <sebastian.fricke@collabora.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: workflows@vger.kernel.org
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <danielt@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: linux-debuggers@vger.kernel.org
> Cc: kgdb-bugreport@lists.sourceforge.net
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Cc: Hu Haowen <2023002089@link.tyut.edu.cn>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> ---
> v2: Make process/debugging/index alpha by filename.
>     Update references to the moved files.
>
>  Documentation/admin-guide/README.rst                                  | =
4 ++--
>  Documentation/dev-tools/index.rst                                     | =
2 --
>  .../{dev-tools =3D> process/debugging}/gdb-kernel-debugging.rst         =
| 0
>  Documentation/process/debugging/index.rst                             | =
2 ++
>  Documentation/{dev-tools =3D> process/debugging}/kgdb.rst               =
| 0
>  MAINTAINERS                                                           | =
2 +-
>  include/linux/tty_driver.h                                            | =
2 +-
>  lib/Kconfig.debug                                                     | =
2 +-
>  lib/Kconfig.kgdb                                                      | =
2 +-
>  9 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
