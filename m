Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793454311;
	b=cO/ArGBiI3kKpTMbHfMCrDN8TUIg1dK64OVwNTRKNISekbdod941pJ1ap6PfT18plweJ
	 Xj7bpIo+tPdzZxiomyAhyyWbRtfdvm2wd8oQUj+nHK5uBGjH2VUalzjj4hl/NgP7rPbkO
	 0IpcTRWh4HOJwnxv180JUkEheJB5WGqZha2SaL0RvmAMjnIKiiv6lmwEU95Elq4A6mgOw
	 0EWggnGe0O30oe1JMBFEodDBaCriWTLpOzRiPyVKE+DtYTLNiC3tXij6QPyurEl5Itt2l
	 L0XYSmjIBx4GnSwyH70OoJf+Ax9qQBn6mHlbo4dfYv7RFNEZqR1tUw+98pyDQ0uiY1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ydiuw2JFoGviRXfS/1qoEyS58uTjOZNZXXzHRdS4SA8=;
	b=LvygBNSiEF1daqvYiVE7ffdhtcRy15y/N5WF/XT+0gwJxuWfCsQ0sPzu98VPcF0gJurn
	 UVI6dbNkbt/MhcX+DZFFBwRzdZCijgwbnWw9OwuYCCyTE0pwkAoFwizmZH9uhV2rzfRZn
	 mlD6GaoxQUcmS1+Pu+zEDwr7P+++gMAmHYfGTqEptsFPj4uczJMLxIfuz9tx0774W6kR7
	 k1l9TBC19OLUIao0HJLMP9jyKkYLSZvdp59/7SZrUSMn/bG5mYCAn0XnIYc009fREJRU2
	 8Ni/ad9kFNb4w/wFLN64fQBus6JPG0qSaeaXP9p1vqlbrYLFzFaWV6zgDC5AlOQ0VVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h1CbNOxg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78862606A322
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 13:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78862606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h1CbNOxg
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so2769594a12.0
        for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 06:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793454310; cv=none;
        d=google.com; s=arc-20260327;
        b=TYzqSIBfZlAmfsqvxhsit1eZonPI6fJO5t3WCu6xtomjXkJnTESlJOL4FzyVg4yozr
         02Xe6o+retKa6NIjNLuXjOdYU4u47D0hhUa6NJr88bjdV0hec3tUsF2zQ4r4v6TZ2Gtr
         J12DkLwrfYsilGr4WUAM3OmQzaOW0yX2tWP4BFJo47Hiy4icCb6pZpkoqMovNdgRTgdV
         k6RAa66aiIEKWq4EY1I1yRd4Dj/VX5KcuQBmq5LbBK8UlPJvZrC5X+ZPuTQIEiBOfrKe
         0wpskIyJptpvEZg2RjAbrsmpwrYrHz3OavztzJYmYuHKGrfG410RWjqo9APDnwR8DyQv
         8+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ydiuw2JFoGviRXfS/1qoEyS58uTjOZNZXXzHRdS4SA8=;
        fh=0IwuiAMFvtqV8KygOTO71K4ukQje2AZSJCxqfpK6A6A=;
        b=YT7nwAxS/aaoIfRBVqTc3FOo0Y+mekj7RPC1lFcUNlkE+0KuI8G0CuduOiKd47Cym6
         24bXygFz+xlLxV/ocZlMoKFFIOdQ8z9n8A/ohqoz/fqDqCcuqCPEhaLptbjn8uU5A19T
         KARecEWYlh0GnLyhDvZ7PByi87X0ABZWS5NyBr+yxXTz6TpCckGalJ7WGSSnKh0kzjbd
         7XY+/SVzUdaMIqRBz6eBMO8bxs59XLTiKxABpyrHS1w3v8NlQHnLu2IinQsfMRY4vlCP
         Tp2ktP9muaUE4TOsS4WIQGBniwGPVEV21FoaCpUcuYo6POVPR36A60UL+s20HtN+FmTa
         Z6Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793454310; x=1794059110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ydiuw2JFoGviRXfS/1qoEyS58uTjOZNZXXzHRdS4SA8=;
        b=h1CbNOxgyw+hpQJtd6f107k9Jr7eTRpY7s5wNEukKTRX8dgBrYA2wfAwECF6uhHUv8
         TK63MbmgAkGBNAFJ7zK9KiFGeYc3oKVgxY0GSsOWP7Jp5lwDBrHaH/ByaDt2vSYCYV8N
         dfRQEsJyZAMTGK7AkPvr3rQIpQrAx4vjyMQTzLLld8ZS938SHHZNYV06dqi61zv+L9BO
         1tqUzMtkBSLucnsaI8ncxcGWacThWVI/LZPgAHBaig5AzOaJcb7MOR8KIJjpMxEH9Bao
         5ARS15jFwp9Ol8YnJOo+atsdimimrpeg6er+oZ5pRvMKEoEezrfoNqWszIeXEnLaGhE4
         3iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793454310; x=1794059110;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ydiuw2JFoGviRXfS/1qoEyS58uTjOZNZXXzHRdS4SA8=;
        b=XLaPeYOHZLFT8qyF9edb/gw7SEt7ceUlGN3UCnjxqn9z2bXwPgPNs7pHXviX8Zn6WX
         1KPi+P5Q0f0xTIPuTgFzzczAP9TI176C0/j/xM70tQ8a/J4n+Hw1YL9QDS5FHkkIQyUG
         uCyjQrekbFAvXwBOCq6kz7dlP4ki+Zh9wgqFOwSmZyZXWI5oXiOryuUnm6fA98DqXM6g
         5W41DyCyyPYY8IWzevnmRpuL3SN/83yPM/nJtYcRwuMXIibuZ84fN5UzWadVkwVqQh4n
         3v+o7ul7kTdPCnpZ/4TmDMX1SGqr7Qs3n1YdJ2cz4elzt4SqV+NOnVk+fUo9y8LtFAQb
         /HVA==
X-Forwarded-Encrypted: i=1; AKwUvBwnXE5HSH4lGj58PpCRPdiTtYqPLHzBUIoYdBdoEHwd3J8dpj97+JqG7Q2smCV6k5J+5Dc+rYnutjBZlic=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFSDipdbbu21HF5mtATtXUdEDuediuKvdXdscONN3E2uam1iG2
	kyaI4WnmjCQbmJEtN11+A9J7qgFkVntE+wM2KUGMhNJvGG1IT4D6Vmey6KPQ3q7YLtgLMwocXRN
	LiQWycYh/lNen+SoJMNkDxAT6AXCqmFU=
X-Gm-Gg: AYBFou36i0wo2XFZQHZH8fZMxD8qyBk3Hid1l2MS5tkJitPNF7355hFSqekIL+KaH3e
	BspzmeAXUv107uDL8FvQ3Ui6qQsaPnAmMHvJW/EMwDDRowHRB5SOC1w11skPjAt3rvNLU8TJYQy
	NydHVbZf29laXk5o90sH4aBpalmP8ZP3kyUFdJwWwn8Xo5ggBeZI8mkCf7vhKfcDAhVlpazh8Om
	YQW6dtSELFE8AdZ4vgP+Mct8pVEQH2s6v6PhTH4kLDFvibHUaoANsdcIDUI28pgyYvZCITUW1l/
	zGW+fsGSBsuBV1Nw34TfnkGZ4qCGnhWYZamQDSg0eqnn07ewBk8K305nNJppSshkEg/aUHXuzKq
	NGmqDeWT9OK2WgJ3P3sBYeoRzqpvCseKTVNPAm/jrai38rkxx2p/RJQppPWgK9oyx3BWy/iU=
X-Received: by 2002:a05:6402:1ecc:b0:6b3:d0e9:2e87 with SMTP id
 4fb4d7f45d1cf-6b4ee0e1f24mr1392387a12.5.1793454309714; Sat, 31 Oct 2026
 06:45:09 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031005425.3351240-1-samarth.colleges@gmail.com>
 <20261031123749.3783352-1-samarth.colleges@gmail.com> <2026103143-alienate-subduing-50f6@gregkh>
In-Reply-To: <2026103143-alienate-subduing-50f6@gregkh>
From: Samarth Narang <samarth.colleges@gmail.com>
Date: Sat, 31 Oct 2026 09:44:58 -0400
X-Gm-Features: AclHuK_UZoL4ALbG8OiocStKAY43wgTppT1vPowuPmaCkqxwveQ1ulzoHGIddAk
Message-ID: <CAAbz3fR3DxTL66-0MJVsoWq5-FhypwdDn6=A5iyLUKY_LyOD0A@mail.gmail.com>
Subject: Re: [PATCH 0/2] serial: keep the flushed TX buffer mapped until DMA
 has stopped
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Greg, I will address the findings Sashiko found, would
appreciate someone with hardware giving a stamp of approval!

On Sat, Oct 31, 2026 at 9:00=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Oct 31, 2026 at 12:37:47PM +0000, Samarth Narang wrote:
> > This series addresses the DMA buffer lifetime issues in amba-pl011 and
> > fsl_lpuart reported in the parent thread, where flush_buffer() unmaps
> > the TX buffer before the terminated DMA transfer is guaranteed to have
> > stopped accessing it. In fsl_lpuart, the buffer is unmapped even before
> > termination is requested.
> >
> > Since flush_buffer() runs under the port lock and cannot wait for DMA
> > termination, both patches request termination while holding the lock an=
d
> > defer unmapping to a work item that first calls dmaengine_synchronize()=
.
> > The TX completion callback leaves the cleanup of flushed transfers to
> > this work item, while shutdown, and suspend in the case of fsl_lpuart,
> > waits for the work to finish before releasing the TX DMA state.
> >
> > Both patches have only been compile-tested with arm64 defconfig, the
> > relevant drivers enabled, and W=3D1, with no new warnings. I do not hav=
e
> > access to PL011 or LPUART hardware with DMA support, so testing by
> > someone with suitable hardware would be appreciated.
> >
> > The imx driver also needs a fix for the issue reported in the same
> > thread, but requires a different approach because its TX completion
> > callback unmaps the scatterlist unconditionally. I will send that patch
> > separately.
>
> Again, these need to be tested on real hardware.  Not to mention the
> bugs that sashiko just found in the changes as well.
>
> thanks,
>
> greg k-h
