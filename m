Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1BF125DC
	for <linux-serial@vger.kernel.org>; Thu,  7 Mar 2024 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809654; cv=none; b=jmaARM2BfxDs4kxEFogYG7NOQj1tOJaCOSySNTYmmTFnc43ouACo2JegoLyEjVUNu3bhoQh7Oo/x4+nOY0YLOYqvGis8zJewiFrUfHCCuZ/9MXcFb3Yf2Wj6FHV/HOAIdsuU2DP8Peipiomy6ocgNJxWAvFpRejTckL359LbAmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809654; c=relaxed/simple;
	bh=8fq6DP1IayRX/qdHSZUZ5CnaG9xJer5ITAeZDZ4n+jk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=oVPbyQuF4Y6EhvXFYBrbg/XsUQSY2MG6k0GCTL5VVsAN1zPJQxgnX9aLXzvwYsW8aijlQp4i3EGyMsfufp3SYOhl5VGITWvEAszGbLUIyzzRAYjnxV3pfGLiNdo0h6WVHoXAVc525JuyAtPxEKRg3jkdR6nbOZa0nxfHVOzeo3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHs1hxeI; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHs1hxeI"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-412f62edf25so5593795e9.3
        for <linux-serial@vger.kernel.org>; Thu, 07 Mar 2024 03:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709809650; x=1710414450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4J15cUleRbELR2TDXwXkhERfqtEnVLsMg5ktu7Cjd8o=;
        b=OHs1hxeI3g8qYazy4QmMZDSrc7KGHC/cNhYZ1YK7v0VVEOoUaqcobPVf7v/HgRWnQ3
         zd8URr+oJKBwzFix4AJF6e/nC2bAX612Z0sl05NUadkFh55xBjaD/Lpi7FxrtZfOmJSv
         QKtjvdRnROOBIjmq945lKw9N0HBlEOKXuSlocCzc7vGiKwEQhzHWyz6qFMVffJiNU9yr
         kyM09nvlaCuqr2QKxT3tH3p8EpM0yBLR/zM9q1B/WSlu37AfXK9Bq4shXUclhOLXvs17
         GDUCkGQpPl9MEXJhyr8Aa57cL0PMQFFyW+nWq1e63lU0tmev9DOODLA1TD7flqSmLclm
         M0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709809650; x=1710414450;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4J15cUleRbELR2TDXwXkhERfqtEnVLsMg5ktu7Cjd8o=;
        b=eG9zPhmgXGziga281oer4QiN9yyxijbqZmRzjxY9r94m/S9+/t8kZJanP46LIahR3+
         atmb4+6EHEGo4osayUD0oQweWGthwZehWI1IRzh/ppp/zwAqlWb5mC1LYus66GtSX1JS
         Cx3ZqYFgHmIZJ9pzHziT2Z8b8xL4peC4QviMjvQxQNB7WIip302sxgE5pgzc7CNKPdsB
         aid/Vm+9vCC5/CZHD+s7KjL8oLrnVLE/cLsmyxujX6G2zIocGL+uf9NowHFcYD/vPmLu
         GVULslPRsaza/u4z0U6GdHthNRhX8E8fSBWu57f5Uy00cziEuU6944htm+cfxBjCFGgg
         QdDg==
X-Forwarded-Encrypted: i=1; AJvYcCUSqmoFBl2RBs+qx2VIyI54CBeL/upz8LbAI4F5HStjWEXWxR0c5yWnA3RrAIwpn+JkTs5uZ74UkmnH0nloa0KlytPSaeUPHqRsZFz9
X-Gm-Message-State: AOJu0YydW4imkQfWHO6BzYDRqc8e357+VTdZ0G0OKUaGWjEC3cTDD61H
	/gaqrx0Fta+HnKxJ0zfvdordcDuI4FrZqPzAIo67Va8TCRPQOeHg
X-Google-Smtp-Source: AGHT+IH7rX01NE5RdpG1UOVTFqXOwNKfzL3DMs+T9JJflZsj+t/vKjE3zzzr0pBzeywsD6BfNYfIWg==
X-Received: by 2002:a05:600c:1f95:b0:412:abfd:2c0e with SMTP id je21-20020a05600c1f9500b00412abfd2c0emr14648063wmb.41.1709809650451;
        Thu, 07 Mar 2024 03:07:30 -0800 (PST)
Received: from ?IPV6:2001:470:5139::fb2? ([2001:470:5139::fb2])
        by smtp.gmail.com with ESMTPSA id o22-20020a05600c165600b00412a0ce903dsm2199034wmn.46.2024.03.07.03.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 03:07:29 -0800 (PST)
Message-ID: <3a2987d4-ca89-4f4b-9f01-ee19a01c1b6b@gmail.com>
Date: Thu, 7 Mar 2024 12:07:26 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cniedermaier@dh-electronics.com
Cc: Rickard.Andersson@axis.com, festevam@denx.de, gregkh@linuxfoundation.org,
 ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org, kernel@pengutronix.de,
 linux-imx@nxp.com, linux-serial@vger.kernel.org, lukas@wunner.de,
 marex@denx.de, rickard314.andersson@gmail.com, robh@kernel.org,
 s.hauer@pengutronix.de, shawnguo@kernel.org, sorganov@gmail.com,
 tglx@linutronix.de, trix@redhat.com, u.kleine-koenig@pengutronix.de
References: <2e866164c89c495aac905753978e8747@dh-electronics.com>
Subject: RE: [RFC][PATCH] serial: imx: Fix RS485 behaviour on disabled
 RX_DURING_TX
Content-Language: en-US
From: "Tobias Jakobi (Compleo)" <tobias.jakobi.compleo@gmail.com>
In-Reply-To: <2e866164c89c495aac905753978e8747@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I also noticed last year that RS485 was problematic on i.MX hardware. We 
use a i.MX7 SoC located on a SoM by manufacturer Toradex. The SoM itself 
is plugged into a proprietary board that features a Renesas ISL8xxx 
RS485 transceiver. We talk ModBus RTU over the RS485 link. The SoC is 
the ModBus master, the slave is a insulation monitoring device.

Since we source the i.MX through Toradex, I opened a thread on their 
community forum last year:
https://community.toradex.com/t/fixing-native-rs485-de-toggling-on-uart6/20573

I also realized very quickly that the newly introduced loopback logic 
was the culprit. My solution currently consists of a new DT property 
that effectively disables the toggling of the loopback mode:
https://gitlab.freedesktop.org/tobiasjakobi.compleo/linux-toradex/-/commit/98397c9436f48a149e2da0b2969a2d1d2d88c611

Anyway, I have tested Christoph's patch and can confirm that the patch 
(also) fixes the problems we are seeing. Test was done by applying the 
patch to 6.1.80. I haven't tested Rickard's patch so far.

Would be nice if this could later be backported to the 6.1.x kernel 
(this is the kernel we currently use on our hardware).

With best wishes,
Tobias

