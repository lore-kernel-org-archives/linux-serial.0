Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D783A6B79
	for <linux-serial@vger.kernel.org>; Sun,  3 May 2026 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777836367; cv=pass; b=IY5C/eji38WTguZa5IP+Q1agyTo2GkEYr6E4+oXCz+PQoY4JFLroOggvy3CVlbRbZx1jCC7kgc8dJB9KDq+xoxRPbccVcpbF9+EznrcspE6qSywu2060oK9bqsR3pZdgUGkf7BuYPwKSVFuwh7oFjwP32MTSGGOXhBb5O7M4+d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777836367; c=relaxed/simple;
	bh=XG8UmKg83pU3wa46ae11h8XQSd0IMy9ZOQoi4a221jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBJyc/qHcMaMXhpvNn7t6ad23iPBiY5IxFzf1r+f+T7XE0Vv7v+aLOMsawQ3FMkxCaCAebFzXt1VGhyoDp8ugKPvNNTVT3Bt9UFjxjzQfuWMjRizafJZJVtngWuGwaqcszv1ca2K0GM65DAG3P7xeVxNsqjSIqBFveOP5WG1eDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpAhrsiN; arc=pass smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpAhrsiN"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-50faeb8317bso26186211cf.2
        for <linux-serial@vger.kernel.org>; Sun, 03 May 2026 12:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777836365; cv=none;
        d=google.com; s=arc-20240605;
        b=SEbSTiYM5NVBNBtQHhCnR0DTHl5xpOJBUavNHtUpA1N+65St2U3Bm/gm4u08piHzTj
         VQlM3UdY1dfCJatPP56A5Acr5QK/Pe4bkzIhc+p2/r8SX4D2hrj63QEEClgMU5rgh/4x
         IqfX1FjCZwCeDAuZcAey5IHJFQ1yHe6qjoHdh0JJXOYkTaydRqmz+vL7pfDVe76mFtmY
         bguLrLQo9qhW0YWFIcysKrTh01RR1p6UFVQiPaN5FRQ+IgkZ7O4adnNsK+wmceieHqpi
         z+2vTReCL9gDI2xd+upB4xw5rk3YWoG6PwsX/WKVHHy2iLvcYpdYQCHKHoiZtx9mizrd
         RhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XG8UmKg83pU3wa46ae11h8XQSd0IMy9ZOQoi4a221jo=;
        fh=j/tvHOkeoG8hp9mgKq0DSvIGb02ioIJIp65T7sZQWNQ=;
        b=ZUye+weS528xDx1W5RmKLYTz+FiLlwAUL6bpluV8jJgORtohP6B9TP92jLc409ejgd
         uNjOhEOuiyVe9cZnr4TwL8Kc8ve41dm0lfreahDIXprOhThm/HbRi+xXBfSjZBXpcWy1
         dsoZOaVCgKzcQJLsW/ibk5PlWqzaw1y0PoR7Ndkfdo7qFVJZd4T+G0HUOJMRFa3rbM7g
         uVg/BbNvdl3Mk8zgVrWyL4r3rGSVI03uI35j7mF9SgnOewFY9pKcq/zbRL6x55vFyUQD
         SI4gcgRIfTKLkIl84h7sWXayKXSBkxRYNyOziC+4G+zGpTNShMFyXHhHgPNcLLq8D01X
         wiNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777836365; x=1778441165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XG8UmKg83pU3wa46ae11h8XQSd0IMy9ZOQoi4a221jo=;
        b=TpAhrsiN1w4MuUK/KvhoDfwpfknywP/TchZIP7VXEZlnXDUtXU2XHf3VVLtqVTdpHa
         60XqD8a0azjGaFiM5UunFpakszAQM+DNoShaQgLHdnVadbULFDu2vwbw7SASACzD19y5
         Wj47b+C9UDD+jLni9eCF0iLIXMbCHZSwK875B71D385SJqAV12dHooJzlwyv+xhqH+3J
         5byLzcj0LJ+3ygOtXEVCCwv5qoIT2a8A7x/VQwtY9YUvt9S0ge5pNxwARlWGRBKUBZ8Z
         mW0JkKuW5rAkAJx1O60fg8j0atdcwf5IHh9jW/omh1JkHBVt4Inx70wUn6b5m6HuXisE
         uUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777836365; x=1778441165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XG8UmKg83pU3wa46ae11h8XQSd0IMy9ZOQoi4a221jo=;
        b=enQ069c8mtGsZalpRUjn8xy9b+aW2vMsjVXzcKatJ8UE+dE0/xeMv2UyFVZv6NigNJ
         CEwud+tZJVZRIMjJlTKAQL9AojU04QRhzDh0195i5lAUCn6Qv8thD7vmwBRKOVgw/BWO
         lox1zpnpnrlP08ln/RFqlJeRACQ63Ia6U35K3wNQyP95mB0+5CiuT0ACOGQ3FDn+lOw0
         QWeUcH9/FGZshTzuVmd5XEGNYaaFtetw/Gejj/ZJ5OPBhG7FEDdzq+dwtArSvSOU0r0u
         JoQ60FctSkD1Dd0ogUtMMS/iBmvdjHqZAVybWRIFHpSznyVggo1ByzlswMdML9MKCcmt
         SRKA==
X-Forwarded-Encrypted: i=1; AFNElJ84O+ySI447ar849dJJQxC/Q7J3mkQZHhZzcihk3X72K/veO+XF5L9GsypBAj2pyalUM0Jn6/3LAuFOIaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ttRrba2yWNF+pOaM3zCgcs5UX6D40Kjmm9gYeLznVslIsd30
	NCZ25f+8Mlkp+iUDnbyixLGBmft+fAeL//RQGWSO4UK+z+5iKxCjXO8+neRbCTy7NqPjNAQYR47
	SgOZlLvBWItIALaveODkRhEkO5RutA5JL5m0Q
X-Gm-Gg: AeBDietPNIXjT5x+9Do9+1UNcTlg8R1XqS4xkM1KWgN1ZVYIOcEwHKzvTyQdwga0Qs9
	56OSyyhTH6lgd1akFlpOah6HjjpAk3ekZqYIzFrMj2+jX35+B/pF9BzM7tEt7t9mM/WCkIcsZg0
	Snbn0NMd8ktTxdIIYjJoV5LWFA86hibJeFJKsDLwqG/2CZ1QrQigRhK2YmHupMCI2YKfov7/M5L
	TWQhNuJTUaJOK05YFdijBNWwVxq2C/sC6i1qeimrycbpXxayuovMAOdnd+9GTKUbVnQqKe6yqMu
	niQZqGhf/ROTD27bNovp6Kh2SebrcEI2Td4EwNjilTRJfzrbAVQlWkn1AaaUP4WGmwZDGWfL8DI
	QRzWa
X-Received: by 2002:a05:622a:30a:b0:50e:5fe2:83aa with SMTP id
 d75a77b69052e-5104bdf1496mr111994061cf.12.1777836364623; Sun, 03 May 2026
 12:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503030801.14080-1-enelsonmoore@gmail.com>
 <2026050340-kilogram-prissy-a833@gregkh> <CADkSEUgPtjkKC684O3qB=koKDPwJoUj-qU_4Z_18NAU_+bBqkw@mail.gmail.com>
 <e12da6e2-5e50-4819-a5a8-2bc675da4c14@lunn.ch>
In-Reply-To: <e12da6e2-5e50-4819-a5a8-2bc675da4c14@lunn.ch>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sun, 3 May 2026 12:25:53 -0700
X-Gm-Features: AVHnY4Kt5s_1C8ObOd9tow1DeOBNsioFkEIF5beY5wz6dDacfl0-oSTa2HpU6_E
Message-ID: <CADkSEUiusP8WjOAPTZjAexu1hMukWugXow45hzvfFOYvO2bg9A@mail.gmail.com>
Subject: Re: [PATCH v2] tty: synclink_gt: remove broken driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-serial@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Haren Myneni <haren@linux.ibm.com>, Eric Biggers <ebiggers@kernel.org>, 
	Qingfang Deng <qingfang.deng@linux.dev>, Julian Braha <julianbraha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Andrew,

On Sun, May 3, 2026 at 7:23=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
> Sounds like a whack a mole problem. I assume the recent removal of ATM
> broke it as well? Maybe __has_include() could be used?
That's a great idea. I will investigate that.

Ethan
