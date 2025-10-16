Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D3A30C616
	for <linux-serial@vger.kernel.org>; Thu, 16 Oct 2025 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604982; cv=none; b=T8/k0Wf7zt/QppcLgBZIiSIx1vj85bUqE1wGxsiLaMXjHBgu9QKgaEvz26ArKuIFyUt8cv8HeQ79x115q2tAAEVDO/sUqKZV81UIuLkGh6Kt2Lj/0Y+4bRg7LQK0UzIZhAmG0vb2Y9cowds0L6PDgb5U6s6AL6u3R48Yy4JQ+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604982; c=relaxed/simple;
	bh=BTJ5BDmS1jbavXTN8W5DVTEeJJq886cvTMsOxekHMXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWbEDfg1yxmIPVUft8A6Jgc1TizFPvwvMAEmeW117rzLKz+k6lBwWvdQfC0+4DNGwAqnKOwugBcfBjSsg8vrS9gXj5QOTYDILkoi4eky4jwBbx+fiF1ukgxG9ucJEX17SSHO1z7r5/o+VgECsFo5ECRtiOxWXdgo98vkP08Zyx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jWwWirqE; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jWwWirqE"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7836853a0d6so1212207b3.1
        for <linux-serial@vger.kernel.org>; Thu, 16 Oct 2025 01:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760604979; x=1761209779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTJ5BDmS1jbavXTN8W5DVTEeJJq886cvTMsOxekHMXs=;
        b=jWwWirqE3QEI6lWNFj/7+5RR2L5bxPNe1ud4s2AtPOvfbbS5A6CkYZWza+a6RCNDFH
         93N+UCon8hBkdIT6saX1iUKgu3f4apc66BBsMJq/MIDKs+TdSz4mspMFfmD0JPfF4+dL
         WnZU7tbGwhhLhy49RvQbWKJHTunb7Bcd09N4LO8G4o9y8BrlG8LpynOcAKIJRSqy+ib5
         B61j9QvIGyN7LziizwQQnQVdkf52qyXXiMoUmSOJBiqUAozR9vzOVz6Eo0RvDqg1gyrP
         QMgnxkv5gBxS7x1BkCnik6MN54stZ0EhLzw870phdeFDMvYuqfNrK6URwWRZtpHIPkSd
         DbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760604979; x=1761209779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTJ5BDmS1jbavXTN8W5DVTEeJJq886cvTMsOxekHMXs=;
        b=CdcmOmwCU1pkFTiRgwylZsivFkvZmhL6l6oi1NUXeruQTJ69TG6afmDbqtC0oIn1m+
         T52yiN+Of76497biDKCfNtG5PHO0PXvRvDOdQrWMsiFoH6nIqBcaZCLl1Id/jSnYJn9a
         pJfy2sawtxNsIDaQmQmVAaD7Mb5QMAqJiRHUlIAnfWb+fzvPZNlZrf/e+4HzKuTwPUD3
         7FVhPCQO1YO9s4Jpen12TEIZmypGjFvpWEcuIOPgdvIskJW8RvxIp/MhE255CBwcMoLb
         yYcKen25HUNhUXi9hUlmBfaSDJ+cwztn8fQOQIkT5KTJ76tWykqxDYBV7aU5RTWDVIMX
         9lxw==
X-Forwarded-Encrypted: i=1; AJvYcCVfwBBssUhh7GhCta1C1m27NAnEmVmWUFfM1KfqQ5peiBUpJTssINkx8zXxPFpO1TJ8EyA4BT4kVNfA0X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTNfz4k3vWcFKdix6hkBe4IFl82F4pB3ILi8iIOQdv0RIxDyTh
	BlG6zMUEPRnZM1qjT7f72lf3//kbkT0zqhPb716iDhX8u0SMbkfSk+3dgyvkfwXZZ1tSd4CNSj3
	SLDiG0F3bWKegHNlnanz1TiscBaEqgd5tq+4DW8zS7Q==
X-Gm-Gg: ASbGncvPTEUn9ocDtGiiW7IePW1UGRzwu+UFKmpEjEqpXYyeY+G+iG18oi6bLSNDOmw
	XvUc+R8g12/MrabU7z9BaYqLpERW6vWDUgfjtbfDaphoAGpjUGOFRKgJe4wH5p2Ho2gGkh5Nhxd
	hkXqIrJz3OXp/OmbVyu0jKfn+ZvG3tzUWaUwt+etRoTbqoFbzf+kGKpB2SwIGpbAsZgrI23gKZS
	YTNNIQ21SiyqB+N/YOgczx216O4zR5vQrUYYflmgCg6T+vyLC86u1PvepbhaunESfVS
X-Google-Smtp-Source: AGHT+IGxqTGy5wHmODLi1UF6gIFjWY6sKPakop2EXbRVgjjq12zyCIQCyGdiYtedanfT5A77kDydHAWRiH5qffLKEn8=
X-Received: by 2002:a05:690e:1686:b0:63e:c3a:ea77 with SMTP id
 956f58d0204a3-63e0c3af55dmr1343586d50.14.1760604978793; Thu, 16 Oct 2025
 01:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016070516.37549-1-zhangpeng.00@bytedance.com>
In-Reply-To: <20251016070516.37549-1-zhangpeng.00@bytedance.com>
From: Muchun Song <songmuchun@bytedance.com>
Date: Thu, 16 Oct 2025 16:55:42 +0800
X-Gm-Features: AS18NWB1MKGKlQ42nxBswbDuR0UxKYudldovqI8s1wflRtIJVP8mzsQzwaKGcuo
Message-ID: <CAMZfGtWhgHoYU4c2Yz5w6XCXJ0oSoJbm0_kW=YvjFENv+pDj3Q@mail.gmail.com>
Subject: Re: [PATCH v2] serial: 8250: always disable IRQ during THRE test
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	ilpo.jarvinen@linux.intel.com, LKML <linux-kernel@vger.kernel.org>, 
	linux-serial@vger.kernel.org, linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 3:05=E2=80=AFPM Peng Zhang <zhangpeng.00@bytedance.=
com> wrote:
>
> commit 039d4926379b ("serial: 8250: Toggle IER bits on only after irq
> has been set up") moved IRQ setup before the THRE test, so the interrupt
> handler can run during the test and race with its IIR reads. This can
> produce wrong THRE test results and cause spurious registration of the
> serial8250_backup_timeout timer. Unconditionally disable the IRQ for the
> short duration of the test and re-enable it afterwards to avoid the race.
>
> Cc: stable@vger.kernel.org
> Fixes: 039d4926379b ("serial: 8250: Toggle IER bits on only after irq has=
 been set up")
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
