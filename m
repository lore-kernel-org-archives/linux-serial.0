Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830183C584E
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498113; cv=none; b=SFG784dkY7SSy4hd8iHAgCD5As1+4l7VhDDyWBvk1bfQJbKKeXZiO08y6+dQiN70Z/bROl6FphZG10JQA22ibep35vjQbdNmh8KMyX8F8mMPgwBEKvnm4V6n63oj2W+EuMufFAGEIpQvTLZ+nS8CcpNmpzgxkQqO2wF/TrUv8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498113; c=relaxed/simple;
	bh=jkeayPSZulQ9prUpZMNSrBO5oExtprLg/kYB0TR6HfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5WISZMsPSsLmkwQHdTvsG6CePGeihsLpEkP5kZwu/Ep1vt9LAoWcWE+vJnFU8CoRlPx2BpsLqzWt75YnkNLvFIx0wkNozkRfBxRG8Xt/4UirBOxFdR5JdbXx8n5e0Ko96gwioZcoM96w09jXvVNkdC/VG3Ny6+YwxvUykom6E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpTmylg7; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpTmylg7"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8454160043aso384277b3a.3
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 01:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783498109; x=1784102909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j8rBUcXNXqhCtAAq0ugm4aLb0G5OINBhuMNxLh4q8Uo=;
        b=LpTmylg780Sc6hmznHnJPITFePFseXCOOrP+QxjGCxyXI5Wj9tadW04vVtH6eHGwTY
         YG0/vRzMbzRtIG+BHII+j1s0KT1PriUrUElMy4E8cekJHHg0WyEIfaYGVQa5/1kFaELb
         Faz2B9mm/P8M1Qq4DNTYF158ZNUEg5DUNkvBLy0wgUF1/plbkT8F2t3DjsWRed10EK45
         wryJcoy+4cS9ooUFbQiOJzXCHQEvKl+PswvUxO2tFumhca7T1JW2xj0EZi+ka5uHQmfr
         EKip+wgSaaICQqBePa1zkpv1jifIPdjNmTojuMjOSlDbOIC8Q3kXSiAF9/KdhwMQ2Tca
         iPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783498109; x=1784102909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j8rBUcXNXqhCtAAq0ugm4aLb0G5OINBhuMNxLh4q8Uo=;
        b=cvzTYgjfMLvXJeIzWJX7PFSvmvd8M1dpXzAe7M8dPgtbnlDnPU7sK+kjQThBShB23N
         Z25/sVS9FuAJKKFIwLdHDjgosH9dhYsXW0vCLgZZdctLpPowrea8ief4fReFWb2cuepw
         t+KzbHyQj/9XqXX/+mxqC+xeDgTT6ESmpm1tUfoJDyjAPHKb6JHn3gdw0aqev+EVw/tg
         KgJd/3OGuya7r+Yks0q7BjNnAmuXTbz3OQP1ojb5VQxbTF2lrxvSe+2R/wCD54cgqpGf
         /LTjPlFQODi7LmjS9/MMR2DJ4NdJ6oaI5i9rqmLVYeSrO3hNBAuYfdlEk7hahjPLqbUc
         BPlw==
X-Forwarded-Encrypted: i=1; AHgh+RrPZ4GlQU+6NhbG4xoYRkSH/k+Sypch/MYRiGfYwGmXCdDzDH4r0LCyNTOX+MKSyv6BzuCJWFwTXxJvNyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPg4NySVANxse8g1lYk0aZFjCtop8y7ehshrs1x8/oZi/oCSzg
	Oxzt9RWo8eK0H9JkrRbfoQgHIDhnpAL58xt06DUyBkgV2Ev/HsrBSW4y
X-Gm-Gg: AfdE7cnx1cjSXX/Bg0GO0s+wRtTyhxNYi2BmRQsf1LmyEOm/SOPKsp+cwBrHisaFI36
	uXV7/eK6XtybA4nVwAPJYZ6swwVCfzs3UnpOpQRd5qnU3xNpyhQ61Vw8belx82Hvtx/PI9Mxp3T
	/sh0K8wWN7U1quczQMSorD5RjT4FWRP8MA4guASms7JxCYUkWbJEIIg/LqhJuVZo128Yviiks+G
	+RLfW2b4pNCj3rHT0vkxqucLztZwqc9ra9jDEeB6gVELVlnDUUTK652dVCnQIfsOlzSfh2EzEcK
	Cpj9j2dvWXsOv7Mb4kRSspmt50E0dKg6X6cwRXH0c6+PtH5QaiG4nWJkB8pCrJSjYW/DE0E+ja5
	NQS5JRAs4B+U+6fA2QiTl3LgGAbDLy9nYC97bRU0PVWd2NSbtTI04rOzXeNc2QvvVgBykVrFQuB
	1BMpNesbw5xA1dX+99Eg==
X-Received: by 2002:a05:6a00:6c9a:b0:848:2a55:7110 with SMTP id d2e1a72fcca58-84842febf46mr1920240b3a.36.1783498109347;
        Wed, 08 Jul 2026 01:08:29 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d7c2casm6620038b3a.43.2026.07.08.01.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:08:28 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: wangzhaolong@fnnas.com
Cc: jirislaby@kernel.org,
	gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ chain handling
Date: Wed,  8 Jul 2026 16:08:19 +0800
Message-ID: <20260708080820.62288-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5cf37150673ea4d5c28f94db91cdf68504b50522.f7d28dac.3ec0.4c7f.8bb2.ce59501a4b8d@feishu.cn>
References: <20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com> <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org> <20260708071138.3698581-1-realwujing@gmail.com> <20260708073938.3975921-1-realwujing@gmail.com> <5cf37150673ea4d5c28f94db91cdf68504b50522.f7d28dac.3ec0.4c7f.8bb2.ce59501a4b8d@feishu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 08, 2026 at 03:53:26PM +0800, Wang Zhaolong wrote:
> Just one technical clarification: my v1 also moved hash_mutex to
> serial_link_irq_chain() and kept it held across irq_info lookup, i->head
> publication, the first request_irq(), and the request_irq() failure cleanup

Your v1 commit message discusses only the "Unbalanced enable for IRQ"
warning — it never mentions the use-after-free.  Our v1, one day later,
was the first to identify and document *both* races.  You confirmed on
May 29 that our v3 fixes your reproducer.

But the v1 lock-move is not the issue.  The issue is what happened after.

Our v5 (Jun 24) added lockdep_assert_held() and __must_hold() — reviewed
by Jiri on our v4.  Our v7 (Jul 8) renamed hash_mutex to irq_chain_mutex
— per Jiri's review on our v6.  Your v3 (Jul 8, after our v7) copies all
three of these improvements and presents them in your changelog as:

  "Changes in v3:
   - Rename hash_mutex to irq_chain_mutex
   - Add __must_hold() and lockdep_assert_held()"

That is not a technical clarification.  That is taking work we wrote,
reviewed by Jiri on our patches, and claiming it as your own.

Add the Co-developed-by tags.  We already added them for you on our v7.

Jing
