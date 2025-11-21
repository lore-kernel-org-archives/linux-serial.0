Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B892032D
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763751059; cv=none; b=dlecrVwzLmN7nGH5WUt5mQ0yuiDK4fgxBkEE6T4K9CMOpun3jqYc/y8UlgPq6bDwLmeXgEiyxM45DCRRfmVS1d6FSLgQKaiPJrYak7Z3lTqfIwPsbjR6BnC4ph/L0GA+NbjUzIvl3zmu3oZr2DO3IPouf0ryi0flXadId1m0pIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763751059; c=relaxed/simple;
	bh=PRmdFpBAp0gKYH3/id9Pz+CPCxU1dvesvh01EHtKBRM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZsK07ZKkRUdAL0wh6bx2Ovya0/LgjgBmqPuQveEb3SFi7vEPkrcBLI3nScRSa0+BL09E6aXBYenCg1T+v1NbWRAWQHuN9F9LLgnCe2Y2a6BB2fZLaGlVc6k4MHniOYv9ftXDFZwaLrToQaOFLEAYrLFIr0spqq53SN6CjAWi5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EX2BcZu5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EX2BcZu5"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so1392821f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 10:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763751055; x=1764355855; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ibfn7mBD8G88qTHwmiSSUBpyhylgYk5Y/kKJqSpwQsI=;
        b=EX2BcZu5hQJ4SpiJfYqlTMYDNNpEfgvIKbYOvvOMJNnuP4VItjDy09pU01YVSxPbS3
         uKU6PmEGajp2txDibZmuYRxW2tOjkXfpGPCMqMCD+1vR9vRZMBfFHY6408ey+A2AokT/
         grKEIyfScD/E8VsPhznegRs1pOr7V8gKEEaD7K/bV9XaoMDeFFrtKELDMuvmXyA2+fpI
         3i8IcytjHQZZLytwUfgNp/jrGtFiZLQ39dNhbFJGq0HmrPKQauPTDgVta/Plhls//Sb1
         KpWE3ZnEaGMrEZIZdRpCdVmpyjmU6oXdsgvqPvlQFU0FoxXnjupnmMktdTAx8LCnsr7i
         viUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763751055; x=1764355855;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibfn7mBD8G88qTHwmiSSUBpyhylgYk5Y/kKJqSpwQsI=;
        b=wpZVwr0s156g2M5PCOzDRsQsdNfznYSJ778nUc3njV8LC+ix8Ln8DzvH8K5zjA4DUr
         PG7OP4WIlCYlXDowFwsc9fnHkHm7xoP7jzt4w6qGmMaBnVxlEAU6QTs6z7/Y4l+/VwRV
         nwmQpUN1uCzI54pQQTz507aGTqscZbpCX0ePc/AY5DZ+FjdRCgvWttJ93K4sI2HYvJ7D
         YiFO4KZOy+tOffV0F0igWZRem3V8wvyVQDj6THhUTxGkEktmX02QDuZHkF0B6/G/ObLg
         PxVVYDb6G8/82y4dK9FevLtQxokJLcPLDIqUAOszGdTgrBeDFxE2Fc+Q0lH8c/y23Gig
         kPDg==
X-Forwarded-Encrypted: i=1; AJvYcCVGXI+ZucJVW6zSw7pHekcc2hhEkINC8AN9rVuNgX5cPeA8rsAL8QaWLE2scSKyXxU8ds0O2NHmLHU41b0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzhx9/l6+IELXq4sn4Hiy2+tllZgQBvZCp8vFl+u3ilz7NMjYS
	scvvnEG9RaQF4Ug3dY+dm0HSr0zkrPwxjMG4JwmDsLgyRa7nWdil40DpiCOusOogMj8=
X-Gm-Gg: ASbGncu4q1vcux50kf+WcgxbsSOTDy6vLuPX3T/+m0fCJ4napDedB3P5hz+Mw9hjTEM
	dKpFkTUKCRapO53jrZsRDbh0ULtuAZCPGzR6pk9PTBykvy/cwV69ARteav/gsMroim6rZeEqy9P
	N8yRJL9er/Vt2Re5cK6bSWDeYzxmJSMchyQt2m0zL+tcU+GLpXkzOIe+J2aHbxst8NP1fq296Tl
	m/5+siCBL9ENf5anHdSCPZLJ5ooNeECyxqctPtn3uevnKn4sKE70GyRoUfkOUODh9l5xr76mPIG
	ahT9JpRggYD8hzpAJ0L4uuO+ygZAD4KW0F7Xxp3CtaVUGBA9mHO7iQuAMO5OYtVCBL2EA3pue0H
	ebHFd+1XBtyrDQW8wn05WUHlJTDcHdIcBkuo4KeQ+JL/pfNKrj0JZgCDM1Uxwi0WtJKlWxyzVGf
	jCbiTr2bMtNKHkg7rnQ8FI1VpBbpy+6VDA3y8=
X-Google-Smtp-Source: AGHT+IHxEr/Yh7njaXk+mwYujoxolgcHP00SWc/UQYnx2ejCkcaeHIL00gnZEqf09doPvbBPesYlHg==
X-Received: by 2002:a05:6000:2c05:b0:42b:394a:9e0 with SMTP id ffacd0b85a97d-42cc1d27abamr3461896f8f.32.1763751055244;
        Fri, 21 Nov 2025 10:50:55 -0800 (PST)
Received: from [127.0.0.1] (99.36.160.45.gramnet.com.br. [45.160.36.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8baesm12473639f8f.39.2025.11.21.10.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 10:50:54 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v2 0/4] printk cleanup - part 2
Date: Fri, 21 Nov 2025 15:50:32 -0300
Message-Id: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHi0IGkC/22Nyw6CMBBFf4XM2jHT8mblfxgWTTtIo5amBaIh/
 LuVxJ3Lc5J77gaRg+UIXbZB4NVGO7kE8pSBHpW7MVqTGCTJkioS6IN18x31g5VbPHoVZol5MzS
 mFNRQ20Ka+sCDfR3Za594tHGewvt4WcXX/oLV/+AqkHAoZK3rIjdG0SUukc96ekK/7/sH/Ekl9
 7cAAAA=
X-Change-ID: 20250601-printk-cleanup-part2-38f8d5108099
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763751050; l=2044;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=PRmdFpBAp0gKYH3/id9Pz+CPCxU1dvesvh01EHtKBRM=;
 b=BB4qSfzhItSvSkb4sdozUwQREO5JyqBCeTI4O6aM+90/NYaHuB2QnqOSN1qJltnW37QS3VMVc
 WAytuhobAlHD+BrNYQL4GhwMxYd+M7u1t6KVhQ+YfHsl6wR1PtaGGy+
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The first part can be found here[1]. The proposed changes do not
change the functionality of printk, but were suggestions made by
Petr Mladek. I already have more patches for a part 3 ,but I would like
to see these ones merged first.

I did the testing with VMs, checking suspend and resume cycles, and it worked
as expected.

Thanks for reviewing!

[1]: https://lore.kernel.org/lkml/20250226-printk-renaming-v1-0-0b878577f2e6@suse.com/

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Changes in v2:
- Squashed patches 1 and 3 (CON_SUSPEND usage) and now is the last patch
  of the series, suggested by Petr Mladek
- Moved commit 4 as the first one in the series, and it was changed to
  use console_is_usable helper, suggested by Petr Mladek
- Moved commit 5 as the second commit in the series, and adjusted to use
  console_is_usable helper, suggested by Petr Mladek
- The patch 6 was dropped, since it was implemented in a different patchset
  (https://lore.kernel.org/lkml/20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com/)
- Patch 7 was moved as third patch, and is using the console_is_usable,
  suggested by Petr Mladek
- Patch 2 was dropped from this patchset, and will be included in the
  next cleanup patchset.
- Link to v1: https://lore.kernel.org/r/20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com

---
Marcos Paulo de Souza (4):
      drivers: serial: kgdboc: Drop checks for CON_ENABLED and CON_BOOT
      arch: um: kmsg_dump: Use console_is_usable
      printk: Use console_is_usable on console_unblank
      printk: Make console_{suspend,resume} handle CON_SUSPENDED

 arch/um/kernel/kmsg_dump.c  |  2 +-
 drivers/tty/serial/kgdboc.c |  1 -
 drivers/tty/tty_io.c        |  2 +-
 kernel/printk/printk.c      | 17 +++++++----------
 4 files changed, 9 insertions(+), 13 deletions(-)
---
base-commit: 887c7f05d40eb51ba3f38fd71d5e6b4aff4bb8a2
change-id: 20250601-printk-cleanup-part2-38f8d5108099

Best regards,
--  
Marcos Paulo de Souza <mpdesouza@suse.com>

