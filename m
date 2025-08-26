Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40A130CDB4;
	Tue, 26 Aug 2025 22:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756248710; cv=none; b=Kqn910s3UB2Lcg7hhv5FY2iuQ5UQh6tdquZM6+Wx+4ibs8b/3vYGoUY0KDcbyL/pmpeXDa0N56hwW7XoaQpjOMR80iCpTTJWame6cthTDefNBJKFtvS2MoA65iOuQTLeUXU3cwEcKMekf8V+5MLI4NfLkBgb6CxoPHvcxjsSz7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756248710; c=relaxed/simple;
	bh=hgk4XDMvj1XRZUEv0zpCfESAIhrSX8CeXQ0czb2Zh0M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sVWMy7DcFaeeYQUoxfto5FhCg+8XHjLuXErAiTWYS/QTtRv5kZY2lZBq9GsROd8BCxubQAIiowpGWQtxeEJKMGW0Sc8k9hgT9FVisC7GjmpV/dnnd9Z7wuZhB39iWb3qmD8nqR1TqBdQhaQwnozSJ6mSj/g57BYzHT/I+eeI7RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZH210GJO; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH210GJO"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-323267872f3so4907928a91.1;
        Tue, 26 Aug 2025 15:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756248708; x=1756853508; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nZ1zyXSSIOQ4H4hZM313mvzovTi9cnOMX7vreXvwnt8=;
        b=ZH210GJOWtoq0n3sxfhXPRw/4mx439U/2mRcSrvPdOeboa7RywbdKnCnjV0GUAJ88K
         SJ1IUQFwuURXaF/4kzUDVxyHoivDgO0jBgj6VJXeo4N7kI38CWGRmXNJU9EdtOytZhFf
         Zm9qVHcpNvtfzEwFWoJqBM6TOjGFi0Gkkq2OnxgThdC3Joxx7xtOWACZ0AU40sLdCWax
         L2VigclYvqaOcfctTDSb9P0IjBLT6sCmwIQkDel/TsSRxX6MO0J4Asbjj37McQxU3hvc
         AmxUWE+K02TBrxPbPKx5SwQvMuop/0JETjxHP9OToRgCIONHsjqWQeBAW1OynfPaSjUu
         32XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756248708; x=1756853508;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZ1zyXSSIOQ4H4hZM313mvzovTi9cnOMX7vreXvwnt8=;
        b=pOIMRpebSgrNZ9HhQl/suHG1WEJthXelH2+2coWVJtTwNdyZ3Ubo+JU0WzlUp2W1kd
         JdBGeqdUvvrMLwMxBizKaQ0BQPEXnqDssAPgBr+S/8XPhMnQas3T5/jlOhWDNX8kBZpl
         tupKKRCDXOkMgxqCX9IghFDkefTP9MxUZaIlR8CSCzX9yCAVCUCR2ECS1kb1rglT5+hI
         /C33HGOwKkzJQMYHCY+2qItzOk8GW5oM1ywFWrY8mCYZnZMC4Nze44v+eO857ofIxxvS
         rCIxfLkqS3rCv7npq21C68pY/peI1ZcFpJRQBbWSbyzGYuCSYdw7mWdcqCc3ADaCy+Ro
         6pQA==
X-Forwarded-Encrypted: i=1; AJvYcCV5Zsdr3dBN20qKAklXCvwyG4a2R2AVxnhQHnpnY4rQG8tjWro+NAQtYHE5RjkFz1yRzEMgzmHL6DML/4mF99c=@vger.kernel.org, AJvYcCXXxa2yjhAZktjrbS4MVgsl1+fqEkBLGKbEFyVWPJo4JnXEdV3u+aVO9kvgUFOs1AYO22dB0sOZNoRQ6koJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxYPNWVlgAW/lXtcoh3OtSTcvOnYzhaGYmfuSlRHmAoiidf65wp
	k0y0iWTsAHMBm3XEgjTTy/gB2oxpNGidFM+/8yqHBSVb3+QtDTSthl0M
X-Gm-Gg: ASbGncspUl7hgh1vNnKrI0J1pt8nagTQIxedQ7f0yAp65Awv8gDK+iZqUEWq2Kvk0w/
	9aV4iuGlFAD3PE/jc0fa3dEkuKA3xmqVvJ+vemMjj4mDg51iUdWGuFqBJl4bJxkD/P7/A13UmIs
	uCllCqrHNcLvKoX1j1xQ/MXCTY79AaW+zU1M9YQf7MyXSGa7lzlew/pIqolgjiRfhABwtABpkA8
	aPJx5Ge/dpvhC1CzDOeYvBtVvtadkVTTFd/6eJUSgn0iruewPWz6SBxVdI/y1Yd0RcnV1ngtWna
	GpjEJPepWmMOGUqrODQUQjEtoTcx2fhW+fUDS9Of7wwiOPwl0ZWLSiPsV9lxd/vb3yE33Kd2LML
	if4RcE0BQiIJKWQS1wdpV
X-Google-Smtp-Source: AGHT+IG/HzQ4hMId5Yct6mGAhKNYFzfy96p39xqVpexqISKH81EdXf5MkxVWA1nFcqIHqt/EM66QhA==
X-Received: by 2002:a17:902:ec82:b0:247:7e9:110d with SMTP id d9443c01a7336-24707e91239mr101058735ad.6.1756248708113;
        Tue, 26 Aug 2025 15:51:48 -0700 (PDT)
Received: from [0.0.5.57] ([136.159.213.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688a601esm105340815ad.162.2025.08.26.15.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 15:51:47 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
Subject: [RFC PATCH 0/5] tty: Add KUnit test framework for TTY drivers
Date: Tue, 26 Aug 2025 16:51:30 -0600
Message-Id: <20250826-tty-tests-v1-0-e904a817df92@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHI6rmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyMT3ZKSSt2S1OKSYl3ztOQUiySjJANL41QloPqCotS0zAqwWdFKQW7
 OILEAxxBnD6XY2loARpCBXmkAAAA=
X-Change-ID: 20250824-tty-tests-7fcd8b2b093e
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
 Abhinav Saxena <xandfury@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756248706; l=4094;
 i=xandfury@gmail.com; s=20250614; h=from:subject:message-id;
 bh=hgk4XDMvj1XRZUEv0zpCfESAIhrSX8CeXQ0czb2Zh0M=;
 b=mSY5yCA3KyC3Jqpzeam3sxhrqhDy9sptr85JvnLMfcV7xFOHeUh1WHDvH6DvdeIHlJNpXm7ph
 p1EdMuN7iI6AUnv/NRn/HgYTdbqiB4Uy6CHqf9MebJo5XZAOXaGCc0s
X-Developer-Key: i=xandfury@gmail.com; a=ed25519;
 pk=YN6w7WNet8skqvMWxhG5BlAmtd1SQmo8If6Mofh4k44=

This patch series introduces a KUnit testing framework for the TTY
subsystem, enabling deterministic, automated testing of TTY drivers and
core functionality without requiring hardware or userspace interaction.

On an x86_64 build with CONFIG_GCOV enabled, these tests increased
TTY subsystem coverage to approximately 10.6% line coverage and
14.7% function coverage [1].

Problem Statement
-----------------
Testing TTY drivers today requires:
- User-space interaction through device nodes
- Complex setup with ptys or real hardware
- Limited ability to test error paths reliably and deterministically

This series solves these issues by providing in-kernel KUnit tests that
exercise real TTY core paths under controlled, deterministic conditions.

What This Series Provides
-------------------------
1. Reusable test helpers (`tty_test_helpers.h`):
   - Minimal (~150 LOC) infrastructure that any TTY driver should be
   able to use
   - Automatic resource management
   - Integrated into core files under KUnit guard, with
     `EXPORT_SYMBOL_IF_KUNIT()` to keep the production symbol table
     clean

2. Mock TTY driver:
   - Demonstrates how drivers can leverage the helpers
   - Enables deterministic scenarios without hardware

3. Core TTY tests:
   - Validate open/close/read/write/termios paths
   - Exercise hangup, resize, and error handling
   - Ensure real kernel paths are tested, not mocked stubs

4. ttynull driver tests:
   - Validate data sink behavior of the null driver
   - Provide a minimal driver contract baseline

5. Optional coverage support:
   - GCOV integration for test coverage analysis

Future Work
-----------
With this foundation merged, follow-up work can:
- Add more coverage of TTY core functions
- Enable each TTY driver to maintain its own KUnit suite
- Introduce stress tests and race detection
- Extend to include more tests for other tty drivers:
  - UART drivers: test interrupt handling without hardware
  - USB serial: validate disconnect and reconnect sequences
  - PTY drivers: test resize, flow control, and hangups
  - Virtual consoles: test Unicode and input handling
  
Testing
-------
- All patches pass `checkpatch.pl`
- Verified on x86_64 with:
    ./tools/testing/kunit/kunit.py run \
        --kunitconfig=.kunit/ \
        --kunitconfig=drivers/tty/tests/.kunitconfig \
        --arch=x86_64
- All tests pass (working around tty_read wrapper in progress)

Feedback welcome! :)

References
----------
[1] Coverage reports: ttytests.haunted2bwanted.me (alt: linux-9ik.pages.dev)
[2] kunit.dev/third_party/kernel/docs/usage.html#testing-static-functions
[3] KUnit: docs.kernel.org/dev-tools/kunit/
[4] TTY driver API: https://docs.kernel.org/driver-api/serial/
[5] Big thanks to LDD3! (Ch18 especially!)

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
Abhinav Saxena (5):
      tty: Add KUnit test infrastructure configuration
      tty: Add KUnit test helper functions
      tty: Add mock TTY driver for KUnit testing
      tty: Add KUnit tests for core TTY functionality
      tty: Add KUnit tests for ttynull driver

 drivers/tty/Kconfig                  |   9 +
 drivers/tty/Makefile                 |   7 +
 drivers/tty/tests/.kunitconfig       |  44 ++++
 drivers/tty/tests/Kconfig            |  44 ++++
 drivers/tty/tests/Makefile           |   2 +
 drivers/tty/tests/test_tty_io_core.c | 249 ++++++++++++++++++++++
 drivers/tty/tests/test_ttynull.c     | 163 +++++++++++++++
 drivers/tty/tests/tty_mock.c         | 186 +++++++++++++++++
 drivers/tty/tests/tty_mock.h         |  34 +++
 drivers/tty/tests/tty_test_helpers.c | 387 +++++++++++++++++++++++++++++++++++
 drivers/tty/tests/tty_test_helpers.h | 239 +++++++++++++++++++++
 drivers/tty/tty_io.c                 |   4 +
 drivers/tty/ttynull.c                |   5 +
 13 files changed, 1373 insertions(+)
---
base-commit: 8d245acc1e884e89f0808f64d6af3fc91d4903a0
change-id: 20250824-tty-tests-7fcd8b2b093e

Best regards,
-- 
Abhinav Saxena <xandfury@gmail.com>

