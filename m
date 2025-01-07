Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCAC53AC
	for <linux-serial@vger.kernel.org>; Tue,  7 Jan 2025 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273278; cv=none; b=Du0Uvd88y013Hkx+wLnZodZJ7FGd4wNybrBpcMigTQ6lIv325vV27gcnVnlTQBjv8ilyuhwV5X26CsKDWWBrrrdn2uLHSsmwJP4fz1Te9ttrS4sEj1IN8lVBnogl6LhmI5eRnn6l1WlBYuE+zR3flIW9hIe7K7CTXZxYu5rn2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273278; c=relaxed/simple;
	bh=0u9MgW16bgC2dEV6Ukdtx0nFJzGnOVOiP4ZURlBVu80=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=b14QAQDOxH4WnS5E1plzt4xAV8XPrAKius1G8VRsrljBNFn4RX6r9xRWLMSOWUFMa7H9ERSOWK0a4qvjlnxHPmHghV+MrfFYQOiQZCK40ws/U+NA+gaC+ecjDqyKBMVJM1D4iYMs4CZJ9VEkipTnJpunEZbQQ2bdW1z/yzwoOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx/uXFvR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx/uXFvR"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so2614719366b.2
        for <linux-serial@vger.kernel.org>; Tue, 07 Jan 2025 10:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736273274; x=1736878074; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vzx+HdaxCDWyGf62BmuKh1ikMoaa5bQ6XS9Y+e2EN1c=;
        b=Rx/uXFvRekfY+CyfIWJZwDz5S9CnlxBN7o5qNBGDMlnrq+4LApIK2oEPbH7Fgma4Ul
         Ud3ylguE+3uwGyxtpSCQuQ4Mpq8wMNKWon2FSOo/lD/IC3H8N3KwvOqUNShc29weoRem
         ugfJFSdts8NzvaCRxdU3lHQYK8OfwPZPOIVewmJ/UiOYXVCeS7BnPOH1ubNoSmk0PsBy
         hmDaTfiYcYdwEicTqAQHpCqD4JmBJlp9Y1GnOkiZz0KY5p3vCcBHCxq5qegNItujEzoi
         tXhhOJ1DdVgJoIs9yIx0HZwUwuwMsse34DZQ46Fgczf9zHMbs6ydG9vuMcN4HXHC6/2k
         Evow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736273274; x=1736878074;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vzx+HdaxCDWyGf62BmuKh1ikMoaa5bQ6XS9Y+e2EN1c=;
        b=aJZs14pUcVln52qvgF5bdhx/DeLuV9km0dMO0XY+ChyoIpPgHWIZ2JyVNBj+3CTolL
         7BU8FGU79TG/Hz6fn+Uu3JBjtq2HgU/ymQTJfKzStt+H2Nq2wzy4oRwFslxa+KSd47Ft
         9leIrjdzUH1c8cQeuB2KvC/1YxK8DSqvXB3EUoU6GJdELMAIFkzpz4r7Kj6ZHhtIxT4a
         ZzkM0VrDEa03aeVhfgQFS4Id4dBI7ZtcNYCzu4uWQFNE79g6f4NgnOw4B+qML1irRCno
         nC9IO7Uei3A8beCSfBegayQL4FvKVDzSwokhEg/5XxJUJLXFzcLMVHb02tV6z7JrMI45
         KXJQ==
X-Gm-Message-State: AOJu0Yz2EC6cqXHpzLCd5bIUpKDwwQe55Z46iLaWsOGJ5TfApkknhYYC
	B7hfYL4fNaM7HddXUIs9uxk8I8xftQ0jTl7MQ67mXPgVwQ30RijBAurzM1tC/yYGQLutcEblwAW
	k0K59LA9Ll2D1gGNfMrhDAxhhwHVbv5U=
X-Gm-Gg: ASbGncsnWj74MMbPchEkDkNuJvT0yM9vjSjSmMx+8DKS2jyJiaYG6Zd0dV+cwbYnuOB
	5fvtRdj2XHoaZINdT72WEVWb5nKHiVQSDduw=
X-Google-Smtp-Source: AGHT+IHe8euZESlyTAkAKQVyPhpv2BpHqHEtbGr22QZF0PGjupQFrBULLm8Brr7wSy02khMUojm/ln0RgZZRU6OH+KY=
X-Received: by 2002:a17:907:1c9e:b0:aa6:6276:fe5a with SMTP id
 a640c23a62f3a-aac3465010fmr4947861866b.43.1736273274353; Tue, 07 Jan 2025
 10:07:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Date: Tue, 7 Jan 2025 19:07:42 +0100
X-Gm-Features: AbW1kvYVdNXR7o-9S2TPvtwQQEAuUG_yc543Vp1yz9MmL3qoni7ut5vq31pObD4
Message-ID: <CAH2-hcJVhxubEsRciMSrp2x4WyDrmmYNe0Db9-LzXkiRpBQ0iQ@mail.gmail.com>
Subject: Precise timing in ldisc? tty_put_char() in hrtimer context?
To: linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
i am implementing niche rs485-based serial protocol as a tty line
discipline linux module. Requirement is to hit transmission window
with precision in low hundreds of microseconds (eg. +-200 uS).
Transmit window starts 500 uS after message is received.

It seems that hardware driver calls tty_receive_buf2() with sufficient
latency, so my idea was to start hrtimer using hrtimer_start() inside
of tty_receive_buf2(). And then in hrtimer handler call
for(...){tty_put_char(tty,...)} or tty->ops->write(), but it seems not
to be a good practice according to my online research. They say it's
recommended to call tty_put_char() from workqueue, but documentation
also says that calling a workqueue might introduce latency of couple
milliseconds, since it's scheduled thread context.

What would you suggest to handle such a strict timing requirements
between RX and TX data?

Thank you

Best regards
      Tomas Mudrunka
