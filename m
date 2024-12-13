Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF7B10F7
	for <linux-serial@vger.kernel.org>; Fri, 13 Dec 2024 00:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734051354; cv=none; b=qt9AbMc8nas24uMrbTnm4XB77/106QS1NNUf+ye49DrxDPo39CcsJmjUJTf5ERkCHiSYqR6xD5uJEpk5JiC4jKZ4poqryG7kW7vkdH8zC05ruiPrOE2ngmjr2PJZG+QJlKZSFbl0XAGYuA0cyT665AZoUWw46j9y8th4Bs8rdjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734051354; c=relaxed/simple;
	bh=kVwcluLE032tqgMZ5HCmVVcG1bXOZ5sD+ANaaaLviWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQgJBum8q16yaFgY0AjcOTnulGpX3AO6keyODBi5jgSBodBMBzErcWnQ5fp3nQ2MwZ4j1zuSB3L1OCNubTEHgAY9eGh2Xuu1z+ICW4jeXNpapNwbJ0uGpPf+yBlleTtmfLFoDXSTgACP57cMzp9gG3fj16Nb2UxIPF1Mto2Al2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lw8IkRvQ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lw8IkRvQ"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30229d5b229so10388791fa.0
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2024 16:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734051350; x=1734656150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXGrN9zDEEsnJysMYit4acN2irkFENJw6tU7ppFprrw=;
        b=lw8IkRvQjbjFEB30b+Hq8SwLm6H0I8jr+ev7f2Spmfyi3nRnlZU6DHGYje9klLGEJQ
         30EyujaUbEvp0Jp4/1r8zJr8G31XWID7fqtcLGZzQXfoA+ujj4r87EBbyouYNndG93b4
         P+PI2FMDHeoXi0jEScVCHpziimppoDyP9ucm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734051350; x=1734656150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXGrN9zDEEsnJysMYit4acN2irkFENJw6tU7ppFprrw=;
        b=fmtUtUgTikZu13tcMnJaZJvdgkU2/6WHTfX+BJnGu+zA2edg9FqsXLQceOoHY96jHg
         5Sj7nSD5iZSeCXmgE1+7ZG9OCd6gT9XqPWD7TkCTSS+Tt3tIw8Nb6KlS3bUduBky3WtN
         MaK3XKa8iz+sLE1hIxxjo5Sd5jzIH0moDckpJ0tbykZsebcIOAoeqF1VjrRNzhWTGFFm
         8M/LAw8JI/FKPQz+Qs5DZc8flsHFuGphVvKwopXDl0Sol0h4TT+Nswj6FuqRhszEG1Q4
         l4Cy+PWQDzHDjj800Kh5OKm/WrnehqYFQ3N/GNdnmfk+HfSTXVuh94Y3izDNzVJtrzLe
         m+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUX/xGj4uDrtOxAacxgn01apIFJioE+DFkRgBto358vGcEGx9ZLGim9uClmis8ZZIn/u5eAyzZh5TX+g2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZaWTzVqRdDuwIzZydbMDs9iodndB2SBPuaHBR2n3VIwDkOjWn
	6LNUEAlN2zzl/EoTaXf/WRzFnyVuTVCbBD9uFZU7UyJuLOYq56up4IPbQ8M17zUsNtowqYsw5zb
	XBw==
X-Gm-Gg: ASbGncsEmpXNqoN5+P+CwlkuaVOkRMTUzH1Fe9FyeSjFyXf2ifTfBAjGGWKGDPJTu0U
	Wbes8O5crOjpn6PCVY5/cWOvESwOZi828CM1UZ9CLcUj6O0SDY6z42sCpuQ/p6VfSrMnjysZ0dR
	z1TMDyC2Lmzt6xfAZO+1lbmaEDwjwPMG5H/C7spz2FZv4f/6QYy24TAkURmHWGga1p8jjX962zr
	ojJ/WqvyTu+9WmQ/C4CZn21tyV6qruTIyCcCaXFk9AzWwHjhLyGstmWjoHoOjEbfkMQwNk22Klk
	alZSYAREs4UnWLc4daXy
X-Google-Smtp-Source: AGHT+IHWfyHNn6xF3550RwrtMgYJJ9/zLdLwzD7smmwPqm2sd0XAEC1ddXijWNOAdSOXnZdms9cYhA==
X-Received: by 2002:a2e:9444:0:b0:2fb:5035:a03 with SMTP id 38308e7fff4ca-30254492ae2mr1784141fa.14.1734051350504;
        Thu, 12 Dec 2024 16:55:50 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3021e43be73sm15035891fa.42.2024.12.12.16.55.49
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 16:55:49 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-540201cfedbso1210663e87.3
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2024 16:55:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYNJ8dOnoefEUyUCgtlMt8DQsc1LYxkaucZuQVu9DW2FAgwRvyVxL2L5UqzqHHGbYbpSQX6yl8J7vrubE=@vger.kernel.org
X-Received: by 2002:a05:6512:3a88:b0:540:1dca:52bd with SMTP id
 2adb3069b0e04-540905680c2mr99501e87.29.1734051349295; Thu, 12 Dec 2024
 16:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211153955.33518-1-tjarlama@gmail.com> <20241211153955.33518-3-tjarlama@gmail.com>
In-Reply-To: <20241211153955.33518-3-tjarlama@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 12 Dec 2024 16:55:37 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XZA-16JJU-CZGBtqZnQNhZ3Uv29VUdPhbDp1x2Mforcw@mail.gmail.com>
X-Gm-Features: AbW1kvbUF595ctLi_r_y4OzGLCoepX601ov6HOKOsSq80mpxxsyGl0fjgF1PuZs
Message-ID: <CAD=FV=XZA-16JJU-CZGBtqZnQNhZ3Uv29VUdPhbDp1x2Mforcw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] serial: Move LF -> CRLF replacement from serial
 console to kdb
To: Amal Raj T <tjarlama@gmail.com>
Cc: danielt@kernel.org, jason.wessel@windriver.com, 
	stephen.s.brennan@oracle.com, amalrajt@meta.com, osandov@osandov.com, 
	linux-debuggers@vger.kernel.org, linux-serial@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 11, 2024 at 7:40=E2=80=AFAM Amal Raj T <tjarlama@gmail.com> wro=
te:
>
> From: Amal Raj T <amalrajt@meta.com>
>
> The current implementation of `poll_put_char` in the serial console drive=
r
> performs LF -> CRLF replacement, which can corrupt binary data. Since kdb
> is the only user of `poll_put_char`, this patch moves the LF -> CRLF
> replacement logic to kdb.
>
> Link: https://lore.kernel.org/linux-debuggers/Zy093jVKPs9gSVx2@telecaster=
/
>
> Signed-off-by: Amal Raj T <amalrajt@meta.com>
> ---
>  drivers/tty/serial/serial_core.c | 2 --
>  kernel/debug/kdb/kdb_io.c        | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)

Looks reasonable. If someone comes out of the woodwork and says that
this breaks them then we can try to figure out a solution as talked
about previously [1]. It would be nice to include a link to the
previous conversation in your comment message...

With the reference to the previous conversation:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/20241115144933.GB4408@aspen.lan
