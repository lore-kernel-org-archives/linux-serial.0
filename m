Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D491DE3A8;
	Mon, 31 Mar 2025 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743418650; cv=none; b=lXsY4e6CaAObw2oRWz5X7a9nvKK5lg0a3iP6v++1+spHEshewsb9A1q3WZXSmWoZBO01rHRiumeX0SfEO/D5r8o99TQmHw0QpvsBWBeWEs2AldFeKpGD2Mz2G+1Xpn1Rx0gfUcJRkkGsmR6E5PaibSK7TmxhO1xKjVtJY7shWxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743418650; c=relaxed/simple;
	bh=09yqRkz8LTxcnQum29LjmUWWXJkwcJhFdYmdig6HcgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXAh7jtVuaO+6ZGhFWSUVD6t1eNyU1yidRA2l9yJsG6Jin0nuVjrhHNAdG3jYsAYlplabWDCyOBB99tEGKWurCwZmMPeXxvRxEqZcyVX0vy6t+I45rmUpsNiWtYZ5rdnP+tRhaGjNM1AwUlphWGPTZlNUZ2fGQlIMihc/1Q7o+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efEeA3cW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efEeA3cW"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-227cf12df27so61054595ad.0;
        Mon, 31 Mar 2025 03:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743418648; x=1744023448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQxoGO+j1MyZc3JaI/rKrHOI5r9i4Uu5nnw1H4HdvvM=;
        b=efEeA3cWInkiE4H6xdpflnmXpW4H6usWL9k3pd4mgloulYAVV+b9TcPZ5BN3TPclMU
         lUagS6Z6zOHIuoGxtIw7dlxRi8BavqBDVpNtBHhLi6D1FiG3x92slDTXoEJwG+ZGpXOR
         h/RBgGXdPlOsNTiYfJAqV+fmsioeTVD6E9rPi/CsgjAPx/60J1SCifS5ZKgAEY7BkWr0
         RYj+xYk53pttnN0PFvXy9VHyd6wKHw+kQ9JZrtJG6Z7O5ndCcoCzPTHf0HWM3JBc0m4T
         MNDGw546Tn5+4Hk76M4oTpskEjf9tsdWX3chWVIGo3I/ukzDtpcNoWgp5qvG4dKQjceN
         J8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743418648; x=1744023448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQxoGO+j1MyZc3JaI/rKrHOI5r9i4Uu5nnw1H4HdvvM=;
        b=jjibRsymXytE4WEOgTSa8d2DYBC8QbDRDKK7xobTRbyfqWN01ZYsoJRlb5dfy+2eKO
         6Lf/RdtOS1OqDjQrDygbCku8OZ16JX/6ov0Xwm69UNZ3NzNxdQKzI/2iQ4smjK/NGUE8
         404Y2xQ8xRG5pKbSVWobrM8My7VrRssXqXL2HWL/aUN4TAVRRRY2aYq+75LMDtz1/amD
         Sh+MqkTBS/sSfRb5ybE/srcgJ7+KDwoCV7Dyc69PZ0qVJ0aoSwriUWOWpPFG8d8KbXsc
         zg7xyP65Wsbmh8zIMFBrScwwP4xNZv1gumW5B988ChJFfxRFmtwMeh5w72mWL98dezwy
         j7RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDQAQ8AABeFxbnoenIoYa0Oo1gc3uaAlp5IN6HOMaSvAqKqk481dqwl+4Sh5vHhT7OKHYQnliUc5n6+e+e@vger.kernel.org, AJvYcCWTAjTXuyEpruufSGgomwqzcGUMPiFhhkd/ru4AEAEc30P2cULnTawGd5YbpVp/FAcsk7jb6xd2nrJJwqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1vS5EkXYCRGhWJrhJsCYmgknRy7O+YJ27jFnMfb8cUiURUbIt
	/sORJW3vEke2fFHIoiYG4z03dCEOgeTv1WCJKmvKaFSBAhmyqH7s
X-Gm-Gg: ASbGncsrFGNXD8to1WPKV0c3cKmChRlYaQpg43btTTSKVpGl8/U28tapLpF7c4NyVQh
	/UsID6gKbeKMErakewlzKBKs74ffCLV12Nm2TrcO8wGM0lC90mCsPB8Hi8Fm4RAKTNcR1NVtLoR
	THy74MHCl9ACSJ+Bm97fT4YoA+LFO1UYgrzhtKjwhzk4oPmTagpzIKVLBQXe7/1IYbl8Z5Ky2Rr
	3XfR7QqF+sJL+qNsqpRfTNn6Ur5ATgZBGSYjb2cYCP2YSX7fMZYXkQGeeWqMbUzjpyPVFVUzefh
	3fCZY5XJWN+Kx6Cvm3nBsokn6KjEJNGnFUF0dpSylGd4gGufzVAnfMCfKnb+cn1ac/MxNeB+Af6
	kYz4KzEturTXh0Ds93iHETvf5KADnTGhK/GcR5wwqCA==
X-Google-Smtp-Source: AGHT+IHNmQ9Qu2Wh8ipfkyOz9gG66AB6OTRqclxipqrg+lUH4XOIHmm7HxeHOz4+gDNk+/q1p1iFAA==
X-Received: by 2002:a17:903:2341:b0:21f:6f33:f96 with SMTP id d9443c01a7336-22921ca356bmr192345245ad.6.1743418648294;
        Mon, 31 Mar 2025 03:57:28 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397109d241sm6660848b3a.129.2025.03.31.03.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 03:57:28 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: bigeasy@linutronix.de
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	conor.dooley@microchip.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pmladek@suse.com,
	ryotkkr98@gmail.com,
	samuel.holland@sifive.com,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v3 2/2] serial: sifive: Switch to nbcon console
Date: Mon, 31 Mar 2025 19:57:19 +0900
Message-Id: <20250331105719.8409-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331080318.BdZQodhu@linutronix.de>
References: <20250331080318.BdZQodhu@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sebastian,

On Mon, 31 Mar 2025 10:03:18 +0200, Sebastian Andrzej Siewior wrote:
>On 2025-03-30 20:21:09 [+0900], Ryo Takakura wrote:
>> --- a/drivers/tty/serial/sifive.c
>> +++ b/drivers/tty/serial/sifive.c
>> @@ -785,33 +786,88 @@ static void sifive_serial_console_putchar(struct uart_port *port, unsigned char
>>  
>>  	__ssp_wait_for_xmitr(ssp);
>>  	__ssp_transmit_char(ssp, ch);
>> +
>> +	ssp->console_line_ended = (ch == '\n');
>> +}
>> +
>> +static void sifive_serial_device_lock(struct console *co, unsigned long *flags)
>> +{
>> +	struct uart_port *up = &sifive_serial_console_ports[co->index]->port;
>> +
>> +	return __uart_port_lock_irqsave(up, flags);
>
>this does look odd. A return statement in a return-void function. The
>imx driver started it…

Oh I see. I wasn't paying enough attetion to it...
I'll fix it for the next version, Thanks!

Sincerely,
Ryo Takakura

>> +}
>> +
>> +static void sifive_serial_device_unlock(struct console *co, unsigned long flags)
>> +{
>> +	struct uart_port *up = &sifive_serial_console_ports[co->index]->port;
>> +
>> +	return __uart_port_unlock_irqrestore(up, flags);
>>  }
>
>Sebastian
