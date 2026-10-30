Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793341860;
	b=QsW6T9r9z3aF3xlWJpsWSh9AZ0JjrLZy4CTDmjQg+owSVwBmHCcGUDWE9cpbPJtqxlCZ
	 KNr4KAR49OIa8lNUNedAonSpkKiQsvX9JaljQgkirglr9aXFKXSLYSTXLRfWjMiBmob3G
	 wNipvC0nMahStTl2A7s0dpJPDeCKxy9k3aehClflOJYL75vDddAYVlPcJRJPQGRX3tQmc
	 ibXXlFarnRLp1o4Nc9uTN6iAzyNEObRgucC2CTJ0ClSEiHMnaY70ywqzDsc0QiIE98BXn
	 NeDnmdXROUOJNytjI9CMYogdI09c5toAB1h7dCa6IOhUFY6ZJLW7ENYwkoZYAn6rsjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793341860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UppOoST0Trl7TROBBYtHebLU93t2eXyMY6EcGmmSljU=;
	b=xKVqQhJYUfI5w1aEjmsQXl10p6FHp/jZu6/lWFb6Q2fYXh6qcLKSObvqb2RI76husfSy
	 3fD2H3qs1vQhA4LF/3tWAdZXI61/U+iCZiNNpGeQy9EC4Tgsmes3zXbngnNF2Xa0AGVVI
	 4Z93v2vjLKWv7TKUxVPEZXmvYPUGCykymuyutd6txnkbOUKThyVagfoGz0RJkOlKwFQq5
	 7q92N/hFgH/sWDeo1EqgPut0s3XOK68+TPa3gX6jBC3tQnpOsUUXd8gLe0I+qTHTzW5JA
	 NhsS/Eprh+QnuZLSMmT0MoS68TJsgR97jDHF0iBQTGsnUkYfCrufvkob6htyr/DzD2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HmhjGgHz;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC8606A31C
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 06:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3EC8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HmhjGgHz
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33fb4680717so978181eec.1
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 23:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793341859; x=1793946659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UppOoST0Trl7TROBBYtHebLU93t2eXyMY6EcGmmSljU=;
        b=HmhjGgHzKfVwRzuxoZn9FAH+hl9oEvGgNolCPK3hxscZsQxL9/qZaEgAYM63Mj08eZ
         3BkNCkGGqBT01aGnBhd1z05UHeOVYZ0PXB4Ve0u9oke8Y0kdiFOdiUB24aUgmGcE35YN
         x0v2ySqq5BYQa+n/YnWDJ8xwO4SeLmEowhO082yfGHONJVlJhdqc0WCclA//NQFwbGzV
         wQT9tTkTF91BmYJazkzHCQse8bQTQI563EugFUKluhZgZhbI+tSHvbQZTLO5a4yOgEEF
         rCAv982dGFLUqvoFRmmKJVeYUnbOamtcFiJfW1IOFmF5EqYgKJxGvaUpUGGxtafEyt1s
         QyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793341859; x=1793946659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UppOoST0Trl7TROBBYtHebLU93t2eXyMY6EcGmmSljU=;
        b=iubsidBsbbNKu34OmT42Lb60Swfb4aBpxYgdJPdK1Ge9NvQx0QjDB1WTaB2wG/bpjR
         IqTWSYg76obj1Ip//uXafyxn8yLE+OT30IeGuB39jqnlrhjA69POp/stM181HMmOsbJH
         SLAlwv+zbMmLHwQ9FaL9CeuCoozpY5QF9ZVRj+RgwgsY3rqGrauQ/s1/cDu6oAGW0jMo
         bul80zkqERmPy2FwGtsp9SS/cSCeCkuz+yDu3zNuwNefzIfkGsB9BaaXC2fdqCS9Eggs
         ZcpSh+0Ti+JdCDIz4KoDkVRkYh5pALu89UzhoTG2tXphAYsd5cs29WoYVIwFnM0E5CIN
         SgLA==
X-Forwarded-Encrypted: i=1; AKwUvBwyQq/uQhtON83MqRJQOwh7unCM4nxig9l0OWeb0Sw09M6Ap1tyOML3fJjsbtHPkvNDAh6RZSfpSRnhxBU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKp01feW/CpTEDeIf3dZoEfj8WvBzjN5yOTdIPW1djM2jC/s54U
	PnzD60vG4xq11G+gfonKC4SvgMfMkKCcZbHKPcxos+9MYYDU9jDTd85z
X-Gm-Gg: AYBFou1y4cQGQ7p9sVYnRNh6KMYmp0CZBBoguBFYjNmWurs0YzPOTdm9sXxf0ODEy47
	RbJ9uF5vxNLONJT/WWkAK1lRelebCfIrZk0M0UPC7ALzZkb0MtLXAE7QycO9y7Sc5K8Q6zwfJZV
	7I4moWrusBj7SEv1G0SZEQAD0EoamvHh/0Pf+6UVuUNMucE5MzlXhLeyRBXvnBc385+6jmsiCVW
	6LfoETA8tMne+BGQH7k4a0KwdnaQ0DzSAAY6hM3DdOrcSPdaJ0OpbJT9+CEGahW0ZlcqEEvToi9
	6X+5FyRhiKEKtEMH17g6rWmLxBhmxuq+MBceASmP/+IjCx7xT3prKYFshIY61EFEFnz8UAIJ1pU
	doYh/CjnAh42JK43ysRK9iNDw3p2ttZptwlLny1EhzNm3kZJZuMwH+5y+ifhbk3INXPpUAR6XzV
	zBykMFOrA1kGHK+gKCCgzcOONzdE8olbx3Yaqd9EbwVRhhCWQrYhUloENqzg4Oct6IpsQBw7qf3
	Ce5uvjMwSshDhN3SIsNtLrqhhjFweFwF9mQ0ppuBL/j9QOJZT90vuRnHNmxoIbvPqa9n0FVcbtZ
	qNXAQ/qp5DOmNzvazBZm7eJ9H56znkIEn0Vs2lUMh97c2w==
X-Received: by 2002:a05:693c:88cd:10b0:369:4c3f:8a5 with SMTP id 5a478bee46e88-36a4238940fmr2362399eec.14.1793341858562;
        Thu, 29 Oct 2026 23:30:58 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1easm3914964eec.5.2026.10.29.23.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 23:30:58 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	dmitry.torokhov@gmail.com,
	mathieu.poirier@linaro.org,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH v4 1/2] tty: sysrq: don't expose a partially written reset_seq
Date: Fri, 30 Oct 2026 14:30:53 +0800
Message-ID: <20261030063053.170432-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026103031-hungrily-compile-49c8@gregkh>
References: <2026103031-hungrily-compile-49c8@gregkh>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

On Fri, Oct 30, 2026 at 07:05:10AM +0100, Greg KH wrote:
> I'm sorry, but I can't really parse this llm-generated text.  What is
> the bug here.  What is being fixed?  And what is changing?

Sorry, that was unreadable.

reset_seq can be changed at runtime, but the new value doesn't work:
each keyboard keeps counting the old keys too, so pressing the new
sequence does nothing.  2/2 fixes that.

1/2 is for a race that 2/2 makes easier to hit.  The new list is filled
in one key at a time and the keyboards pick up each partial list, so
pressing the first new key during the write can reboot the machine.

> And how has no one ever hit this issue in the decades that it has been
> present?  Is this really something that needs to be fixed?  If so, why?

The sequence is usually set on the command line or in DT, and that
works.  Both bugs need a runtime change, and the race also needs a key
press during the write, which takes microseconds.  I only hit it with
an added delay.

1/2 is far too big for that.  Telling the keyboards about the new value
only once the whole list is written avoids the race with a small patch,
and doesn't change what the parameter accepts.  I can send that with
2/2 as v5, or drop the series if runtime changes aren't worth fixing.

Thanks,
Zhan Xusheng
