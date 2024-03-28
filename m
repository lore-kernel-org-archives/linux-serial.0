Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EC0374EF
	for <linux-serial@vger.kernel.org>; Thu, 28 Mar 2024 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654459; cv=none; b=hKTEgMoutVKTKEAsTqrXuHk/ausZscT7qLj/F+p5zYOxq6KWeLdx1a8gBVAfh/xlp+f9HMrmuSp3juKCq1UYJ5JBmj2lw2BnAaoy3gCNbNcLFLsi+6fA4Dweef/Vcr2Bp/d9IulBGRsE5NrM8BpwP/RTwEhgYPKthPU2v0TNLNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654459; c=relaxed/simple;
	bh=XQ4H6m7tZOjNJqsayCfyl+1h1KKHM5EiiF21zB23LSw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jBPT8FiG0d7rSTZn7R9JhLVkTYus+6p1trnNoBOD9+7vWLj+jgnJDmf4rDfa0imlh/OAVYOrUVof5EdZSH2oOmZDu7/TnbCtLlpX4by01NoGtcGykXQBGVPMChVyLCRRryL8zFmmxU9aBrfK4K+IlNe609gCKNq8qxDosBQsxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fastcomproducts.com; spf=fail smtp.mailfrom=fastcomproducts.com; dkim=pass (2048-bit key) header.d=fastcomproducts-com.20230601.gappssmtp.com header.i=@fastcomproducts-com.20230601.gappssmtp.com header.b=aJj7mmFE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fastcomproducts.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fastcomproducts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastcomproducts-com.20230601.gappssmtp.com header.i=@fastcomproducts-com.20230601.gappssmtp.com header.b="aJj7mmFE"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e228c12468so2702735ad.1
        for <linux-serial@vger.kernel.org>; Thu, 28 Mar 2024 12:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastcomproducts-com.20230601.gappssmtp.com; s=20230601; t=1711654456; x=1712259256; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XQ4H6m7tZOjNJqsayCfyl+1h1KKHM5EiiF21zB23LSw=;
        b=aJj7mmFEBYUBuqlpM+abBfH1ihe3Qu4XReMi8/MxxPW/+upG/4Vykc0xzw25/drWZR
         OF7KD+tY8fhUAmiK+hzmnj6kmhkzjUPsB8BElL0PMh8Zq5IGwf8U5+ptW3LnuQ88FYRh
         j/sC2Iw5PSoR9jXM7qeRC2SUEUv8Wc4MM5rBK0zzC+ozRrsensChNn9SIPZ/G0kmDlqH
         n/PdHA0TPhAo+uNaUGp5g+XhoHWgw7mnqY952pRk04qH5vkduTZWIHeV3ZXWnG5/1Voo
         UnttoGbQhVv1lv4Qr7o1fetF4Yzpc2RjrCtICpA9r2g2RT72/pW6RB/v4JfJc/SZfSsA
         voEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711654456; x=1712259256;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQ4H6m7tZOjNJqsayCfyl+1h1KKHM5EiiF21zB23LSw=;
        b=uFM9EZ1i7viy7pHuZRmWcbjpitiQMTVJX3TCKS2hRlEzBUTw9HLRz7guWcWSog2KGY
         NY8Y1BMkrpGkS2ZYeOpRj4PDfTFKykJVwDpo9Szke+JQ/FzYPlvLMpWgNzJ3TEKvos3V
         sim1e0tBWAh0EJur9pcxI2xoLLx+c/ERpGPKhipEwavjS/Er61lfjvIMpJFGyggT2nuG
         MqeKgLF2tZvhpwGRJ63/qLbSE89IqGPPHcyXPDwjaNURVACVbF8GTVRZhD8uJ2wnTFX9
         Xw7FEitNxef3ccAlgWqzfqPE4eAhcxbDiCBO7cZeykA6BCCl1NFySH1nc8bDEI2f66SR
         w8Lg==
X-Gm-Message-State: AOJu0Yzr8+7RWB3wQgrSAaaYWjjoXmXW4/rKFCtyWXXcYLnxSnzuWydx
	QE3ddO5GBNeSF/7G3NS8h2DlKzV3mPvnI/YuHXmCT0daw0nPETsWYUOuxpx5N5lvOKdNdDWhUE2
	UhNkOVwI9f6ZAJrzyDEB/fcX0O99MtTqc2uJJ1JenFsZvXyZCPQ==
X-Google-Smtp-Source: AGHT+IH5NIUTIQ/dfG6GsP8iNmkX14fihxZF+GlNH9uU97gZP3Y9cTYoCXNI697D30nMOirkAFO1x6yvVIUOqDvaRfc=
X-Received: by 2002:a17:902:f54a:b0:1e0:aca5:fd24 with SMTP id
 h10-20020a170902f54a00b001e0aca5fd24mr444300plf.24.1711654456464; Thu, 28 Mar
 2024 12:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joshua Droney <josh@fastcomproducts.com>
Date: Thu, 28 Mar 2024 14:34:10 -0500
Message-ID: <CAJqSBBNc5mPcKfFSH2jXnjp9PB6fQGWN0vB9JPKHENogUw-D+A@mail.gmail.com>
Subject: Incorrect UART in /tty/serial/8250
To: linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello!

My name is Josh. I'm currently employed at Commtech, Inc.
(https://fastcomproducts.com/). I'm following the instructions at
https://kernelnewbies.org/FoundBug to report this issue. Please let me
know if this is incorrect.

We (Commtech) have several serial boards, but the board in question is
the '422/2-PCIe'. This board does not exist, but someone added it to
the Linux kernel at some point in the past. This wouldn't be a
problem, except that the board ID that was used for this non-existent
board (0x22) was ultimately used for a different REAL board, with a
different UART. Instead of a xr172358, we use a 16C950 on the real
board. But the Linux kernel finds our other board ID, and tries to
initialize it as an exar chip and fails. I don't know much about the
kernel, but I believe the lines in question are:

https://github.com/torvalds/linux/blob/master/drivers/tty/serial/8250/8250_exar.c#L47
https://github.com/torvalds/linux/blob/master/drivers/tty/serial/8250/8250_exar.c#L925

You can see that we have a different board with device ID 0x22 here:
https://admin.pci-ids.ucw.cz/read/PC/18f7

The 422/4-PCIe exists (0x20), the 422/8-PCIe exists (0x21), but the
422/2-PCIe was never created and its device id was used for a
different board (0x22, the SuperFSCC/4-LVDS-PCIe).

Josh
