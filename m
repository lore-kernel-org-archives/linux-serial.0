Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB8427FD4C
	for <linux-serial@vger.kernel.org>; Thu, 24 Apr 2025 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504039; cv=none; b=QqjLNzeig5MjokJGvYEfIKz0kd8o7ZZj52yFt1XAiOp779aVulXTLPmsrniWxUeYSiLlyyKh0wq2sqKPAEoBE3PbcseMbq1I6lXyfCM7475fuvN8RgrKC4WIpdh138SOXCL1klqFGtB5o4cV+6WvR3AYg1IBEPA7GthLINT1904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504039; c=relaxed/simple;
	bh=bEqpNki7jGGD4CCKcLuIXPBkDheH2qulR1vPkXOdIOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlC2QtmeYKVErkAXuH9yJqv7TzUF1hbOa/XQ3gH156l2KRwjt8Z3J2Pp/C7yPFuus2e+nfqXZWrGyMwbRaM3W4D3zzWZyfeeRmgiRsw//ysdgFJjQUA5SwtOSRDRw2XYBNklBayegPA5IzhZDxTpaKGuHYE9b6VSUfDFO0LFpkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tk55LPHl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk55LPHl"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22d95f0dda4so16499505ad.2
        for <linux-serial@vger.kernel.org>; Thu, 24 Apr 2025 07:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745504036; x=1746108836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEqpNki7jGGD4CCKcLuIXPBkDheH2qulR1vPkXOdIOM=;
        b=Tk55LPHlP4pEqHSLvpq4BVGw93xeBLDzXPom0qvop1cA0LiaB70Ya2uaZBbbBo9Mox
         fdSYLGSsJkNUo1Pi06i4LuqjCUorPhqtz+KWNDF1jyhbKMHQg1F2NXHju0bvho6b1xQp
         m+U+RAOqIZnnvk5jatl3rDGxXnuN6SlOTLFGqyJMqkMEouY0kLb6lCZXwRflaB7WU83d
         pIxaxO4WzklUAB9GJttlZUaRZjJbIKHuy39DEL7KlCw5BN6DOvs4ShYXqdhw6Mc34TFn
         MbXjlyYLcJuEnkKyyHMh3POCl/7zfyC3S4Pb8EKazCeMIkCmV1NrFc/XMVIo7XvMOPUr
         FXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745504036; x=1746108836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEqpNki7jGGD4CCKcLuIXPBkDheH2qulR1vPkXOdIOM=;
        b=jtKnoE7CCKyBmOr9O6f9W3EevDM+6TbE8YC4PgV5Do96Oj35Ma91oqw0ikmkI3Jrjk
         igukDV1+RMHn9bKwkKygzQLuL5tcjciKilSgkYENk3oWjZNU36NB+ODSEM4X16R/CPOP
         jyv7gXZ7L2l5wLKXxmzbSF83lJaqGZXyN/5pU9HIyMofOzf79J5MEEYndnSby5Q1u4Uh
         ozqjf/jRyZYJ3OZNzZPj4m2pDDhnLHiu4CxvrrsE9ZYGwbRUpjLv77eOILIxkhvOmXCn
         Z/E4lIiL5fLugv0+YHr/4lNfRZX6+A88aO/ooPqr9Ewl6M1aXX/7iBh9SY6Lrp8HvIx3
         yY/g==
X-Forwarded-Encrypted: i=1; AJvYcCU+uXCdtoPADQeZxFTXz5fEVJLneDFxDIaFLQQyy6z5jgcRswcP6Ze6u4NWOcHkCTy5Sl8jaWnY2S75CsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQdHkQoojoLbIg7b4aZZ9ITGJKf1U06Bj8OWWHn4i0pn7HBMIV
	0xmC/Rv8TjNON+rNeyPRHL5zWR4wVN3eLM7ALiy5mYVcZF8EsAtZ
X-Gm-Gg: ASbGncuE/moq6TUYBFIDmUgx5JfepQukNY5Ox6seG5woshjQINehu5KWqkao2in0RLv
	a7T61sRFyS8PISm3NOLRkUGs8FriodKJCdsy4hwfyIKvPvN0nAD9vUeOU/C9Ti32lXieH4ZK0RH
	ts5tWYi9ukBV5qQuGh6Opj/M6tRTLvVarqSPkGgG3sRRFbcrIxdL9OSBjxE66MuHejgszFMafpY
	K5xef49nR5YhYCjO/3Ez7oQycY8iW9LMkb5CB6t01JC3mOlt4Qjjtuk4zL+F3nNw7Ha6bwJD4Mc
	WOmIrO9+WkzDWqVe+44r6gqDE5eLxZKkvcVtGTTkZRBdWU/iszz+fkwe
X-Google-Smtp-Source: AGHT+IGVeoyB0CtF1JIBT/QIdiOCuc0hvo9bPO8kHlwKv6ZbpmQi14kg9HTEQ33x3IgXj1fNkM0diA==
X-Received: by 2002:a17:902:ef0b:b0:224:584:6f04 with SMTP id d9443c01a7336-22db3be4400mr38867505ad.18.1745504036256;
        Thu, 24 Apr 2025 07:13:56 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:a0e1:7d00:529e:8ad4:796c:105b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76c8bsm13764895ad.48.2025.04.24.07.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 07:13:55 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: john.ogness@linutronix.de
Cc: Jason@zx2c4.com,
	gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	pmladek@suse.com,
	ryotkkr98@gmail.com
Subject: Re: [linux-next:master] [serial]  b63e6f60ea: BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]
Date: Thu, 24 Apr 2025 14:13:51 +0000
Message-ID: <20250424141351.7674-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <84r01i0w9k.fsf@jogness.linutronix.de>
References: <84r01i0w9k.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 24 Apr 2025 11:06:23 +0206, John Ogness wrote:
>On 2025-04-24, Ryo Takakura <ryotkkr98@gmail.com> wrote:
>>> By other words, the rslib test should get fixed by adding
>>> cond_resched(). And the conversion of the 8250 serial console
>>> driver to nbcon is correct.
>>
>> I see, and agree! I'll test what's discussed here so that we can say
>> the above statement is true and the John's series can be brought back.
>
>I'm looking forward to seeing your test results. Note there is also 2

OK!

>more issues blocking the series:
>
>https://lore.kernel.org/linux-serial/80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com/
>
>and an offlist report from NXP relating to not being able to suspend on
>ARMv8 due to printk irq work IPIs.

Oh, I wasn't aware of those two...
I may look into them as well after this!

Sincerely,
Ryo Takakura

>John
