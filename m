Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121EC422541
	for <linux-serial@vger.kernel.org>; Tue,  7 Jul 2026 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432396; cv=none; b=GuTKJ4ZTuRv7qCWZApc28f0qvzYAHIx65+iiw9UMxtS2uiEzUo0XSrZ3Fc01eXRK8yRSsA4+FVR+lmNQ0FpRkpLrNsKqkynNGJqTZTd9BXNbVsZ/KT4pUEcqo18VTlZN8hzLbYgGLmFVRwpdzOtbAXGoh/o9ldFEfsFbIVfchOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432396; c=relaxed/simple;
	bh=dSwDMoPTuTYs8oieuBdetWH9+Gei9O7Fh2FbdLLh8Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtEDH9c/0d5Ox5W0XL5w/OxR9lXlPJ4CUkJeqAAFVFhXNeyxFMD4WF3aqyaqgJ7EadPvg9Qxu5gJbJxxkxTmzkZdmatC3jYXOvJCRoV5EHj2SQKwS15bUFYCr+UoidffqBx/5ElibepUc/Qt5BQCCFSyu/SyVfz6K8IKMfM/NNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvDKbiuW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvDKbiuW"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cabc0a1ab6so46845705ad.0
        for <linux-serial@vger.kernel.org>; Tue, 07 Jul 2026 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783432394; x=1784037194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7I0aueMD4uslTAQBZu79HFurPgrBCpjQJvk0FJzT2YQ=;
        b=UvDKbiuWhjBdRiGXuKbOFod/gMZFaNapYJZwURUy2unBcKE7JCxA9bzgtzk+ewg9GD
         WB4I+/rgSA+1qWmwpk7cYRf3KJIYkwBTHso+vwsggx8xJjK8pNgmaLmrDsyKW/VN7jMr
         u7Q1EXa2pCCk41135AEMYYqAdqNa+PPgCcdy1JMKLSjP5Tv5rpDqTdLO81gpStp803VU
         LTXRA4LC+yNi/7Zwyo/jbD6Iac0fgFeoeu1FcB9VmXd9xg2x28TQSljTCnvuiD7tZ3q4
         AuXxu1S/E5rmlaQHoemp8Afd1RfGl2XeOBcdSZGB4BvJJRmA4lFpUsoOycL1IiT1ivPB
         Rq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783432394; x=1784037194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7I0aueMD4uslTAQBZu79HFurPgrBCpjQJvk0FJzT2YQ=;
        b=B29165SraUrD5kxPse7ImEWcoxJaeBvU50Ao7ZV4okWyM66TWSOoh0P/GdqJi3aM2H
         mWbq0y/ZctHPEiy8aNM/XGBn4RUk3MgfXYO2uwXs1c51ab9Qgu2/k+uew6SQqbR8noWs
         oD6ti/Jgz0FYHw7FWLZrXHUbRBi/n1j5zjEIyDr3pdebDdPl9j8wcM9GTkPkpyDekb2u
         w7R50w4ZTPnOh+56Lk7RxSfF733duLwQDoM//hyqtiA02AAhwY+ylz3jB0rhbcLMRF2J
         8XUoyC3UY16U0rVj01NvSLEZ7CShdJE/H6sPjmCm1aHX7JCTuSlvw8PibLK+S6aITyTe
         tHPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrQJAWoZ85j2q8PxhNfAKyZq+/M3+hgeaJHEhJvCdkSGjjIpN5pKggI4Li1E08KA13XF76bHF7ruFbq13g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE1qMJkBadhe8LaWxuGBplJEOCD5qfx/Nw8UW8U8t7BZ+YMtcn
	53Y6TZCY+hBwBb7qa1Q6zCGDkgHyvETS6GVEr2HRCdqM8tZYDL90QZXU
X-Gm-Gg: AfdE7ck3oEZr8dMtfhUucsD60Pb+trPG8Bd9uQveSVPYQ4t/zgd7aW/6GZzWeuHVi/O
	W8W3aLdudx5KndmVxvcz5uBt9i0qt3ywlPd4ixuEY30F7rwuHTN9+507WIpt7YsafkbkTQrlCjt
	SQH52d1p2TYMX5EQQZlemH1SZk/OlEjY98yXi+WQGXka3hYsnN7BeU68m17d5tQWQOpLWSzhUQQ
	Pnl3f38QrIDBWuWIb3tTps0ynnSn8pwe/xdiNo6Ve3rFz0cop6puQoPa/Cj0nOBqCtUXPmfdz3+
	dIW+9nqE2790MfAZqek8AdowGUiOeb5s8eLrI4DlC8zBzVM/YRuVBKr/Ky/s+tf1OPGPO4Rb9L6
	alv1Ea2c27R/kkgVuZljpIU1Nw2QFEN0LrQZ9wjqH9aJoQzGa4m1m2qG+VesJMA5LnjWJdJXuMK
	ED7H7yjRs=
X-Received: by 2002:a17:903:2c03:b0:2cc:5fae:cc56 with SMTP id d9443c01a7336-2ccbf07a9a7mr55558305ad.27.1783432394256;
        Tue, 07 Jul 2026 06:53:14 -0700 (PDT)
Received: from ubuntu.. ([61.144.108.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf8c12sm12680065ad.26.2026.07.07.06.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:53:13 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: jirislaby@kernel.org
Cc: gregkh@linuxfoundation.org,
	avorontsov@ru.mvista.com,
	alan@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	wangzhaolong@fnnas.com
Subject: Re: [PATCH v5] serial: 8250: fix use-after-free in IRQ chain handling
Date: Tue,  7 Jul 2026 21:53:08 +0800
Message-ID: <20260707135308.1404824-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <80f44ace-9231-4b4e-9e47-cbe49b3e2d3e@kernel.org>
References: <20260624-bug-221579-8250-shared-irq-race-v5-1-15d841f89e1e@gmail.com> <b7c51606-e95a-4a15-9aff-d0c293ebe986@kernel.org> <20260624084352.2978059-1-realwujing@gmail.com> <80f44ace-9231-4b4e-9e47-cbe49b3e2d3e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiliang Yuan <realwujing@gmail.com>

On Thu, Jun 25, 2026 at 06:38:35AM +0200, Jiri Slaby wrote:
> I don't follow, the function now looks like this:
> ...
> What am I missing?

You're right, nothing is missing.  The function releases hash_mutex at
every return path, which is exactly what guard(mutex) provides.  And
i->lock is only held across the list manipulation, before request_irq(),
so scoped_guard(spinlock_irq, &i->lock) also fits.

I'll send a v6 keeping the guard style.

Thanks,
Qiliang
