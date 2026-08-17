Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF802E7377
	for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2026 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958831; cv=none; b=dzCS76h0S3cD18Y2AAusVv0Ua1gy52vS2iZaR37MjzfOD7++PZ9CUJ+ZW2SM2mnkbgdcKj1mua7nyt26muCkthAB83qfpB3k2XCHJndIok80B8IvOGbyy0uA+O1fGV0tiFXe+7FPya2sDpVnQBmXMAprooPOfQbZBA3p48eNECc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958831; c=relaxed/simple;
	bh=EFq0cP2vyw7H2TNf9LZlP4PIeG6g1xnzKlSjNWO0LIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5oukz3Qey58qoUYUTkU2O1QZij3ksrYV+02WuS/Eh6ULUyrrlnm3nFwys71Ewz3Cb5Bepq4rzwrDJiwGaiknpjpdo0ovLgPpuWU3zGen56ki0/hNf6/NeHNVCeuQX/VnNXqRar6nIF+9Sko05AyJabvXKlCH6WVeVK/Mn1rwtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bfa6766cf6so1808923e0c.3
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2026 02:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786958829; x=1787563629;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CzfTLtGkzMq8n3eA9+papZ2SONMrcut8ItlqmmafgrU=;
        b=D8MPPwohPnH/krvDB7h0FC6jU9S8QEvSBPXEBaligu9JH0hLxUAJDMDwV8Hte1Ab2m
         rXecqNVNySkQwclluCJMPfDuZvz22iBCxTPHqUVCFXjuZuUofYPRygxi2vZwiBMW4Tyq
         naa1xwHZlm7sjLgyVEIMNyD4l63P4Eh6bhGNtddeY7vgTJoKPi4l0HlvlBSpTHkQZLcg
         2F7nlY5bDwbTdDqRkCUQCKXFmwA9ex5BtOfddbEfzFEvMUkMel6+OPhN843YyAogMbDm
         A/vkxRJ9nKCQSRv4XGInDhq05wYor+bkQz3JFGZdShTD3PaTa8vgoyigWtYwsbISpS6F
         DeQw==
X-Forwarded-Encrypted: i=1; AHgh+RpvSy7CPqkDN2cUzvxpSbLa8jstneBQamialK1zAqciqBCCcVeUsebeuMINR3lZ9PVng2s2PhdnucXZHf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAgfDAQUOs4PmmtGkfw2U3yt1EKfzR9ImVG40TaXX9347/nDyZ
	nZBV+0Dz2HvAWJ3Yyv/dgn0SU+gLjgd7rGgDumdjCiWq8J7XQt4oJmxzAg4yL/sN
X-Gm-Gg: AR+sD11bJ12KuY4T/XB2BkbFcZE3ZqCvSoWrTCBBT2Rmd2O1dfItYsgQnO0okHXOsk9
	c8yiLq1W2iX9gaizOyZwQEfJNl52wNHD81vijnBublE82XiSedCRTn4FBstLf0glQyVgz/3oTws
	xVGb+gLtZvzUaZetN5kt+IltvwHpz/wDRsp2tc+ttc0cGBJ8RXFxJnUOAhU1ut+PID5VmaXYwXs
	ORrttatluHLf3cfjpprNeBseNhk1REtCIzuH5CamzHZnvUnS/OgMNm0OL6FJdYU9XkuE+dBezDh
	mwNa46n9ueiE+jCP2PLst8m7N4ZDmPiHvqR1arPmx6cyuwG2wIUOdRi8hNN0jVUZKD+6QZ83rfZ
	xS68rm5cYm/SO+2kG1KSI2M51HQ/9gQJ8RWLvW+tjS+y68xhdwVRxq0BEi1yBpGQ0VyzJUjeoiJ
	YCYBddJyjpXzlkuMfzIXBRD63XlxSTrsn9yJgD+1JqAp8BjVbV+f+J9tc3UWhtLox5G178MokFK
	FT5mei3DSfTXHYfZSmff0OTsKpMujU=
X-Received: by 2002:a05:6122:9004:b0:5a4:7e8b:3171 with SMTP id 71dfb90a1353d-5c591f4fbb8mr5911837e0c.11.1786958829276;
        Mon, 17 Aug 2026 02:27:09 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5c78c91b0sm470430e0c.9.2026.08.17.02.27.08
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 02:27:09 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5c27e38ee18so1914917e0c.1
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2026 02:27:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpj5MmQh7rWGAgbHM7NwULIiRTJMEtoys1tK49QC6b4a+Im1jJA6rqSP5c5cDzd3uf0ynwLfv8qs4VOLDY=@vger.kernel.org
X-Received: by 2002:a05:6122:e467:b0:5bd:b27c:bace with SMTP id
 71dfb90a1353d-5c591fb8a84mr5496977e0c.14.1786958828527; Mon, 17 Aug 2026
 02:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ecfzsv6h.fsf@igel.home>
In-Reply-To: <87ecfzsv6h.fsf@igel.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Aug 2026 11:26:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU4C+W6Tpsn3Vr_kqmuU2Vzg7ExXhspmB5qNWMZ3Wnfeg@mail.gmail.com>
X-Gm-Features: AcwNN1X8U8C-rcgaQUE3aE_ZprS7KOY_E0tm_eXFcwDXgVn4bX7wNfFwNA64GvI
Message-ID: <CAMuHMdU4C+W6Tpsn3Vr_kqmuU2Vzg7ExXhspmB5qNWMZ3Wnfeg@mail.gmail.com>
Subject: Re: [PATCH] m68k: nfcon: don't call console_is_registered in nfcon_device
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, John Ogness <john.ogness@linutronix.de>, 
	Petr Mladek <pmladek@suse.com>, 
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andreas,

CC john, petr, serial

Thanks for your patch!

On Sat, 15 Aug 2026 at 09:33, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Since 7c2af0f634f1 ("tty: tty_io: use console_list_lock for list
> synchronization") show_cons_active calls the device method under the
> console_list_lock, but console_is_registered tries to acquire
> console_list_lock as well, causing a deadlock.  It should not be necessary
> to check console_is_registered here since the function should not be
> called in the fist place when the console is not registered.

Nice catch!

> Fixes: 7c2af0f634f1 ("tty: tty_io: use console_list_lock for list synchronization")
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v7.3.

> --- a/arch/m68k/emu/nfcon.c
> +++ b/arch/m68k/emu/nfcon.c
> @@ -49,7 +49,7 @@ static void nfcon_write(struct console *con, const char *str,
>  static struct tty_driver *nfcon_device(struct console *con, int *index)
>  {
>         *index = 0;
> -       return console_is_registered(con) ? nfcon_tty_driver : NULL;

Interestingly, that call to console_is_registered() was added in
commit de61a1a3a0830710 ("tty: nfcon: use console_is_registered()"),
i.e. in the same series that added the extra locking...

> +       return nfcon_tty_driver;
>  }
>
>  static struct console nf_console = {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
