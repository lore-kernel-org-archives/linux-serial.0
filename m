Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2A2D7DCE
	for <linux-serial@vger.kernel.org>; Mon,  4 May 2026 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882298; cv=pass; b=rOTFjmtNpMNO6d680IzBWmt4k+le34O50wOXDKY0228PwmnyK0Nj5uaiILaCGAushcw2E6h/SNLipJsF+EH+viS2KvuckFFN+qo2KNkyW/xbsJiAXxe7R+JhW+8sa9FDbHedpDlaq1jMUb5k9sGafMjGHNZqrilz5Rli2Qh/pzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882298; c=relaxed/simple;
	bh=qkjho5AtWO8Gw9/7gdWHjLup+DSXYc2B34Ax/RgmV10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efqoyeP2wQZ90a+p79+qNX8zO8gQeqHsIIUY0f4+6ui9Ms6J35Bxk0NTdE+qsPj6RveERfs5knLDtudKnTm3DJ38yY7mPoULWMoqtph35jOYPdb49CWqdUpsS1EfQfZ+SRgRMUOdZiRz2AprK88SS5Mg12bAZY+mvo9qWTKmkgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sm2pnuJg; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sm2pnuJg"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79cd8f8e261so27031037b3.3
        for <linux-serial@vger.kernel.org>; Mon, 04 May 2026 01:11:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777882296; cv=none;
        d=google.com; s=arc-20240605;
        b=g7XnqbOCMqZYFic77+FvazOilRU6eCFvZBZKhs/hN1PMAzjOxWNGCHFzQ1ic5Z6S8K
         Id1iltaTzOHRjEfRh2bQbjXEuyVvCdByPhjNV3P1Z4ESLP8MCZ4UQXOb4K9Fv/kEUmKG
         xP8tRCjOVlhE5168cgJG3oh3mIPdxHQekP7or9yIMP0c1K2iXXj0+G9viLK1qo16f1sA
         PG84qG//RFk00kqgLOgR3o5t+Csk4VEJrr5+6KpHRGCUH3/aba2qpXaEVsgxeWGkwDnn
         NQPH3Rz9tK9Rt+7q89nygAz6xpSipomXFSCLPVN6hOP/WmQtOpWIeG2edd5or19ql7kk
         37CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Pgpou4jQiTZElVcLxQgF05oTAlr5ad4m7S8+xHELYt8=;
        fh=ODbyDOM7xj0m/VaOtkpmP14j931nYfYFHOkOemYYmRA=;
        b=iJarXWB33hdnonvNMWRILfE9inoC+kYlLivxPMUvEVKhqNg2rGgsUj8ryFeVQ7x8p9
         ItMYFQ/rwn1CtwaAhgtPFxH1DWeUei4OUlHizTTlicf08tYC/j0oPexjc+SGYeeVO1JY
         SJdOnAO6Y3S4JXHQaDzngkLw49sxpu6uwhCaG3cE36ACwFrE8LFgXe1Ij6wzbFrDebTY
         5x40bNwLxD98Mtx85QvJ74NV5aSQpLpTonhQfkA9BmWtH7joUNylVuVR0d6BsolLm5le
         RrKnO1fQY7PbjbPlWReTTl8GEw8aAzVmL5MzASMelU13aAd0ayVGfaPW/Spbzgmz3q+X
         qzKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777882296; x=1778487096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pgpou4jQiTZElVcLxQgF05oTAlr5ad4m7S8+xHELYt8=;
        b=sm2pnuJgJa4F8+5WLf2xHYHIigwjfyvZIuZJqNDPiWFUS9HkgibOgqS/O9fzYQNs1k
         Rt2E9HEeTc4Pb8a1tfJn2iZEr3wesH1nn4f05kfcGKA1vRS/NgUNAlhFOaSJ6vMEhcBn
         Slj9b3DidLAUafdyKHHmXsE3dng2FwRnS7DP+4xrig5TKq7jnfCb++QUlUayUjlbij0x
         4b3cY3JrqZwtWDks7vDZ4XbLyipTk2eE9aHEu2HebkCjUiMF0qjP6hHi/RDgtSaVZf1K
         UQtL9ZmIMI71OxgHa+MK6FyHg2W35UZR7LpsGIYqNPvC9KiUQqPxy0h3lQhP52LMCrfH
         8VFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882296; x=1778487096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pgpou4jQiTZElVcLxQgF05oTAlr5ad4m7S8+xHELYt8=;
        b=O2VHJIY0e7XFCWCxwpgd9DWBO4LDfa6GX0RNYslWuOvWNs9MfqWbjg/erKbjG63HHh
         wbuaM0j1htUOFWYAkLWjjn+NuFmD8DbuAxTADa5fxkOeUTIX+ZWpex4/9QjBllOYjtpr
         PJGvWvEmMUWCrg0U22MS6+sHhwoveWJrOEmHoj/t8Jgr84hVtH0/8V2mNXAVe+bJuF3q
         J6pBgwpQawOp6aA4YVdqmup2Wqd2FFNMpxiP2RMomSG5fbuGPrCxjv6FtjM902MxWAMT
         h6e2bf4C83vHU/sigz9EXkMsnrS6tQ0Mzt3KuoCvDoXS9puJ9aaqlJRrfZ6NwyERfDtq
         XbfA==
X-Forwarded-Encrypted: i=1; AFNElJ+8I1C+Kn3Pexmhqn/kORNG9Ha1w7WcEmEEoxd+4B6qhfbRHms1bMHJy5sdcMLTUR+mvH1d6f28RCPFfxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gWYZ8kKWMWtJiH60djxusP9ZSLMpmYGhK+N5PrzkUP2w1hxP
	3Q9UvroqXUPpySCNcPGEavasEoko2xXDv8LOmxUJrBp/LkoMPULS8blSAWraoUG+Yh8Z9/t+MIl
	v68bHVe1QN66iNudqvqAiGm4UVh4kOlc=
X-Gm-Gg: AeBDieuZnvktG1UE1+o6FNboI6ZfCjgpiWRY0vqlu7V/wS/lp57fwEmwamJdF2DDXY2
	7jREb9G0LdXzxG9TDtdEzhRHXtkdIosvCZQd+lgtpWBBp6UVwBWToWLPBAgjFOXVN9zsUSjmcMw
	g/4wsQUKcVCNqZcTdcgVhd3hyra6Bn2JRGmf2KNdfTxoV4B+9jUWUHfCrAiN+TFoQQQ+T8VlpiP
	4O3N1RKCqJIaZzEZnc+0c233R5eSy5QaJGdkIwTby11FVLD6B7Hwl1ohHf8Ycl09EhGDIbPzDPt
	Ily0b4BAJLmxhg0g1wc=
X-Received: by 2002:a05:690c:10d:b0:797:a27b:864c with SMTP id
 00721157ae682-7bd7713e3d1mr95926497b3.38.1777882295715; Mon, 04 May 2026
 01:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504072321.928921-1-zzzccc427@gmail.com> <2026050451-tree-trustful-a841@gregkh>
 <CAFRLqsVMYRESR4dhpcsxXF17FvaX5obXyT0ZXZMkHymnw-6K6Q@mail.gmail.com> <2026050455-secret-monetary-bb37@gregkh>
In-Reply-To: <2026050455-secret-monetary-bb37@gregkh>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 4 May 2026 16:11:23 +0800
X-Gm-Features: AVHnY4LjXl1JLE8p_S7Rl8jzuX71GzhhQuaOs8s_EpuDKP9vjlNYy0O5BosDV7U
Message-ID: <CAFRLqsUbpHfyax69zsUGL_BzQmed=0HD80mzoQVSeW+LpgQ6xQ@mail.gmail.com>
Subject: Re: [PATCH] tty: n_tty: order lockless input availability checks
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, peter@hurleysoftware.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"

Dear Greg KH

Thanks for taking a look.

> Cool, where are those reports?

Sorry, I should have been clearer.

These are local data-race reports from my pty/tty fuzzing run.
They were produced on v6.17-rc5:

  76eeb9b8de98 ("Linux 6.17-rc5")

The stack line numbers below are from that tested tree.  I also checked
current v7.0.3, and the same relevant plain lockless accesses are still
present there, although some surrounding line numbers have moved.

Report 1:

  ============ DATARACE ============

  Function: chars_in_buffer drivers/tty/n_tty.c:216 [inline]
  Function: n_tty_check_unthrottle+0x25c/0xbd0 drivers/tty/n_tty.c:275
  Function: tty_io_nonblock include/linux/tty.h:323 [inline]
  Function: n_tty_wait_for_input drivers/tty/n_tty.c:2163 [inline]
  Function: n_tty_read+0xed5/0x41f0 drivers/tty/n_tty.c:2264
  Function: tty_read+0x532/0xf50 drivers/tty/tty_io.c:904
  Function: new_sync_read fs/read_write.c:489 [inline]
  Function: vfs_read+0x5fe/0xb70 fs/read_write.c:572
  Function: ksys_read+0xf7/0x1e0 fs/read_write.c:712

  ============OTHER_INFO============

  Function: n_tty_receive_char_canon drivers/tty/n_tty.c:1259 [inline]
  Function: n_tty_receive_char_special drivers/tty/n_tty.c:1372 [inline]
  Function: n_tty_receive_buf_common+0x2cb0/0x3410 drivers/tty/n_tty.c:1588
  Function: n_tty_receive_buf2+0x51/0x80 drivers/tty/n_tty.c:1487
  Function: tty_flip_buffer_commit drivers/tty/tty_buffer.c:515 [inline]
  Function: tty_ldisc_receive_buf+0x1e8/0x450 drivers/tty/tty_buffer.c:532
  Function: paste_selection+0x781/0xcd0

Report 2:

  ============ DATARACE ============

  Function: input_available_p drivers/tty/n_tty.c:1926 [inline]
  Function: n_tty_poll+0x623/0x16b0 drivers/tty/n_tty.c:2452
  Function: tty_poll+0x224/0x4a0 drivers/tty/tty_io.c:2199
  Function: do_select+0xce7/0x13d0 fs/select.c:536
  Function: __do_sys_pselect6+0x1d8/0x240 fs/select.c:793

  ============OTHER_INFO============

  Function: n_tty_set_termios+0x82b/0x37a0 drivers/tty/n_tty.c:1799
  Function: tty_set_termios+0x112d/0x1b80 drivers/tty/tty_ioctl.c:348
  Function: set_termios+0xc1b/0xca0 drivers/tty/tty_ioctl.c:512
  Function: n_tty_ioctl_helper+0xe5/0x8f0 drivers/tty/tty_ioctl.c:982
  Function: n_tty_ioctl+0x253/0x730 drivers/tty/n_tty.c:2509
  Function: tty_ioctl+0x1cfb/0x3070 drivers/tty/tty_io.c:2801

In current v7.0.3, the same relevant source pattern is still present at:

  - chars_in_buffer():
      drivers/tty/n_tty.c:216-218

  - input_available_p():
      drivers/tty/n_tty.c:1912-1915

  - n_tty_set_termios():
      drivers/tty/n_tty.c:1782
      drivers/tty/n_tty.c:1786
      drivers/tty/n_tty.c:1789

Thanks,
Cen
