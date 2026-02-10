Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACA38C1F
	for <linux-serial@vger.kernel.org>; Tue, 10 Feb 2026 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731383; cv=pass; b=Qr24+0LFTWYjCMTdg05D+7GZgirofuVA0E+RThySHGdaRg/0ybjGnvYinahVIoUkfZy8UM/VsZwbtHY4gOQ+WbBTlY0VVrGQlpLToPRrLSg3NBHr4CMcVkkO5I1yUov6cEXF6vjYORPsOYZV3wETXRA4FLYltneV3gmA/vhMGSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731383; c=relaxed/simple;
	bh=9XpFiuQyj8nawW672bUhUrxpEZvvGDYyYs6GM+wh/HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnsrWHbe7x9lrl3U6EG2n1sgMrZyQOAOVAhusGejDS0Q3OctdnmYzIHutXjgQHp2t9dweAHdMWT24f3cXuj9QcU3I+dqJInPox0xOskdt4Wj79HclLjqYtpckBMKyjARLfxtnivW2/6L3V9ggTVpnaEc13QV68NtTZpRMTaqg+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FVjluaJi; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVjluaJi"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79273a294edso7827137b3.3
        for <linux-serial@vger.kernel.org>; Tue, 10 Feb 2026 05:49:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770731381; cv=none;
        d=google.com; s=arc-20240605;
        b=MhTJrjgHzv+ZEzFt8LQdyNeY67H4PstZgKPgc92duoJLEopHci69QBdZBON0QQ58pJ
         24WrtpNna1yqkCh6w/uEJKrYtjwni9dSIcZ4D/msZbqp6iWnG1KGTIu2I1DqkXsmej6r
         VqNY4h3y278AwMilzVKGtnE0WSpFnJjzkuRm6CLOSkxsitVhhrJEshB95bXuFvBYTfKM
         QmEU4lnLxBXKMMrVFKXPwbj5mtQGL8VQwfh5LhWvzGSkZ+wrgNAvj5bCYY0UefVwcr+s
         u87q1nJs/lKdQujcMccr35pYpgtUZhXp9+JQz2g76oI9e/BW5nTNUILsSdz5o5PkKczv
         YENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9XpFiuQyj8nawW672bUhUrxpEZvvGDYyYs6GM+wh/HQ=;
        fh=3XE50f4FwqioerIqAfdsKy8+jD1kNelMyvRQhlYgmjE=;
        b=hvCi/Ad2WrEmPAOkG5JA7AiBj1h9nTp4Gkv5hQn3o0uu2uYlbtWJ5/e+gScMPpMJ8t
         WVWIB/YG9QntlvSWRP+I7M6J857t2WqhHyuZHqa4HYbrdX+IAbs2y4ewvz6j/SwnVgHk
         lAtep5U2ALGv5EJjPi3LN5IT3+/EM0kV3EBuin+qOR119szlQhasfjLJLsptKGKTyjhv
         nh2ohkfwEzlFTbKLRxxM/gq2YvlZT15dU6c6yoxzEK4V/i5zFPZo+75UymZuy0hQIeaP
         +DS7A1oJgaa7YhEs8uy1ENijYJk+m1T8aPpTOIk6imuTlU2URzofWdKvrKky4OcXzfRi
         +RXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770731381; x=1771336181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9XpFiuQyj8nawW672bUhUrxpEZvvGDYyYs6GM+wh/HQ=;
        b=FVjluaJi/8ThEeZraLnqQvWJlR0HKFZLpSG1XhwbQ0UiTnHfcOhoktDshb/0lSGoJ4
         154+0iaG8QMNSww0igt0KyZmzKCUw6xQJl/weiXfUYARufHHND8m+U87DEqrV95plTki
         eM+ZTMBfDiO3Smx2F0uslbZV4qCIbs6NUVl9egJ4hhCKqVTHW7LFOGnIjfg7iIHQMaoZ
         Vse84OmM+520dvp8RL6OmGpj9YzKZe0ykfrJSmU3ajXZ0uavO0Fc6+Nz9cAkEtsfDFXY
         M0SiLFX8YUpnD51TJHtaAXFQUU+vq0SXk2fs5NecoA/dZSTR47UVwrJchhF4xZpyEjYg
         g3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770731381; x=1771336181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XpFiuQyj8nawW672bUhUrxpEZvvGDYyYs6GM+wh/HQ=;
        b=X+Q6l1d/SpUivEoJDCVA/3wd1PBRQmNAcAYmjbiGqjGiaN8W89FG5j7lqvzig+Thhn
         Ei/aUK+2zjUL6x4N4LA7yT3aZpFD9HIwIFMbPZcO0mmzy0TDEf68Z6LEFGURC3GuMvLy
         fo6rY7N+fGFjDPMW/UyJpo17mgZX5ekMPPuArn8vnD4GSKpdUj2e6DL69i0YBmBC1Aq/
         MGYd/E+lFo/uH5FhS35DoJnr744CR5/GX/AXnEYFgcylj8K5C3wMYrgtKnzWktQq9/IW
         WDsFR8ohwHx1AWmaXbuP5eMleIFptlpzcebO1Iqi5L4Vh45T2IGlMiVs1YLkpSL0eyj3
         MhjQ==
X-Gm-Message-State: AOJu0Yw4HCKs0X/8zmjDJsyBpABSNTsB5fkQlJsBt8s8Ovn5Xg8kMlJ2
	jMq+58Q/fWOSRgsYyHD4I4H/tSu3s9dPaVgRsXW1kWZs0GKfDBCfr8unUkO0aF8B5r7lki6wLA7
	xpiOBv1q6DVc4HUJv2nRynDxgm1i+RQDdzSx82apSGg==
X-Gm-Gg: AZuq6aLBKTtW+F9QlQQ1aQJfUlaR29s38atukY7YwvMQ7ZxhQgfollXd/+JfLlj5Bp5
	UK99Ch1wyGJCcqPh0GV/xfGKNtfMGjWp451vV8HGk1+MZXkG2Q0umuA43QEmiN4jvDKH/+liOgu
	yMGm1irNUkLxxi3nbqS8cymlMFqTUs1gjiXWpwo2FLMvJP2YxuaSJOn+Ry7n3BzvTD4+8c2H2se
	bs3J1rKNiFdZwhVk2gjgOkF+HKMw9+PtNgEDF2/jh8HJMoy2kdKwsc2jejoOHgf+2qtOu8Xzc9F
	Po882AKfrI9h3H48kxvqK0mJ5TYO2L9LiJx4FGsGzM7vrg//PsdqPkdE+gLAI3FkL+g=
X-Received: by 2002:a05:690c:6a06:b0:794:dfcd:5e91 with SMTP id
 00721157ae682-7952aa38625mr143855497b3.6.1770731381372; Tue, 10 Feb 2026
 05:49:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210125100.223138-1-peter.maydell@linaro.org> <316ebe17-5938-4e8b-9269-934c7c773c01@app.fastmail.com>
In-Reply-To: <316ebe17-5938-4e8b-9269-934c7c773c01@app.fastmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Feb 2026 13:49:30 +0000
X-Gm-Features: AZwV_Qg5DAIDUx-86op9KZ3J1Pw32SG11KYWkl4_wcHUHV6tnliqrM9_TbPjSWk
Message-ID: <CAFEAcA_nUiQ9ROXBq6Q=3G1wzLtBHDEKSB+4OyYWkt-tR_ZTJA@mail.gmail.com>
Subject: Re: [PATCH] serial: amba-pl011: Enable UART in earlycon setup
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Miaoqian Lin <linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Feb 2026 at 13:23, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Feb 10, 2026, at 13:50, Peter Maydell wrote:
> > Currently the PL011 driver only enables the UART (by setting UARTEN
> > in REG_CR) in pl011_startup(), so if it is used for earlycon it is
> > relying on the bootrom/firmware having left the UART enabled.
> >
> > There's no particular reason not to actively enable the UART before
> > using it for earlycon, and the earlycon handling for e.g. the 8250
> > UART sets up the UART in its setup function, so follow that in the
> > PL011.
> >
> > This allows use of earlycon with a UART that the firmware hasn't
> > already been using for its own output, but the main motivation is
> > that QEMU will otherwise log a message complaining that the guest is
> > trying to write to a UART it never enabled.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > NB: I have tested this under QEMU, but I do not have any real
> > PL011-using hardware to hand to test with.
>
> Looks good to me,
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> One more question: what is the symptom without this patch with
> qemu? You mentioned on IRC that qemu may warn about attempting
> to write to the uart when it is disabled. Would we still get
> the correct early console output before the uart is enabled?

The symptom is that if you run QEMU with '-d guest_errors' to ask
it to log things the guest does that it thinks are bugs in the
guest, then you get a lot of "PL011 data written to disabled UART"
warnings. The guest still boots fine, and assuming you directed
the logging to a file rather than stdout you see the guest output.

(This is because for PL011 we have deliberately not emulated the
hardware behaviour of discarding data when the UART isn't initialized,
because we think there is a lot of "my first bare metal hello
world program" type code out there that was written against older
QEMU versions and not tested on hardware and never enables the
PL011, and we figured that making all that code break wasn't a
sensible tradeoff for theoretically increased emulation fidelity.
For newer UART models where we modelled the enable flag correctly
from the start, you would have to explicitly enable. The CMSDK
UART model is one example of that.)

I have also sent a QEMU patch to restrict the complaint to
"print this once" rather than "print this every time the
guest writes to the UART TX register".

thanks
-- PMM
