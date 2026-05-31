Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DE11DDC33;
	Sun, 31 May 2026 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780210975; cv=none; b=C6I0gihMBuxNDh1IWMncgFsT7RZOvHy9ogP72YlwbLpYoYQ3j5omU10KPIJV9Qjf6zjx7hX6hEkmT9gPEGxAstO7sysvKUY0GDVy1DrSv96tOXiVlLVQzOo786ReeNONs/2guvzNGQXFSYgf1dUYxsEptFUVgxehDFtWf0QX1bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780210975; c=relaxed/simple;
	bh=KEyCBdonVMiqDc8WS7LEEHISba4DA7PR6Hv9VjQb/N8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MCz2cGYxxWaoJPMIkyPD28C7yox44cD6QvKDqthg/07fl5nPiuJ76rThZU4Si0Ovg8uYebTGhgglFE2L1tOn3TK5Yd6mqfOgwb3ei1+uaQS3V281ZLpG5LGtuyXIXlFhjCLShWLwj7kPT7ChRcu2rI58Lwe7OKW/sKgIOmW4pSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm0xTCxv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm0xTCxv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EBD1F00893;
	Sun, 31 May 2026 07:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780210974;
	bh=TNo/DBsbd7T6Wd5boSxyQ/8mBLAohX5xkpcukm+9f/c=;
	h=From:Subject:Date:To:Cc;
	b=hm0xTCxvJyetF9xTE6wmCMBb7QoTP5L4S3MNH/MGJVf+DtAYubOsFNBXIjHmR1xzM
	 6iuxJiw6xM/PwdVP/pVxgBNeBoED0n8vwjQop1bfxMBk6LO0703JCCQ2CPvmDgpzOo
	 n9OyQA/l1Hc4xLVSCLRfJyyfCwREH6DnIokqsj0cSO6Pfxu8IayyAIkpWRVIPRzIge
	 tyKGjpkax60BmlVguhXWzzhogPI/KerEm3SGmbasVbeUijJB/hYHAMiGdOV8bdFbav
	 ivVA4kFg/NfpeqdqwYAq6y2xBpEPQEVWNaIsokf+Ly0STz5YTWHkD2V5SvUzNR1FC/
	 ZbIWMU2X1hLOg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH v2 0/4] tty: replace __get_free_pages() with kmalloc()
Date: Sun, 31 May 2026 10:02:46 +0300
Message-Id: <20260531-b4-tty-v2-0-f7149947d4ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABbdG2oC/2WOyw6CMBBFf8V07RhaeYgr/8Ow6GMKVVPMtDQSw
 r9LcenyTM7cexcWkBwGdj0sjDC54Ea/gTgemB6k7xGc2ZiJQtRFJS6gSohxhkbX2Ba25Iaf2Sa
 /Ca377EH37sdhUg/UMX9nQ8mAoEh6PeSTIZeQAqjJWqQsDC7EkeZ9SuI56K81cSigNbK1jURdW
 XF7Inl8nUbqWbeu6xeHcVnp0AAAAA==
X-Change-ID: 20260528-b4-tty-7c6e90f41d13
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.15.2

This is a (tiny) part of larger work of replacing page allocator calls
with kmalloc.

Nowadays the right way to say "I need a buffer" is kmalloc() rather than
ancient and ugly __get_free_pages().

---
v2 changes:
* fix placement of include <linux/slab.h> in men_z135_uart

v1: https://patch.msgid.link/20260528-b4-tty-v1-0-9da9f7aec5f2@kernel.org

---
Mike Rapoport (Microsoft) (4):
      serial: pch: replace __get_free_page() with kmalloc()
      tty: amiserial: replace get_zeroed_page() with kzalloc()
      tty: serial: men_z135_uart: replace __get_free_page() with kmalloc()
      vc_screen: replace __get_free_pages() with kmalloc()

 drivers/tty/amiserial.c            | 14 +++++++-------
 drivers/tty/serial/men_z135_uart.c |  7 ++++---
 drivers/tty/serial/pch_uart.c      |  6 +++---
 drivers/tty/vt/vc_screen.c         |  6 ++----
 4 files changed, 16 insertions(+), 17 deletions(-)
---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260528-b4-tty-7c6e90f41d13

Best regards,
--  
Sincerely yours,
Mike.

