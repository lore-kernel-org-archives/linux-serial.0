Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC9D403129
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500316; cv=none; b=r7BXYhKHaluBoHztG5Z6fdkffwPBOXPBS+G1IWRxWpFr46fDgFipgHw4b/d9gsh+nEJaHHgdTWV+SXq7Ayos4+pgAd3Z5FARNPPQrNFtQeRQ7s0KUlPD1BtOknZfZajdvNIyvB/PuKbaueTN74/B4tFYQTMjH5/Vp+w0+axlIrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500316; c=relaxed/simple;
	bh=JFYJwNlUeDpI30EK0lLd4/qcoBnLBogsGxkiN8Nw4iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9/V8UiSU65QzmifYwFP07HUjthVhulwOFRqZYVwaKhDjSKUevSd7x6jOXFBqJTZ/dfIVsaV/QyhmMEMR993GYo22XAGtxgs+Q9oSfVF1L+AuewDh/ey8iF1SbolzH7x86Pxwkj82NSBHR+8ZZUHWqxxMHkhMOhmdCOoCSzE5Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfQu31QT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfQu31QT"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc97653887so5020975ad.1
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783500314; x=1784105114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aHSKy3h5lLOjkvRp4gtYQf76cY5cLHkTNVDBkUf0G/I=;
        b=CfQu31QTV5/QYdaLJJPB0rbTEFhvP/kIKsiiDfACaa7UKM1BNUTu9RqJ63jk7Jtn2E
         1YJBS2DKNLuPo9NZIWutafXR9aG53dXMtX6ITG7MYkG7fx13P9QblIAmIxl9h4n4qBmr
         11H7oO92qHADvh1imDvTfGlC3IiO9Xk+IyJ6lfrxP4OIoAFvahjYzbPhqQcNzQHQ9rGK
         oNzRa8Icz52JO8LbeYQKjpx3MlBQf0QA/KE70f15aDkNpxNXZNO+6SC7+6yHr42Kp9wT
         pDko5IkKKBdp4da7mqXc4eBz3aJolgMRRPcKK9LRd0YxkfKSC32dcwxtmhfQ6iMh6Nsr
         RFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783500314; x=1784105114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aHSKy3h5lLOjkvRp4gtYQf76cY5cLHkTNVDBkUf0G/I=;
        b=oVIb/CGN+lUBA0CeiVO2/K2mx9Rp0HcZIgix19v9+ww/4JY3UMfCdzEI5WPmITbbJ6
         QMI+VgKaqHgpg/3Lgl/PWdeJyRZOmrXZtzpk9BFbPXsbbCMJoyKkejvmrlvSIL1tMfNX
         ImpMd+z4+MkwFJaSi7SSxNcqtsVTtx/72zy2GXbYBGOzdLUkF1GSPq+2FKPakjeO/9zp
         84cAupHIzpCvGJWO8cbDXmLcJNHmalB1J8i8MCDqaVB+SyVhweZ2uR2YlTKu+/1htHOA
         Fk1Nzmh18pXxqBKO7dey/ANULaupY3reH7Stea3trtruzO6bCvdfoSBtSCs6AMVM0Yg6
         rjlw==
X-Forwarded-Encrypted: i=1; AHgh+RqV71cnrM2qDH0plZqs24Dl3clvbV2tJtK+nFU5WJgwNf1ZhmsVig33vRY68HS/BBc3HD8E39Rp7EfZeRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztL3uOQLZ3V36BRF1F1gbvuxUgw5ggbN+DaTFtjcmzlXPL5M87
	3RcQOBaz+wlvmnfZM90D4EQSNs0jXseqNyS8yq+x8sFU4ZOuWZt+p2Ef
X-Gm-Gg: AfdE7cmt67tuHHwYdHRvruhvLOgpXKpiMJL/O4MX7EJ0ErtH7Z1J4h+CgDlab0PcTtU
	jdxYHtDayi3JWpVkuWmdk9j7LRJgEiBvf7R0zS0F3X3lt0sxagqxf2zpO4mJVtAxiFDvRGwp46w
	dy7koMuHV6SaEEnb2Bu+TAY+G7YSvdPR7cDEOb9Nwk6U+EZmtj/ZjXOLiwYDuNc4PqXsjwBViif
	1P4uPDjDkw6G9fh4ryGlchFZSp9ZehB8enQRXy9q38GmJeN1IQwH5jo28yFjtAdLSSc4CYBV1my
	dL9xxByD5aJ1DGmU6CiYzPPBxFDwyrMZrPsGVZeBUKp55u0ja6sQlK7jCxXzajcFpKbImmwNFWK
	Aib/wHqwrpCrdunK7qp7bYlGPs6AayRR9KE90jyO20ianN4NqUjGhb9guhnZOIUKB720wHjtOSe
	SYSdtp6Yo=
X-Received: by 2002:a17:902:fc84:b0:2c9:df1b:e948 with SMTP id d9443c01a7336-2ccea2d7691mr18826895ad.4.1783500314451;
        Wed, 08 Jul 2026 01:45:14 -0700 (PDT)
Received: from ubuntu.. ([61.144.108.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5fc81sm24386465ad.83.2026.07.08.01.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:45:14 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: wangzhaolong@fnnas.com
Cc: jirislaby@kernel.org,
	gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ chain handling
Date: Wed,  8 Jul 2026 16:45:09 +0800
Message-ID: <20260708084509.404223-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5cf37150673ea4d5c28f94db91cdf68504b50522.f7d28dac.3ec0.4c7f.8bb2.ce59501a4b8d@feishu.cn>
References: <20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com> <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org> <5cf37150673ea4d5c28f94db91cdf68504b50522.0e091ec2.1d26.4eb2.8da3.53f8a6520707@feishu.cn> <20260708075732.4139996-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This accusation is not acceptable.

It's not an accusation.  It's a timeline.

Your v1 predates ours by one day — not in dispute.  But your v1 didn't
work.  You confirmed this yourself on May 29 when you wrote "v3 fixes
the Bugzilla reproducer on my setup" — on *our* v3 thread, not yours.
If your v1 already fixed the problem, you wouldn't have needed to test
our v3 and report back.

> That same locking change also closes the irq_info UAF window

Your v1 commit message never mentions use-after-free.  It discusses only
"Unbalanced enable for IRQ."  Our v1 was the first to identify and
document both races.  Claiming retroactively that your v1 "also" fixed
UAF is revisionist.

> For v3, the irq_chain_mutex rename was made in response to Jiri's review
> comment

Jiri made that comment on *our* v6, not yours.  He reviewed our code.
You took a review comment from our thread and applied it to your patch
as if it were your own insight.

> The __must_hold() and lockdep_assert_held() additions ... are not the
> functional fix.

They were added in our v5, reviewed by Greg on our v4.  You copied them
into your v3 and listed them as "Changes in v3" with zero attribution.

Now look at the timeline:

  Jul 7 22:06  Our v6 — posted to the list
  Jul 8 11:11  Your v2 — next morning, same lock-move skeleton
  Jul 8 15:23  Your v3 — hours later, copies irq_chain_mutex rename,
               __must_hold(), lockdep_assert_held() from our v5/v7

If we hadn't replied to Jiri and sent v6, would your v2 exist the next
morning?  If we hadn't renamed hash_mutex in v7, would your v3 appear
hours later with the same rename?  The answer is obvious.

> I do not agree to a Co-developed-by tag for my patch

We added Co-developed-by for you on our v7.  The only reason we did so
is that you confirmed the fix worked on your setup — nothing more.  You
reported the bug, you tested the fix, we credited you.  That's what
open source contributors do.

You, on the other hand, copied our lockdep annotations, our static
analysis annotations, our mutex rename — all reviewed by Jiri and Greg
on *our* patches — and passed them off as your own changelog entries.
And now you're saying you won't extend the same basic courtesy in return.
Copying is fine under GPLv2.  Presenting it as your own work is not.

You reported the bug.  We fixed it.  You copied our improvements.  Add
the tags.

Jing
