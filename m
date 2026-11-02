Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793599349;
	b=yR/ql/NPICpFHAk53qpl2Ccfl0v5wFj1gcQ1QbLhQoE28fdg/XIWJQ93qoemvYJBJ8q3
	 Ca8MOd60mpJYaz2LfZq1xy/rgRb5FxN05T7rznQLxYFefGhyEmbCi3G6k5o5luUgFwBuY
	 JMUyQKsQFA+UuGMNVc7OC9aCw4FM+5SKYywUJUwarOHl7nRxMB4DEs/C/lqyeAS40/W+x
	 xJB9OXF3rWO6PE0LRwyJTZfF3tWyj65nBh9T44IP7linFCvAwobrONS9ST89mz+v4+Ht0
	 oK8L/OytqdTjxXh0dSxQJ+HUAna9TosooXRYin8RbC/SYFTLtBD9YyQk2lj5KIgnvYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793599349;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RYeg0ZcGTZBufOOnOYC/CzC0AaACWriIHjWoefd30tQ=;
	b=yjBJUdLWG1C6K6dlbmDXaRTRm1dt9ZfY1noj2Di2uHizvJJ5u8TneKpUwtV0wPMEVfRY
	 7Or2a2L3RTArTtMzn3OVP+286mGunMgLxvgxf/7ULY1y/OMs7V/9591WhADTe9eFHobvd
	 Mu5ypJBJqBnvwiVMoboYiXj5Tu/RYvpxFAxt8LVPKO1pF1XLNvxyaFLf8C36e+N0zEKsr
	 tvf9chjnUFxWvaWnhzSWVef2x9JxzJ1wLtWzLEoisv9JbouGUfnxR2x9bagexRC5ezR51
	 3MFi4yL49n5iqQjUEVPiexyOQ5TZ374moqsY9Xe9hPeylP91CKG1mY9lSnrtEiq8IrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=lAFhuhxa;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E74606A324;
	Mon,  2 Nov 2026 06:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21E74606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=lAFhuhxa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793599342; bh=RYeg0ZcGTZBufOOnOYC/CzC0AaACWriIHjWoefd30tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lAFhuhxakPo++JnydJXTUS0MKXWRLKXiNLURbQpHmiEmvcO/h6ztEShHftkJm/kCs
	 JQQiQV7PfmC6ZOcwa0ReYVHhliJkWV6sy/9nymQgpDv6lag4elCnExrmPvDbi17qGI
	 yTTbOSuKD/kRwBEukd46+sy4MMly/F5a7WEMl5js=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 942C6AF; Mon, 02 Nov 2026 14:02:20 +0800
X-QQ-mid: xmsmtpt1793599340td8gs8q0d
Message-ID: <tencent_2A5F482BB0F8C8773425E14A8B3D4C70BA0A@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoehrNTBV4XsphP+DqFvEIB8+ApIkXkPnQo3tibbq1V8CHwkbUaf+
	 hZVKN83bHkc6da7VGD6vDrL7+9zAD845JUMiBgCuySIKI6z1ZEDKhMXgJENYvgzfKcQQJ93pafVA
	 VY8sRbYFJV2e/d736cZyrqIJLgFhRjWl8VNO0oYFGSFcAuPesQJ8CfewN5d0wpJnBBExSjdlQW/g
	 wKBFHasPXsERdegmZOBHx4KwjbS9b46kJBbIuk8S3HmloooE8b/ybgB5esG4VXJnCHYeEzk4u11x
	 48+saYe0769CK+3/8xgYiecWUHG37baj7eB9Au99TBUnyWJ3Rkz1uzLFHyk1rPpWyG1dewmfzSuQ
	 SLvDZ4RxH8WhhbO5tddeAsouxVmOV4TVypSs6fzSxNO8tbp4Qwx+dipRkh2KoLxcWo/lIo4PdPSD
	 Uz1IVtJVWULXtsxTxRvuEag/SFKq3BCSWSpT+T3XyRJsNLcmWL88qKOSRM5QEWc+uj1+ycplPiCZ
	 QOs09F/zYYZC8lui6HEj4aaANYgbRprZ8FIyGPw+k0GcZsvut/15RkhiXAIxE1OyPTWXPPgtpOrJ
	 VeubF9rdtxyiKFSl1rNNcWHT8bPdQ/FyITKwslE7dtEUecpT/PAXOKQrRsO5sLBNXEaAChnZEWvK
	 IHjwvhyfNOdyxGgUML4hXMoUwgI7AGapSzWuOqs2MTKmwYY9mx0uAqnoOB2yg0h8qPYKzemHbA2w
	 687NN2tAUcaDk4Ib/y5fKNQRrdC3BgDdHQc1vNLCPpTZba4zN6vJhPoCiFXmSRPy6psAXojwhOc+
	 4l5/zkq2ureh05LbFVgFWflq0fqYJ29Hrk4oIPQ7uenBdJ4kxaWX5SYLgsslRmrOXpH8ofISqCUb
	 UVW4XB2EqJhFdDsdDHUK3p9ChuQ8azp/WLfaQm/F/8znuPb/z88lKEd0xy+J1yMAmaKUz81KPFBF
	 77IyFTfELkHRM/TyxyYnBWjrnN0Ir0dpy8B8Y2vq1TH3E3FGnCPkuykL7jCrD5HSchiCCp7/+nsH
	 +tWp8jiFEGCLJYgk5KfVhCbILMOc/Rocts0B4HGoBjJt92L5Am9thE4k5b1yxF6JioQ5wHYA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Shuai Liu <847807867@qq.com>
To: Kwanghoon Son <asdfkwang@gmail.com>
Cc: Shuai Liu <847807867@qq.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 06/12] rust: serial: Add minimal serial-core polling console support
Date: Mon,  2 Nov 2026 14:02:20 +0800
X-OQ-MSGID: <20261102060220.6221-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <auSGbrP19XfI3S5N@debian>
References: <20261029-rust-bl808-console-v1-6-b736ee920078@gmail.com> <tencent_12B82162741365EE49D2A22CCDF2A04D6908@qq.com> <auSGbrP19XfI3S5N@debian>
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

On Fri, Oct 30, 2026 at 07:58:38AM -0400, Kwanghoon Son <asdfkwang@gmail.com> wrote:
> I don't understand for now, COMMON_CLK not possible on x86?
> or you mean CI not supported?

You are right to question this -- my comment was incorrect, sorry for
the confusion.

COMMON_CLK is not restricted away on x86. It only depends on
!HAVE_LEGACY_CLK, which x86 does not select, and several x86 platform
options (e.g. X86_INTEL_LPSS, X86_AMD_PLATFORM_DEVICE) select it
themselves. I verified that "make ARCH=x86 allmodconfig" results in
CONFIG_OF=y and CONFIG_COMMON_CLK=y, so with Rust enabled, as in the
Rust CI, all of the dependencies of SERIAL_BFLB_RUST (RUST, OF,
COMMON_CLK, HAS_IOMEM) are satisfiable on x86 and the driver is
eligible for build coverage from allmodconfig there.

To back this up, I also build-tested the series on x86 (LLVM=1,
allmodconfig-based configuration with Rust enabled): the serial-core
abstractions, the C helper glue and SERIAL_BFLB_RUST all compile
cleanly, and a full x86-64 vmlinux links with the driver built in.

What happened is that I conflated COMMON_CLK with arch-scoped
dependencies I had been looking at in other drivers (e.g. RISCV- or
OF-scoped Kconfig entries) and stated it without verifying it first.
It also means my suggestion of "depends on RISCV || COMPILE_TEST" in
that mail was unnecessary; the Kconfig as it stands is fine.

Thanks for catching this and for the question.

Best regards,
Shuai Liu

