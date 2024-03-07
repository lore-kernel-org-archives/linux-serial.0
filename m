Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC3812DD9F
	for <linux-serial@vger.kernel.org>; Thu,  7 Mar 2024 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820626; cv=none; b=KDn8EdtmfeHoh7eHfd/y2NAIUVoH9wxrkot2RT5BDKMLFfGacl0SqoTSYOBnoOjlSGiai73+yIFMAreaDnAQdOwHqe6pa8U8IMEMTr+hyJeJjSIWojiQgtQQO++QW66jRigNKOFK7PoTDGzmd6pIyQPHZmoCTG9iBkIl83ebNek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820626; c=relaxed/simple;
	bh=8Uw8xMBW4UQK0qIgbOHRF+CbwIUsehbE2zVuCzuImqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2y9LSxQVbgw0AyvYFoyNEUW6ygnotlG/tMhCbo3yVJ53mRl+mywN2EA2kB2pkBXrPNzWaG4epyyxoomrZNi/gKm9dKAIsxj8TZA8qWGS5IG62APfMuhRbgUDa/6C1i46bNDTpGemhekQpD68lJkQP15+AzVXCMXn/fhDdg146s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4/iHSBG; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4/iHSBG"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-412e68b8594so7148455e9.1
        for <linux-serial@vger.kernel.org>; Thu, 07 Mar 2024 06:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709820622; x=1710425422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Uw8xMBW4UQK0qIgbOHRF+CbwIUsehbE2zVuCzuImqw=;
        b=A4/iHSBGlcw+/1eAELQ56IAuE8pjP+I3a7JXTiKPJ2C0iJHk6bA7+iLZFFUI8E2yv0
         et5mKBSVD5qseF0l9cADTSk81K9MA6E8gIb3KXsDctmAWU+DM5nT4Vv3rophH1Foed8y
         aYMktPmS9l5SkMtdhp12Z0yhEPdW6LoauLpeeBDsqNd5lFrPAg2sXBhcOdH68dWCRrkL
         NdAolSM3EVh/Ib0hHEWdhVAMc6Vdra0Li9uXkY5D5Xs5HdvOTefbhJC2qMyHI6Ckla7+
         Iz++dIByny85EUK3N3Z/4rcsXwAn6OWihKDGN5hA/ryp4H9l284mMHriWWaI/dygevdx
         7M7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709820622; x=1710425422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Uw8xMBW4UQK0qIgbOHRF+CbwIUsehbE2zVuCzuImqw=;
        b=tobCFHXVGVunFKi0oVqt/Kb/XXsC1PN8+e5Bt/Hz+x5TfZXwDCoeXqFDjUekXa0lMU
         DMZRLarOST3KtjeOJVNAlJHOc6mTK4NfZrSZPzEBiTUM8G/iGY3SYSGMoDuzS05ezi4d
         +Fg5K/DBT5v2VgBpoUAajSYBjKAxJHvEmk+8YfJEL/pAE8MfllJlmwNJ8klwgC8Dc730
         ePOqJVdRrQ14v6egTg/7LeJ9kF1DrY2UWovjB8Qsmr4f1m0T7ecccUO36n+ufUUbGZbo
         3nVFc9qkOdFuhqvGVd6wrBPLRAxRS1VSvgMfWwhQFRAVfX+steYO7rmfbPbPEnOee85C
         BrDw==
X-Forwarded-Encrypted: i=1; AJvYcCUnWW8scHN1rX7UmxBEQAFOexcKKD9IEje7fq2sxDJkF7F3CrJRiKt96KE7VdxLuW+aP6yAl6LgI/2qYXfQQ7olFEBei6d5v9aTNkjj
X-Gm-Message-State: AOJu0Yx8S9+lgdwwbl7R52De6ItTbxV1BQVXuBTSeY3VpAPyPl1lgTc6
	7V/wB6kyXALuHiJ2uoTVKTB3+EpzTZPZZo0bVQLFKrCaOe73wDbc
X-Google-Smtp-Source: AGHT+IGCX+TVYxmSkg/Nnak8CCjHl6k+VgF6ooUvLNKGPo4S7QMZbne+sScf4Gn6hI1AUfL+CBYKGQ==
X-Received: by 2002:a05:600c:35d1:b0:412:e56e:b4f5 with SMTP id r17-20020a05600c35d100b00412e56eb4f5mr8139230wmq.8.1709820621878;
        Thu, 07 Mar 2024 06:10:21 -0800 (PST)
Received: from ?IPV6:2001:470:5139::fb2? ([2001:470:5139::fb2])
        by smtp.gmail.com with ESMTPSA id gw18-20020a05600c851200b00412a31d2e2asm2839875wmb.32.2024.03.07.06.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 06:10:21 -0800 (PST)
Message-ID: <51b7c6c2-824a-4f6c-9667-a8f047bfc080@gmail.com>
Date: Thu, 7 Mar 2024 15:10:19 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] serial: imx: Fix RS485 behaviour on disabled
 RX_DURING_TX
Content-Language: en-US
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: "Rickard.Andersson@axis.com" <Rickard.Andersson@axis.com>,
 "festevam@denx.de" <festevam@denx.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "jirislaby@kernel.org" <jirislaby@kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "lukas@wunner.de" <lukas@wunner.de>, "marex@denx.de" <marex@denx.de>,
 "rickard314.andersson@gmail.com" <rickard314.andersson@gmail.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "sorganov@gmail.com" <sorganov@gmail.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "trix@redhat.com"
 <trix@redhat.com>,
 "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
References: <2e866164c89c495aac905753978e8747@dh-electronics.com>
 <3a2987d4-ca89-4f4b-9f01-ee19a01c1b6b@gmail.com>
 <2d92d69369054578baacccf23ae2eff1@dh-electronics.com>
From: "Tobias Jakobi (Compleo)" <tobias.jakobi.compleo@gmail.com>
In-Reply-To: <2d92d69369054578baacccf23ae2eff1@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 07.03.24 13:38, Christoph Niedermaier wrote:
> Rickard's patch in version 3 solved the same problem, so it should also
> fix the problem on your side. It has already been accepted and is already
> available in the next Kernel. It has a Fixes tag on it, so it should normally
> be backported to the 6.1.x Kernel soon.

Sounds good! Going to keep an eye open when it lands in the stable tree.

With best wishes,
Tobias


>
> Regards
> Christo1ph
