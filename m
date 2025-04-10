Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8051F0E50
	for <linux-serial@vger.kernel.org>; Thu, 10 Apr 2025 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744261760; cv=none; b=Jsr+Lu5Y//co1cNLkW7O+Laa+RO9mUZ4ZEioyOZzSRcspFUb021P+PmgmP13WNapOXM9GVACTqg9zum0kLbEXGv6kCpZisiQQzsQdi5n+NM9zGCPVENUKQFcU+XdAp1h+p/r0hsHEKAffeYIr7ufg1Eea702YXtPFy5+1owSbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744261760; c=relaxed/simple;
	bh=G16oVcschOk1bCBWwdD3ZsJUcsex2zjDzFXRZC7O9eo=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fhUxBR27rahQz77ZGzQrdrcryOUdkUZHpgwot8x8RFnBj7SBRTf//ysydEeZne69NB65Xo+X2qf4zX0jPBa5YaC3KIsSaMEmMyLFtPw1zymQgMxW888A2YusBrWTt4GYH3zWl0iFrrQX7XG1bl3IedmVVrb+ei/W90NGcT/TE/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nhyg+23K; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nhyg+23K"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5fcd61e9bcdso212116eaf.0
        for <linux-serial@vger.kernel.org>; Wed, 09 Apr 2025 22:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744261757; x=1744866557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G16oVcschOk1bCBWwdD3ZsJUcsex2zjDzFXRZC7O9eo=;
        b=Nhyg+23KIvdj2ds/dNoqaEQBtAsf+l8ko22/0+4jtvRN2tw9Xc7oxEI8f8BdnYDTiE
         wy/7saWqUY6bU6A6WaAv1yLARvwdxE1XGz4cX1LXU3HkjRenBGaTqV/cwhECJall2SEs
         b3T7jLsPsW0YtLGXBqKsEw1OfECpoBHejRrc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744261757; x=1744866557;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G16oVcschOk1bCBWwdD3ZsJUcsex2zjDzFXRZC7O9eo=;
        b=mC2860PIxTOfaZNG6PRTE2a3tPTYIA3Hv/wN7TSpjr7yWELNQqMtNNl1Aga1um8EHP
         DGpjCjBOyCsFFLA32IW/ryJcYl4nijTavT2YmU8J0XMeavejfb0+akIcRlN6Bb3BqJtD
         D8wG5QUq692B2bO7JJBXuSUbTiS8bQCwkLVnCdQHZxRvNuT8QFKGqHZh4KwlFf+6kim9
         nbkiD0xQMICG4/FIR841a218O9WTQ98Qd3iBSUIOnZcsQtY3t60qQJGEFgM5aRF/tK4s
         zizPt3bPSO6F+FLtFTrHZOQ+gtTLjplAk5ART/Y0gPtDeU3dtRN/q7ksobmfzd2c3/i8
         F05w==
X-Forwarded-Encrypted: i=1; AJvYcCXdIFT6zpekRKY3uDCB66og/xE8wcIC3mRCE4JY+buM+uEiAJ3VDad9uwOKdjKAQX13XY5ENQ8obpxY+bE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6K1UTmh1W1P2eCFYV+HxIVOxRGdM5mY9ZGXwi0898jB5umRA0
	sE+ZA1vw5gpMRbpgObc7rPlMKe5dFK4H/UdQ1XSa2jg3FrI8ROfWP2zzIaFtgg==
X-Gm-Gg: ASbGncszmY5Sq3bCSZg5UlOqnYPc6ZROYi251GLKTH5EdEqKPHb0mBhXOM5U9W2iDH7
	iQUl2vpSJGIgBHmV5vKb72mZrLVAR+ZPSGtezw/j2V33WJTDJ+QplgBMpDSIfWn0y66euZE5P+9
	wNQrwcZzbSUGYzSXscXryDFZv+ulwHckRs142Vwe5MymcDM3oF29E12MJuMh02QIkaNNZdNeTb4
	A7twvS2nXpR1mLGiWvPCe7ZWIxKMakfwZSFjPy/a9qZEVVA9WTwPUgg/xsfDjgT56aPQ16O6Hes
	Y3UBIoPdBIXYbYPLtKywgq1kQ9mMZjlJhPKJc5cjZcinJnQWmXaTqBuIRViSZnQBnkplgglhS+t
	DqEM=
X-Google-Smtp-Source: AGHT+IHf2dIBsgMwlqUxzHqfg0izmCh/XeIh4+y37IHWa4xRZwCt6+2s0H2VCnvp55v7eCTsGxhXjQ==
X-Received: by 2002:a05:6871:3320:b0:27b:61df:2160 with SMTP id 586e51a60fabf-2d0b383616dmr840067fac.31.1744261757422;
        Wed, 09 Apr 2025 22:09:17 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d096cd3764sm534917fac.31.2025.04.09.22.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 22:09:16 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>, "Kuan-Wei Chiu" <visitorckw@gmail.com>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>, <jk@ozlabs.org>, <joel@jms.id.au>, <eajames@linux.ibm.com>, <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>, <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>, <dmitry.torokhov@gmail.com>, <mchehab@kernel.org>, <awalls@md.metrocast.net>, <hverkuil@xs4all.nl>, <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>, <louis.peens@corigine.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>, <parthiban.veerasooran@microchip.com>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <yury.norov@gmail.com>, <akpm@linux-foundation.org>, <jdelvare@suse.com>, <linux@roeck-us.net>, <alexandre.belloni@bootlin.com>, <pgaj@cadence.com>
CC: <hpa@zytor.com>, <alistair@popple.id.au>, <linux@rasmusvillemoes.dk>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <linux-fsi@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>, <linux-input@vger.kernel.org>, <linux-media@vger.kernel.org>, <linux-mtd@lists.infradead.org>, <oss-drivers@corigine.com>, <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-serial@vger.kernel.org>, <bpf@vger.kernel.org>, <jserv@ccns.ncku.edu.tw>, <Frank.Li@nxp.com>, <linux-hwmon@vger.kernel.org>, <linux-i3c@lists.infradead.org>, <david.laight.linux@gmail.com>, <andrew.cooper3@citrix.com>, "Yu-Chun Lin" <eleanor15x@gmail.com>
Date: Thu, 10 Apr 2025 07:08:58 +0200
Message-ID: <1961e19ee10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <740c7de894d39249665c6333aa3175762cfb13c6.camel@sipsolutions.net>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-4-visitorckw@gmail.com>
 <25b7888d-f704-493b-a2d7-c5e8fff9cfb4@broadcom.com>
 <740c7de894d39249665c6333aa3175762cfb13c6.camel@sipsolutions.net>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH v4 03/13] media: pci: cx18-av-vbi: Replace open-coded parity calculation with parity_odd()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On April 10, 2025 12:06:52 AM Johannes Berg <johannes@sipsolutions.net> wrote:

> On Wed, 2025-04-09 at 20:43 +0200, Arend van Spriel wrote:
>>
>> This is orthogonal to the change to parity_odd() though. More specific
>> to the new parity_odd() you can now do following as parity_odd()
>> argument is u64:
>>
>> err = !parity_odd(*(u16 *)p);
>
> Can it though? Need to be careful with alignment with that, I'd think.

My bad. You are absolutely right.

Gr. AvS
>


