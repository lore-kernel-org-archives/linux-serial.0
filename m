Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DC83672AA;
	Tue, 30 Jun 2026 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813251; cv=none; b=SjwJRmfRmtiKYjyfH/v4ggog9CdWdg2G1MB8Wo8pRQ+y8Iy4fOSXqZTfGFhKwWGw2FZpwbhKYuvbtncEojR/xzFhE/qCypQN/ZdYpt6b4Dq5es5DZffVX8SucX7uWaD9N3rn/kESLl7ofAwidG8Kw9bhmFgQz8WUnysfmkl1xvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813251; c=relaxed/simple;
	bh=U2xdr8VH1cmygTFcncFI5dWxWKaiylus78GKf0wWHXA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wmr5RQoXnM5REUXmUY5R9g3CgyG2WzVAusP9zON7OmVNjuWZgz2Eba5KlplDzDWbPdKsnmhgGHWp2gcGWYLZhGikmDdUzJDS3qEAnR8lVfMZfG3s/ESU5mm90kAmOhbWt/Bcmx40Fs+yn/0YSZLYOjRWs1hSE+WfeOCyBCQGMYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKVSHJxA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKVSHJxA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB081F000E9;
	Tue, 30 Jun 2026 09:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782813248;
	bh=qHdjGsIhJ+8ibgAZAo0aWXS4qbeGOWvcwxs3o6/Dxk0=;
	h=From:Subject:Date:To:Cc;
	b=CKVSHJxAPE1lT77XrFx/EwdRsgolR0yEMv004ju9lIT4uEOOACXWfYPZoFmCM8Stf
	 8FkIpUqHwkwx0e7Py9kYxoxTqzZL9ERzIERYlMd8chFj6oy/XFcqU6Mz9yELOhaf7T
	 pi0Am0mRaQlno0WuP8yJ3sY5OsIV2qCg+biTKNKRNJiqVLv7bdeNprnQC4R6s7xOjx
	 adzDFTnh4cZV1j1ljrPwaM5EZUNklF4Li42JvcpJgpHzBkOCCNhla8Frxg8C2odkJ1
	 HW10EsDbk4hfa2Srt0AGj0UgVEM2sFKdbQMekTSOHBoBlEyDTBRDOcW32SNDqa2rhG
	 2+gb0M95WvImA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH v3 0/4] tty: replace __get_free_pages() with kmalloc()
Date: Tue, 30 Jun 2026 12:54:02 +0300
Message-Id: <20260630-b4-tty-v3-0-a8476c66c582@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADqSQ2oC/2WOyw6CMBBFf4V0bQkthVpX/odx0ccUqqaYFhsJ4
 d+lmBiNyzNzz52ZUYTgIKJDMaMAyUU3+BXqXYF0L30H2JmVEa1oWzV0jxXD4zhhrlsQlWXEkBq
 t4XsA655b0en85vhQF9BjtnNCyQhYBel1n0cb8pLmVe/iOIRpeyKRXPF3LxFcYWGksFyCbiw9X
 iF4uJVD6FA+mOiXV5OPR1fPcsKEYNwwsD/esiwvxF31sQIBAAA=
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
v3 changes:
* rebased on v7.2-rc1

v2: https://patch.msgid.link/20260531-b4-tty-v2-0-f7149947d4ef@kernel.org
* fix placement of include <linux/slab.h> in men_z135_uart

To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
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
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260528-b4-tty-7c6e90f41d13

Best regards,
--  
Sincerely yours,
Mike.

