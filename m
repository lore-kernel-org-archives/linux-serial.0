Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C443B42C7
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830934; cv=none; b=bB/Y9MgagBAPM/iuSdLXqq21M0eEwoIVwbWraNjI1puE9ztnCdrPBwsQKgyRYK07uaVWYLcuWZMp1OCcB2J87PfpyXdmLsFQ23BInlDnXJt7wZt3wewC5QJonsKGKtBFdCvZ5pXwEOvRgBGcUI9+rJV854ueGwZFcrRamSIQiZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830934; c=relaxed/simple;
	bh=XwAp57s6t2T5WBJojbhGzQsWgRkmZhIhViv42WsnBXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8BGdwLnC5/2fAoc74+MnEQVsrjc892n2vCksXCwkg5Uk/7Ao0io3OXNARSywXsq4VWTh+swMogftHy6OumvmpLLTEN3HQtcQItNEyt5OfJ4bfkAFk7OWQT8s/CeBrQKxaUxuwV9uA5b9cy3LgO/iAhRGO4guzclTUbTtRzKdik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya4I8h3I; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya4I8h3I"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2e69aa07c3so273331666b.1
        for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 11:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830930; x=1792435730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xB95fmRKta5UC1qC17l7YA7Hzg7lVmH3sUQeY/dSryY=;
        b=Ya4I8h3IUuLscfWVQ1QPjMhEXkWrJ8TUXvuhVL8kots9KswY32X5bTNoIWPfnqGdAi
         j1j6DLZaq+N48o03a7TmDiD0kunJ/zjjVzrAAXdFDhVVm9xsY1PYKz86E/lN4pwV5Q+C
         wfBc/KNqTIrKqEJwOrslxVOW/DAACdq/NFqCZS6wodFFCfvqSMnmzq6d/F2txH2yzcN3
         IJXrlx6hd2RZ5szMcimHfxvnmOnAXflTLROWVWfGnPZ0kf/nCcgH3b2ALA7DJgtourTn
         FFYsRR8hqpR+y7LTHT1PJZOh+WvH0wBhZJlgBFHchnTmDbWzTdcIk2zFkJLOvXP8BSCR
         s19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830930; x=1792435730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xB95fmRKta5UC1qC17l7YA7Hzg7lVmH3sUQeY/dSryY=;
        b=H4yJj3CAKQiv64Qv1wCcShbB2VKxBvWPCgJbNV2Nsjjl6I9MSDh5I4m8aDnE1N3BjI
         /2RH3HQ/Fhn2FPkpM18NbF/TuNuTsveHzmuH0I6fEUN+aGiR816Zrnaj70f63+ywIMgq
         KlzjmMYRu4/OgjdPgovhsj3+NzeuQ1XHEL0TWhDMA22/zH2RRZ/nlzWAUa/gq7OxQBRD
         W1s9K0cKoGJ9yHuiq+DyQPsyUTs7VzxhuN5b+p4PPSjH8qD7JD+75Au/0NkqO+m03TXD
         ucNf70Y+IC9yrVidpZrzuxIzMb2mYfG21UBknMxfnVJ1X3Lq8AYYlsMrzfdVF2h41TJF
         HlAw==
X-Forwarded-Encrypted: i=1; AKwUvBzHwjeGQJOGWZlSaul06AsGx3KgoLxbRAST02T57um1yNbHmd5feXvUBKlGWd2aW+tJY0MX0JfpJN1m9Bw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJK/1+6JnJcom+mccxoBa7p4H4QczFUB8RS2sSJgoxojLfm74kH
	2Bh/zDd0k471RYD7KmTX1tEv4T9IYvhQRj7gAsLhu1KWSccSqYhlhn3Q
X-Gm-Gg: AYBFou20XE5op8iUtJa3y31mWVSYtBA1a80LBpJHTwLNjynjgNWGsg1T/NsXPnpWuCM
	uhuLqaG77770clSj8PnuwVTQX308Yg5EHfXcdnzYKkn1frNUbsZWnTiM7G+G3aLsIVkpqveTUTh
	3OxEgJUdQy82h6P6zEke2TQ8mGA0UspECAsd+7j6s5DVn8qRv31DLI37ooA2Wbi809G1bayVd3r
	So+uY5JMAFaSL1h7Dg7cUjNR0RHWC7qdelL7uLOEf88/C5TkraKOKVG3VRuXy0/WNL4gTj1WbUr
	GUIlq0cXBjnhLJTO9dpAZ49tkVoz39uAvR2SDsh4wf0hvk3LelDXI/8fKCtjN4eAMCqNn4/RYFb
	LZBC14aHw+FUQ+RB1JMnewmtKPCvqh3T5nDv/S0FY2xGYY6HSkPftIIqGGeCT2OcGF/Z+IV7H84
	rM1yCoYt+jY+EHFzllNMzxofPMMtEhgQsu0nIT8/SWHjE+QIBpgre/5ghNGZ+QqAjSazFjzbWcB
	6HagjewG5CQpa12NUVutD7ExcMB0jnLhjqEdOg0Wcu/FkSn7uk=
X-Received: by 2002:a17:907:72ca:b0:c29:462b:f908 with SMTP id a640c23a62f3a-c31a9fec198mr1293598066b.10.1791830930106;
        Mon, 12 Oct 2026 11:48:50 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:49 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com
Subject: [PATCH v3 4/8] sparc64: stop IRQ setup when descriptor allocation fails
Date: Mon, 12 Oct 2026 20:48:05 +0200
Message-ID: <20261012184826.986050-5-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012184826.986050-1-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_alloc() returns zero on failure, but build_irq() then configures
IRQ 0, which is reserved for the timer, as a device interrupt.

Halt before publishing the IRQ or changing its descriptor, matching the
existing fatal handler-data allocation path. Returning zero would let
callers continue treating the timer IRQ as a valid device interrupt.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/irq_64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 3f55c69d5f3b..4cceeba726ab 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -619,6 +619,10 @@ unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap)
 	irq = bucket_get_irq(__pa(bucket));
 	if (!irq) {
 		irq = irq_alloc(0, ino);
+		if (!irq) {
+			prom_printf("IRQ: cannot allocate interrupt descriptor.\n");
+			prom_halt();
+		}
 		bucket_set_irq(__pa(bucket), irq);
 		irq_set_chip_and_handler_name(irq, &sun4u_irq,
 					      handle_fasteoi_irq, "IVEC");
