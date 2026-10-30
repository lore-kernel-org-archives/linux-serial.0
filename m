Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360042;
	b=X8no1YN+ltAJp4BlhKuG6aL/8yhXF5Od9tz1p93EDZCHeY589pqb7Fq4O4JuSeI9Arba
	 FDcFKJqC91MVLHNZZyvjlWOs7qbnQtlXJPWp4mCpi8drLqpJERC4jCxtBZcCqS/TGuVfW
	 3U0MuvASwmtuChlryv0nVYyI8ZwGAvIrrkiHQG0wLwRfHxEX49PxV7B6UOjtsJnBGQeU5
	 Gk0dHyWuSCqDPoRWt+bwysnN1pITyfCfBPYIw0/1LjJyHh4/Jp4f7Q0kJ3sh/g61qlU+u
	 v2XGFan2djhB6usD9jgiktoOHaJyYawBXndRAFuHoIJ58JIBBIRrJd7tsqbUHo0AV6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cI5Hjpdp7zO9I2V61FPJbbgLxeyy0DYFAxQRxLR6EAc=;
	b=p/4GvF3uBZNiz4iZAc2qYnchE+bDFNy3s2GjGlfxTiV7FtxfNU82PQ1PPs4+f+7zgUXf
	 Huw/2dmtFwyPsv6btxMcx8SE85SJ2MpJAtxOVEt6fxTLcGHc3KbAmm+zp1gtK12ZGQtyU
	 vl4rhTGP9vE3M7oyT0u6PQno1YZNQtA2dPAnH9oSGUK0E7W6N44I5ET5QJ2Z9vwUF1ZVV
	 pE0IcY7jQaJBIBRF873qy6cBrvR3nJEeX/dHg0CAhlqtdw4ggcxud/wzILdc/7ieIiDmG
	 4uvhR9Kuwb266NCK/aM7W4So8WlSLdHU1Z3Q/TvqOv/OwJKuOaxcjgCHfTkHYSX7sVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qJbow+Ry;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2220606A31E
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 11:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2220606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qJbow+Ry
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15dd124bbe7so1004613c88.1
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 04:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793360041; x=1793964841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cI5Hjpdp7zO9I2V61FPJbbgLxeyy0DYFAxQRxLR6EAc=;
        b=qJbow+RyFWF5QFZ1uK9QqF+vowuLwxygWZLw3anLNkpKt2i+llLDUTDFmgfzAzjRDW
         oyoO4VUhqgpzvKvOjHKs+v0GdLN2btyCgZ3VD+WGsHR2hYOqCkx85LT38YXk/IqcJNiC
         h234mBMjvur1K224jgfEktoInVsrpWOUt4hyGawetllJ/V8UOmCz7Zbvn3P8c1/uezFi
         FxbQZNbgWqxGWcS8MfP6+lGInMZVeDUSpYHXoakWwI2Xw0JJ6Q8TR1wo+c6TG7Zkw5yE
         dI2qrjaklS8FQIjpCEZTp6sr0+yqS1dWRZD32ne98Gi6+XLuQYF1tvdu3epsW3V+mlGu
         EquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793360041; x=1793964841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cI5Hjpdp7zO9I2V61FPJbbgLxeyy0DYFAxQRxLR6EAc=;
        b=SBog9DV6kgPXrpwPModVPawXjRH7MSgwQl+w5oom5Qj5oO+RE7bxGTNbVGOLxObpFs
         mgdVWS4C+Deh3md2EJD3bAXrRMKXxLp5i7fsYd/B+yXYH3klnnN2m3lyWPK33eNfKxRz
         IcU+eqeGk563L0OmoEm8Cgtr2grvhFjDkWg6GNLkGgrKOH1HVwdbZ2rd4iO1O/tdqaVY
         PKNTBZ60en1qWHyqcys/zTlKy4RlLTHuzJa3GIxH9CyZK94vsffQsTEMVfeOEXGP+0lP
         l2tD0X/RJMdTwC5MMpneCjMqGq6mIl+raW8o6SyGml8npjRByesIZrsCOTwv3DQWMGeq
         jrPg==
X-Forwarded-Encrypted: i=1; AKwUvByAtytSVOHmQ7biSMsyUpN3bpH86rixevF8Zu87P4hFEUNPeLiG2ZEvy+xb5fCVfQfMxpRDsN4NNz1IpX0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLF2Mr9lfNQQw8bnvSeOTF0XW0Qs7qKZmUwEKeXCp8Gwba/l8GK
	1ResU2WfH8DsBHZaIi5qZ42tRTuI9xYO/hB8IfN9Hsj+TPadr6FDD43x
X-Gm-Gg: AYBFou1/LapYwtHZyLhgb1lE11LMJVpu7CDlAccGGEr1paE/mxTHtM9tWvOpvJpbWyd
	tbF3HjpNGG1KvLxUcNI6TSt1c51CkRhew9cGuZ2LM6+VetDdGmjZmXs1q5y/6bM13Y7r6SlnW43
	bTOOXYcpsiXiWML9vIKSFKIb/qc44Z1dvpZQiTGJFUqi4h1TCHRQFENhUwUT1B1Huv2Pav+pgU2
	J/gK3WKnWrik5qDCzBJtqAuWgAHZFmFizSgGijo820Dlx+ADWy8jF3HHmpp/a5g/8FlOuj8TUE8
	83NtG9osAnTzdYHgvauKkYuY/+9/1MRDzGVtbaaC6FFZlFerm5PYByfsi+TqRInaqmgjo7Ur/cv
	sYTxwVRc6mBlDdd8/wkXL1FYjQYOvI7X+yw9g/MJNiyoFWMCPt50i5LmYQZv16PcQo2OOaUrZFh
	79xj9mrO1l5zmqkGMWFOhpjoZMZ1ab/zI14caNugNqYAYgiXUKrczH6XsgH2CPh37avfZomcdC/
	+beyxgxq2geiOfDkzh9goXu8Lk8kHrTqu5AlTFGP3TMsIsu0iGyWOt1VPtkhaL9h2FkDVIniWrr
	Xor7cSDwdkWDWziG0mxyCWrasTACTPFP0GSGFrIvEg6brg==
X-Received: by 2002:a05:701b:424b:20b0:199:7dff:f9cc with SMTP id a92af1059eb24-1ac5ceefcafmr2906676c88.42.1793360040974;
        Fri, 30 Oct 2026 04:34:00 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac193b8179sm7809929c88.11.2026.10.30.04.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:34:00 -0700 (PDT)
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
Date: Fri, 30 Oct 2026 19:33:56 +0800
Message-ID: <20261030113356.248358-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026103043-tributary-partake-aefd@gregkh>
References: <2026103043-tributary-partake-aefd@gregkh>
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

On Fri, Oct 30, 2026 at 09:33:41AM +0100, Greg KH wrote:
> So this feature has never worked?  Or it is just "one change only"?  So
> your change is an addition to the feature, not a bugfix?

It is a fix.  154b7a489a5b ("Input: sysrq - allow specifying alternate
reset sequence") added reset_seq as a writable parameter, together with
a version counter so that each keyboard rereads the sequence after a
write.  The reread just never clears the old keys, so on a keyboard
that already used the old value, a new one has never worked.  Hardly
anyone changes it at runtime, which is likely why nobody noticed.

> So this isn't a "real" issue?  If you are modifying the key sequence,
> how can you press the key at the same time?  Doing "major" rework for
> that might just not be worth it.

Agreed, please drop 1/2.  With only 2/2, that race can hit any
keyboard, not only ones that never used a sequence.  Do you want 2/2
resent on its own?

Thanks,
Zhan Xusheng
