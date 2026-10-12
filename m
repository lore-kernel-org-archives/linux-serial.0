Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA084399D6
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789888; cv=none; b=anpNS7DbZk9ehFfrK5L4aRFdfushOQ3u/J5hB1GQ5SWvW54dMZbOVSL7TYgpyfyZ9vA4wpjkum+cDyWCP87mlk2aCmEGZ7IcE1voHzUP1gnOWZ2XW51KoSuF9ExxFqex9AdYYlBrVxtoDZrbD28MaVG2YEMJWdRLekQ28mGNPeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789888; c=relaxed/simple;
	bh=jV17N1XnG5N3su2j27UvWD50Emp1boXs8D7A8+3TlcU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NDLIBk6LOu4c8XEG0mphIW/zfaOTwd65R6E3rUPOV10rdzl7Ge56Ccb/eM3rSFB1fqWJqwJHTN1FtaFmmxudhblzxU1UjZ07SZOCT34K9t5GtlIL64cY4Q2YaxI2EPEpBdP9LH2wlYOd/pLJ+QhI11CpL2wp3tt8oVCOIHxRTtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=de2lYInm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de2lYInm"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so12318415e9.2
        for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 00:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791789886; x=1792394686; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CV4XRNqthVu3jHiDgMNv0zc2zrlUjFwHtxZxyGCKLaE=;
        b=de2lYInmXLjrAgQWTM2tuSxy18BhEZYiJmZQYuHlxVsriTY2f+l0E5S3dDakUFxK+g
         vMfFzd1wZ78JMnHTXjv29O8+7EGD/Sprhy/X+n6kLq+D3adBmJAjan/lx9FUgPgy6msq
         XROyye6iEomYtJ6wlfbtT5MRKdjdiuSkuxGSJWy/Vxh9VZaAK+7sWwoSnenYb76GorkK
         GrLu+IAzaR30mWYMSlJULjk8oPVBA4ntWFZQ6AxNN21w7bNC36R7vdbu8xBQLsEzwksK
         erKKDLaTGcZS+FVA7vk1lEYdPAuttewf5y4cTAyUbZCClGE34AHbJwEbfsGPWSkKnoxv
         37vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791789886; x=1792394686;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CV4XRNqthVu3jHiDgMNv0zc2zrlUjFwHtxZxyGCKLaE=;
        b=QMyMURBZfjmdL5cPiClcbW/MlXRtZ4oVy2xYnYDSNeBfsHc782RoW8dNtYBqEh/6Z9
         PGf1fZe6zP9U02R4aw8Pgm+ltQdEebyJ+VjXq12mylyr2NsarvE4x9Qv/OYLofccPw67
         hYgjUvCbcw3fEiIL7AzQl2io/3i6JVd1DaHTN1wVWORVLbVRlK6MUj1Io9Vxw8wSBfSv
         qu2wmNZIFxFlxVBQxRjxlcjwPyJICRxQWjG53wwZj6waxn36ECnCVW3DdwS7fn8mekL1
         qGA4DP0IJ+pe0w+iHSgHRQ3617CqcHOb1B3dELS8qD75Ctev3RE1WWczefGJwYZhdToe
         iYwA==
X-Forwarded-Encrypted: i=1; AKwUvBxDBR+RcaWZenLBhXL4p4dfBshB8/VBcR+uKYBNxOQo7hqGlliu12CRRJtP6+lTliKg9dTNBmilP1N8hTw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJikr/OnRzYnMRlE1J5Hjy685oqfCBi01L0UfC9LATzkpjZHoFc
	4q+fGn1/mxEqkZks7SQT4O7qAqrDt0UQLMgErOyk5zBF09YgZX7seMOG
X-Gm-Gg: AYBFou3rwIN93GvDt3a94aZ/O02QUKsY1XhzeEIVMMuObWRVDh2rWb8/VZgSlIzv1kr
	OwkxSwv4SA/cN5L+dkstBvPFmdHqgCT+qX6VdYZzzd5Q40eFPjkaiy/iHHO2J9dpIMmkw5Rhvv1
	gonbIU7N0YZkpuDm4/g33ZodXIHp3/ACBqYiqcHDKKa4EGSJvvutyUTuNI/3t1AAnnGK83Jsbxv
	etClBCoezSUig27fFs3LUDLP2bjHBF82tng77F9rDCEPEUKr6DP5DzgEOZAu+TsblachxTKw9e/
	XBL4nljiLNjynaFpEhASnQ0iXocSfCiJW/V/bf9m6ObxqfDFE8WNmxfddw5yrg03Cff7N1VXCZX
	0/FqEQPSaFwHD7SeD98Z/FDjJ4XWw7/BbiK1HhtYpiCnw0g+dlORUKWfxzSN84KWp6+i4FzwUqs
	XxfOKnSeNnLqJOk5jf3xa9ZVsvsUrwyq4chtnTN57YmCFFoUqd4m7RuCumbiXtXxi8fL4C7ZH8P
	y6aKsQo3vMV+y7JPyXysYKoUy6NTog2zniNja6sDdDpCX0ADlQ2+VYctpTrK7mQ1ek=
X-Received: by 2002:a05:600c:4ecc:b0:49c:fa21:e749 with SMTP id 5b1f17b1804b1-4a18e4d55f2mr191008715e9.31.1791789885437;
        Mon, 12 Oct 2026 00:24:45 -0700 (PDT)
Received: from [127.0.1.1] (ip-024-215.users.dtel.ru. [91.210.24.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e48db03sm380276065e9.3.2026.10.12.00.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:24:44 -0700 (PDT)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-serial@vger.kernel.org,
 robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH RFC v3 07/10] tty: serial: Add Cortina UART driver
In-Reply-To: <b48bdddf-2218-4164-8a76-e9cfa2802111@kernel.org>
References: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
 <20261012-b4-cs75xx-v3-7-0e0d17a098cf@gmail.com>
 <sashiko-outbox-167778@kernel.org>
 <b48bdddf-2218-4164-8a76-e9cfa2802111@kernel.org>
Date: Mon, 12 Oct 2026 10:24:34 +0300
Message-ID: <179178987463.76422.8459872081179927553@gmail.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

On 12. 10. 26, 9:13, Jiri Slaby wrote:
> On 12. 10. 26, 9:10, sashiko-bot@kernel.org wrote:
>>> +static void cortina_uart_set_termios(struct uart_port *port,
>>> +				     struct ktermios *termios,
>>> +				     const struct ktermios *old)
>>> +{
>> [ ... ]
>>> +	uart_port_lock_irqsave(port, &flags);
>
> Seeing this, why not to use guard()?

No good reason. v4 uses guard()/scoped_guard() for the port lock in
startup, shutdown and set_termios, the sysrq-aware
guard(uart_port_lock_check_sysrq_irqsave) in the interrupt handler, and
guard(mutex) for the port table in probe and remove. console_write()
keeps the explicit lock/trylock pair for the oops case.

v4 also addresses the RX points sashiko raised in this mail: the driver
now sets read_status_mask/ignore_status_mask from INPCK/IGNPAR, reports
parity and framing errors as TTY_PARITY/TTY_FRAME, and inserts the
overrun marker after the characters drained from the FIFO. The hardware
latches these errors only in the interrupt status register (RXDAT has
just the data and a valid bit), so the error is charged to the first
character read in that interrupt.

Thanks,
Fil

