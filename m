Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EE134B697
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440560; cv=none; b=W1MmBRyJJKJngKqw5vk9lZuXmrFJVMCxhOKTN2w9ONkz+GCpWbKwnFLQOQmyj+XPBrKdySq/NEDUyUtxAsGcD9wG1IpXGamRY67K2O0eDxDxcS36B19QFFPrW2twMiGxg9chUCOFVyWsbOMtuDg0bbmZ1MzOu3cGM3/4T96KxHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440560; c=relaxed/simple;
	bh=5VNrVx4ZKAIvebGxfLNqPgw9xDv0RVGMqeAFRyrl6Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6ixsvnQqgNFqAXY2W5jKZgc8j/KDbiB03kgghIrtUjRa9BHznWDOQ8m2mkz0jMn96NEA6EAWg5u5IMF1m/kLmGK9Ag1nRmMKOM7xcCES59YPjkdkLw1a7rmuU+Zou/hUk01ck3Z8YHqjPpVfEXgTxaq6AKVU+AYH2k+Jq/pTlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMRKMigy; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMRKMigy"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so9572695e9.3
        for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790440556; x=1791045356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=92J4cdfV5TssQddcjnr52AW40i0MRdcSuU09rnmRkE4=;
        b=GMRKMigy15lhxSBtsY9tLDNnBp7jDte0j+9a22hpyfopd7WK/kzTZkyKuCrx3FDgOD
         QB62hxpqiZiEpg/wmJfp15seOyKZJ8t8M3+LpotC1nj7mwchNUw10R3mSKxa8i8ZZNbI
         b/u9ThPqkGvnDsDmuEe6Zsv4pTruh2Esy/PivZgp40yVT7/hf9XNRk5YrhByOlrkl54R
         wCUToG/F7yMPkEDPSu12arX5Iqj3LrIVuNzZ9SUO2G339eTPuq/PKvbWzDJMkNNY2p/h
         Ah1+crCdkTu/2KxpVi7Io+iyE/RJ7NVX2mWT7t7QTaljZLkZhfJeXSmNsXGKMol6+9lu
         fBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790440556; x=1791045356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=92J4cdfV5TssQddcjnr52AW40i0MRdcSuU09rnmRkE4=;
        b=dKdkhfaEOQkMYaQ/s1TqjiaXnjx263NcUqczd2ppFfEGjU/uvrMeJm3flogZwwFbjb
         yAyBDFjSYpwjqQD5OBuEj476c54VJuOHLUNhL/mYpHK3ioDuFmMwseWtysdtQJYgoWgx
         QMmTSqulmjOR3SBZHCYOkt0ewkkMZFelQTZ1yR+4RhF+uA66JoH/n/LSJ8r8wXGtaN4r
         nkMwds4rD9pe2YAz+14JwXo/bsZkGmjlLH8KQP1UalrCR14hCqqBAsPwy6XZ0KJE1bSC
         i8cIUDFIWcVIXFNDuN4Hn/Fwf3Qe+fleRAWQXGryvGYzFkq9WY9FlabBjpDrCNL2DKeZ
         j+Ow==
X-Forwarded-Encrypted: i=1; AKwUvBy+o/JacDCDdW9HWBqg+Yui3Jyuxi4+ymxiGi7WZ7OxAuDtO2NbDLUGVK0JOen9P6EELpvNGR/TOy+n1N0=@vger.kernel.org
X-Gm-Message-State: AFuF++lAwZ8uonmS8KbroZzCaqEYIKWfYbRZesXUHeQ2uwlC9b8he6i0
	T+/lAgGu+YlulfQZhDA+D6+GnhYYgadyo/8GiNa6+b08CkIfjRyoi1Bw
X-Gm-Gg: AYBFou3h1BmK1Q7BtIzneBjuGm9tHUOPFYEBx4nD+U997zUU6LWL3o42Nvis6P7lpZY
	pjuO+OyCACNc9LvytwINnfpMJ/K5lKNmTGXj9T/JibTW0z7LWHBQAzLqlGQ0SCxFqg9AdYDyVjP
	nfM5z/8gV86hHhGcoXDyL+xlkDxCbaA4Kk6NnilUzJdgk1L2afdBaM5gC8eT+V3ljsOePQ3BGWD
	t7IvBBdNjrIJVGeyN7+85tHWVkIWVU3lNr+/dGQY3Z3MJ1GM5JTWh2dsspNV/J9mpyll5ZZQMae
	rHs1zGCpzIfRDR8b/jrzEqR4723PT+EAPXJh+NhwF8GM8rXVJelq+YkmLaHf0tM/S3UfKKsRJB6
	QSUAPrJfm7F4yuNOKYqh7N+Avf+GbuPQaej0AriR8sCqALNow9zWUMwllSYdjQz/5INq0WnXKYn
	IffIPHPr45uXUwPbKGKYpWNh1gCfYQAKbX059eRNLbFFlZmBuGsp+P1h+qiEPuaCV5Kwkzt3fCq
	FEo3jYPzsZeg9AXLpVpkSB1/JdTH26kASUfjp4JCXw5whxstUeJBizep/Iag8LeDQXunAX6K2ZK
	Ow==
X-Received: by 2002:a05:600c:1546:b0:49e:7a00:b9a5 with SMTP id 5b1f17b1804b1-49fe66bdee6mr155118895e9.4.1790440556411;
        Sat, 26 Sep 2026 09:35:56 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355d96sm16176146f8f.17.2026.09.26.09.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 09:35:56 -0700 (PDT)
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
Subject: [PATCH v2 1/5] rust: add DropGuard KUnit test configuration
Date: Sat, 26 Sep 2026 19:35:47 +0300
Message-ID: <20260926163551.52371-2-mohamed.osama189110@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926163551.52371-1-mohamed.osama189110@gmail.com>
References: <20260926163551.52371-1-mohamed.osama189110@gmail.com>
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

