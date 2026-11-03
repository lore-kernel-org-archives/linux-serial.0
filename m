Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743577;
	b=MRo8sqOYdYjS75wUhA4AuOxtzEcq06I2xORuWIkBrNU0I29LtqsoN6804XOy+DDPDqA9
	 yfWFT4/FTFE6z+vJ5gSJGuH4b1iuOWw0GFutWuizX224K2gbX95PUeu2V16i8bN8joWV+
	 vgBD87VsEWfOyNW3WgwucwSSUN5BBf+Q43muusWnvpB9k4+EOspkywM3jTUu0kdMJH1cw
	 v9M54NVoJTBBzRANx27HX80UJpLwvRpJbX4TZ+ihDNLMU9lopojnkqH50oPx0CMzOFW+t
	 43IwoGSvM4F3+vHnS+ULNzKuNSkrXvuB56pgngORuKMLfpQ6QcZbrt3b95+GVOa2n9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hv0Uio0iKv6YWg4emi8XyGAuTMh6jvPk4JOtOEL/kqI=;
	b=aJKKFrP33xsDmA1qydE2mGI/BZ1vbmusGQgoEkEiqIuGaC+K+74WdD+lYWt0nSoI0Lk3
	 1Ab/mE1ig4mvWOcMsgIWO08HnKavAyhUZI4Ef0uftSonpzD+n3+zY3QULZtAmeQkP73pF
	 XPTDFQLlW3uFKdhdQJU+iYdHpqMtI9OuYotTi89qmAL8/akq0TXCvzAFViPW5LruUROdB
	 TZAlv3jXf9HfAWO1zOfT6T9I5tREglz6M+d72l99xTFnttO3oXsysbQvJy0KoHddR7XWF
	 viJu49MV2lp4Lx3K/0kp39Ha+fnvv82WIFP1qvwWDyBkHyba3vqURRTD2TFj+4+0fGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VWPaHvnX;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D4606A326
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 792D4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VWPaHvnX
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-54465f79af8so118101cf.0
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 14:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793743576; x=1794348376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hv0Uio0iKv6YWg4emi8XyGAuTMh6jvPk4JOtOEL/kqI=;
        b=VWPaHvnXR4QbSC5IyHVKu5R88jNYS/0KrZk5ghuorRGJARgbf8FsaNzpnVC2zLJEdX
         pa9OJ3WVP+4YhQdgWFAwTzIJTVifMCP1ol6riFYHBz7ZMlHr3lBDY9A/+PsoKRCNQFOx
         sligINswxDpSji18Eb/9ET++sAXIUl3P+I9AqvOXKCmnXaWp9JZOO8bgk/K2DZHWGkkP
         CswXp/YDWUFeWiCLCNzlSzODJQBe+lBNurqJxHZAJTVuav4ZUcsx+KO6BOJcYlC+8AEV
         M4+nGfRIKClahBvqOlhLzMDiENOkewQ+hn24ujf1KlZJgz71U8BMNYZnDJwZVIbtu8Zs
         jSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793743576; x=1794348376;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hv0Uio0iKv6YWg4emi8XyGAuTMh6jvPk4JOtOEL/kqI=;
        b=AnZSKflABMPJeqaEWk0h8kNtYPhq+aPhawVicIfpPlA48oNXo3lUOwYHMjtbfRGKyS
         JDr4DN3WWU/QNyP8vjUhpwBddXUBYBfwdRXG8tUIZHOo7tZtKnDGt3UPvqfbHZAbOc2c
         N5y07ZFq0kBLHJ3on2Lw3VXbsSFU05HFUf6ldkwwhfgPg/roNJ/1P6WEYt3Ek/rU4z9G
         Q/jhhh7HT6ghSRfasE8qpoMsO6aTzLaPkGZASi8UkIf4KPvUaoLhC6dmmnHCcUEFk56C
         g/VfUF6gIiEG+BEgdvSmh/kN3xwqjN7Pzz4qjX1FNjiMrTLe9MHwytIl128eL01aChxe
         pUKg==
X-Forwarded-Encrypted: i=1; AKwUvBzun94opy0yhI7Zw0pA/P4LisrIqnwLylZ+kKmj5Pffb/td6bssjXHstfvuqNVrVX1WHvAqF42lBlbsPPg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dBHpS1l883j6gw0lNonJxAhghgPQqQr4kZp7uHgM+kTPj7py9
	xfqwx9zoKe9hFC/ybhty+Xjxg2qBjj77nlewrYB472Hk4J/3nl/tiVFE
X-Gm-Gg: AYBFou3CuNs9vBeZmh3SAn2h8yE166QWc8Wjp+HmX0AZTR0X238B7O5eYp5FJyA0LfN
	KKJjzZ1vl2m3q+9MvPJEfnE1amu4OD2ttoOe25uj+nIBSTKWxLhFF4z1v9UISD2Qq++IZiajOb2
	Q1ntcuLzgt604SQJug3CQKTrE2HegNqL0gfiFKdshvz/ekmsdDXvVyoaPkJ+SD1+2xzTbp2yYWF
	VvqfsnBNx5BwKphd9yaJ8u17bfjNYdjy4KpfXSw3SNJGA9ihE5gOoqErwB8XvHKRzXQcIVkib6r
	R9/QI2n0v7ltYcDISDxBz5ASZapX09voW0rUfSaIqK1ZbOgZFr2p657lmrXpS9hKoLdwJwEccJ4
	+9KORQuho+dZ4d0FkwK5v0XfphOZWQ/jMe5/c65BZDp7KCR69mSSedvOTnIseeKtqNMU/EyfaD9
	YG27kd5oJUUa+8VB5HtQaFNIDOb3Jf+j6RQ44xYYTJ9w2jaRFskTuYHJ+ZtPtRCSl+jt/QVze6d
	wY9uq6AjgGMhCHL6UG5GytYM36MF+HKLCuARMAoUdyVPgjkc9fgjqeOC3hI+5S4R+ecvq53sste
	qsal6dzdXJ+czcUkbby4aYhgsoJ/HHKZxgwavt9T91qgQrMjzUqQvWU=
X-Received: by 2002:a05:622a:1f90:b0:535:a5fb:645b with SMTP id d75a77b69052e-542b83f7705mr214523681cf.70.1793743576258;
        Tue, 03 Nov 2026 14:06:16 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cf31desm6749061cf.23.2026.11.03.14.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 14:06:15 -0800 (PST)
Message-ID: <9a6429d6-ecd5-45df-bcb3-6bfa235008a9@gmail.com>
Date: Tue, 3 Nov 2026 14:06:13 -0800
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] serial: sb1250-duart: Fix console message
 clobbering at channel resets
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2608060322360.55540@angie.orcam.me.uk>
 <alpine.DEB.2.21.2608060337580.55540@angie.orcam.me.uk>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <alpine.DEB.2.21.2608060337580.55540@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/26 03:54, Maciej W. Rozycki wrote:
> Ensure any characters outstanding have been sent before issuing channel
> resets so as to prevent messages issued to the bootconsole from getting
> clobbered.
> 
> Contrary to device documentation at the time the transmitter empty bit
> is set only the transmit FIFO has been drained and there is still data
> outstanding in the transmitter shift register, so wait an extra amount
> of time for that register to drain too.  This also prevents subsequent
> messages produced to the console from getting clobbered, owing to what
> seems a transmitter synchronisation issue.
> 
> When called from sbd_serial_console_init() it is too early for fsleep()
> to work and even before lpj has been calculated, and therefore neither
> udelay() works.  Therefore delay by hand, observing that roughly 170
> iterations over an Input Port Register read are sufficient for the
> transmitter to drain with the BCM1250 SoC clocked at 800MHz, so using
> 2048 iterations should give enough margin including in particular for
> the faster BCM1480 SoC clocked at 1GHz.
> 
> Fixes: b45d52797432 ("sb1250-duart.c: SB1250 DUART serial support")
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: stable@vger.kernel.org # v2.6.23+

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

