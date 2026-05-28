Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8FD3ADB9A;
	Thu, 28 May 2026 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963869; cv=none; b=mCtAxkE6bCxWdtxe60xCrIFcPE5PYyGMiCQGpA+UDNKhk7Iflb+FoXeYlnE014IfVY1jCmBsOzizGw1DdRHsFlnjVFJGGgDxLueWzDm3S5oNq/oU0IVH/A0IA0aTvDPR1P75YLiDkDAB6E5kbBDO7/5pZ3IMaY+2lgnjPW0eMRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963869; c=relaxed/simple;
	bh=aGQ/VA+ZIchjc00PGmctorPs80OgTmwWDy/YPjhTt0c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g5awt9myAyvpzU5TVAblWMbKNs09bLpRTh5f4kSTGK9i9wuji2jqUVxD+4hD0MuTmJ/MsWRFmQ08ZjYLuYGWVlu6YwR9f0H1NNA9Vf6Sgds02R83kyZNZzavBfizUHCRNibiN8VPT7XXXQScszoSmCExQrVRV13K9NbO182M62E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDt7TvPp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDt7TvPp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD3B1F000E9;
	Thu, 28 May 2026 10:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779963867;
	bh=slIwflm/+XwBSB+Sc00rEqpqi43gBVcoe+YhIqLQhvU=;
	h=From:Subject:Date:To:Cc;
	b=bDt7TvPpY+qDGLo9EVpQWjBAPY0sn4yUYXH+UbHw0hPA1fQcBVcKVCwzoljW1C3e5
	 nvDnjRBsUWmk9KZUgF85Eis35xdFqaZsxEoeUmSQ7MGVvh8/0OkVkyViVcpNvIPc+F
	 v4ZX/sys+O3MFtL0E1q5wcgrEyFLsNUIKIWaoYzfjSJavj7ny8wqzEW+rjQSF3zmbN
	 v1QbmGF2vx4qvwdlBf2qf+aePAP61hh4Q+bQw1P3b510pxYvz4rom/nK/DuTPMi5uJ
	 K1r1z2OgYW0+3MWW2yJc0SBwNb7474dDZDPvk7yr6xwu+sJtTE0r5D+a+z+/MdOY7O
	 XfGRNlY7nRQmA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/4] tty: replace __get_free_pages() with kmalloc()
Date: Thu, 28 May 2026 13:24:16 +0300
Message-Id: <20260528-b4-tty-v1-0-9da9f7aec5f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANAXGGoC/yWMSw7CMAwFr1J5jaWklPK5CmKRj0PNIiA7rUBV7
 04Cy3maeSsoCZPCpVtBaGHlZ65gdx2EyeU7IcfK0Jt+NIf+hH7AUj54DCOdTRpstHuo8kso8ft
 3dL39WWf/oFBa3QzvlNCLy2FqUxReSBT9nBIJbNsXIfJF6osAAAA=
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

