Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9079C1CEACB;
	Fri, 11 Apr 2025 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744402566; cv=none; b=S2PchL7IvRvAO2TKia3pZWbeSUOENb4q4fnM2gPcriRLzofMlmR0bJi7BH9ZUhMumiZVfev0RKcEkrJA4SqSO+4WfbEJe/Sas5fqTm8ff/8qHijIKZ3NJpptWTCZYplhflzqwTDtwq880lZy5C+vZTq75CeRcM6b0ZilD3rEVYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744402566; c=relaxed/simple;
	bh=+XRrdLQjbVC+DwwNqBKs9alqnaihfnHPxzvcydtyUiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2jBK3T1ur73DH2HcNR+RZ6qIaw0Pun4c3s5OlntWOWIDDuXTjsOFlq6d7nCiZ3+hQo5tiveaCuMi1ruSnAHUsDmH1PZmRduA0uvV5KXOUih/mpyQ6lcO3rrj2T4bXMjjnQv4LR5ac96jt3CuuGGtu+i16fZ00YafRgEAyaLQro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izTNSBcc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izTNSBcc"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2963dc379so393531966b.2;
        Fri, 11 Apr 2025 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744402563; x=1745007363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XRrdLQjbVC+DwwNqBKs9alqnaihfnHPxzvcydtyUiA=;
        b=izTNSBcc2EnqWy6ukmb2C6xrHJze8U4bjyaKEP+aK1ZQcWJMyWs3or4gmJsxi3IGPD
         yVlA3MKCesBPUdypdHQHwqEI2xF37EuVc21k3c/IGbamv5YeHPKRYb6dqklm7S8aE23w
         ZlTvJoGU8g1gmTZCWBjx4XZOK0fOgcAraPdgGe7arTsErbJc2r4qnfvSdS/ka/J4doSs
         5Q1p4V3zTaS6tiZ1P4kKCngMny3dfCyG5578o5yoRxL2UVVPI9ws10eRpHUC/l3kHbEY
         HyERRqSKSo9DFpfqYvH4/BMdO/NlQmELKhQXDeaTMBWnlTw00UW0y78Nn4BuPNAYldlt
         /7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744402563; x=1745007363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XRrdLQjbVC+DwwNqBKs9alqnaihfnHPxzvcydtyUiA=;
        b=RFLBMXvSKFgtqZWV8vLYw031cpY5JNVn9mJ98cH+9rifO2PZ1OlF4Jfgd//Oh1cuPc
         5fa4eMOGfR3C5OQ5kvT7A/Vpr7wyFMD5JQDdAo2bru3mzo73xd3WbqBo5/84gVKZ9RJD
         /Q6ZmIDUUaLK5YxM+oU2rzb6HOC9Tk2cr1eVjyWGnQ64viqKnnPwkJQOzYEXKJr9nFtH
         +zW3R2tvTk0fab5R6rNAGpRxE/YlL6Nve7oX9CbH7drwmWA4SV6YPoJrBN6w8X1xb4F+
         EjLR922k+7dCiSpMQN48i5uXqrtt8xE6DNu1P/QK69ajCnjhbeQUi2hOMFzkt2UPfddq
         i8YA==
X-Forwarded-Encrypted: i=1; AJvYcCUKDbipfPnu56PAwCn0TktA7eX3+igl49okSG0HZJHPbIO8bsQgjNntYMlMKJ+VI/ibqIR4MTsY1UhS74uQ@vger.kernel.org, AJvYcCWMWiQw8GqbXMnEd8h5F9iIKSxmDOMDhOX/+Hhlqn45ZyWZGakYRa3vh/dh6F/pMPf/c/Q3i9qCNAPJblwd@vger.kernel.org, AJvYcCWS3SN7CMlZk5K6J5eZYiM6BdQeoz1hybdSBMmYaiQsjUGI+t3QT0Olc9KLrrM0mHe4aCXK9ByW15nC@vger.kernel.org
X-Gm-Message-State: AOJu0YyV2eiPqD6+TThY3Hb32+f/RKJom8SQoTHrX3ftyoeoU70jCRMF
	zp7hou525Ho83ZRjT0S7OPLGqizL3878c/VIrrIm1LLy5citfkSF2LJmVZaKs8+1u0St+BHcHwQ
	IEFbRi3bMeV1pOQE4aV0psTsuWK3Cfsq+lrs=
X-Gm-Gg: ASbGncsDawjcLK58bsie5oG2jkkYY0tN8BO3JxlCpPDasMp1MiQbiSEgyeCIs9e6tc9
	h/vDMHdIpbN3D31hNrP88h2YHtd3u8ILGfmhQrsCdkfOHLYIR4i12KOAJWISMOsagXCpHa9quIb
	M6jdKl+YPWS00S0o2XvtkZHA==
X-Google-Smtp-Source: AGHT+IEZaZAWkd4kV8I3YpLTjYmCJWDI/4A+MRh05C4NiDzsXUA03h3kae5kQ4a316zTbon+mczO7k+6BBDiH5VtnPA=
X-Received: by 2002:a17:907:2ce5:b0:ac6:ba91:ca4d with SMTP id
 a640c23a62f3a-acad34c9a32mr343863066b.31.1744402562545; Fri, 11 Apr 2025
 13:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411154419.1379529-1-elder@riscstar.com> <20250411154419.1379529-4-elder@riscstar.com>
 <Z_ltyAO-OBzl0adV@surfacebook.localdomain> <a3b2d0cc-c055-4cf0-9e03-3ea73041642a@riscstar.com>
 <CAHp75VchEcpP67oPC8xD+tYrY_A0BGSJqK=1au939-W60_qQoQ@mail.gmail.com> <925ea396-fd60-460e-a3c2-968d0d837a61@riscstar.com>
In-Reply-To: <925ea396-fd60-460e-a3c2-968d0d837a61@riscstar.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 11 Apr 2025 23:15:26 +0300
X-Gm-Features: ATxdqUFiElisjjk-BrvNvfHnahnRHi3i4WdHUyY93YRJhwdS1w4TdJrF0zeP38I
Message-ID: <CAHp75VdA4VPf90NQAqMLNejmugHCiAxhXwrH14+238KWiPvfgg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] serial: 8250_of: manage bus clock in suspend/resume
To: Alex Elder <elder@riscstar.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, dlan@gentoo.org, 
	benjamin.larsson@genexis.eu, bastien.curutchet@bootlin.com, 
	andriy.shevchenko@linux.intel.com, u.kleine-koenig@baylibre.com, 
	lkundrak@v3.sk, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 10:56=E2=80=AFPM Alex Elder <elder@riscstar.com> wr=
ote:
> On 4/11/25 2:44 PM, Andy Shevchenko wrote:

...

> when Greg informed me
> he had already accepted the first two patches.

Indeed. Just send a last patch in a simplified form as I suggested here.

--=20
With Best Regards,
Andy Shevchenko
