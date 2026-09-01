Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59622471258
	for <linux-serial@vger.kernel.org>; Tue,  1 Sep 2026 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258182; cv=none; b=ifVVtIFnyCPVI7qNMx6Uxt2lVd5l3zRE4OdBVS7chcom7k+o1QO9FXnIdHowhy+S2JxiomzevDiXTonSS4k1uBE5m1UZwzERAPigwa5fzunI4i2pyFXPUojESNE/HN5Xx62kVGEIAV/339fRtG6x7JULVcUVlErgU2ZRmwZe6sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258182; c=relaxed/simple;
	bh=f3IaTrQW3PdwJG2CI8iddb29hq+NAzAZPlqiyZ/dPEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzMXOWI3HLWE5Zi2FjWanGZZkkbzfx7K1Q1dq4OpPrvF1TZw37d9T6FFE5JkppHTA54yQR8x5UY3cTniX9SD9pVYbRMoniAQHzxU9/ShDEeq7KnsGh2/DBMt5o2iw0kn3d/8QS7Rzxqz9g9mXGpY8Efpt0LiyZ6MXR87y8kuuDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6b34face6d0so507581eaf.0
        for <linux-serial@vger.kernel.org>; Tue, 01 Sep 2026 03:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788258180; x=1788862980;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jjjR751nJX1Dlxj+MGQJnqs6zskSNN1F11sy8NVh7g0=;
        b=Id9TVN5iVgaIBE1YFdV/Iso67VbinkgfyqwTGupZuRRQdTs2jkPLH+8wy8u8e6hIZ2
         Pb8qkcHE9nM5JgOaPTuQxAGVG5IRaGIr2qcsQXL0c2/l3cLKGL2X7vnKTAo7wpeTLuFi
         0Y2BHjEWo52437rXMRygS0HNnXJhs4QzmAVbU3mtw4Yx5RJ3w9SGbutz6Y8KgEvkJiPB
         zBsbM3ElRqayTNDUnW5adFjEaor7sNJIsOW4NE5aUhB8vrqUvY1YMHtPW+/NuSYtcQb5
         8xoJRnLcHS0C8Q38tNCKv5QQI3LNlm+PJG2yagyi7RrY/yMbaUqGisbfChD77DX6kS4H
         OqOg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6RzkFODeqVWFiza7jKBtWigooC49cCz4Ju+0BKs5OTYhtxflLVWLGSAOxjwILPrajkGryj489XgX/dB4=@vger.kernel.org
X-Gm-Message-State: AFuF++lL0++p40GKDOC/pCGl/MpFPzvT0sOMB9rrnLF7E/OROsAtwH8a
	w5TbEXQQEGsHIJdDAbs+IGTQiTiqPKS2SOoDHcyYNa1BFw9qf3n/oOfLkFtzZJ51
X-Gm-Gg: AR+sD10cP5SgDq3jqJU8ecRNDFwHchqZ/lz3JTKwVW9REd8MEva7MpaXCl6DQr2jPlU
	JIYyGfmH7RjAhQRtjCIS1HR6m59ED48eInfdTQGQOFLu5TOF8ndenrZTrxrM307zJNV+qiwNEJ7
	OBIJQHRLp288IMkLRkszrpjyGFk9ZvljVGBxJ9rFVDZubPVyJPdivty1sBBSflWmAXpjfz3ssA4
	dyx1JFL9Vu2u8dg6pHL7jxpNTVs/o9Nk+ut9xkUPA6YwZZWCy4heWVGzRB8F2QFuC8Y6fXe2cSt
	vtYrFfbf7JZWM4HyvFUJ4QGgNKXmlHQIgCuOGwrpb2xonKWNzT1ONj1/bWamdcC1gYyfpLTpdyJ
	xF8IDeb8NQRNOrytd66FjPzYp1/z/bOfRwZpIdzH4Fx0cZPOX1tbN0Lt9jLcak14ua3iQz3Cd3s
	jz8hpt/C7ZV94dXFCBpht5Za6bkpQW/zKxIolsAsscflPHuoUTBJVecGaFpMyCSn8iRfnTljDv0
	8eyKrAzsZuKXwpBS50cXqd9Vw==
X-Received: by 2002:a05:6820:4b92:b0:6b1:3d06:ae0b with SMTP id 006d021491bc7-6b37815525fmr3492312eaf.2.1788258180138;
        Tue, 01 Sep 2026 03:23:00 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com. [209.85.160.54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-468a0223cc4sm12315927fac.0.2026.09.01.03.22.59
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 03:22:59 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-46ad7304688so935008fac.0
        for <linux-serial@vger.kernel.org>; Tue, 01 Sep 2026 03:22:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoNK3RpGHl58tW+ABdX+eDPJXAYSF5ZN5OScmqWTul9FTDgvjAqNRP5qEFzVFDA2yBLmHA1KEWoRvgLQ9k=@vger.kernel.org
X-Received: by 2002:a05:6102:1a06:10b0:787:ebf8:77ad with SMTP id
 ada2fe7eead31-78a02a6eb7fmr955834137.18.1788257853731; Tue, 01 Sep 2026
 03:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830221129.2668354-1-julianbraha@gmail.com> <CAMuHMdWkPtJinDa10S_r7Pj2DTgcKpwgxt7U3tqm7fnSwGxm-Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWkPtJinDa10S_r7Pj2DTgcKpwgxt7U3tqm7fnSwGxm-Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 1 Sep 2026 12:17:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUywobKkt5Zozh3GdOW57nF_XhydJh7PaqTBoGB-2XvTQ@mail.gmail.com>
X-Gm-Features: AcwNN1XlRAlFl-Ap4ZBsvizrQPe_wtXEO1vr6JdvvpwQv8gi-7uGjhpumvEIf0U
Message-ID: <CAMuHMdUywobKkt5Zozh3GdOW57nF_XhydJh7PaqTBoGB-2XvTQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: fix extra output from savedefconfig on
 out-of-range defaults
To: Julian Braha <julianbraha@gmail.com>
Cc: nathan@kernel.org, nsc@kernel.org, xiang@kernel.org, chao@kernel.org, 
	zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com, 
	hongbohbli@tencent.com, guochunhai@vivo.com, michael.bommarito@gmail.com, 
	kees@kernel.org, vegard.nossum@oracle.com, sam@ravnborg.org, 
	u.kleine-koenig@pengutronix.de, mmarek@suse.cz, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, 
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Aug 2026 at 14:36, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, 31 Aug 2026 at 00:12, Julian Braha <julianbraha@gmail.com> wrote:
> > The Kconfig interpreter currently allows defaults that are outside of the
> > range bounds.
> >
> > In these cases, the 'sym_validate_range' function will adjust the default
> > value to the nearest range bound. For example, see this example:
> >
> >   config A
> >     int
> >     range 1 2
> >     default 16
> >
> > Here, since the default value of 16 is greater than the bounds, the
> > effective default value gets adjusted down to the upper bound, 2.
> >
> > However, 'savedefconfig' writes non-default values, and without being
>
> s/non-default/non-adjusted/?
>
> > aware of the automatic adjustment to the range bound, it would write: A=2
> >
> > This limitation is also documented in a comment: "The following fails to
> > handle the situation where a default value is further limited by the valid
> > range."
> >
> > To resolve this, let's factor out the default-range adjustment logic from
> > the existing 'sym_validate_range' function into its own
> > 'sym_get_near_range_bound' function for 'savedefconfig' to use too, so
> > that it compares against the effective value.
> >
> > Adds tests, accordingly.
> >
> > Fixes: 7cf3d73b4360 ("kconfig: add savedefconfig")
> > Assisted-by: Codex:gpt-5.6-sol
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Closes: https://lore.kernel.org/lkml/CAMuHMdVyUAA3L4mUkSjmnuE3cvj-+N8z-Bhxsh1wa-FQWc=fjw@mail.gmail.com/
> > Signed-off-by: Julian Braha <julianbraha@gmail.com>
>
> Thanks, this fixes the issue, and would let us revert commit
> ab74edaeb1ae7c71 ("erofs: Fix EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS
> default logic") in v7.3-rc1.
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

FTR, this will impact all defconfigs that restrict SERIAL_8250_NR_UARTS
to a value lower than 4:

    config SERIAL_8250_NR_UARTS
            int "Maximum number of 8250/16550 serial ports"
            depends on SERIAL_8250
            default "4"

    config SERIAL_8250_RUNTIME_UARTS
            int "Number of 8250/16550 serial ports to register at runtime"
            depends on SERIAL_8250
            range 0 SERIAL_8250_NR_UARTS
            default "4"

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
