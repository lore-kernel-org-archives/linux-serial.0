Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C7246AF1E
	for <linux-serial@vger.kernel.org>; Tue, 16 Jun 2026 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631186; cv=none; b=S7YikE9if3BrfV7DGfLvDR3oMz2ATPqUj4NU0k1TWc+PeXa23xJ45yS6+ST2po5Ck1YIqMhp/2y/oTYBlbF7c4F0p3YwrN2hr9HZtKZ96ZUBGccigIW0fuoIMjzQWorO8zMiPbrG8+u/JURuHxsrWh0Jvn7aN9nHG1l48R8TRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631186; c=relaxed/simple;
	bh=+q/g007+aO/UHimxmV0Ih/bgR3YyUAWftdajmVeUjbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPzXsFvW6ZePxHXRkU6xx0Hloy6CyKUTCCZo21p8bTY6VUyw4PAl0SMrWCA6Gc/ZZfsB4iOqAfMf1siYGSlJQ49NfXrdU2xVLXZvDACp+ZUmtnI35PwpXqEHWyXA40WczkvgChHRwW+YBJaiYYv5RG1cXqGwhQmpbOytM4rOHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b32hocRz; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b32hocRz"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3078e0dcd67so5090077eec.0
        for <linux-serial@vger.kernel.org>; Tue, 16 Jun 2026 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781631184; x=1782235984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WMNZjiW8tS8vPiFakgGpgrB0JBuBFIJhbYt8HcOFzdU=;
        b=b32hocRz04br2LMqils4rylgbLdgemBzQvJslTEqgMdR24JQRsFMVbHJUYSOFq4AKL
         PmmLla+bEm1kF11VtvNOoqIOId3Pn/f2QjPgo0KyB1wHs3DiweFc+bWy0fZdC2RZmh4i
         /cVc7p27K07e5oG1Qb9HWX38tQIBYKu8RXnIaopZG0K17mOAXOu0RU8pLkgA5YamxYRz
         InsNGvirT0Sf93PcHksDHGkx+tPZ2S6d76a/o4GZh8BLxkX3uP3u4ewEGp6TNkffQtLn
         P6S6YvaY/N+B+/mzS1FzPR26uJ3cxwOjch5V3dJZlxYjghfzwBNQN635yulVAyloLzvs
         lpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781631184; x=1782235984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMNZjiW8tS8vPiFakgGpgrB0JBuBFIJhbYt8HcOFzdU=;
        b=e/SCOSGPeYGAXR88zEJsnb01PgjCXb/Ve8W3mYuRUfab281hBy+1HYPAzffBScxt1P
         +9zls8nGhy15r5XEGlbUfqHpQWe4sQA/XJFl3259oMV7UpB+p6jr8gsKrsRwB2tff2zN
         RDiYts8k7OaM4v/d5HhurWKRm2u+B+URufBfqVFjCGHNMm2LuxyQ/XNqwCdh7KW9JPm+
         z895jc99wpo1xmS8BJ6C+gr9V4dw0UYfPN9I3hX2c9HxHzejL7/yZvs2K/++TOrP/UlK
         17Z3qJl8oaKUKB6gy22pHw0Ten58dSgwtSBdf1/SvvXTdq9rXcl5bHHHJ+zF+t3X1p4K
         VsSg==
X-Forwarded-Encrypted: i=1; AFNElJ9oHnqJ41FzF+CvdIY7qe/poCh6EzLpCHSBGabyObuUkyNlzRiSzAiJme8tKITU+QKItogbV8TCURX46Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzFs3+D1WsLIaBlU6m/qe+Zk9kh86Xq4Pf7bGH1HOIOwjbFCug
	w13WRLTQ+R8P7t1lgfoRK/gg0KfuDd/VwxNlBApqS2PiqTb+bF3L0QWMT0i4QDB7jj0=
X-Gm-Gg: Acq92OGpS7DKe39ujenwq5xk26Y4ewkAbwKJ13M/zjVAFVGmX5Vt2xXqqVFmsQPVBMQ
	A33W2/aKxxFmvCLGFTxanFWPfNSR/Y8CwoGq6r73ZKtKndVYqYitm4EOpbSIVXwH3hn60rBmlHT
	5kB7PD+8/7GYQcZ6X8SvajUmC33nuh+jl+OZtJRg9XDg1ipH3FdVibOGQAq9Ta3W8gdmFn4FQUu
	ju5RsvPtyeju2+uZ2oqSwsah5NvTbCX7Dg2JNy2gSN67Bi1d2wYR1KrBFIS18GVYloH0V23Dyl2
	36CAt+mWWxz2lQQEKkyT+o4nOdRLT/RZSWY1H1YDwgCMVuuoCE1SVcrlhfspHM/8Taitn7+KdN0
	wq2Rl1RKxoytvkBrkZCJyPhmOUyw1kENjLGVdfFmtSyJad8cv8Jtj3cuYA375do2PQxVdKnhphm
	YD/9ET2oNTiilcnSoDJOfwqO7vPd7dLYzHY496E1n137nop+Ecp/mLtx4FT+2FIPnohM3g
X-Received: by 2002:a05:7300:4347:b0:304:8364:e95c with SMTP id 5a478bee46e88-30bc9f12a25mr177854eec.15.1781631184354;
        Tue, 16 Jun 2026 10:33:04 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ba6b7f840sm5431554eec.19.2026.06.16.10.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 10:33:03 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: "Starke, Daniel" <daniel.starke@siemens.com>,
	Xiang Mei <xmei5@asu.edu>,
	linux-serial@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH v2 0/2] tty: n_gsm: fix gsm_queue() UAF and add a base regression test
Date: Tue, 16 Jun 2026 10:32:38 -0700
Message-ID: <20260616173240.3665059-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The receive worker walks gsm->dlci[] without gsm->mutex while a
concurrent GSMIOC_SETCONF -> gsm_cleanup_mux() frees the DLCIs, so the
control handlers can dereference a freed gsm_dlci. v1's NULL check only
narrowed the window; v2 fixes the use-after-free itself.

The fix pins each DLCI the dispatch dereferences with its existing
tty_port reference (option 2), so the data path stays lock-free. See the
patch 1 commit message for details, including why the late destructor
uses cmpxchg() so it cannot wipe a re-created mux (Daniel's teardown
concern).

Changes since v1:
 - Fix the UAF by reference-pinning instead of a NULL check in the
   handlers; no gsm->mutex in the data path (Greg, Daniel).
 - Pin every DLCI the dispatch touches, not just the addressed one:
   MSC/RLS/PN operate on gsm->dlci[k] named in the payload.
 - Add a base selftest (patch 2), as Greg asked.

Verification (KASAN, panic_on_warn=1): the originally reported splat is
the gsm_control_reply() / CMD_TEST path (see the Link in patch 1). A
reproducer targeting the MSC handler crashes the unpatched kernel and
survives 270 race rounds on v2. The selftest passes on both the clean
and patched kernel (pass:3 fail:0 skip:0).

Weiming Shi (2):
  tty: n_gsm: fix use-after-free in gsm_queue() control frame dispatch
  selftests: tty: add base regression test for n_gsm line discipline

 drivers/tty/n_gsm.c                          | 105 +++++-
 tools/testing/selftests/tty/.gitignore       |   1 +
 tools/testing/selftests/tty/Makefile         |   2 +-
 tools/testing/selftests/tty/config           |   1 +
 tools/testing/selftests/tty/tty_n_gsm_test.c | 344 +++++++++++++++++++
 5 files changed, 443 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/tty/tty_n_gsm_test.c

-- 
2.43.0

