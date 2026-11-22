Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795340243;
	b=iDzcVHRbNxRFLu6SnJ+uZdN02/DaZPqpzUJSgY2tOBzYysfvbAvLip9/moV+6yQUJ1aq
	 AvqNKl6I4e49NG+Ja3DVysiYMc8c10qeTm/zKbTPOrgOcCZg2MBY+OxDLwJbHG1XmLdIm
	 uWzLow7qUrrqTB3wWphOx7cHxD/XCbVwzEf76pRr8DVbW/BfiyU0Bj5luu7R9sAY09PBD
	 IHU34V3Tw7IHz7dJ4fVs3WB8/CgmvvsIZgVDMd5+Bq+XwrFnLNgs8nszcSkjiWKocnQ61
	 vtOj3PRr3zcTx2ORW4kaKfAjD9n3c3uwfo6Lat+XfaVN7AWpbcCHZLhJmhA+a7PvX0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795340243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID;
	bh=0O70Q7pwLusshInas4sUrkw+Osg9GoLbcJc1oYS+7u0=;
	b=MHRNTqRwI0GIasSMAM9Jlco2kZURXLR7Kbq+9acJxcwVW2Y8ae+8AVM3xKY8EzHd8734
	 ep9FnJbKoZ+uVO/6DE00KavwE5HPuND0QKHDRhImH3/O4zrNJzeYTRLLsxYEArXlrD3ZX
	 y3TUM2NkglcP0pHsxUGxtl/JHK6FvYwahPRyRpTRcx0fsnLi+CtP6mpQ3gpaKcffieesU
	 nOILw8aUaWXaG5S3S/kqiTrTMDufc38GPeMQjt9Vg+L2bjSlKNfgCDOSHkptIXLr8L7Pv
	 hv+dmjEgk86f0SuOn/W1i9Oel9ES6nojAP+g5xca7WEmQImmDy82NZ8FJDKuHjqfgZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CSd6iNgZ;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA84606A32A
	for <linux-serial@vger.kernel.org>; Sun, 22 Nov 2026 09:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCA84606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CSd6iNgZ
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b083afebe4so305524a91.0
        for <linux-serial@vger.kernel.org>; Sun, 22 Nov 2026 01:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795340242; x=1795945042; darn=vger.kernel.org;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0O70Q7pwLusshInas4sUrkw+Osg9GoLbcJc1oYS+7u0=;
        b=CSd6iNgZwMRdMIpKElggnjFyr+SaXv2UrhUL0a1aNghamLNZJ4mM+aOxZ96cMtfkhK
         OTHQQ7a8WpsfydVe6ftENotB0PAJ/JB+mso5AoKg2HnDnCtF3xCkRrfO6fdGtTOUDrQ2
         LPQMeBcn4zOr9I0Bu8c2edRtb0S3J8+RgiaUUJl0XT/IYiCPyaS3aVvs4VQ+Q1mMuz+w
         88ze+sGxsvXDQPvqus/f4Y07fIlq4HyBN8HbWR9vBNJ1CIcoItFd1znbeqT7wrCeHmRv
         Q9RRKS5WtZ451mq96bcuMqRFAg52jJ28dYRO8AGzH84nObAq95r2SBy3BQ4d4Um5OKR+
         T2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795340242; x=1795945042;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0O70Q7pwLusshInas4sUrkw+Osg9GoLbcJc1oYS+7u0=;
        b=ycquoWghILDgjHMEY1qAWU9iXcZOwfOMpBiLzP9FZGG6BsR8W9qTAWTG0LH97OXBoA
         bWhY4X+6FsLkODJXA3qahP/B09gGVyX6srXtvnmsrpATkAUfSS12z/hdmXYLOvJesf20
         hWtrGIreqrEhaaB2HizHLuBIh2CGg6aAcM0KmUgcUd1zs2jTnX9ShMTBAJRoLzoxSzEu
         KvaMjqdCEH8HOxzYkHZvBjOHQQnsB/nPoFU84H6qVP2ayWPQq7YNUq6QXLl2YufGDgkK
         zhrdwOhTTL3z/syeFifYnGcvGprpmaSX8d8yG0iyhxNEza3sTOJ0Ga01cOCrrOeQg3vM
         WFXw==
X-Forwarded-Encrypted: i=1; AL+hErF5N0iv7hBakalJS+18DSuhhz3Fl+wxlU0XkT4tLSWAHPR3oss5aFK/h22JvMvL7TiBIvc88MQvsX4+hCc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jpDsn/6swSOMIg/vT1c/jyUcC7jHrGCZxpWfuQThJ2bBqmAa3
	4iSQYp4veM9ODZOqPy1u/aMXpfFS+gaZqlXjZv5wjcmt0M9bTPU4T/Qs
X-Gm-Gg: AZFdTZcOwp30QHaZa1m6yYQumVEawG4Tng+mVwk960vIpzwFLcZSqOXzdSPhNixKPME
	T6opvpKZdTFClvChXB1BEuMlFFRYIr5R93onrmD3zXrjNF8/OP7dtTH9SysE2ogiEVzt53ML76p
	UCWTWC9M2Y0Wcbe6iGtOWc/EmDqPJdzfZhX+KuV6uxE6EtVzfolrdxx7Ju3ZvG5ThITK6h5hvSe
	aY/RJ74DRFr4boFZ+zh8vTOQ1hMQ2OglWEM4nvvevzBEohs3uXQ254+nsUN6+Z3jAzsA5G2nX8S
	GAER2Cp7jLHHMTWUK5RYh2CTzELUTtyrP8+R25fi87LJ4xlF9Q3DeiarayK8lEkcSeQ2/G/REPe
	5fqtWiqgHKncW3tfb22flVcL9/Og4GyczraZYlACnC6ZewS13ri4nBJIOXFsE9Zx24vt8cS/5wb
	C2Qi3ZlP3qsjJ4uegpZ9j8F1DMtTX2vntnw3Ls1WWp/KroptB67HGc23DRP4cUhJOzh4ZhMGA6r
	FbuZ+0Yln9NV1svP8p1RsXTi4GKkwu4lFUIMySC2kFNb6qHYHJw6a8TIVKsS7H4hlOsezd0FW4u
	FblSqrOLLrsqD1bBsI18i996aHwlXIJ9yyhfBuqaYXMnEvzpPsO9rnT4yLv1TMsXtZU89WjCsEp
	f/Ccz6Ra4kqOo8kUYk5isoaX90Ys=
X-Received: by 2002:a17:90b:2ecb:b0:3b0:9a3e:bf8b with SMTP id 98e67ed59e1d1-3b41c98a1f8mr12481111a91.6.1795340242152;
        Sun, 22 Nov 2026 01:37:22 -0800 (PST)
Received: from claudebox.iyengar.cloud ([50.39.139.68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfe9bb9sm3367272a12.12.2026.11.22.01.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 01:37:20 -0800 (PST)
From: Arun Iyengar <aiyengar1990@gmail.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v6 0/8] serial: 8250_dw: describe the Allwinner H616 and
 A523 UART configurations
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Sun, 22 Nov 2026 09:37:19 -0000
Message-ID: <179534023971.231108.3039673113639895699@gmail.com>

Tested patches 1-7 on an Orange Pi Zero2 (H616), backported to v7.3.3
with the two prerequisites; 8/8 not applied (no A523 here). The UART0
console at 115200 passed about 700 KB out and 350 KB in with matching
md5 sums and no frame, parity or overrun errors. UART0 and UART5 come
up as 16550A with a 256-byte FIFO, and rx_trig_bytes 1, 64, 128 and 254
set and read back.

Tested-by: Arun Iyengar <aiyengar1990@gmail.com>
