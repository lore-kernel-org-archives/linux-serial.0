Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED82066C2
	for <linux-serial@vger.kernel.org>; Tue,  4 Mar 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080404; cv=none; b=io+Qr4mgUkXF6S3qydyIBoObapz2Y9je1GtuhCY7eTLwP9Cv2UPl+UFcphko47D7EpRtNEnnjVv+dMkBWRGcyylB6mHfE30wzUXNNJF5kfJL6XdZIxFo1mgmnMlVYzIuNUfKcsRzS27J6nMQDAsio5bAKoAY6m12xr/OIj6xfD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080404; c=relaxed/simple;
	bh=Pb5v8XeAHlUAdU8teJGT/joxk1D2UYCLbNbcthK7dEs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PgVOvvKiGrU/NXD99AUyVy/YuSrIIrDxon0e56YRMmzAr/+xr07QxjcBL7lhHzgTEimR3w128aa2i2WavObHuxeA+bbE4nOEU4gXLBdhYBH7xOMWbhQ1Lr0Aae61aTDZddQ3X6IFLSVvBLOUWmyyvqIV9NatQOBkhsRtgupdZ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eqTUwK1o; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqTUwK1o"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-abec83a498cso522432166b.1
        for <linux-serial@vger.kernel.org>; Tue, 04 Mar 2025 01:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080401; x=1741685201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vumk0HTnchdldWRc8wT0cAdQjFLn1MfJ3/QC5i3Nw5Q=;
        b=eqTUwK1ozQnv7PEsQryrxWFaC4V9xB/TW/o9zIGwNoOmqD1aqBzj1JC3drB8erfo5p
         wb9Hcya48YEnC3EHpitzfauyVpJiyDwAjTkW/daucl+eHEuIIjalwWsm1eHbGLG41iBY
         fgOLwF1PUiBtNADhsW4nt4zwl4L9fZK7mVDl2u6cvVDikqbjK7EUyQ0urMTCNYbdQO/l
         mqJ3HSFwjdr5aYOsP9rBFQ2aUmj501MaDcxZzEinBfz8cG3OCcxAQ+XprkSAo44oY9iX
         hKf8OutnsPysfeip7QE/2XGG68KKvnfkU3eHfiHBF4Po/OzNJeU0hNWIO8btMtdG4k+R
         Li9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080401; x=1741685201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vumk0HTnchdldWRc8wT0cAdQjFLn1MfJ3/QC5i3Nw5Q=;
        b=erq2CL17HxNuS3jjprsCzoFm4KV+emj5NTcJ6/bDGD5Lx0dkL04XlJU0w95p1Sumik
         FLHHykaqaeuJhyzuDfxYstvgE0z0g2wj8CoYJUhnu5Z+BZ5Ue+hHoRo8GRKm8CmYRo9e
         LUnGtTihVJEaRY9NQBcPCSKPFFGZsb4hEZ58g3Rbmj2mnerK3FUBKCdpxNxGDfWuSTlp
         vxUYQqvgX8hKvt6coqR1YznUbo63rcDi03nVkJSiKWq5b6NLY9ycpxxPdRvk00gKs5ke
         9hgHEa2KJ/m8H68+rSarRKsdPnb5zEHf5QJUVGnxbD9ZkUClNQnEBJopfz7ICOjNsELZ
         g9vw==
X-Forwarded-Encrypted: i=1; AJvYcCW5l/exaXlCsYkY8XrOLt1+pIroTUQ65mzJtBwCqAVR7f05Bl3z5AdreAZEIOGeap/ii1sW52P9+5ptBEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy055fScq5YJ9aNCzc5J1f/h3tyrC3xTCkU4D1MAuQ/iqXFkLeP
	09+xfkEP0nJrd1LUFwMOvis874nho0Zf0BiGyZzMbt3h/Cur0aS2yFgKaeMGsHb3BZwuviI0fQ=
	=
X-Google-Smtp-Source: AGHT+IHe+2tTUNkWh4sjbCTVRn346FQZX3D8pl7o+PzR8CFWDsL38sKG72bCeLReMhyKEWhXvddJVO8sWw==
X-Received: from ejckt25.prod.google.com ([2002:a17:907:9d19:b0:ac1:ed2c:ab54])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:7fd6:b0:abf:46cd:5e3f
 with SMTP id a640c23a62f3a-abf46cd7414mr1245962366b.16.1741080400857; Tue, 04
 Mar 2025 01:26:40 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:33 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-35-elver@google.com>
Subject: [PATCH v2 34/34] MAINTAINERS: Add entry for Capability Analysis
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add entry for all new files added for Clang's capability analysis.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..cf9bf14f99b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5638,6 +5638,17 @@ M:	Nelson Escobar <neescoba@cisco.com>
 S:	Supported
 F:	drivers/infiniband/hw/usnic/
 
+CLANG CAPABILITY ANALYSIS
+M:	Marco Elver <elver@google.com>
+R:	Bart Van Assche <bvanassche@acm.org>
+L:	llvm@lists.linux.dev
+S:	Maintained
+F:	Documentation/dev-tools/capability-analysis.rst
+F:	include/linux/compiler-capability-analysis.h
+F:	lib/test_capability-analysis.c
+F:	scripts/Makefile.capability-analysis
+F:	scripts/capability-analysis-suppression.txt
+
 CLANG CONTROL FLOW INTEGRITY SUPPORT
 M:	Sami Tolvanen <samitolvanen@google.com>
 M:	Kees Cook <kees@kernel.org>
-- 
2.48.1.711.g2feabab25a-goog

