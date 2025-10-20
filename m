Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81EF248891
	for <linux-serial@vger.kernel.org>; Mon, 20 Oct 2025 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961029; cv=none; b=rNlimWiIwjoHSB820TkhTNRPe+BUDT/N+6vS0mIDA1au0eDrU4NpvnqAwlSZh7bJbBtWWP8V/NuBnoqWDGbGDfRanR5gzdwecm5lLj7JcxmB4I+1dmO3h5LEjfgMuaB91CiE2Duiz4R7INaGNru0zu28sraCSruquBqB8Ol3jpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961029; c=relaxed/simple;
	bh=3Ib3zrr/tPmm6C+NhCIYGI9GLz3/YlX3IpNvy/WsbBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvR0DkYNOLwrXQZIKRemk+sBElGI1cVjPw4Z4UkJaGx3h/Iyxr4Ciknm8bSiq2jy0Dylu8Se7xVD/+fCPnV4Wpubr8Wm6ITULY573xF2AVaCDWJ5vaWHO0RSYvK9GUsECQmYQdRilHgKNkHylUpyQa3AqCHluJiQCTxWLVr5awI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3Q8Fmiw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3Q8Fmiw"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b6bbfc57b75so75292666b.0
        for <linux-serial@vger.kernel.org>; Mon, 20 Oct 2025 04:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760961026; x=1761565826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ib3zrr/tPmm6C+NhCIYGI9GLz3/YlX3IpNvy/WsbBw=;
        b=D3Q8FmiwZInTYZCNZ1U12ur50ed8ev7+xzgz0oSlfPRYDYt+iqQpVAcelpSnWzKXhY
         mc84dPtZSk5q4YPHvst/8GYW1R1Fqz++FYc81xOs3+4o6XZRgdrHKqBc38hcperdMOhM
         BNi2OmHzGRQ/CvywgZWFgnsmWPJ1zco+44sS4w6YYkVxw6P6XJlwSFAIcHj6jZsz3ku4
         QxWRbDL6dYs65cfl2du8Brrd8nBagE8+IonYB8qpYmAh2ZcMjZutr+3CumMTv+eNKs+a
         +zzm7BaRVeaf+rC/WSedHAO2QskhIHw1rKQm4ET4jXBhOUNrGEe+AA/u97YqAoE69vqh
         XCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760961026; x=1761565826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Ib3zrr/tPmm6C+NhCIYGI9GLz3/YlX3IpNvy/WsbBw=;
        b=XkZcO+BZz4ArZjdvuApIwCWzVcRiAWuccZ0cYQTJFmDA3p1/7f8z6gzZSvdKI1DVKb
         A5C+GdWdlObjkBkqazb0/cCTSACcvtnUaec5aclpj09/HCK5irD9SJmViLquOTKuJzbi
         xUVsCP12nMBKVUJyZFGcPVwJ9RIXK/2xl3YfIzgJPMr5l4r94WCsOKSvL9YITC5uGi5D
         CrzYCFwqvs5PSteTQVG9nEvQUZM5cFx4WfyRUGLrf147H0xARqSuKXZdgTWpOfok6QHT
         mlcSrH4vMP0RO3r8s5zNlYd7l3lhyuVdYr1FUm5PSfwu+F31Lu6kzLKYEgjnE1i+0NK5
         75PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbNaBNVDGS0TyEKXOWarmqvPoWl8Ys+hSAQstNVznO6vwaMX2ki7tF4TBPRUukAZYflfAMUSuuiJwGXak=@vger.kernel.org
X-Gm-Message-State: AOJu0YztKlkqpGJP9oqFb1pq2MrvZiV9ydoas+p9ylUD3pmjp6djaHZy
	0zKRLpcl5KgvnlkZVUdJuRqu5pICYj1Spetv1lWU5bdLCoYjJVTUKJ21vOKCHlzdZhpfG0iEznZ
	9eM5n8Ln5o3W0tVVbEGzml7Wt4hS7oQ==
X-Gm-Gg: ASbGncuAwV3ypdhjcTrqpDyYWgtkuGrwJ3In+1y+CqupVSxKWdq5UfpoDgQe0NIfjV4
	Z57Gfoh4oD1uWwT+8VLOMRFzgnxJNpqZYwRLsaZ8xQ4toMieMomic3bhRf6kpOhjxRCPmwoQVD1
	IDlBBF1EblmMfDlE4nA0aqBWzr2Gsl5Qp9vhB1OrqhbPtMAZwuURmsBMDKvXyNGzWnJ33MgoHm1
	fZ5dVvqdEGSZJBHMYjdSUXaAQf+kvQ/U65zyfzogXWrxyOdXT2NFV94AQ6Jj/p6WG+/
X-Google-Smtp-Source: AGHT+IHpqrZ2dPIwhNgY2sr456DoKSrudoQCSOVCHp2/+Yamq4lGHHP853dkoUAlwu2plIGKzBU9GigR01lDOFEXyUk=
X-Received: by 2002:a17:907:c00d:b0:b2e:7614:d92d with SMTP id
 a640c23a62f3a-b604e6d11acmr1848895866b.0.1760961025902; Mon, 20 Oct 2025
 04:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016103609.33897-2-bagasdotme@gmail.com> <aa388d29-b83b-454e-a686-638c80c6a7bf@infradead.org>
In-Reply-To: <aa388d29-b83b-454e-a686-638c80c6a7bf@infradead.org>
From: =?UTF-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Date: Mon, 20 Oct 2025 13:50:14 +0200
X-Gm-Features: AS18NWA3E0Ss9-ztf94LkzgiKtO5TbAFbLXh7zu0w6jJDo6kFqwu4lbvMiqUEHM
Message-ID: <CAH2-hc+XQR7v9Z28yH_CTWZ4ieaF5eQFKBVut1idULP=4w03fQ@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: sysrq: Rewrite /proc/sysrq-trigger usage
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux Serial <linux-serial@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Cengiz Can <cengiz@kernel.wtf>, Jiri Slaby <jirislaby@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Content-Type: text/plain; charset="UTF-8"

> I am still OK with removing the 2 "However" lines. We don't typically
> document or provide warnings for how the code might be changed in the
> future. If someone modifies this code and the documentation needs to be
> updated, it should be updated at that time.
>
> --
> ~Randy

Problem here is, that you cannot really modify the code without warning
users in advance. This is the warning.
