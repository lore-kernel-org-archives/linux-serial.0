Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4138512C491
	for <linux-serial@vger.kernel.org>; Wed, 10 Jul 2024 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619146; cv=none; b=sXMuN39fXAqDkzJEEaROe3WrTmA5mkHWU9YsIaoF4Iu9NWOBtEVZCBfg9u/6d9h9Yb5Fyu4vyECsSBzMr7VYxMiQpDk72xmPahTUDOGsDMqrW+d+CwZ4Qfq/Wz/ZP7/1WZIuyhnYLyu8bFct0BL6Fznv+pSb4DK3l6oeIdKsgm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619146; c=relaxed/simple;
	bh=nBZya76Wm86h/8wItky+O7Gdjz38LBYG63PU9pDmJVg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CbaJBFzYKXSqGIe1luWub2fPl87GM+3ECxj7cbcgkoabh2IE0z7Jxet2ueaaAbMVgYWS0kfPvjbAspw0/3X7udj2IvZz9/LPT6wy9iOkiuW+7oZPV0tquB1hpIigd99xbDUh/Q8fBGnkMd91a/YWrTkgCP9H1YaVEkqBwu9cLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kZjJ8VbB; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZjJ8VbB"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so84516291fa.3
        for <linux-serial@vger.kernel.org>; Wed, 10 Jul 2024 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720619143; x=1721223943; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nBZya76Wm86h/8wItky+O7Gdjz38LBYG63PU9pDmJVg=;
        b=kZjJ8VbBhaQmH4TwuB/VUbxUBREwgkq51axvF1ENBmfHyhbX0n+8X7teGOtvVPEczi
         tKJRRICI5t7lKRMoAuRG6aiV8AiWMzAmU9cZYuji1xJL915tEl0aVagM92N4h57EnUAx
         xDjj1WJ0rIdUUnp/pWzTnt9gCjvBojPLOkghpmTlgIJ9dwsFcxEl2Pal54LkWyht3k71
         3y/8JSIG1HcxOdyvuPYLzAjFptYtHGFk4t/V1/FQlwv6R8Nj85sXI4JnZd3befDjb0zd
         OXa3Smgp5MQDjUIqDTPtF19JmaGJph+TVhpCX+c0w1xOakNu2YFs3rIX9Ldlnp21TXeA
         5HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619143; x=1721223943;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBZya76Wm86h/8wItky+O7Gdjz38LBYG63PU9pDmJVg=;
        b=X2rfxLc790cOpHDdqobFsGJDMjgBy8RKMx8Z79IyDMmyhe3NibPvubWxKTNPknVJkv
         ouMpA9JJ8Bf0XIxrrHV/KwyegugzV6dTQkWdbetNFdQSATdWz/bXkmi99MSXy1S7bAay
         ZKKvqQW87UMwhxaPcJGMtbrWVt0TBZaSbCCRB51+JC5TJLxYbxw+ydGvqMVvi1IZyXaO
         QxpWs1ElMRYfhULANpEwr7GLW3prbCKDJQM50Ieu6oAjzgqQIAnzKPNkuMdEAYapX7h2
         2TMinhzNRaNOLuCCdof38xFH8gOij+xfWglvQht/Zp0gQQ9FE+kIqSXpp3MzocM90qt1
         rzBg==
X-Forwarded-Encrypted: i=1; AJvYcCXkSfyDOxVyzj7iabayRC79fmdWgpZMWKFY9aIujZmjaXTuhLa7BYgjgDTIb3+P/IZen+lXV4zhi5JjPIz5xOcFWvn3SM3MzJK1qSgS
X-Gm-Message-State: AOJu0Yzv3FXAmzpyySZ+itnlMswd8aZi8Z6CRdbKBJEAVhbCZkaZQwhM
	FV2cDZmGVeyAprUubZI/4UZ8rlLV2snRcNWXFuBckLlO0L43DnZzbtSWg9pJtBA=
X-Google-Smtp-Source: AGHT+IFxVH7DKj1n67o5WR7wEDepIOdPrqplzYbVbu533HXdOYfMvD2fJtNIVNrSrVq4QHOwvZojNA==
X-Received: by 2002:a2e:a4d8:0:b0:2ee:92ea:8d0a with SMTP id 38308e7fff4ca-2eeb3102734mr31637631fa.23.1720619143259;
        Wed, 10 Jul 2024 06:45:43 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e09e5sm83564695e9.5.2024.07.10.06.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:45:42 -0700 (PDT)
Message-ID: <0a47f15062ed65048fbf8ffb902e28fe13a625c0.camel@linaro.org>
Subject: Re: [PATCH] tty: serial: samsung: add clock comment for earlycon on
 gs101
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Jiri Slaby <jirislaby@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, Sam
 Protsenko <semen.protsenko@linaro.org>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org,  linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-serial@vger.kernel.org
Date: Wed, 10 Jul 2024 14:45:41 +0100
In-Reply-To: <2024071030-gravy-backwater-88ec@gregkh>
References: 
	<20240710-samsung_tty-gs101earlycon-v1-1-bd0f8481542a@linaro.org>
	 <2024071030-gravy-backwater-88ec@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Greg,

On Wed, 2024-07-10 at 15:40 +0200, Greg Kroah-Hartman wrote:
> [...]
> That should also be in the comment in the .c file, right?=C2=A0 Along wit=
h
> the git id that you feel should be reverted?

Thanks for the review!

I didn't really want to put all that text into the .c file as I thought it
to be quite a lot, but sure, will do :-) and also wait until we have a sha1
that I can reference before resubmitting.

Cheers
A.
