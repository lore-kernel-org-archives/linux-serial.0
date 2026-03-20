Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD837DE80
	for <linux-serial@vger.kernel.org>; Fri, 20 Mar 2026 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773997878; cv=none; b=dU/GXLDSVrPrdfQ5HGn28bey0naKZU1HrsWb9KeNU0QUi6EojZw0Wnzt1/tyfT4HvnhjIoxfd4C3VhUXJBOll4cXQWaVYUmEEY6lMF7Ae2xRkixu1u/f5ILiYaSiQ8S2Cu55UtkY07l2nQTKB45DdG3e/PYNKaHe2Ad6YjePPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773997878; c=relaxed/simple;
	bh=osPuVGUm/UzZnnch36LBSX5ZBydiJ3syEDW7/rP0ehg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMD0secI4owVRzmztSERkWZADvwnNCNPyaXFTBxw4IWWcNS9QqwDosxf8y4hyXwtC9iWMGp3y4Ax0HR+prR+rfNHg4MJOoWTswoYl5exXyurJV77CW+rnwwQPiq9k87z2R+GzYSPXmTt+GzhXR+Y0oUAfcTR7UpMk3kXAaYr/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=E10iuiHj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="E10iuiHj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso2854735e9.2
        for <linux-serial@vger.kernel.org>; Fri, 20 Mar 2026 02:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773997870; x=1774602670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnvpWrvuYkXuiKq1OQLuzrMxSlnrYn7ohrRGMt5HMQU=;
        b=E10iuiHjIszaS2WGaFn7yUugVwA2m8d+5Ic7sUjvPMClbXlGxOb5+03kYWeCY4DLIJ
         wAnQY/Di5k6ghnD9rzz3LNUz0L1CAgzzvi/T9XeIKvKabO5+jj/EFVcHM/43k4nsVHu8
         llxcjCC8K5XarROMaaT33EGRCRTmFvpGew95d971JOdI3aGGmrhG0zrMf/tzFTtvlRxR
         oeexdmTCS6W+PtY99Ab8i80vpd82rzJlHKZvAiJmsq82H05lnGSFSR0EA3rizJE9E+lv
         SKzmMLmY+v0cYR4aAfVd03IspAzfYyruSQe+lYjwYfwzSH/JHmFpA1JlO2BZkrplbuSB
         eZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773997870; x=1774602670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnvpWrvuYkXuiKq1OQLuzrMxSlnrYn7ohrRGMt5HMQU=;
        b=gCjIHwcpB1k+GSYpdTy9yhqbf99GGJXRRm6c2AFhA7fu8n7+LvjhwJQwILwRnXo1Xn
         GdY3e0gMQjxnd5mHdGRFanxbwsTx8hlAqj2N4L90glD3H2zs6E7OfNwHCVME4+MujPAW
         b5InxHwntM3qILkB31mv36e8mtECTM4q+Ismqubq5XQKyR7qDPajWjOlgKK1wq/xrZiA
         wxbgvhVyZkMBZo0Y/6A8u4lGsmaZYRZTF0zGdoWay5evoNB17/+ewgCx+Rutj+JxeIbL
         ZP1zXvlg4UfCslhDzAD9xrdXUhF2uRBDH87/l1hjv5IE3C1HwqdHfaI4SgE4IPEpsQ72
         3mqg==
X-Forwarded-Encrypted: i=1; AJvYcCXeCUHppFMGeznfnAt1OKw7Ed34lyFcKXtvgVhXKKlWXb2FtzA0Htp2dFWJJvBPmyx3nHW7+n2kWGrQG3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9SegWaOwTiDj7iZLMyZw6h0juxcGj0JQajCCJv+ixUO7bqIal
	KefzLTOlKCQobXWa8Qz6N7TmVMTx1WQl0Dml+uROkWNwKm5IlqzKIiWb3Uz8p2ZPATk=
X-Gm-Gg: ATEYQzwUl8QeyBwa5nPnsB5sppQeoF/tj5WtldwKAAZ4CvTlMxeOorrJ/gwh6QxeNNG
	6TPtm+dOI4hR/plgX7o++7KxQYD+/UTX75bQOArz9FxzZBf3f3dkPWIlcxPwBclJk9wicvvXoyz
	3bqTMWR6DuR/JRjvFh6AYmcAbYU/RRditIB5hAb1w6e8xndVi6v2HSiYOJJN5IXLqBXQyzzQl0L
	+fYAaerUj8xb607txo+CKK61YwDzF+lwb/HTT8tmA9qO4NAMn+vsGFLmAlvHVmHOgyRquavh85c
	dyrKWu7tCWTerXHBGifPmzSlseKlyS8N0spJfmniY4R79qFDl2rhOe60yg2qS1kG8SLh0h1bw7m
	kkMCdELJUEFPkKgRQlXeXqg1Ypr28ilImqC1D+kUSKTaG3k/CRd8uaFxAOcCVg2uVj+baxVh+z7
	0y6r1UzNFUrdE3g8V4hbLPz5uSh50mDW4=
X-Received: by 2002:a05:600c:1f86:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-486febbc653mr33123025e9.6.1773997870011;
        Fri, 20 Mar 2026 02:11:10 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff118bb4sm18208155e9.2.2026.03.20.02.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 02:11:09 -0700 (PDT)
Message-ID: <1f684500-6c06-4abd-984a-4cf889acfcc2@tuxon.dev>
Date: Fri, 20 Mar 2026 11:11:07 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] Add support for Microchip LAN969x
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, olivia@selenic.com,
 herbert@gondor.apana.org.au, radu_nicolae.pirea@upb.ro,
 richard.genoud@bootlin.com, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, horatiu.vultur@microchip.com,
 Ryan.Wanner@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr
References: <20260302112153.464422-1-robert.marko@sartura.hr>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260302112153.464422-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/2/26 13:20, Robert Marko wrote:
> Robert Marko (6):
>    arm64: dts: microchip: add LAN969x clock header file
>    arm64: dts: microchip: add LAN969x support
>    dt-bindings: arm: AT91: document EV23X71A board
>    arm64: dts: microchip: add EV23X71A board

Applied to microchip-dt64, thanks!
