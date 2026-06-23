Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67743175A9D
	for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225149; cv=none; b=pamLHZ0szq9FQs5GdPqRhFk/Tbrr451hF62IZM0FUQorhzMU8LS6kbKU3umtUWcS8Zn/+A1113kjfIblyPz2/MYkQp75f9SPQqyup+7KGu9zdT7UtKbnjC20PRynkWjHmO39CosI2U7FZ5Ybe8lvTxdhUnwTWQp32b/uxedimxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225149; c=relaxed/simple;
	bh=3mG39iHCZNsXxuzctgS4ljx3FJbNgfE7+EfdkoW77lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YY6OVllhDrMQG3yD231mb/bWxcYtTv2ITx01Dl1c2ewn1pqGFJ5gqD1MAitcyvqzqP0y6e6JRQ7noY28PxCYNk6ciKXzcPBI4kxenxGY3mT5Ks1cLMZSWGVevRMK710i5MjN092UyyXUXsuZytNQtha12zP88xxM/Vs6kOjYo2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV4a1JDP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV4a1JDP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c6b3f71648so62687045ad.2
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 07:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782225148; x=1782829948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcdDEOHP11KOemg3W2Imt3ngTY3JQturNvk8u+a077k=;
        b=GV4a1JDPloALdbNmfqbyXdbISVi1RYNJxzBL2a/hzXEWWxxIC2DtFTB9qZempgODSJ
         KS331OA4mjKrfuy6L4tnash8CuCHB1+xIgWoQmieGwHzwC8+Q3nON9Hm/xDIqinR/tQ3
         HsVIqut2tB3V/pjn6zwOKj+wrM4pnVwsXIVCOp6qWVJApF7rMoxqIkXR6W05fNDRuA0M
         Jg/B6WTH6+XcjWtxzIg/DMyqh1bCrQgddMgmFxQVGlLhsxGgoKIZ2ZFcwS19MUfbgLLk
         NlM5IcU3zOD0AuGDE14gtp7d4/PC8Xvrs2Ek6UfI5LAVkc4s4LK4JfWoq8P7z3pD8FE8
         FA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782225148; x=1782829948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wcdDEOHP11KOemg3W2Imt3ngTY3JQturNvk8u+a077k=;
        b=mGHixq8GWX4Q8lM2SeXWSoLS/pvajxVWRhWuHXwSu38QUgBon8NNwNJwhPQul48wKF
         PvJ416l04x4G/1G3L91uAZXxg/5Yp57UXS2DZeNIWFTCyzy3AyfJbUJjf/5kkms8+IRW
         7gafbRQlntWVHl80vjAKNVyFBlEY9hNPCLOR8h+4mcXXngpyltUt/v12csBO+j3V34bg
         t6riGtAXWWESa/TqICfMjtYcjkWgdM+WnctufZAphrnyZuV3Nipe5r0n9XvTcryjUgz8
         A3fwd0jPNdIP2P75/hyr3ArHB8uqfrI+LuBkvGK1hDTiS4oqXxpGoIlTS7Mm9PRnD8OZ
         c/7A==
X-Forwarded-Encrypted: i=1; AHgh+RrAe/M1ax3QzFhXqUxKuOCxk6dbQHwwyKz94aVB9RJwfGMN1NK8MI/9DFaPRYWqrdsnx8m0DJFhZcu6TPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3jxwbeek+V+4xjEM5aRpw2XOAFgasT36cHHRGo1Z4bHo6TZam
	nYMWkKTe35wP4eiSfHIQF1nNc0aKKWbLy2ZHUH9ipLX7y1bWBrMmfvOt
X-Gm-Gg: AfdE7clBnqRz8NATtLOHgg64SWUEgfKZ67DHhlnyzjNWN1OnW5LkWHTUXZ2AMmW3sjs
	4qscG8o4ccUn4OrspEDeMJ7PFq9U+OLm8mBj7SbtI3qbHZXmG4W+8zbgWdhC0zhm5bX6yOHVZUg
	c4P+6YwcStWZ646Q+HdGUYTfqA5GmSFfE864ZAmpkcuH6S/MV+wLfcdpH/8BcapaXHY46M59kP9
	q9k9T3xVhy2SI8gmEKHcw4mhiL1aEo1M0GAlcEfKCwP2SBk3YQahT2nlxOcaw9ZMNhgYliOK8YA
	I6iGKLU+nXTuNUu1572iYXSymk4PmrjTaqS46+9rZOb5rtaZdIGhUYnWvSg8cbcO4zQpZAP9EJ2
	nwzIY0DHgbsZ2RNGxG4ePpoWIwGo8/3J+D3kU0pOd0y2Za1iKqRybQjM+FMbNZ+q01eufhDt2TL
	xdRhyoAq7TSkKpD2pKZw==
X-Received: by 2002:a17:903:2f87:b0:2c0:c262:b91f with SMTP id d9443c01a7336-2c718cb08b0mr212161755ad.8.1782225147522;
        Tue, 23 Jun 2026 07:32:27 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743bfe8aasm104014885ad.68.2026.06.23.07.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:32:26 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	avorontsov@ru.mvista.com,
	alan@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	wangzhaolong@fnnas.com
Subject: Re: [PATCH v4] serial: 8250: fix use-after-free in IRQ chain handling
Date: Tue, 23 Jun 2026 22:32:20 +0800
Message-ID: <20260623143220.432877-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026061213-blinker-portable-a198@gregkh>
References: <20260529-bug-221579-8250-shared-irq-race-v4-1-cfda63b4420f@gmail.com> <2026061213-blinker-portable-a198@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiliang Yuan <realwujing@gmail.com>

On Fri, Jun 12, 2026 at 11:49:51AM +0200, Greg Kroah-Hartman wrote:
> What real systems causes this to happen?  How are you triggering this
> warning to happen?  How was this tested?

The original report is Bugzilla #221579 from Wang Zhaolong.  The bug
triggers on systems with multiple 8250 serial ports sharing an IRQ
(e.g. NAS-like devices).  It can be reproduced by probing/removing
8250 serial ports that share an IRQ.  Wang confirmed off-list that v3
fixes the reproducer on his setup.

> Shouldn't the function be marked as requiring this lock to be held?
> Just putting in this lockdep_assert will not catch the static analysis
> tools :(

Agreed, will add __must_hold(&hash_mutex) in v5.

Thanks,
Qiliang
