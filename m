Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CB41F9F51;
	Thu, 15 May 2025 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747281142; cv=none; b=O8j/BtyW3NDyOFCndvEbT/DbSTUY9ICPUGu2MIs6D3J1nG57mYsHLMXLHpxPWCNv1RwC2+0DtUK/XtHYhyNxgL4+wc85MAstMKBXNXJonBTla73denEXJZ+TYvmFOemh/Ntoy6AHe8xhsyNIhju95MEpqD6ks/4utnPoMu9jKY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747281142; c=relaxed/simple;
	bh=fA5WjGl8OzCwdqaIDKpGiFrGKSy4SNccRFrd0ME3Z7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sOQohsWcOnPCtcCGnkAoj7qFINrBk88gysgdVpEQQOGIcbxBq/oV+4/iTLSTZ43vZd8VtD7DUMn4WZdxIFwAwgUhc14SfR4avyexiMCuVj0DlSLSElzrB4K24X2mtXrGTSKjBOD9OCGNED3OAluZ96fjwP+9vPVudWx5d3Phun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b59P4EEl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b59P4EEl"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22fb33898bbso6725965ad.3;
        Wed, 14 May 2025 20:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747281140; x=1747885940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oxUHbPUHgnMm/JVb3wKb9mNsMs1RzSv1R7MGL5FIcTg=;
        b=b59P4EElKV4vvf9tf3AluperLHFqeIDmVHNdzpyRdtHCfSMPlO3NxbjMVr2u7/JoxA
         lcTKnMM+1mfj8xEBJLtszC++m+HKCVUbFY9a2UhT8mQy4Yhgmv771FPG3EZFyROUcjz9
         5W1wbdlwuisQvRCmSrAG0DIa8mQNVGeKf2ZFGFW3qld9MZXrgYpjb39Wci/d/Peg8BeJ
         9xF5W4WvHauwF3D9IjiUJpB99lilpwvc71iLup3pcz368I7AI6H0tBiO+x51gP96remm
         dDfVRtR0POLSBF/gsfolDje2OU8KVvULu/xMHYI542EMb1nfRQyiUmKMdlQZvzJjc01K
         XoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747281140; x=1747885940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxUHbPUHgnMm/JVb3wKb9mNsMs1RzSv1R7MGL5FIcTg=;
        b=l6r2fIajFvZfkOhPC6uuRWXeYdN/UP7nEwpWXo/7kvNcAMNJ1gYjqseLJjXeDSUO1r
         9zTgH5q2rpNbw9cz4CUQY0NyHRJROq2cLEwnra1hNM2pPd0lbYOMuIMxu76jm7l7qAt3
         CSpyqNaY/2zKj+qC+tXzudzAAMKbOIETUrdifzaFmXhd9j0VWuWaGTETpPj8QohBoWCk
         mlNz5EUdk2MwAXGJAM2n2qQqvuy8o+aklapXkh+/WjQY+drMItxFMp5C5bmaNGtetOSj
         lSkmN6lxv3WnsJyRDfH1wD8k0j7LbOo9FMSC8Hm23RFbikJX+KLDpzxS4RjXHem4JqUZ
         lXLg==
X-Forwarded-Encrypted: i=1; AJvYcCUBNTT9YEuIWoZIRQQPAAVF6l7ZgeP3Um0JqcF6LwiUVOxogFnc694x0kRQSESvQtg+/lWogJs7OU78YHqW@vger.kernel.org, AJvYcCVReOLbAfdKslMyKNUM09QKzalT6POHlxMCdnSBdNjAZS3XYrJRlsSV3AF1BL3o+IGu8tfanG23QRwkP2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDUhzG0qw5Vs7MtK+ymnoJJa5WeQB0XxDRqGsN0F24OIjB8XPc
	iVSaT2EI5iIvrZfbTMS1d1VkOTVem+eQBzgHM4ZMXwP5ida78hNuK2NF7g==
X-Gm-Gg: ASbGncuSSUlf6ntBEgs9aJGlyyeCSUruAGz7Nx+EtzIRlDXSqcG41vh9ZlYDArHHFZC
	MjqTqqzO2pg9YbYmDJbqYHEgpwHUMIf8hV+wT3QiXpqPGX1eth7CwN4Q4z/wWbez9jPaPwcsrow
	dmP8GJHYf8pFkZIx3wykWHXmQYQRDcXuTV6PYji9iQMXbyYN3ogM6JF884KebN5IzAUCFcL/4Hf
	qdHelSMwS9z3ZxxP8ylf2FziPPOKvlQaXMYg3CsRjt6ucgm3DJ6qROnoQe1uwxWsxSgptvd+Tcc
	B6Pgd0o3JQyIP+TpVNqieKbI+ZGhors+6U3S4NCMet9fcOLZh4ELE6E+HWterRpbECOzi5dvy/Y
	ZIAGBmRGsbTSuMTr135TiWg==
X-Google-Smtp-Source: AGHT+IEP1XoHBuHE270i0ZfYjYgbUDh2B4NmjzG24AtfqEoOZjen9Q8A09oNwnEn8CwSDeYSqf0PqQ==
X-Received: by 2002:a17:903:983:b0:22c:33b2:e420 with SMTP id d9443c01a7336-231b6034100mr12332745ad.7.1747281140467;
        Wed, 14 May 2025 20:52:20 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7540c8csm108162985ad.5.2025.05.14.20.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 20:52:20 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: john.ogness@linutronix.de,
	pmladek@suse.com
Cc: Jason@zx2c4.com,
	gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	ryotkkr98@gmail.com
Subject: [PATCH v2] rslib: Add scheduling points during the test
Date: Thu, 15 May 2025 12:51:51 +0900
Message-Id: <20250515035151.38575-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test has been prone to softlockup but stayed unnoticed because
of the printk calls during the test resets the soflockup watchdog by
calling touch_nmi_watchdog(). With the commit b63e6f60eab4 ("serial:
8250: Switch to nbcon console"), the printk calls no longer suppress
the softlockup and warnings can be observed more evidently that shows
the test needs more scheduling points.

Provide scheduling points by adding cond_resched() for each test
iteration on their up to/beyond error correction capacity.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202501221029.fb0d574d-lkp@intel.com
Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---

Changes since v1:
[1] https://lore.kernel.org/linux-serial/20250510013515.69636-1-ryotkkr98@gmail.com/

- Add Reviewed-by by John and Petr.
- Add Reported-by by kernel test robot <oliver.sang@intel.com>.
- Add Closes and its link.

---
 lib/reed_solomon/test_rslib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
index 75cb1adac..322d7b0a8 100644
--- a/lib/reed_solomon/test_rslib.c
+++ b/lib/reed_solomon/test_rslib.c
@@ -306,6 +306,8 @@ static void test_uc(struct rs_control *rs, int len, int errs,
 
 		if (memcmp(r, c, len * sizeof(*r)))
 			stat->dwrong++;
+
+		cond_resched();
 	}
 	stat->nwords += trials;
 }
@@ -400,6 +402,8 @@ static void test_bc(struct rs_control *rs, int len, int errs,
 		} else {
 			stat->rfail++;
 		}
+
+		cond_resched();
 	}
 	stat->nwords += trials;
 }
-- 
2.34.1

