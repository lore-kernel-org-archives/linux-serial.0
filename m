Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793326604;
	b=3jG8/Cu+tMuk0y2XUs1HpG1s1EHwO7pmOxsLM0RsfEykxNCci1xA8EsT6e5dEibFCpv2
	 IvGD/XbOF5/ICau/5tcj7GK7B+RLZRF/nWb+nFatPwccBufGiJyixaJnjl0iBZCuB+GFz
	 bgPcUvr3MEVovIiLPF6qMw9dJu+FaNsm5W2FThKCZpU0yVZgUgPZBZTLvuPr5ycVtr2cY
	 M02FVPRlV/M7XIegO/Yb1TfYrVbPASXdMLhtZf9Ur1jlrUbNmB9yIuQw9E7cee5MxM113
	 qFEXJtZKwnw79eRrmaVq+ISSYLVYCsBlf7iVDwFfnHt7uQdg6p/VaXp+Cy0feFRBP5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793326604;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0NybnSmxUimOrGaT/uhAY/1Lsyep1HNUoiXKlp/WhLI=;
	b=n/PsrOkthvZdllDaydqsOKdy1ElWyRCkEf9iacRD2sbq4tK6CFx4ZZGoOe3caJ8sSvS1
	 nleUlCQWg1QgcQLBEJTiZEKSzms7ySYWMYMlytCFjd4ijgKeGBiwukZwm0/Ypir0TL7GL
	 yaLZFoEAlKxW2qkJrmei5dxQujZS2tuH/QV/07FppGz7CJCeXUtzTUDgNTPO+y5qCAI1Y
	 m8xlYzrvlz8g0ICrbUalaZurTdy5o9+G1sOWwjtcUebZVvxRjRlrU5s+h+yhf/ftacoLW
	 mSCHkx7+YhSUHHMDhE2JypVOUBR+/fYwLFG4xzj9JF5NU43FZQUwltudeAbHKuh6X2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=nTeBGzIt;
	arc=none smtp.remote-ip=203.205.221.155
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9140C606A31A;
	Fri, 30 Oct 2026 02:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9140C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=nTeBGzIt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793326573; bh=0NybnSmxUimOrGaT/uhAY/1Lsyep1HNUoiXKlp/WhLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nTeBGzItB2SUwcTHXr9zkNZyfxF89nkWU3Ml3QBzumOKTFGIzf/rL6428Lq+7IiOk
	 kFwoqqbOihLF2pUbGOvS83LiyeFDtDlXoMXTTTShfub10ZfvJBeu25cFWgYiOEUL/3
	 p+i7qzt5KMsMcGQYfwH7+dwRmkdzuGDfIB2Fy3FY=
Received: from shuai-VMware-Virtual-Platform.. ([218.206.237.125])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 40BB1AA5; Fri, 30 Oct 2026 10:16:11 +0800
X-QQ-mid: xmsmtpt1793326571t4g2nzfk5
Message-ID: <tencent_12B82162741365EE49D2A22CCDF2A04D6908@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GrDD+nu7mOEFK7wfeneumfepYk5DRrb+ic7v0Brs7etkwBx66L0
	 aIvLWr/is1w4mmVCNFOLq811d9mlqM5SleJNsXKfIn9FVvH1pXQBrRVYH3IB6G3pcWeHI5LLcQcG
	 bZkm9MXIvq0L0IfDj0ocrJfkzx5KZqxG+durWIlSFyYlR3zJr1UQ6tVjn0lsaBytKYydbwjU/Qjt
	 WUOLJUyNq2WPsSOb4sHGLhdZ7j5LBVtAhFSKihzqzhDWcc73u4gagzBKg03aKXcE38QLaHOKj+rI
	 DtSFMpozd6IiiBRx5B5+VJv/YsxABARh8OjzrmDwGdw8XLd0xfEmkeAsFatQcxvmF3wqx8FgOExT
	 kRCuwct20XxJ0BfWCbAY2k/jQgawbatxy1lu1gLpwTgxLr5gPyj+CfkGu4utOHhvGMKJc2Rx3UIS
	 oeWZDiMwIgIb7He1dtlz6XHYblIQUBz1Bh+DXx2GrQUrY40EAT/WGc9xrFt3qbUXZDZusxU0tmrx
	 pEt269vmjsW9bg85rFgxypDyJ9xT1FSAnUhXF3JNe7VwyP/G3/b5lw0+5CUGSuEM6EHj90J0Verf
	 F4t0/GsUCwRcDmN35Yagt/sWp8rbUqp3JiDCydUch9aip1FjOLKVWuA2nUcE86QupDEj4P2S9azR
	 CIqlfzFkPhClPN95k82ILPVhUWgBA32cX04YGm3AwSynmkUjBBI6Z6wbflkb64nPSyZRpLDd1J33
	 IOjS8iZHeHjk+HmN8Vl8M4jSFg6gCd1An3JQrCiqEen6TZAnDsoKW02oYVcIYgGzbe4Whey2BS+d
	 mDysFu+ZeE+7VQ228uHY28PdsSqjGd29cFwOkC64TSB86AxwELgC7HKC4bWIKq9UMR8cfnDnC8Ed
	 weS6pJFCdukQLHVIwhsQCuX/kBsGOKZ5SNrTje2IhkvFrhUQAdVAXNqYBeyE7JC2RbdukNDTWPak
	 hwTnyhMDo3WfzjXz4vDgdTEo4mrgyQliMwtLrbkUh8xq+qswJ4cRHvAwpHJ4vqYtDk20MiYMVROe
	 c2TcBvmRb6XMm3wm+a
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Shuai Liu <847807867@qq.com>
To: Kwanghoon Son <asdfkwang@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 06/12] rust: serial: Add minimal serial-core polling console support
Date: Fri, 30 Oct 2026 10:16:11 +0800
X-OQ-MSGID: <20261030021611.3800688-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029-rust-bl808-console-v1-6-b736ee920078@gmail.com>
References: <20261029-rust-bl808-console-v1-6-b736ee920078@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kwanghoon,

I reviewed the Rust side of this series (the serial abstractions in
06/12) and did not find any soundness issues. In particular I verified:

- uart_port.lock is initialized by the serial core in
  uart_add_one_port(), so zeroing the Opaque port storage and relying
  on the core to initialize the lock is safe.

- The set_termios() adapter unconditionally taking the UART lock is
  correct: the serial core callers (uart_change_line_settings(),
  uart_set_options() and the console resume path) do not hold the port
  lock when invoking the port->set_termios() callback.

- The console callback accesses to driver->state are protected by the
  ownership chain: the port holds an Arc<Driver>, the console is
  unregistered before the serial state is freed, and removal drains
  the console readers via SRCU.

One thing to consider: SERIAL_BFLB_RUST depends on COMMON_CLK, which
cannot be enabled on x86, so neither the driver nor the abstractions
get build coverage from the Rust CI (allmodconfig on x86). Something
like "depends on RISCV || COMPILE_TEST" (with the clk dependency
handled for the COMPILE_TEST case), or splitting the abstraction
Kconfig entry from the driver entry, might make it easier to
build-test.

While reviewing I also wrote KUnit tests for the pure-logic paths that
can be exercised without hardware. The patch is attached; results with
kunit.py under QEMU on arm64:

  rust_kernel_serial: pass:8 fail:0 skip:0 total:8

and CLIPPY=1 is clean. Feel free to squash it into 06/12 or keep it on
top of the series.

Best regards,
Shuai Liu

