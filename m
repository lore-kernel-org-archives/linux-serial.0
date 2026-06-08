Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF773D3CFD
	for <linux-serial@vger.kernel.org>; Mon,  8 Jun 2026 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937812; cv=none; b=j7l++ZzEcI4+G9c+LTdO3fefcuVStqevI9lpzZDSaG35XqAjaM2IwbtxKVxkj6dO73DOGeOkejMOUUvS2xFR60W1GeK5DZvCUEKfR4G1yBlZW3xheOtIgn80fC/R5tYnhNoXc0J2xitjPCVto0AlPI704FFzKzqlFiTI5KppMfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937812; c=relaxed/simple;
	bh=C1PD1cUSId6ObmvDRcysve+oP/kTqBM6v8jsyuYu2+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxF2wNrEonY4HVgs9/YtDOBCnW7N9IMhM0Iqs15i/yLhqSk8ajbepovL9oguJTnWhM+IOojS5GajcJqBQ1cliO/Fr5corxVYqRX5O5bBteeUZ1xgJcqeQSg6A3YCn24zS8p7zH3wbnWNr3Xq5DOdwxAa0tHf0Fs/pNMewUKilKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkZrgWm4; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkZrgWm4"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso8124216eec.0
        for <linux-serial@vger.kernel.org>; Mon, 08 Jun 2026 09:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780937810; x=1781542610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YpwJ9v/AiXpP4VJQJr26kjpknRLuUcx7eSaLf7M6YkA=;
        b=SkZrgWm4K3Rsi/FlkS/ENS02ZGtySbzI98rVv/0YhbbDgNPMPvJLWwmQnjURT+JYo5
         iHjBn4F8iQj3lr7ZggCDWG7PcKxxvnF5wkgTvHltmTvvqI9zN1Cq/hU2Utb8RMVFrClM
         yh4kLwt7zQZ5pEHxYPa5k8EQ68QMWub3+Qv2ksTTES5yCvr0wBx1U29b/h9NcW8hH6+/
         x4UR1hvo4AEGxTUv6p1YCooDWuZaS/+20WyR+mZ4pSHcw69Q+mhJlngpYaBPJAj/I/MG
         EGsID75cM7tGQZOn8ZOchXSTKanaaMsVl8hqfMHwOWHchCWoRtzwG60xdZVOjdPk2FjU
         Tvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780937810; x=1781542610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpwJ9v/AiXpP4VJQJr26kjpknRLuUcx7eSaLf7M6YkA=;
        b=ARHt769/tXgVwUNhd7jyUf16R8wPYObOxJtMTmunqmJHfV8hBFD9mVopVlefv9LGxw
         UwLboPbv8ETL7xE27rZ7PHT0lQ8evozVguve/y0w6HPVKU644byqmHHDg3jlrkR7ZR3z
         LY48NooE3l6efggMpcM+qELQ2L0+5bho0Xwy+U7yqcY1IPxfiGzCkwk6YSKnbJjaIolW
         5uUry1wUsp0K5t0mft1ofizS4Q2XJLlbtmv2cJUCraTgdCF9dJW7+PjeC6J1/IqQtoTV
         Q4zALsWaClUj70V3wKihHa5AC1AUdyPYYEhAWRbJuY+hmOqTNWIuSVZ+6onmuy+gzZPf
         RXxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4D5WUj5EPbMp9bM0mHnAz8PrfwrCrpRBBxcWi/NwadE8GhK2uojom+/6yyTV1xREnMrCHlJA1B5Qnnhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9qn3Nz39dIUQDbBTBHPrWHcZ7KxcYlvkwVVZJTC/awLi1G06i
	62dGxP1LqdGvquzFTpat7M3RE5zlHaY/gkxA73o/6AKTtokJ3/BdTimJ
X-Gm-Gg: Acq92OGe+Nvd8dKq0V8NLpjW3n6TD7VMLnZ/TbPPI3UID/Pm3WZ6YcgLTNpKvnOad2O
	cxKVzj1H+qmzXEyQ/ZGOO5zd/uHdEe1oyI3OdW9BYV+uw1mCEJCeyDxKhLvEOWGp6g8GMj/2HFj
	cknDhkcBFEEoKcGItqLh5jaeWCIWgMeRqHYc6UvdaVtBERiBAS1oIzXN8cAXlrCytxpx/teCdSe
	48RjT4jwZbWhWRnFZax1PzG2ThNV+13A8BgOLN8NKxoRgW1NTGRhO/cVmF5h7hbfwhWdWZqI32z
	6xq+ub/m/bMOoBC62/A0gpIFI2tnqSCuWq6GTSArLfzGBeMYHQG3SjMc4zuibvC/hLjj8vDl0N/
	QRgIWrua2ftWZATAG03nmjoDWoNxo4cKRu6Xt8DShOmh2L8f4F020/iHE3HjMDs8t5BJVK0trzk
	Kgm3mQxo3tT2/7lnnnQwhJiWSwP8hK80OzDXsguabHztgJ7P0Z7+E9Z3Q/wVHklh0JJwsSghGX3
	vI=
X-Received: by 2002:a05:7300:7488:b0:304:e566:e000 with SMTP id 5a478bee46e88-3077b2db403mr9281297eec.31.1780937810237;
        Mon, 08 Jun 2026 09:56:50 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:355d:c69b:fe36:8969])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df3b234sm22816203eec.23.2026.06.08.09.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:56:49 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:56:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, 
	linux-serial@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Linus Walleij <linusw@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Weissschuh <thomas.weissschuh@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ARM: footbridge: convert to sparse IRQs
Message-ID: <aibz3auoiq4CFa9l@google.com>
References: <20260510052107.555825-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510052107.555825-1-enelsonmoore@gmail.com>

Hi Ethan,

On Sat, May 09, 2026 at 10:20:49PM -0700, Ethan Nelson-Moore wrote:
> diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
> index a8f4b2d70e59..cea72bd888af 100644
> --- a/drivers/input/serio/i8042-io.h
> +++ b/drivers/input/serio/i8042-io.h
> @@ -15,9 +15,9 @@
>   * IRQs.
>   */
>  
> -#if defined(__arm__)
> -/* defined in include/asm-arm/arch-xxx/irqs.h */
> -#include <asm/irq.h>
> +#ifdef CONFIG_ARCH_FOOTBRIDGE
> +/* defined in arch/arm/mach-footbridge/include/mach/irqs.h */
> +#include <mach/irqs.h>
>  #elif defined(CONFIG_PPC)
>  extern int of_i8042_kbd_irq;
>  extern int of_i8042_aux_irq;

This does not look right. Did you mean to drop inclusion of asm/irq.h
for all other arms?

Thanks.

-- 
Dmitry
