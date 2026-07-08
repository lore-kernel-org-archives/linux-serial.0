Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A191F3E0C7A
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783494720; cv=none; b=cTL29WWXC+QSBeKuxC/tHKFAbF4J6oX6Hk2Z0wlyzBsVCGGTeprq11bu9QDbOc7n8A2P1I0PxsDEXSR/bKbtC7Qie28fIwJ5m2hdJASqXG3ZwS4g4VR6cUWbCMqKA8hfGKDGxIxaeEJVVGMizhm9EKDPUR/efk1BkZfwAziu7M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783494720; c=relaxed/simple;
	bh=LT0B1dhU1NRKbZdY/SDRVDGianQnqntWCIrMYKlQik4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P19WspShmIotVMqMZLbsWyQFl+UwitX5g8wKsxoePkQyovJ5Fcd85rWS5WumEeMFL4VRDOa/SpwagXC1RjdBgnf/FaIkWPJR19KzEeqDli0N8NzNnyPc4j7EUw7CbfzF+c78RHx3POmW/n+IQy8iMkaA/65DwMZgiBK+TRmhs2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p73drefC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p73drefC"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cac59f8b64so4422605ad.0
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 00:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783494706; x=1784099506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qijf+Q/iz6Hk/taKo9zjQrhkXJ3vlM7+8IeyvqN/Bro=;
        b=p73drefCZKFQlY7/6206DYhnflmEK6YmRI7Sv9UQaHGehMyqY+qU8V4sfZsRcNrxyD
         YkI6GSVASh2ZTJv/zfbCJCsOvGyW+tsKj/SQf5ukOeoXZhq+WbZeRZoT8m2s2uz965/E
         Lyrj+ZVuG8msHEFJCbtoB/NzxcHi+PvOYUZIrcQZGjloDhKweoefRBPQuTLBRa23VhL3
         1qAj/bFDqZg2jd5TKbTToTqNJGMPjLf3ho1X/wYGQI4zPIMDAch+IVbrYFFBdkpxYOsC
         DYRpgWPjNO3L0SR1YHzW9LJecXKmZH+5QGwu5Y88HDEYHK/ZYT9gtVqxWICFjCcEdBpB
         77Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783494706; x=1784099506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qijf+Q/iz6Hk/taKo9zjQrhkXJ3vlM7+8IeyvqN/Bro=;
        b=tH46FKnCsnoxtdtT8KK27u0g7cZvQ73mx13K0IipYANayg36YpY3YjIuX5I3dYijgI
         0bAeO947+x20ZA7ut+4chA4rRpsxxLeug/hmPaumjCihVvgJGyTsfMZN7UvqOFwCBJEY
         i5YIWgGoakb3VKPJPDf+byn4mkw90a3DHnXh8ZX7paaD+/wnyoiIDgw4slqnTX72diwX
         QUjMewa6VsOy0XQMEX/rC2aQGQC6IlBr+kDlpCit/fB08Y0G+yDhsA50jb24VGtsxtM6
         hP/qokGZSfmHzL4ilPw6cnFA10j4DuSXhpcz+dti1eZXEGl+daL6wOnVAirKSqL+B1m/
         EhGQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzpWrzUOesTlCGwJajYMCdkA2ZpxnM1GGFoSicJCQGXeGyDL1vDcpqQCQkHAP0/hrZHXruZLz5FFWw+hU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBkuL0R2YH63bBEH9YRe2pcDqmnrtUpN8H/9xXUa4IT7ngZNvG
	n2pfacEObFpEraAjzoVxkPfWaiJZLOAFFurt0jU/O0dFaegd7pdb2W2rGzVKl5ew
X-Gm-Gg: AfdE7cncruX0y5srWJm9dIyQnazXvCHMupGWpl+pej5pYFYIkA0uH92bCPtXYEfgZrn
	Edkv8cIfAC1fRpmGHqbesbecY9rxxA32milGBrgEIdAuFVJ9/TDPfJO1ESgBYRkhJvGb2UEmPRD
	BF0QJIm6U6Q5aTScRrSpgWm/C/++kZ4iMxkN/ykkd7Ioz7e5JtbD6W6H/GMLSGkkmxkNPVB58SH
	atbhgdaMixg4hU8G6b+vPS8B2+b5pBUzSB/coek/86cBDoxnhATXni3NJFRh7bhYgVJ8gKmHLeK
	213BfS5CSAhtS5fJ4I/ayuooaevFShET57LVrF2bRS1NftI8XgN0w6LwLNfasXfXI+WAbi1C7Qf
	Tjt96sZMYm2F6nXeYPPiZENF04OgPyMf93lTBUv7rQUU7bpnYG5zE6gD9iQp8zDIuJPd/IG5OI8
	aJLwObyCM=
X-Received: by 2002:a17:902:f60f:b0:2c7:f338:5691 with SMTP id d9443c01a7336-2ccea3a2f12mr13065425ad.36.1783494705484;
        Wed, 08 Jul 2026 00:11:45 -0700 (PDT)
Received: from ubuntu.. ([61.144.108.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e26esm23471085ad.44.2026.07.08.00.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:11:45 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: jirislaby@kernel.org,
	gregkh@linuxfoundation.org,
	avorontsov@ru.mvista.com,
	alan@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	wangzhaolong@fnnas.com,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ chain handling
Date: Wed,  8 Jul 2026 15:11:38 +0800
Message-ID: <20260708071138.3698581-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org>
References: <20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com> <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiliang Yuan <realwujing@gmail.com>

On Wed, Jul 08, 2026 at 08:03:55AM +0200, Jiri Slaby wrote:
> Ah, now I see you are fixing the same thing as:
> https://lore.kernel.org/all/20260708031115.3757150-1-wangzhaolong@fnnas.com/
>
> I did not look up who of you was first.
>
> Looks like he reported and apparently tries to fix that too ;). You were
> obviously CCed, talk to them and don't send two patches for the same issue.

Wang reported Bugzilla #221579 and sent an initial patch on May 27.
I sent my v1 the next day (May 28), and have iterated with Wang's review
input across v1..v6 — the timeline shows Wang's v2 (Jul 8) was written
after and based on the direction of our v5/v6 series:

  v1: May 28, Qiliang    [PATCH] serial: 8250: fix use-after-free in IRQ chain handling
  v3: May 29, Wang       confirmed "v3 fixes the Bugzilla reproducer on my setup."
  v5: Jun 24, Qiliang    [PATCH v5] (with manual locking)
  v6: Jul 7,  Qiliang    [PATCH v6] (back to guard style)
  v2: Jul 8,  Wang       [PATCH v2] (same lock-move skeleton as v5/v6)

Wang's v2 has the same lock-move skeleton but is missing three pieces
we've added through review:

  - lockdep_assert_held() and __must_hold() in serial_get_or_create_irq_info()
  - hash_mutex covering the request_irq() error cleanup (use-after-free fix)
  - addressing both the use-after-free and "Unbalanced enable" races

I'll add Co-developed-by: Wang Zhaolong to the next revision.

> hash_mutex is no longer an appropriate name for this lock.

Ack, will rename in v7.

> Unrelated change.
> Unrelated and mainly unneeded change.

Ack, will drop both the blank-line removal and the return 0 change.

Thanks,
Qiliang
