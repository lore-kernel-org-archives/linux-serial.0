Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A60A25C804
	for <linux-serial@vger.kernel.org>; Fri, 12 Jun 2026 05:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781242696; cv=pass; b=aRSnH5rfyx8NQ1Pdu0EbRE2/ou0W3k54puOT7mPJJ+A0SeA+QbdVE/fMtuSDfoTUfHSVJV7T4OfNKlG85a3yW23E5JJCtrZ5zHT4r0A7ep+rVIUodF7o0A1seISnUPPc45k0FAkSq35QFtkoIW2Xa5I6x6OIaSjySSSRSBGpR60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781242696; c=relaxed/simple;
	bh=4TU4sONWrdHoDPC03h+Nvl2Z+eN3Oklq8XxlxcZsyHo=;
	h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=XdQa8PFxZBWogg/0h3qwA4+zS9j0Bu83sAmR1TGJYJRjbMisma8iAytNouxLU+F0jpYC5R+8NWrIqqIxKG+fiUIWDVM07hXwuaXwVCmfQDDmn1shjFe4SZ/wiMm7WD1Ri6vrNDzxHP3mao3U0JZGQ94WezFtIHO1lgy/V6ARhoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mcqueen.au; spf=pass smtp.mailfrom=mcqueen.au; dkim=pass (1024-bit key) header.d=mcqueen.au header.i=craig@mcqueen.au header.b=HR6gBFi7; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mcqueen.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcqueen.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mcqueen.au header.i=craig@mcqueen.au header.b="HR6gBFi7"
ARC-Seal: i=1; a=rsa-sha256; t=1781242692; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J09De6zkW1Hc/tQmUpLAShrw5fnmfec155qfVSow0VnsLs3RyCXGZYSxVdneaIz/Ufpgd9cu71AtSKdPb+jNGzYsjhH8768cXK24RF/TImjWxLsKv0xMFdrIIl5ienVluoIfQ3MbisFenYHuchNBdnfMyowAo7B1jF3rJiKH760=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781242692; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=9ZGvCOB2OVVMbxTK9wSbQk9PGpwHzsW3CfTsbi4lAh4=; 
	b=hZdGCPocmqbS9gHSoINZkoBabWlY3dH95h7qPtQJT5yDt/vnR3uQHBrN1womyJHmIpBfmv9yt8ymDXDx9J4Fwq69BhA4b6EJoH2WJZq7Ce7eWDZbJ10vRD+lv+SCjgG+CB7wg4rP/iEVDuVE2IZNEUXAFFw6Przn6hj0x4wyD2w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mcqueen.au;
	spf=pass  smtp.mailfrom=craig@mcqueen.au;
	dmarc=pass header.from=<craig@mcqueen.au>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781242692;
	s=zmail; d=mcqueen.au; i=craig@mcqueen.au;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=9ZGvCOB2OVVMbxTK9wSbQk9PGpwHzsW3CfTsbi4lAh4=;
	b=HR6gBFi72CUOzpiieaTTuoXmwMRWQeDTIkn+AlQ/w5aMRaAnTkdFWv0mtfUxVsFU
	9OCXErJrJIfLYwjxbpEywv9h6tFz3n9o4CQXA+M+J+aAGYiV/FopCLPj1wMESG1H1vt
	cO/ufJYMTmBWyCus1Lsjy2ldCLL0QKv7J7SMhfmo=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1781242691029715.2769171812067; Thu, 11 Jun 2026 22:38:11 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:38:10 +1000
From: Craig McQueen <craig@mcqueen.au>
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Message-ID: <19eba567d94.1f5854744141363.4614464714670279886@mcqueen.au>
In-Reply-To: 
Subject: 8250_dw system pause due to IRQ load
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

I have a Rockchip RK3328 based embedded Linux system, using the 8250_dw driver (device tree "snps,dw-apb-uart") for serial console and other serial ports. I'm using Yocto scarthgap with kernel v6.6.123.

It is talking to a microprocessor via a serial protocol at 921600 bps. Multiple times per hour, I see the serial protocol TX pause for 100 to 4500 ms. Usually the whole Linux system pauses during this time (realtime and monotonic clocks don't tick). mpstat shows high irq load. /proc/interrupts shows the 8250_dw interrupt count is going significantly higher during this time.

I'm also seeing complete system lock-ups occur every 1 to 72 hours, with no diagnostic information shown in the kernel serial console output.

Are there any known issues with the 8250_dw interrupt handler causing high CPU load, that I should try backporting to kernel v6.6?

I've written some kernel drivers, but I have no experience debugging interrupt handler issues, especially when it's an issue that prevents the kernel doing console output. I would appreciate any advice on kernel facilities that are suitable to debug this type of bug.

-- 
Craig McQueen

