Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E27F31E85B
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444004; cv=none; b=YxFIm3yw5TxeC89dYD8s5yhkEGRLSz6LFH5eFNJL1gK+laafKQx50yhtXjPfQEYvxBwLONwSery+1L/Qf3zL+v+a6g7J7w9yIBexA9aIwWXFMSP/J+8jafdfj0J6cx7OnC5hGtItXRvtF8ArIUn/zzBDYnClmKbKsbKgBGcy7Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444004; c=relaxed/simple;
	bh=5VNrVx4ZKAIvebGxfLNqPgw9xDv0RVGMqeAFRyrl6Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1j9/v/U/6kl3B8LgcsNpSv7KC6L0Rl672Sz10UPj6b1H7hKg0BNGvTElLs5Mz2DrN8uCJO7ug5FvFyf28SlpWL3Bix/Fz0Y6rF8vkB/8QuXR5SlqvGt6RolowTYariHppODCsza4M7/skQbkKdUtuvzJDAIr5luJ9dQDWRibIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jhsy/Qgw; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jhsy/Qgw"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48882c1f261so534989f8f.0
        for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 10:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790444000; x=1791048800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=92J4cdfV5TssQddcjnr52AW40i0MRdcSuU09rnmRkE4=;
        b=Jhsy/QgwQGQH/87yAKPPf1Dh8FY0VJsXzAvksSD+xuAxf50+UP2OMafPnaZdLnCbLS
         Jv7F/GA007tL54mAf9D7S3SJVISyQ6JlysA4NSC6BD0Kni9qEQTggiwlRK9gdB9RWu5D
         0P1FDDQcvwxMkUBOCijg7K1n96E9ZCJ24FM4i85FIt0Yec11SBSt5mE/kcn072m0mmhr
         JbeNXl4GaT2yEf7Ft0OqqX6f/6VVGhR8rQz8iTFxkBQgUae4WH2tzM+UgTnYt3iYroRS
         Dspapxuh3UEVDZdakBCyrjlGLK/QTD5YJ8xQR90vOlYvyHh7sUrfjsNFDEmGIAxQrss9
         3OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790444000; x=1791048800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=92J4cdfV5TssQddcjnr52AW40i0MRdcSuU09rnmRkE4=;
        b=VnM3iqFGQ1cqVikbvKug5xyc2b3flJseVRB/V+0V09ZAPHgV2G3PluXFE98uOM5UpR
         o9A+jF6msqC0RGcD+LiuOaBPBq/VmXCLvon827555Cq4oSkbgGr3N/pb30R6L1ODCh4s
         wu4R6PZxAud+S83DMvV+aIew2Znass5ZQuyKfueTv1AZZ1G7UBj1XFZpWc6e2J4PR818
         2sgxkXEaJnQv9LQkV61mgAznfMXeb0BAZI8p8xrWPxAhVZxLsFqBJjM/W+iYFQtw7WLM
         yRNAplwvELfYWH/C6mUPjUJYM0mieJzQ8xQuTWrEO7yJjpYg+vTqon3UPDFB+bD0oCr/
         RJQQ==
X-Forwarded-Encrypted: i=1; AKwUvByvqQ4O6dNzJ+sJ655OwF6nH8SXGZvE+mTKWm6Lc61O/QAtvhwP8OctCtRekQeQInKV2x9GOodWq9NhDh8=@vger.kernel.org
X-Gm-Message-State: AFuF++m5kyz+fweMOxDCtcZewAxsYvPndxsiW+h4xARFgN/79nYwwXa1
	xAxhwZmDSOeMzurwG9MOlHJhgetoJUjHnjlqBDkC4EeoWopgpyk2ibhc
X-Gm-Gg: AYBFou1PnJCEb7rcf3ZE3v+WOPzwzS4M6wMglbpoJZ3eg5Y09nFYYgQAw2RBGqf4sYL
	qkn6p0TNXNSAzBAHb7DU4Iv/nem//nRFpnNX1k7F/KCIcJXJz2Sm6IaaAXThwKFi7/73mg0ljH8
	KUbe5KeKU15aaL4HSlrk8/XZR5cf+BPyvpf+O6d1y1nxEdNmNuVkbusuudrkVDo2+Q/vGosrimc
	1fcTAQw5BMW9dfJTc3rjhdygSNbezevaTOTIpNMPxeL9TpxdogYUO7JPb/Zs6ChSQ4oYPiNVdIa
	uJrNkBSiSMffXjUxvKp7OLFcEZGmsiC3aCrW0MkPmu3Y0DkYb+3q6RlsVL7Qucmo51n7uZfVVCp
	XycQeQY4xwDC5+pP/Kv1IHDzTMOn7vEBQDjXx9/dDFD0nBbTYnS9OvoOaW9SF4JB6x7igNYD5he
	2Ak9NK+9BS/TBFaiPzeHzq7QQ+C0/H49uR2iYnJiqC+iagEDIvsmaqvHZ4TLftGuTjT9xqNeRE+
	JmlZaeTXvkvTUwI4q0XeoQ1g6fiarqwmpeB2DHVUK1FfY1gx31J0EeVcFx/2NfKv8s=
X-Received: by 2002:a05:600c:3148:b0:49f:fc4f:9efb with SMTP id 5b1f17b1804b1-49ffc4fa10bmr34693285e9.7.1790443999742;
        Sat, 26 Sep 2026 10:33:19 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5de4de4sm246200495e9.8.2026.09.26.10.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:33:19 -0700 (PDT)
From: Mohamed Osama <mohamed.osama189110@gmail.com>
To: ojeda@kernel.org
Cc: boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	longman@redhat.com,
	lyude@redhat.com,
	linux-block@vger.kernel.org,
	linux-serial@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] rust: add DropGuard KUnit test configuration
Date: Sat, 26 Sep 2026 20:33:11 +0300
Message-ID: <20260926173315.56772-2-mohamed.osama189110@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926173315.56772-1-mohamed.osama189110@gmail.com>
References: <20260926173315.56772-1-mohamed.osama189110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a KUnit configuration option for testing the Rust DropGuard API.

The option follows the existing Rust KUnit test configuration pattern and
defaults to KUNIT_ALL_TESTS.

Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>
---
 rust/kernel/Kconfig.test | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/Kconfig.test b/rust/kernel/Kconfig.test
index e6a5c7a795f0..011c72f14e2c 100644
--- a/rust/kernel/Kconfig.test
+++ b/rust/kernel/Kconfig.test
@@ -33,6 +33,16 @@ config RUST_KVEC_KUNIT_TEST
 
 	  If unsure, say N.
 
+config RUST_DROP_GUARD_KUNIT_TEST
+	bool "KUnit tests for Rust DropGuard API" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables KUnit tests for the Rust DropGuard API.
+	  These are only for development and testing, not for regular
+	  kernel use cases.
+
+	  If unsure, say N.
+
 config RUST_BITMAP_KUNIT_TEST
 	bool "KUnit tests for Rust bitmap API" if !KUNIT_ALL_TESTS
 	default KUNIT_ALL_TESTS
-- 
2.43.0

