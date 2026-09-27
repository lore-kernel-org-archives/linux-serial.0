Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com [74.125.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5753A3E8B
	for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790518670; cv=none; b=fW3GYLP/5DuNnYn49z/PfbUthvD3ITcHh0BDtoSSSeylrn9AraPUNH7DBMq3jSBcJjbasbVldUyV+dz8pdpRCOkttO32J2XUtF1M0sHotZ4XfmEfZWypbYs3vt1wqEe0EOpAaw9Rw9cwYjWtt2P9IvAHyMnEaj9LVgrsmeyb4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790518670; c=relaxed/simple;
	bh=8VkAPD9LDqm7d05XF+l4kP18KbZK75aLsQU4vJdd6zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJybm/jdnCdTirMk9n9+m5NMoeDLqbnBgKbDJSYJgHKgSj1REP+x4A9FI+2/LRbcsixSiOenalMjeILz5zbKMCQ/FfTXdAIty5Vfb3/eqc2Ucc6kodPWqAYxeZkER4EWyTSckXHq5cs4fdQuz1DOwqIOqyQuPeHqweS8/Z5JNeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f39.google.com with SMTP id 71dfb90a1353d-5ccb36d5a57so1098757e0c.3
        for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 07:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790518668; x=1791123468;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hSwyiSqecYc1b+uiw5Lwtr2HGwahE5D4OZtCe4oNRG4=;
        b=Qbu0dVjNH55dnFdl90bmxJByBQ0ZBBs1n1Sa5qmNN5mNu1ZzUInk7jY8csUSt53Baq
         bgj+qJheOCt1rAOMIGc6Zp4NeNR2gCx5Y6ZAE9uM/GQLJRwr1HmaLpkHoQFZ0BEkpvhn
         0UrHBEK3pJh1IRz9Zill8mxXwTslGcHDlD7x8e+/xQI4DmU+jqzP2weAaWzRQ4qsZOae
         2r+g66xVTsXUzZQ3KOcrwXH++XR0UiQNr0yAfrz0MdL7dftpR6MhJu2xGiulgguut0KY
         n/+LLBPqa6lHmkmQbrlaO1g+FGYoXeoF+vYIn5ugjizM4M/gYdScp1nn484GtkfslB0Z
         AOaQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFoukIWNiFjT2R77Tw8PAVm/tuRU+Avi2p8WbXZFpR9Bc8zj+vUOr6bEZhXEOI2eQqq9Nvb9Q467fJDZE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiJ3TO+hmo4doGAVBTDLBI0df/oMMr6EPX6KIR6WBh6Lak99Ow
	hHP25zv9HgZ0lp0reJ8TnTUVYUQJWFKPP1pjrXbZDQFtZPBInG6ATRA2mfrc1f9S
X-Gm-Gg: AYBFou25+aIt0eQPdE//OJOHIixjF5/dyoPaqGuh3LzrdofY01TkZe5hWrebc45rGan
	2P92OpY0K4SfqI9xFdhATIMsfNo6/GiuYnLrQMH3AYjzNV9gPzb4/w5fwJbkQpi/oN0E3wHyucL
	HbKRzzxXJ+1UZjlTdPsq9rdy8QMMLlRzPr4/PC0uuhHzdt9LwmcmLmR5S6eGB60L0w1rJlPEvi/
	VyK4dUP2bK6vEqI5SadtnOGcFSF99G7QAwt74K+n/DBK5P2vZfZZcIOsI5+rGGkFO1g5OtGD8FJ
	rLvchPrMbQwzstPpkO0OCcAlfoT8GYEwRDbpU+r4ZrBKk85Wytuyc949CRADM00pitg/fXUcchu
	fcUuC+1C8+Obl4JU/przE6TAVG7WEyZml6Ywk2gWVHWL3EyhXTfGjIHwLJPDarWtH5aTwhG8bgv
	f3OWxUjnM3yjfW+YJ8A6X4Y8mPu1eVWPxu8qSwZ6dlLROAvDfwNm0dP6J60Ix23jpMqDPmjIv3u
	UJc1T9QFf74XEpFEp+aRbQ27RUB0tFheOdwYRlaNvSQXzAV
X-Received: by 2002:a05:6102:e10:b0:7a7:195a:1b27 with SMTP id ada2fe7eead31-7af1f611721mr3366281137.33.1790518668205;
        Sun, 27 Sep 2026 07:17:48 -0700 (PDT)
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com. [74.125.226.204])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9889b1f453bsm2852658241.11.2026.09.27.07.17.46
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 07:17:46 -0700 (PDT)
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c62dde2so574772241.2
        for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 07:17:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzDzMHc7WOS6Kbj/kE8YZuxLk3DWsWVus0BYCXMZ2mgyerXRbul3pytsXUftJvu83Ae2CHp3sFyfTETAfo=@vger.kernel.org
X-Received: by 2002:a05:6102:1627:b0:7a6:f970:27d6 with SMTP id
 ada2fe7eead31-7af1e9f2d0cmr3199511137.20.1790518666358; Sun, 27 Sep 2026
 07:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731094402.741645-3-thorsten.blum@linux.dev> <CAMuHMdXfst6urDAoSKQgbjB0j0vU7c0v=WM-gOe93iBEb0Li=w@mail.gmail.com>
In-Reply-To: <CAMuHMdXfst6urDAoSKQgbjB0j0vU7c0v=WM-gOe93iBEb0Li=w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 27 Sep 2026 16:17:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWtDAzX5OsWHteKk7uyaFvXG1o9xvnsDkeH68HR47m9tQ@mail.gmail.com>
X-Gm-Features: AclHuK8L3KT4Gm-Oc3iO6o7xAeDJJ21XQiCKW5qIvopKolo9VS5m0M8TAzfubE8
Message-ID: <CAMuHMdWtDAzX5OsWHteKk7uyaFvXG1o9xvnsDkeH68HR47m9tQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] m68k/serial: Use generic BASE_BAUD in asm/serial.h
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Sept 2026 at 14:26, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, 31 Jul 2026 at 11:44, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> > Include asm-generic/serial.h and use the generic BASE_BAUD definition
> > instead of redefining it.
> >
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Sorry, wrong copy-'n-paste:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v7.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
