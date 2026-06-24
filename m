Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D0A39AD2A
	for <linux-serial@vger.kernel.org>; Wed, 24 Jun 2026 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290639; cv=none; b=OjGa+dVrcxAk2iZoFkuGT84JWH6gAnC2nFxPJwhRs/cE58soPzWgZPHQpniMXU31GEn2CFa2E2fM572gQJJyTQ8RDUnNEvJ/+GmITJtleR8mdb50zolNq09bLJ7D7JM7RrOGvPckubW/1n9tH4Nesi9O7S/x/lW67g95TxkPf0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290639; c=relaxed/simple;
	bh=72ZIe8iTM4iITlm9Dw7wQ3ka3uJNc9uE7sm/Qq+rOGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwlXEuuYVU3RvYpaFdbFBpldTdt+ZpJ4xepE5F+m+F51nOz4Sb3ZbJPZtlg0N/HKq+AP9Fxk5a/zSOb/1TpPAEnE6rMP08//0Vvjq04awQm8WcHAjyQn5cArI7Vbcikh6d4hNfGOQL8H5chzc2fqpzvJbaHgxfo/3mTJY5HZBKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SN+VHmdU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SN+VHmdU"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8452a597afcso551792b3a.1
        for <linux-serial@vger.kernel.org>; Wed, 24 Jun 2026 01:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782290638; x=1782895438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LywRaryLfYIUziUYo8/cJX6WIM+4o6nZrLaP15WfeI=;
        b=SN+VHmdUkFVFzd8d+2WhNb7XqbDRoiLxSMEq5B8redmETRJdedegJkpuOXg+sv+6Me
         Zy4nWHvlF+XO7MJd1Ygg5+Ui4XB+XZS475C+xaYXH2JkFHaAWsKoxgR/84MK7rWwfSXl
         dOX9MPSEcwEcO95U2UPFrgNdSnSCLacaDnVRZSZnp4X+py0mZfjOXK2KU+S+JCtQSXnI
         tyS+zx6WN3CkE9DLkE+T0F/Qvn+xJsQS7nQ8pC+GHZdddFO4DnTTsUm1IX4QIKX37ytr
         dCKGk0KkNUDUQWWrSAm0Kl1pb9B1v/CPMPoCTHX/IxwQxOvOlLrKWHK74jxl7mOGQgHO
         uwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782290638; x=1782895438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2LywRaryLfYIUziUYo8/cJX6WIM+4o6nZrLaP15WfeI=;
        b=WlppPkOzsXHRBSoPaGJr3h2UAKLhgd2MSdzPcruQ1aa6y77jD5UCtcPieCeha0ftd+
         BzaursdhTZHiQa0NpaEgMlzGcRAPCJcvvg1VMTdRaEstrQL3zCZmi4710FTXnQGXi9gy
         BJ9mhi0K0G8Y+GvaEgRzYTFAJSdUgs9mD9KZwlgbOUY8QCv1hCtto/jwljaXyccF8Hkw
         ci9UVfesI/qeDJFBqadwO1Ys5Tc3XyHr1Az8qghqjtFTYgcPCcXUZ/eJdgTvXXzOAFWy
         wquE3460aVC1a6uESY3lBpkNUpKEu/xVtYi32FCoFORfs2tWCsFmBAA6dyLfWi+jdJQA
         /cFA==
X-Forwarded-Encrypted: i=1; AFNElJ/tbQXXjDQYqJjGAIhoPBS7R+d+S2qOVcSLRC8jtKT79eRJXA13t2LLrvEMNds28ea5ONcEGDftwYBR5z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU7dI0jWShd5tnJJBPQZwVf19mRHw3ay3kjInKuALg0UQKlPHz
	0HFs3vAlU43kNNo694JFVj491evtx99uQpMzya53nkACi7SKRtzqpSNj
X-Gm-Gg: AfdE7ckmGTTpfhKJg6pEQ+920p+aLKWBwvix+ojxfWiXIA78PjDDdlm7WtKflTUIePn
	Tg9CKfD3Er+DiAOpA8HVgUE7L3maoOXiq6Y5aFMUBP1EFDo38SsANHCs6z39pM5B7ecIrvlO93W
	d4IXIIc5vpgQpHfW3cK8Xt7QHOaeMkNYn1D4zS5PixcZXInfOtWPTTbkBJC5tqev1fCzJCMWBZy
	6AuuIZESAPqHZwfxaFfkt7HZStXCH5OEpEfz9f2olDkzChFx80iNPM7UGIFeiRj9uejr/iAvdHP
	50JG5Sic7iOysM12gkh28Iy25aMmVV2Pz0Os4MMhOwFbzDUWtnww4CX4TLfVrgJArb1wFMyKDOg
	MySGkTqO8WJTzJwJcfW8ATcE+HYs94EJqPMVA+p9E8MGrP3Odt+kFlDYGNVt18HwkWdP2KHhXTN
	OR6/T/dRQ=
X-Received: by 2002:a05:6a00:1bc9:b0:842:6e9f:9d3 with SMTP id d2e1a72fcca58-845625b764amr17467896b3a.43.1782290637810;
        Wed, 24 Jun 2026 01:43:57 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40f05f9sm1554657b3a.42.2026.06.24.01.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 01:43:57 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: jirislaby@kernel.org
Cc: gregkh@linuxfoundation.org,
	avorontsov@ru.mvista.com,
	alan@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	wangzhaolong@fnnas.com
Subject: Re: [PATCH v5] serial: 8250: fix use-after-free in IRQ chain handling
Date: Wed, 24 Jun 2026 16:43:52 +0800
Message-ID: <20260624084352.2978059-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b7c51606-e95a-4a15-9aff-d0c293ebe986@kernel.org>
References: <20260624-bug-221579-8250-shared-irq-race-v5-1-15d841f89e1e@gmail.com> <b7c51606-e95a-4a15-9aff-d0c293ebe986@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiliang Yuan <realwujing@gmail.com>

On Wed, Jun 24, 2026 at 05:31:59AM +0200, Jiri Slaby wrote:
> So what is the reason to switch from guards to manual locking?

Scope-based guards release the lock at the end of the enclosing block,
but the fix requires hash_mutex to be held across request_irq() and
released at different exit points:

  1. IS_ERR(i) -- release hash_mutex and return error.
  2. Already in chain -- release i->lock, release hash_mutex, return 0.
  3. First port, request_irq() fails -- cleanup under hash_mutex, then
     release it and return error.
  4. First port, request_irq() succeeds -- release hash_mutex, return 0.

These paths span different nesting levels and early returns, so scope
guards cannot express the required lock lifecycle.  The same applies to
i->lock: it must be dropped before calling request_irq() (cannot hold a
spinlock while sleeping), but hash_mutex must remain held across the
call, which also breaks the guard model.

Thanks,
Qiliang
