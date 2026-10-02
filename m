Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445B23D28C
	for <linux-serial@vger.kernel.org>; Fri,  2 Oct 2026 02:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790906705; cv=pass; b=XQGA44emhKng3m76ivHgrC8+S6iVtRT2ggnC0CaEbN7d+H2rtK0pLm+h4o+GlkJv8EAr5Kk1fswgxX5pXQmEn5G1OvUHJblmIsf5BmhW+OxzO030+SZZqrg9C2zQvwQeLfQEm2ZAY2Svlcw8dQSoapDiBKAemuHCrDokoQOeFl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790906705; c=relaxed/simple;
	bh=Vefb40LfhWgTBUzEfWZInUgcHpDKSPrv/ywEarEYv6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gok8U9XJqSKhwAh2JKOWLxSljD68J2vUrFnjgJe/DJ8d6yMAP+UC8eXEh7c0Rf93CJr0EdxKC+qZV3yIwqdt1XwWY27RL3AfW5zAEIrUfu6cQ/twwDoXahdhTF4rdYA5Gmf7CkJz+OzbNPZWjD2tfaR5c4k1sRHHezvGFEZp4n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxXnMiLt; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxXnMiLt"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aaf10bf094so10479901a12.2
        for <linux-serial@vger.kernel.org>; Thu, 01 Oct 2026 19:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790906701; cv=none;
        d=google.com; s=arc-20260327;
        b=Fmlp8k8nFCLklUsOYRVcXPSOC8eypYOe/DS45MpoR+0A9Cc2iNc1QePRnLhZcbZi/s
         /ANVS9tuwwAedJhx/JifPL1rOzRmLJO892Woi2gydr73AN8878NtTTo16x2BP6HKoWah
         7zfArKgjmz9g5foWSiQpfPsrkmHrxlFTOORNzzjk++jVVXWmoD/sSfZUAUL9vCjjApZ1
         uY+w995TzzisxK44LNBs60aDjeiFdVMI+19uyon5ZfpYkiOwT2zqJxm+vialUfOe/YOA
         83ZEibbakYZ4sFOSmZ8Gmh8+PynWCaX+mOSHNstUIq1AZQAD+a0giOxmmdG1Shr3UV2W
         vgGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BNObIucQZt6XOuG/l142nh9+U24Ab7g3KvjwszYIWFQ=;
        fh=I9TJyBjjw9ggGxlxB/oPDngNLw4+LTI/FV2rK3h7xhc=;
        b=bhLKe4jTi5xC4fDNjMtkHss3DSDq7drXuCavd5RYaUd9A1Dc2t2BOfGg6j5/QstUhR
         FTZq1q2FpliS5WYxkQYZhMYXR/Oa173qNy6qi46/bZkLacL1l8fDPjdpPuYLz99IbQ7Z
         jXNaSTDnxkDnFLHmV9Vl/gWOdbRb8vTuBc3JrjGsVmPuAxWGQmgt54kJ956VsIXmAj6a
         nXf1CVCnyTpFB0cO1m34cI6/pw/QRj9t3MdVnI0TdX8XQoHBylA2mtdHcKQFNNgGWEMi
         AABnteOsHvkkGn3ewYuH/T4c5h3o05TVK7TMIVPHAgsCpeexIiGFRHBEQbcUjRZAkl4B
         sqEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790906701; x=1791511501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BNObIucQZt6XOuG/l142nh9+U24Ab7g3KvjwszYIWFQ=;
        b=jxXnMiLtvo9i2v1/1Xd+Uf7ZsvueyHqKovTGSxItK/k4JUBURYP3gIUxIm08o5TNoU
         j5OXFt/gb6t18f5oatne3aGQSaCkaFhntHvUeklKQhEjFj7CZbSblgEBUjGFU77lmRn2
         zja0g8odBtBnq2TfZLZCgTNEvHHlKaypXVvxjrkrZkbx9BMW/yP6hH/7+9zmwkX7OMsg
         qigJLai6c+kXfL1qdOhX/yTpwEBljvAVRxhO3GV+V8dEXJqnTeIh+rTx9sEnZ0xmcnuC
         CcDOnJyl16eOIChvUyKt4jvdaLcOx7Hdk+MW4e3rMLJdfLw9MNYqkPRRuB0SjGGTRC8I
         ZILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790906701; x=1791511501;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BNObIucQZt6XOuG/l142nh9+U24Ab7g3KvjwszYIWFQ=;
        b=kQVhTIZhSH4jYZ01Pig3dm6b1vTkrotcR2HzTBxNrpYxkXVOHB6pWyHWTpM6CxhKsJ
         XVRf0L9yLbZ8k+3riznuAFXX5iQBpHUNh+/bdRebuc6VwXJYbhOyStXa0w3FfbdIqEpp
         jM4benPUW8ns+dK0pCZhz2hOYJIdT7T6f2JE6yueVKzg+pR7wTp2fspCwTwWzriyqy1d
         KoK800tospdjimP6TDkTrHLvb/TCPTnhJypn6GZwyv0/Zz+K4aMmBIy62EunOqO5M2Gl
         0kMUjfZqihKN589Hy+PNFQoyBXekGXgvfo3Q9nkqaxznlb1MblrBac/1qJ8E6RJMJA+v
         /QYg==
X-Gm-Message-State: AFq9FYI0l0B+5gQb8yPLqLuYJ5TDiWfxuI58dzvIAsoR9EXjYZBoNnGp
	IQJhrwkP51BPeMTPa2Ii1zPQ9crTs99RFmGMT+AomCpKXH1Uxq9sDd0o46DKBoNxi9XAf6pV4r2
	lQ2i968Yxp+kwgJMO+bGaOwH+r9UG6Hs=
X-Gm-Gg: AYBFou3h7dVzSXzAlHymV2mR8UUig+u1Ph7hdxHu92ygZEbphm1gddrXbKhoZDwxbfO
	wYJD3HZbKfhK0VGpJdNNQmxs/7OnIz5GjqFvVPAAu9owFLYHGV1jVR0hpr/9Qb++5M8q4lvocmj
	kjgwRfjW2p/Rwdebv5/O4L5IkaQo4TMGH5PZv3aexQjXmEWIFmczhL0VdfKIsSlZgNMeJgYIpGV
	pCqynYOr/1k0mcHEOv1wH4dSsmB7rAiOET9OtNFA0NS9RqvwqI++rwguCRWER+wQ2rpfwQ1kGw4
	FJn8Xcd0EcFH6bYXV9Mf3/cNvv/U9PjvGWQ8PNhFTF52VjJXszhWvzW1uYJK5K8DMjc0jDSE0ja
	dNtXEhD9/TDQUx8KqmaNBl+Y/vT1keQEftj0MrhiC4bfsIDSFmrjlBvjW8OwVUGrDitY4NnjLHf
	sfr8a1N5d7M6xq9Ejgxf3S2sNo4+xsSWYNYs12Nc5Hdfqs22539Vwm3GVdwOI2qvXy3w==
X-Received: by 2002:a05:6402:3253:b0:6ae:1a0a:ae9b with SMTP id
 4fb4d7f45d1cf-6af9e2ddbadmr526637a12.25.1790906700698; Thu, 01 Oct 2026
 19:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927204317.21546-1-rosenp@gmail.com> <2026100132-geology-shingle-d005@gregkh>
In-Reply-To: <2026100132-geology-shingle-d005@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 1 Oct 2026 19:04:49 -0700
X-Gm-Features: AclHuK_Edka22cv7pAp_46c1jQz2-5jdqpjLkkUTPn-yUOquVWu1-dC2o2nF6g4
Message-ID: <CAKxU2N-_kZM9LF2s_1kwZ-0visnuCH9f7c3b8+iEeCH=RgK2QQ@mail.gmail.com>
Subject: Re: [PATCH v2] serial: ucc_uart: Use platform IRQ helper
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Timur Tabi <timur@kernel.org>, 
	Jiri Slaby <jirislaby@kernel.org>, 
	"open list:FREESCALE QUICC ENGINE UCC UART DRIVER" <linuxppc-dev@lists.ozlabs.org>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 1:45=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Sep 27, 2026 at 01:43:17PM -0700, Rosen Penev wrote:
> > Avoid calling irq_dispose_mapping() by letting the platform_device
> > machinery handle it. Also enable possibility of handling -EPROBE_DEFER
> > and other errors. Handle before any allocation or anything to avoid
> > dealing with gotos.
>
> I can't really parse this, what is the bug here that you are fixing?
>
> > Assisted-by: LLM
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: move platform_get_irq() earlier.
>
> Why?
this was reported by sashiko in v1:

[Severity: High]
If platform_get_irq() returns -EPROBE_DEFER here, does this leak the
asynchronous firmware load initiated by the preceding call to
soft_uart_init()?
>
> thanks,
>
> greg k-h
