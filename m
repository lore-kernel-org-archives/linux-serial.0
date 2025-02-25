Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43525A622
	for <linux-serial@vger.kernel.org>; Tue, 25 Feb 2025 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465008; cv=none; b=JIDynsa3v2f4uTfi1hBnrWX6N5eqdkbHmLD8jEttJ8Czr3H5/0A+CGYVpQxh09ItXAwzA2rVmvK9by/iU6A8ZDDSOyJ6U5sNnBunCAMdXqIUs3JhR/9OsECuFSdnh68nZcmAywkJQg76cFqKZGgpLvCLJMAMPM+8kxSo7lCwvWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465008; c=relaxed/simple;
	bh=RYfyD32sRASx29xi497H3XJdDF3XXVn40eOIf2rnFm0=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rVFE2qHqmclQge3wwHJKzD/D7eVylWoLs4Fy9atlNnhpbUKQKVgoHC2SFFCWIcsWJUzBMMFJVmuMQndWE8W+0u+2T6qoDDCJkAeJBTdFEXLi8JaQOcuNLqznTHFpMbCdZ4dYvMs5MX+9Q9T0mRzz9uSEvvwyFTi74VcQBeNm69g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ATVTdfAo; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ATVTdfAo"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3f408052bdcso1815772b6e.2
        for <linux-serial@vger.kernel.org>; Mon, 24 Feb 2025 22:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740465004; x=1741069804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+mBAQq6Mkez/2/DMWHStf85qnBYyGFLVJqfvqnbkxk=;
        b=ATVTdfAoZ8/xxq1ZmnjF7OLKA0Xgvb7CoBQQ87W4nCqYvgoKGF1WfWw7itwOEF/kQ2
         qSEC712GTgta39biH0N9ptdUCZON99uEGDNtQAHraF5yqKkiQif0P3PLLx4dOpd02hU3
         w51m7o1mLP/kdvlplhEAUBZB0iorvyx/M6eRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740465004; x=1741069804;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+mBAQq6Mkez/2/DMWHStf85qnBYyGFLVJqfvqnbkxk=;
        b=sAHMLQGsiUMfq8KHy/1mJiJZK7SBqJE8fw6dI3ijnKYkRuC0zFHCLrYBkzo9rkL15L
         bC/cTQgWbKNoyvwQ9ZVeAUE3Llmm/TmANfB1KwGTMNTE0300u7uJx5aHb2Qn4/f2Ubbf
         sFRIIuZUGBE1iY9C+Q5BvJDobGoAIT7QbuDq+bTfn3/+/2zMlNPAQBkNMjwDIw2RKG5C
         t0GwOq8KAHL9H8zSvuQz4qLgW+Pq+kcYm/M+iyHlxxlgpcfnbaz+bQq0+nLUVGsmUUlZ
         7EFY66apOrXFF7U8xoXPUvkJbSjx9Nulrh0SQ+z71DSMAI3+ksnklBAdN+U91/FMBbPk
         vPDg==
X-Forwarded-Encrypted: i=1; AJvYcCVKJ9YXVlsbX8HAW40P6+6Npa6z2JNtOm26gTpAnx+DQdU/TjWEhWd87frIGghCJpC4SPkUovxd0TKPZ1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIPHf+M0aqSM6ti2mS74H+6tMJkthNov7OPX4CYQ+d2Fm4HQqO
	ddXDNxSFJHeiCP3UXzhWAIxBF/KLXGmbCJMl7eWmNKvQFqB39YLnCfKg9NXcvw==
X-Gm-Gg: ASbGnctpSOAIVeuzg5GMG0ZpDBPyF+ZeBd36lE+omwAahZNGNMAb9fSO3eXo2AZ7h0A
	1ev3uO2zUKiuSzFzVN3Ysp06ikHcg8+lAyhpN1volEX2VqYh8L6aSSdZyvvmLcj2/WXlJuPh8Kr
	JlvOS7EyxcwX8TyRB5+pxqQ5470m5JUPJvqfHOgKPI/qv67/4tBq1uk+LKNaaU0zWyAOxkL7vUD
	Ax9j0x8k+mLzCAP3pYzj0WyAAKGy1GRRYqWO7YDdWUNDJT+Vi1nGw4Vy/hXpDF+s1oJz91bgurE
	LSEy/fv9UvFqCnepDaW2GRUjMchN4uCBSMdae3iv3USrA4ydTKVVVEG3JSpZh8Nb
X-Google-Smtp-Source: AGHT+IFdXMbhGx7fP9GFKGlpguOITWaZZGOBzMRAt9OnDAJpr0Tf6LoZNYE9WcUj4WMJOinaxdWK7Q==
X-Received: by 2002:a05:6808:3c8f:b0:3f3:e8e7:2001 with SMTP id 5614622812f47-3f424777eb0mr12305946b6e.26.1740465004283;
        Mon, 24 Feb 2025 22:30:04 -0800 (PST)
Received: from [192.168.178.74] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f541bd992bsm190300b6e.16.2025.02.24.22.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 22:30:03 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: "Kuan-Wei Chiu" <visitorckw@gmail.com>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>, <jk@ozlabs.org>, <joel@jms.id.au>, <eajames@linux.ibm.com>, <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>, <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>, <dmitry.torokhov@gmail.com>, <mchehab@kernel.org>, <awalls@md.metrocast.net>, <hverkuil@xs4all.nl>, <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>, <louis.peens@corigine.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>, <parthiban.veerasooran@microchip.com>, <johannes@sipsolutions.net>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <yury.norov@gmail.com>, <akpm@linux-foundation.org>
CC: <hpa@zytor.com>, <alistair@popple.id.au>, <linux@rasmusvillemoes.dk>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <linux-fsi@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>, <linux-input@vger.kernel.org>, <linux-media@vger.kernel.org>, <linux-mtd@lists.infradead.org>, <oss-drivers@corigine.com>, <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-serial@vger.kernel.org>, <bpf@vger.kernel.org>, <jserv@ccns.ncku.edu.tw>, "Yu-Chun Lin" <eleanor15x@gmail.com>
Date: Tue, 25 Feb 2025 07:29:46 +0100
Message-ID: <1953bcc1790.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20250223164217.2139331-12-visitorckw@gmail.com>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
 <20250223164217.2139331-12-visitorckw@gmail.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH 11/17] wifi: brcm80211: Replace open-coded parity calculation with parity32()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On February 23, 2025 5:44:54 PM Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> Refactor parity calculations to use the standard parity32() helper.
> This change eliminates redundant implementations and improves code
> efficiency.

While the dust settles on the exact implementation from driver perspective 
looks fine to me so...

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>
> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> .../wireless/broadcom/brcm80211/brcmsmac/dma.c   | 16 +---------------
> 1 file changed, 1 insertion(+), 15 deletions(-)



