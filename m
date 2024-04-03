Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431EA148844
	for <linux-serial@vger.kernel.org>; Wed,  3 Apr 2024 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152735; cv=none; b=XYYv2MBCc2FMZC/Kjg5ONgy1r5QcuHlxJA1yaMDG0l+MZGB0Tg4Si3JziXJ2i4FRcE9Glb18YXL0p7qN2S9nWQd9i1aop2sCQndijQfW2IoRU0fyGPueQ9scI28qViexU8Rhxz4VPLZn8qRfDnKft1q8LAEQmEwNuDOvl4MBViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152735; c=relaxed/simple;
	bh=TQNlFkl/iPl6kEZxvkBf9c7pV/p9E/CfhbTLpQyyNlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISm+CkPNY/LRo3WaUdizoDMFrsWX1+n+DbC9AiX38ODjL1FAJYYIpJIXI84DAWnSESMVSGudj9b9bJkAySfMj6TH8gIrcm3x/9p6iP8FMcgcZ8wgKml9WVf212A9aeL4vr2L2sXP9APUUvTKLxWjnwUIEtxZrHLS2FCoR3kl09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nNIuh8T+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nNIuh8T+"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41624fe40b2so4146525e9.1
        for <linux-serial@vger.kernel.org>; Wed, 03 Apr 2024 06:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712152731; x=1712757531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQNlFkl/iPl6kEZxvkBf9c7pV/p9E/CfhbTLpQyyNlU=;
        b=nNIuh8T+JlqmtZHyz4eE6vMszpgykfl9OLbG4MEu3gWvbwqTDTNj304CNV2HRcSxXT
         DPkbi2YxwQVhCbUF5+Kdq/bgWnMAy5ABX2+82sy1RfRN8EljLnm2IYm22zA200Eq/B42
         AjsQJTnh1fm7DIyjXapkzRiIKQyE4XxM2NtdqBXPaHhBGX0rPnhLJ9J3+i+i1kHsNvvd
         sUKwMusI0wxrqgg3npzVq+2kkuFbsbNaO0q9njbzbguWiYPyCl7ojCBiurOs3KEbcqbo
         8qxjy+7T08THQZisLi0gUvP/bCnaGXabSj0jJXv2hv7EZLh+L9/wsnTLl9kX5zuuAZHR
         fO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712152731; x=1712757531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQNlFkl/iPl6kEZxvkBf9c7pV/p9E/CfhbTLpQyyNlU=;
        b=S9w/2E+JqpxTezt0p3i6vcDxB5sRlze3rNwnc3IF1zAcqn/0RS+gmcpr+TvXTF1uWk
         yNbnTkSYL+pyJCfHvMU9a1voYvYdhzSabT86qqF99y133NHu5LGMyt9pIof9XE6IOKCM
         yEukhFKIlS2pZ2VvdWLP7Zcb+YeQRxVZO08PDWizcTCiCJ8EihKntqpNEDKl8IwJ0xuG
         6mGnZm0tpZrH1YVckIgYFqMb0EjnO7m7DBWedvHX3N9vmiah+kKFx4i+5vsH/8hVPIU/
         ooxozGzvY4EHANR5Keh7FTf0ruAjAi9nTDUBx9k2ElnlCHsHY0/EyAiiavLrwA8Kr4Gp
         7gGg==
X-Forwarded-Encrypted: i=1; AJvYcCVW2H0MsuV/vXwGk88mZycjoF/OKm9nh0+o1DKwh+KbN4V+KZmFi8XyJFvYFDG/v7woZCSGdkH32rXaEu7xzAVedzjJDzW7jKkplt5j
X-Gm-Message-State: AOJu0Yxpz7i/bb1fzIN/lcdqzV5aVnRtyDjrB6JxYZRaFRLd8jcr2w+G
	SO9cB6F26ILdZK+NYFiaX9K4yZhsxfMlu4hfBrlKBpuWtne/vasWWZIT2Fpg0NSkFX4W4cF+9Qh
	6
X-Google-Smtp-Source: AGHT+IHeqNDBA/AfyKYzWvB+jEZxaoUQEyY/aylIOI09KkhqbTFndAoM1/OE52+0lZPrdJynAwVY/A==
X-Received: by 2002:a5d:4bc6:0:b0:343:72e3:df00 with SMTP id l6-20020a5d4bc6000000b0034372e3df00mr4208682wrt.49.1712152731627;
        Wed, 03 Apr 2024 06:58:51 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id v21-20020adfa1d5000000b0034399b0713fsm1541588wrv.18.2024.04.03.06.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:58:51 -0700 (PDT)
Date: Wed, 3 Apr 2024 14:58:49 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: liu.yec@h3c.com
Cc: dianders@chromium.org, gregkh@linuxfoundation.org,
	jason.wessel@windriver.com, jirislaby@kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH V8] kdb: Fix the deadlock issue in KDB debugging.
Message-ID: <20240403135849.GE25200@aspen.lan>
References: <20240402125802.GC25200@aspen.lan>
 <20240403061109.3142580-1-liu.yec@h3c.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403061109.3142580-1-liu.yec@h3c.com>

On Wed, Apr 03, 2024 at 02:11:09PM +0800, liu.yec@h3c.com wrote:
> From: LiuYe <liu.yeC@h3c.com>
>
> Currently, if CONFIG_KDB_KEYBOARD is enabled, then kgdboc will
> attempt to use schedule_work() to provoke a keyboard reset when
> transitioning out of the debugger and back to normal operation.
> This can cause deadlock because schedule_work() is not NMI-safe.
>
> <snip>
>
> We fix the problem by using irq_work to call schedule_work()
> instead of calling it directly. This is because we cannot
> resynchronize the keyboard state from the hardirq context
> provided by irq_work. This must be done from the task context
> in order to call the input subsystem.
>
> Therefore, we have to defer the work twice. First, safely
> switch from the debug trap context (similar to NMI) to the
> hardirq, and then switch from the hardirq to the system work queue.
>
> Signed-off-by: LiuYe <liu.yeC@h3c.com>
> Co-authored-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

I'm happy with how this is looking. In the long term it might be good to
move the keyboard resync code so it is with the rest of the kdb keyboard
code rather than in tty/serial. However I certainly don't want to tangle
that kind of clean up along with a bug fix so I think this is ready to
go now.

@Greg: I assume you want to take this via the tty/serial tree? I
contributed a fair bit to the eventual patch so a Reviewed-by from me
probably isn't appropriate but if you want to take the code it is
certainly:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
