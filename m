Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109353CAA49;
	Mon, 31 Aug 2026 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164873; cv=none; b=puUHZuZJx+Ir0aGPMYRXRvxEiYIZSFuSK8gIRE9Ekz+Ko9tTpGWvs5HNTs+GEOwuPRd4Nn4NltBUWXgaUCS1ZrAkN7sZEzlOqr40bGI4ViexMAG15P6sy4olrDsJzdbf5a5em4KR0J79kP4/atBFXjx6oH2X2jXkcCRieHI6H+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164873; c=relaxed/simple;
	bh=5FTh0Yv8tSAdH324nB6zsmdGAwT+GuWavAVk00uLqhc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nRvjHOA49ROc08WfoGxs01hUceLM6EajkmZAFe3CQ+JXWPdFuy10rFeKq02hvoNdwbCIfqIx4n+8ZZqzrmc4H7bkoGnuxrnA34cBVM3G+4msu9rX7nKyMJ9xHUy8l5MzBw7kad9yO333R+71mp5SIHK8vK3J0t9HWKCSPmw3AJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWpmUpON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWpmUpON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237EA1F000E9;
	Mon, 31 Aug 2026 08:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788164870;
	bh=sdnDSnE27149BUcPj7rnlsDQtbHL0lCszRlaB8rnvRg=;
	h=From:Subject:Date:To:Cc;
	b=jWpmUpONIzS8DwMc97TLTkDvp8xhwhffGlQU+Gw9Em5B9/M5J/Cen3D8DG3Ny5rXA
	 /X3Zg8kghs4opYX4bsP2kTLk7XDnWbqMZL1Vzm8Jn5XuxlWYWT4hHFfEGvfrdd8c9H
	 NzVseV+IXY50R4md+TZPLh5gPD1MHVOAhL0DHzfVzpTNJglk+qDD37TlvsX99DW0Xt
	 9isP1ngUcA7K4+tMAixOnjetJSa3kcD67YzuGUckxXQs2OqW8bg80rihAolDXHb6Md
	 TAMBYtTxtXGKbCNm7OumQSKQVq06YANUkHxfDCqBserLdiA6hvWA6Ga4/Iplu5R8Ir
	 yc49DsjUUXjFg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH v2 0/3] tty: replace page allocator calls with k[mz]alloc()
Date: Mon, 31 Aug 2026 11:27:42 +0300
Message-Id: <20260831-tty-v2-0-88cd58c3c640@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2OzQ6CMBCEX4X0bMlSsPycfA/Doa0LVE0x20okh
 HeXVo/fzOzMbswjWfSsyzZGuFhvZ3eAOGXMTMqNyO3tYCZASGhEy0NYeVMNcNZ11Uih2JF8EQ7
 2k1qu/Y/9W9/RhHgaE1p55JqUM1OUEtZ5Ga3J+jDTmj5YiljxHyshjS0FBw5GoyxqkFWrLw8kh
 898ppH1+75/AVqHITrEAAAA
X-Change-ID: 20260829-tty-84f05b74862a
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.17-dev

This is a (small) part of larger work of replacing page allocator calls
with kmalloc.

My initial intention a few month ago was to remove ugly casts [1], but then
willy pointed out that Linus objected to something like this [2] and it
looks like more than a decade old technical debt.

Largely, anything that doesn't need struct page (or a memdesc in the
future) should just use kmalloc() or kvmalloc() to allocate memory.
kmalloc() guarantees alignment, physical contiguity and working
virt_to_phys() and beside nicer API that returns void * on alloc and
doesn't require to know the allocation size on free, kmalloc() provides
better debugging capabilities than page allocator.

Another thing is that touching these allocation sites gives the reviewers
opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
another size is appropriate.

For larger allocations that don't need physically contiguous memory
kvmalloc() can be a better option that __get_free_pages() because under
memory pressure it's is easier to allocate several order-0 pages than a
physically contiguous chunk with the same number of pages.

And last, but not least, removing needless calls to page allocator should
help with memdesc (aka project folio) conversion. There will be way less
places to audit to see if the user was actually using struct page.

The patches are deliberately kept small: each one deals with a single
driver or subsystem and with a single type of allocation, so that every
conversion can be reviewed, and if needed reverted, on its own.

[1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
[2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/

---
v2 changes:
* change xmit_buf type in uart_{alloc,free}_xmit_buf() to u8 *

v1: https://patch.msgid.link/20260830-tty-v1-0-0cbe6170649b@kernel.org

---
Mike Rapoport (Microsoft) (3):
      tty: port: replace get_zeroed_page() with kzalloc()
      serial: core: replace get_zeroed_page() with kzalloc()
      tty: hvcs: replace __get_free_page() with kmalloc()

 drivers/tty/hvc/hvcs.c           |  6 +++---
 drivers/tty/serial/serial_core.c | 18 +++++++++---------
 drivers/tty/tty_port.c           |  8 ++++----
 3 files changed, 16 insertions(+), 16 deletions(-)
---
base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
change-id: 20260829-tty-84f05b74862a

--
Sincerely yours,
Mike.

