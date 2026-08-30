Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A922DCBE3;
	Sun, 30 Aug 2026 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788076183; cv=none; b=JqGegGL7nfYmVLE9T1KekdGSfWJdTIcUOpEMrZjWFND7YhDM88q7tNKZP9vXl7Dm4aX38V2lXsa/zGsAto1s437Y9cthT9s1A2TUfI/RPEKYDLF2o2pjB81CrvaB/7fJliMy3tsAVNqrxsPZnuJ4fFQ5cnn1iAF+YMVKhv6oDg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788076183; c=relaxed/simple;
	bh=v5KDJGioMDUQEbfn+Zfwn81YGi7/DYHdybbGniOixqk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GaVrlHC7743cd4iy8seeMJeOIHj80Pe5n99C7yUIaIIxlh6LIQ8AyJHkQlNX4F5v45l+fPAoCGxqhUGkPL9t9v/DwGK1jdcjns2lc6vw7PGYsVKvBSJJ0vd1dbZXGnbOktuq47sl6KYiD+IL/WExtko1YQqT7PVkJuA/CYAsj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNe9x6Un; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNe9x6Un"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A190A1F000E9;
	Sun, 30 Aug 2026 07:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788076182;
	bh=Kmf7UNuR3TJfz0wmHchwj7E8FCZ4Ng6XB4qrntzPsXg=;
	h=From:Subject:Date:To:Cc;
	b=eNe9x6UnAK5IeFqG2g12NDUx45i6Sa7NrF/9OqdSg+uGiEVFvzk5LFJM1blh/UbMy
	 BZdDLd/DVd8TX6VxnkN9vZ8z4Y0G81c3wDyXh6pV3V/c/msuMtzKI1ivKcA4LbE3GJ
	 SMADYzhe0EHnAp8QVn9iHnc4HAwNqZp0DizycG89nBIv7RLinZsDF8J5uANqqAdMd5
	 +2quL2ySSSXwdofmmFlhwgLBxah6rWfg7/YTIT0DhFiGrsE+iIVRR1rSgfZmODmmmW
	 bYJFZfVqhJVUepBerrCFkXFvHkrqPe7aFeEXQg2zv7dE5mUBz907gwL1aKOKkqXg2T
	 KV2IanmTnRHOw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/3] tty: replace page allocator calls with k[mz]alloc()
Date: Sun, 30 Aug 2026 10:49:36 +0300
Message-Id: <20260830-tty-v1-0-0cbe6170649b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6DIBAE0F8xey4NRavUX2k8AF3r9kAbFhsN8
 d8FPb7JzCRgDIQMfZUg4J+Yvj7jdqnATca/UdArG5RUrdTqIWJchW5Gebddo1tlIDd/AUdajpf
 ncJpn+0EXy7Q0rGEUNhjvphId7K41bNsOOOCfDYIAAAA=
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
Mike Rapoport (Microsoft) (3):
      tty: port: replace get_zeroed_page() with kzalloc()
      serial: core: replace get_zeroed_page() with kzalloc()
      tty: hvcs: replace __get_free_page() with kmalloc()

 drivers/tty/hvc/hvcs.c           |  6 +++---
 drivers/tty/serial/serial_core.c | 16 ++++++++--------
 drivers/tty/tty_port.c           |  8 ++++----
 3 files changed, 15 insertions(+), 15 deletions(-)
---
base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
change-id: 20260829-tty-84f05b74862a

--
Sincerely yours,
Mike.

