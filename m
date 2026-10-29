Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.200
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793260391;
	b=ZhpRvmdEmA7VmFMYx/H+lxGZRt3mYxSdfhWdE4wlK9OHtKsZd7/v1TTdve8HiV2bZ/5C
	 hjUlPJEqMD7KunGYnVXym38zvTgPwiH2Oet33gVMBK0fNl/vraxyjdqU4WUBDqxqXQRP+
	 rmHLQi1KYbcIY76gh8UFoWxcCenzC71JbEkoK+GtywnNmbE/9d44Zdgl3+QTw+kDd7MDE
	 tlZ3VoOLeGoDU4VyGTgu142YmW0u4+FZxVmlt6sz/TwRhdx83dHfd9v2+yNMh/k42cvWU
	 oJ7SsvzZ/O4TUQmIgYa4Bb3KccMzGSodZb0vM5y6YrTLlF673VSmBdGmoQcvbpbmoFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=kUc17Gyf3nvifNnB1KWpHD2qqumkD79iYmF/XwTcUzk=;
	b=P3KjVL7E63QZcbm+++wDPgKUhzBNh7v6+1KXPqF0xCYR2dxOZuMmYjP5ff+sBea5bWcn
	 pxYnEWwkrJlL5ueT3IguheIvD0ClCCrLskYaoEyVUZRGSTaPMK6uYdAg8bWvxROh6jhlV
	 LhhXyuP3Yf6rN2v70sUi6Gs1pJ8bSKT5lFnfsTUkkUVJ/+JzgkwQRxfizZ0dI8KIqoC8c
	 ej53IqzBm/T25kby5HGUbG4RhHUMBeGlDJIJ1itT8U35FeBpkuqQzk1Gwtb2LHD2oQPbj
	 GhmBS/V8Bwvgj83g8XwmIdboT19MooPYH5+0Jo8Zq9YfE0vXq2nwaxn+QLv2xJIoqtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mml8OJiu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.200
Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79345606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 07:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79345606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mml8OJiu
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-5187c752f46so810880b6e.1
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 00:53:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793260390; cv=none;
        d=google.com; s=arc-20260327;
        b=itiYc4CnN98M/7zi5FOaZhlc42jUctOAN3hzPuah/GAuAJVgTEIcBvQGekmVUw8ZAX
         AK8m8bFhf5aj0z10iEJzgvUbh4cBN4F0XgRCDC2BBXV3QAcnL0Dz5bCl2b0cNWMQOD5x
         ZsY0XFP0IfxwSQg5vrGHkIyfiPSUs7Q5snbZ5Kd0zfzIsaLXJfJaEFCeZynWMgP2PC4K
         RaPv0smwWTWERPArEodsXRlsRRWr4vi2VrstW8aEOFQhHKMyDEd3cwUhsQ5E3dz+Atsq
         fxLGbDJ/nCQrZwqWpNnBNjHqMlXg7xofbsONYqELOp233pbzX98F/ce4CA2qOKU+Os/Z
         PIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kUc17Gyf3nvifNnB1KWpHD2qqumkD79iYmF/XwTcUzk=;
        fh=xVpdNYd318p56AjVGTKvmYLfBHu5QZRQ9untIUf/6AM=;
        b=TCY8Vj7+uESdzm9AwayKgGA3cu/56+UlCVoBVkOeGdQpWVYghgBZlEbW+b8M+iuPvq
         SL7EwzeTQrIGhw15Tfqs4YMLGF6huaJG6CqDPF+qzkvn0Mx2v8eT/8rmpYfkLxUaUSVm
         vEXFGpdGiLkYBze+nAy4MGyoMUXwxwh/Aw3XI7moux804TNdlsRv4Ygl1oWSmkrcfLN0
         8uueBk3q4+DHmF1rjsorWMuFWvClVQyih5apPbTh+kOUR7QrLq3g1d9icym5w/4Roza8
         L8DZ2OHE2fkb2QEwuKAkKE2rbOvgl1E+6QuDbpCmZ+JLgHIc5IieeUBOJTcUG1RtCNcN
         rArQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793260390; x=1793865190; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kUc17Gyf3nvifNnB1KWpHD2qqumkD79iYmF/XwTcUzk=;
        b=mml8OJiuTmVOXInxSBsTu3NToV8noLYGsPtTfZHP0vaDh3gz0bd0TFs81P27gH5O9O
         QPB9BaBvPWExsZEkTvysVmwlbl/tXiLLSGtxJN2k1BslC5QwcNLCet8P0Ttbf2K9R59w
         JC446ZKD0o3BMscpP4MZmJ3R6K+tm2viSMEAIAJLw849Xrb8ORrQ8ssI21h0Ol7vdk1a
         B3OEZQWBLtf/0ej8asKTmp84TaesJWhbzflfjs+Osf3Bio+PaLab/9/IFBnLIb8dM79V
         4lMG7iuxM4+Wb4iLujg5jy0MRqhQDMKu/joYpQ5/cW71Ks0i/JWsz0injqpUWxfFXllI
         +OXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793260390; x=1793865190;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kUc17Gyf3nvifNnB1KWpHD2qqumkD79iYmF/XwTcUzk=;
        b=vGWDz5LRzK3gtap7S4YSV71AwwvwosQSssR/R+zaTHlpvgccy2qXf2lVZ9HkNHJvib
         bMURNfsxcJwr0cZqCCksnjtWzCwlK1WLKjyoL/HUGChpEskWOpUxlDdBl3ZMOYlOm4Su
         6LNFvOYW9hwJEfZvABwDUoEtchlg2kGFBfhCGM7EeyiKYXIH6rkW4I8yUPTXCrWmWL4H
         9nag3EzATb9CDpl0WMRzcVOothNykikMRRk4U6g4iemL6+p+3oogKUaCJc+FyFbqGdxp
         NSWFXOTIyfMrYnI/5jIf3YdN8Bg8Ssw5Nc5Ojy/1ebeqQkE4roHwvVhq8WVwfHD3ASC9
         BVsg==
X-Forwarded-Encrypted: i=1; AKwUvBwdVVtYoIxL0sHXR2t+9oqWu3gffx3o+Dgn1Z2OysKetoub+N8gFLT/RZoUaLUDUDBTU5BM6H1EthPPlh4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJn2dx9XAA4NgSf+8EvBF7nNAzxoo/sdLymMvdY34qDrDF5wL6b
	Kukldlsb+lCstKdNakFyvQVgt4DAm4bzAnn44G2gJ5AqGhi2Zo+DQH2beLv2u15NgFeESc4mEnK
	HbQ+bHrELZW/CIVFKY4aXlESddHjcF34oulTOWn3c/w==
X-Gm-Gg: AYBFou15CcN4ijZBQpcxAEKkCvlT+s4nGucp+4OjZI8yzjihZ5jrzRE9uBEqxoMTj7v
	qncZtZ+4LH1g+B8YI2fjQ9LS55n6fkSR1ArxYHG5FHmaKogoIacFs/VPyM2l3IWGKdM+EerC13o
	qFd778slbzf7biMmldNaJSnIuHrYNKI76Lr0tCCNGfHa5rHU3dwO+QiNoNKxRgszBwWkFUu+ISo
	a83VoxXuPxtojaIHKV+NXJYZTq2wGN/W9DAWFGBPAYNf5huZ2/ih2WRZpGFswMLlBR0uN7DuaBK
	RdTeV+5d4avpX3mLBpwV33BPO+drOeSV0xNq2ttaQsHSVMVr/NJumTuZ6lW9bNxZray5lidP9qx
	u664We5H/1NsDB3nOAyqOuHX3oyydSzWgJ6T6VfrIDxPfNvN9y8dXZJ4RtUtCmcNrZ4qPlio=
X-Received: by 2002:a05:6808:23c2:b0:4fc:3dc7:66af with SMTP id
 5614622812f47-56383482f5amr2991341b6e.10.1793260390312; Thu, 29 Oct 2026
 00:53:10 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029002052.54117-1-dennylin0707@gmail.com>
 <2026102957-suitable-gesture-be83@gregkh> <CAGEkeHft5gqu1Kq0saC1O0hg+ZE9AEO1tOgeXmd-g10uk2obgQ@mail.gmail.com>
 <2026102930-underwire-manmade-8083@gregkh>
In-Reply-To: <2026102930-underwire-manmade-8083@gregkh>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Thu, 29 Oct 2026 00:52:59 -0700
X-Gm-Features: AclHuK8eIF8y_uq-0haaIwCtaPGzrYPOasOKqF8SErkDCEeB0RjNpkjMoQKSoxE
Message-ID: <CAGEkeHfTRiRmb-SpLUZeBkUrmRmq-bHLhD=CWnqsrvpbnymuYQ@mail.gmail.com>
Subject: Re: [PATCH] tty: n_tty: convert the full VTIME interval to jiffies
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Ok, and has it ever reported problems with this rounding error?  This is
> very old code, changing it needs to be done only if an issue is actually
> noticed as it might be relied on, right?

I don't have a report from users of those systems. I found this by
inspection and reproduced the early timeout using PTYs under QEMU.

For comparison, FreeBSD's original VMIN/VTIME code keeps the timeout
in microseconds and rounds the remaining interval up when
converting to ticks:
https://github.com/freebsd/freebsd-src/commit/d32198f15b39a0f6dc29229ba4925d67d136956e

I understand that this doesn't rule out applications depending on the
existing Linux timing. Would you consider the conversion correction
worthwhile on that basis?

Thanks,
Hungyu
