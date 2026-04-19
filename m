Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8619D4A23
	for <linux-serial@vger.kernel.org>; Sun, 19 Apr 2026 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776587419; cv=none; b=TY42jpC2RShUwwKgNdPs/5F89Bjm4noTksM6x4NUQxBRb0sByR+sFpjTko2ll97SeHZTm/tXBl/s2FbmlTSmE+Apy50ss25iPIdLcQmV5L6Wx0KDEW7kdXhoy92EFibgy66O08XopfoyR+fDooxDJL01G9OU2fRZRKImyCUAHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776587419; c=relaxed/simple;
	bh=qtKOfm/PzOwBHxZdRJEmVpIhLYPKyAT3yRn4rvKbC8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HY67FBD6k/zWpQQiQe5QY92/5h4PvsBvm33TIyIbB2+oU+xjM9+DEfOpBnjeVCngXYlQudUEiay/G84Xj+hseGc0rwrYC+JtwZ7bJIFapGvU1rNaiyJ0UfIrOFCTxwn9DYlh2MB5kEC/pDae6433G8kMJeT27DDT8u12/96lRDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFRV053y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFRV053y"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48374014a77so25378635e9.3
        for <linux-serial@vger.kernel.org>; Sun, 19 Apr 2026 01:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776587416; x=1777192216; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XwKzTLRiHs5eANohxZZBlyVS97g8sNagXG2LtuYayk8=;
        b=OFRV053ybFwzWyLwga4u3ftRg0Kra8PG5tIhsnYxwUWprFtoOKuRq2FmXtpbs3h0/R
         7n1lXk0KC0WqDzXSMFV/HVJkNwBcKewkGkCDAKyClaaZFl5EjMZQnsT6PaNRB3/blwbg
         Zp/awDPhssDocF4/ZBHegbZuP27hfVnNQcHWjPTypt+CLjrWMnHVoKd2qZk5YzdQj8tz
         g7xQ5txdhAAFQnCj6E+LK/D7Xc4GKT3Eh+6WK37JZ6fsKytfrloNcgdSiFQZBbVT0Niq
         AvGf5ycUqbcfmZnpcvsMFJMoZRFLYSWWEDw9SrJZ7o/9ikE03AUGndANg4mFZX7kppgK
         6SEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776587416; x=1777192216;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwKzTLRiHs5eANohxZZBlyVS97g8sNagXG2LtuYayk8=;
        b=n3K2vOgKO9rHbuLOFRMivDRqQe7ZVxIzk2ZD8vNRqheap26OtdGw/dljwdly7JAy/r
         G5t16XXlArxOCPVyld0RfaRb8M52spQohmL4wKuSFpZpwr3mKAbR2Tj73yzliS0hSZSs
         gqaSuwPPw3ULUuU8qfHsOT5CtYoCMD/770v7VUrLdqztu1fVhnqr6dEvT1yUplRwEMVn
         4Q2VOHnGRn0/i8ULldJQjXKx7ZxsgQE+PjuQ5AB7M1Dz2eQtnG6jwLSIvcv8blj7roL4
         7j21T8vag3m2+4w29lXqT7TazzFKA/gloj2ZP9d1iICnXbZb0M7EImZloj+JYu6YnKas
         QEBw==
X-Forwarded-Encrypted: i=1; AFNElJ9Bwcc7+k/y64+sIcuMxMGjBo/8PmEx113Aeg1Sr2pgp1CwuHKwVCeO1i/KByRSNRj7LQ4HYRGOsGF3JW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMU7T5fuXigS+WJGVSV7hGB2T4RDg+iN2OKGHQDZAZF5r4wt+i
	Xf6QqBUg/RbyJqupPemiPSxGKLtBkDezBvI3NjuNL76Qr5fNBVPg0TrJ
X-Gm-Gg: AeBDieuh/ytkLMPhaCCKm37a1pABuj/A5YEhN6UmwbsrNM82gmhwz6LkSoBEQnaBXo6
	sZZYv1HZwwgKpF9vkAusr0Bde0NrwUyx8b1GwwlhKlAIqvJ1RRKVa7rd7OuR1AMkYYugHR59R2C
	Pad5z9Rii9Nqe+KH7cmeVLaXuIwvXmKw1ISx21uxnDjv5VdPSB2A4XwOW65B5bSRRvzsDOQ+ypR
	i3OPpU5WW57p1bLCOv9/BtquQGGnjTEacFeB+yCGxfWEKxqd9ZtZk15sQVIg467KdN75LPx2Jzx
	Q2PS0Tg+PzsyYO5VsK31gVw/3a23L3t54xHQj4/i9FvEH8/vMzPqzesEV/vRX3a1By4Mjkpe3Gg
	I5Wza2K7cndx0zNsSu0arzuKdelSvddGGKNVLGmgHwf7oOEd2smnwBq5y0SGIicgsm/sJGQ2qkL
	uYx3gK5+6N+BDSIEpl03ynN9JzU32bkyeat6fPZqfDMPoOrr3WOTUwURsV3w==
X-Received: by 2002:a05:600c:a108:b0:488:a82f:bbb4 with SMTP id 5b1f17b1804b1-488fb78a0famr104158265e9.26.1776587415722;
        Sun, 19 Apr 2026 01:30:15 -0700 (PDT)
Received: from strix.localnet ([197.250.227.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc11ced7sm183002605e9.0.2026.04.19.01.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 01:30:14 -0700 (PDT)
From: Stefan =?UTF-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Drew Fustini <fustini@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 Russell King <linux@armlinux.org.uk>, soc@lists.linux.dev,
 Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v4 2/8] dt-bindings: arm: Add zx297520v3 board binding
Date: Sun, 19 Apr 2026 11:30:04 +0300
Message-ID: <6264667.lOV4Wx5bFT@strix>
In-Reply-To: <177646012448.2165534.5760108355183774935.robh@kernel.org>
References:
 <20260416-send-v4-0-e19d02b944ec@gmail.com>
 <20260416-send-v4-2-e19d02b944ec@gmail.com>
 <177646012448.2165534.5760108355183774935.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5099586.31r3eYUQgx";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5099586.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Stefan =?UTF-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Date: Sun, 19 Apr 2026 11:30:04 +0300
Message-ID: <6264667.lOV4Wx5bFT@strix>
MIME-Version: 1.0

Hi Rob,

Am Samstag, 18. April 2026, 00:08:44 Ostafrikanische Zeit schrieben Sie:

> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:

Here is a new PEBKAC issue for your mail template: I ran dt_binding_check, it 
wrote the warning you pointed out, but I only checked the return value - which 
indicated success. Which I guess makes sense for a warning, since there seem 
to be a few preexisting ones. The warning itself was somewhere in the 
scrollback because I let dt_binding_check check all the files.

So I learned I have to actually look at the output to see if there are any 
warnings.

Cheers,
Stefan

--nextPart5099586.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEQxb0tqoFWyeVMl1sPRO8yFRPGiIFAmnkkowbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJED0TvMhUTxoiU8AP/33cFyCxCEyOMxTZRv29
5Ypqo+NuvryxWrpo7I7s2VQvp5/q6NlSpNpmQXLcgkV9mGS6axv15mCZ6py1gJMc
HSIKkTqWZjzxeHoLZ2oZQCyFbMcPwvGhNK0qP/ckwWkv/4g/UFB9ujycOTFXVERG
RWQyIvROo7Lb9IN8ozKehzOvD7ga+AjD0i4RQLlaGS/TbHUcDZKWr6+WqJ8SicVV
wbiQU3cr4lAG7uCbKiAt2Jpcw1Aeuyfyci1hX4jL6KrY+MK6yG39ksq84DPUOgLI
xR+5Rxitj449eH0hPE20fkrE5UvivbYiCNzkrhyqWn42ahIj5DIBrSayWB0KUjff
lm6wYdL+yh/9760hh92rYCeNFYOz+kEQECsAHhTwqX73gCWFL5rYXJzFpNudFqXi
24Yx9+vZm7OhMi+lGJjM1Tn51ztC7MsP0ozz+PAMpuiEl6luLD3ybO3XO0eTEvhZ
oSylCbtelCVkO3KnW44cSdAspNidQ5Mr1EEXtLxUXOSSFQrmAGXmqmph3vSws7vi
X3G+z1WQ3VQkpUUfYyzV5AD1IORM+TfeZtFbKUrbr2Brk54ib7UxztFqfuizV2V4
9FuBUwZE1uXCLz3m7cB5yp+2zNX1AtkF/5STPQJh2hUC+mpbA68beyv6lefWIOKC
NohR6Eo79ZapFjltX76P8lbO
=NAGE
-----END PGP SIGNATURE-----

--nextPart5099586.31r3eYUQgx--



