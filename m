Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3F1F2C3F
	for <linux-serial@vger.kernel.org>; Tue,  7 Jan 2025 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736275460; cv=none; b=l/+CaIDn7aN/iINzEwEzz+yA3PtSkiwMPOWnC/sCbOYk5l7L8eu2J912HooIL+cRQBt26LYbS+K1GxVudcXsA9qNWpQejTm4p3WOD89OtD/EMpn93BUxr1LDuY6rzm2fyJJu7cKnTlXjmuruai6Zyp/xuVZocl18MQK+ttZzoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736275460; c=relaxed/simple;
	bh=AGviw0PLsu9vjRd0NMCzhM8dO4g6S5/ef5N2/qHLv+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=argMfDz8ezprbWjiLDaHxZufTU2pkUxphCDGOmE1G+v7S2QPyFSqDMI0Mmhtfu3KawZzSel+yQmOPeH9japhX7bOjL2lV1n53EzvF5Wv9/N/XbkXRBbke8TmM970aOMFrOL2uJ0ocTu6nZmRkPZ9QxSZ2afFcsLV8quGJAooi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neJVXlG2; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neJVXlG2"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso20126816a12.0
        for <linux-serial@vger.kernel.org>; Tue, 07 Jan 2025 10:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736275456; x=1736880256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=47z0M6d1hPFACGzgXiKiV62MefXPpyqmUCoKbKVNZfE=;
        b=neJVXlG2oX1tnSSIXs3t/5m2XUMBpqhQ5ju9tAaEpWz6ycS1vB4HVSf9e11J2VCJBx
         MTSwh7l7hTGGFhEASiJ1o+leuCjrN9GqIL7CyvhhSQqDxphDxatnc/PMvGfloVzz39F5
         must7+J27ylpic5i+v+R+3kKXKi7twUxb0j/1pPwYw8ZhxgIK/FBY+xNj37iQ4HKCbyF
         VctvVo2i5nd0AFBcvauWB9P8vftJ9Ps+0SXGdHHsH9rTW03M/qWoDR0R3VvhUfROxxdQ
         yaKF3JkSRSlPYGz9p+8SM2fJikY6c/lGx+3NA5ZCrhiqHwbsMnIC1vgGD5dAW5C6iF+/
         oZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736275456; x=1736880256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47z0M6d1hPFACGzgXiKiV62MefXPpyqmUCoKbKVNZfE=;
        b=N7gPBXBEcDWat6mpi2zlZuFbLUdCyYM4YOVn3tMYyeDVmS2MB3UOuZuRs98BlyO1rm
         zhdt8c2Ns84L5H2SI61GKzJJGQi2xvk4R7YLbe4GK6hm57U9ldQasOl3exc/Jvgaexu2
         dbWSYkyRQVbMFczCXkEhGbeBMkXH3OlXPUF5kB47v8XhaOu873cE2+sXaxjNZeHcCx+c
         8p9YWGtSiWxSJJ4dy8XEINZ4WEbKJW+bIGXVvIAYXYiVHZk/j6XmvU4CHtVJE0mYee8d
         jJXctkppy94wjj9BhN3bs0V8+Xd3Itr0PSzD2j4y82R15NAEb6zfXYftPMc3MGA0xbLG
         xcBA==
X-Gm-Message-State: AOJu0Yy3JrFVjp7MJ9f5hpWKMdBExyloBwQFgVSQVc2cB27YPG94No+8
	Iuljup+7VIVS7umJB/g63CH/aqbZyQbeuBQrP2+sO8kpuU8By3p35A0vgg6HgGBAofiwQMKblC4
	Cj4gP98F/7Q34rfMCiiTfW5fGNEOX
X-Gm-Gg: ASbGncuhEe/lWNRNP0+1RPFKyRg0INNz2ls7eB5TFyG1/rJ80Ngk7/U+n+AeFNExHj8
	lGVhDbF845X4GZIHJhU1Lw3Pkwr39R0dB0AU=
X-Google-Smtp-Source: AGHT+IEHFEjz+eSgfDabQ0FO/hLk2BcTBuwiR8teXPS3oQnCx9HhvkytaBPZr7MKLtLa4YahxDzJshDGOYtGRd4/lfw=
X-Received: by 2002:a17:906:6a27:b0:aa6:9fad:3c1d with SMTP id
 a640c23a62f3a-aac3464881amr4546197166b.39.1736275456422; Tue, 07 Jan 2025
 10:44:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2-hcJVhxubEsRciMSrp2x4WyDrmmYNe0Db9-LzXkiRpBQ0iQ@mail.gmail.com>
 <2025010732-creation-confound-d3fa@gregkh>
In-Reply-To: <2025010732-creation-confound-d3fa@gregkh>
From: =?UTF-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Date: Tue, 7 Jan 2025 19:44:04 +0100
X-Gm-Features: AbW1kvYkzxSDFZwlqD-zVIQmucfDn1TkHbbzX39NZg9St8RHR8QRtzuSy5mpqCM
Message-ID: <CAH2-hc+8zLj=4Veb9j-ftGG_3Fc9nGZth2z6ogD89wryaMXPww@mail.gmail.com>
Subject: Re: Precise timing in ldisc? tty_put_char() in hrtimer context?
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Use a different protocol or hardware implementation as having to be
> forced to ensure that UART flows actually work that fast is going to be
> very difficult for you to guarantee.  Just think, how do you know that
> once the UART gets your byte, that it will not just sit around and wait
> before it actually sends it out (hint, there is no such guarantee).

Thing is the timings are tunable and protocol is tolerant to message loss.
Tighter timings give me better latency, but higher loss. So it's about
tradeoffs and finding the sweetspot.

Actually i've already implemented this in userspace using N_TTY and it works.
But i am experimenting with the timings and i would like to see how tight
i can get by implementing this as custom ldsic instead of using N_TTY ldisc.
Just trying to squeeze couple extra microseconds out of this.

Originally this was running on microcontrollers and since those run realtime OS,
i was easily able to achieve 10x lower latency than with N_TTY.
I don't expect Linux with usb-serial dongle to perform same as realtime OS
with integrated UART peripheral, but i am pretty sure i can get to being
5x slower instead of 10x slower when compared to uC...

I am not very experienced with interrupt contexts of high precision timers
and similar stuff, so i would be happy to learn how to handle such
situations in general. Not just for sake of this experiment i am doing.

T.
