Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794467310;
	b=fTasrUoUtDus6hftAfrMzTHtuPLZqVMQblAO0Og8CUc/V9a4t4VJYWwKR1cN3r2Lz3vg
	 w1xh021ItuM43XWQ/56w4n12WKRK33wYBdX/3AIx87WPDqqqhJUaw+oe0YvKfBVTjxi1N
	 B6hweK8epSZlE7WO8DLYBXd1BEzF/DqeW9Xo43u4m2g9H6fxIV0/3ftCvWn15zKJ7OzgL
	 8Wfmf+hlzyhiL7Pg3alqDewcKoCkWc2CBKkMdOQzKhxBfPGyRhiz+ixMML95UBekF8JSO
	 MskjXbZ446+rzaen7hz0R36Qc2Flhf1SJPROzgg72P0L4E0KRmT0SVrgkLQvsGWMfZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467310;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7hoDHAclas2s7Cj2vs8nwdI3qFg9ru7EadW68gJifyo=;
	b=pIH+AAWYY8aYEEjs6z7aHqOr8aYilVilQp+6hyGoyU1gg8k1acYyj+PUGMapGwxvVYo0
	 T1Pzt7+6XX0roiR+XIotLzkvp6CtVWmAx8er4SKOsyufe+EJzyYec6SKJm1jVFOFlLxOm
	 TwYpFKM0bBBcTKUMPAt901nxUsQM/RKGxG1gIb87e+OJjXvdSPZwm7TsErBnwvLg886xX
	 /8aGrnQ54mzUrLtr5nLdThPZlC+F1pkT/4lZFs4+luXcpCtQVTgIxCi+MH0SM8TOnVFk8
	 RjbxzQHBH2ahkJ6a7VvPS3CV59jvsgomX6LioJh2wLKhqZqI/ilAs/+OXsknJN73nmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XFwzp3Lv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19642606A31C;
	Thu, 12 Nov 2026 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XFwzp3Lv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794467309;
	b=D5mf9ugk6N/S6vIPniI88I4GA6ZvQXV2Z9GoqQV8ZjP2uxt0Ed1fIpnA93/xweuNHCrI
	 zbzgD3jXaiFD6t84JgrMxNRVjI7WCFJuj0cyQyJoHdeIv3MHiww/vIrANCaQzhdAztOut
	 RytqSneicz8Hnhgt3pc9Bb3yWOUDC+fv22pjXSrOMCtBB/47d561SNUZNGK1Wn24OTDYm
	 lhQsXABq/GmMcGpYWTJgL4R0nEAiZpl+11OcRkrrTKznbpKjqUp/jdZeJPeoOUEnVIQFN
	 ZY5y9wlpx68fr1cE6xqno6vG5X4ttFVcdzaP9i0qWmb0ZBl10Dd98fybxp0bGEmaPaQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794467309;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7hoDHAclas2s7Cj2vs8nwdI3qFg9ru7EadW68gJifyo=;
	b=k0brYy46UuBG+eYvYSEW2sGXOozYovNsw7zRupsqNC67FiFnBvNMQWdv6Gf3RdoXr4PG
	 UWdzScHadoquDNegoVKki/E1aWpEu2HV9Kd501Od6GUxEXay9zfIOmYR//WV5cZqRg0pP
	 Xh456cexRBESh2CA8zqF7q+8xSfYwq+2obsdIAiZYBAus2yIJ6Hz+nsokTOdXpAnfwhWY
	 GPEZHJcdGQ2LVTpW5R3ePqTdh/PjjGSP4fRjMKTmSCnGO6RdCvql5+iNeq0kOX7A1e/1H
	 c3azPAs4USdyTlXGYKt/hh+KlvAudNhkgsbtXtJ0T9CXstv+V/avV7rj6jDVs7xiuJA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 213031F00A05;
	Thu, 12 Nov 2026 07:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794467309;
	bh=7hoDHAclas2s7Cj2vs8nwdI3qFg9ru7EadW68gJifyo=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=XFwzp3Lv93ahTTd4PoZ5+BeFsd/yNs9DdPabq5jLaTuzgv/VDrvpOW8A8J2mgSRSQ
	 iCe1bSYX1ftdKUAtsS7aCI/1hEWO7cUTzHWwUP7EIVezpjdaROUDzHf2HP3OoDw2MW
	 qAKYZbBlXQO96sqtDnTpPOBdXL1h0v/PH4frUbmz0xxh8CW8HpTyscKdjfVUjQVEu0
	 jHbhKlLoPGqwZsFd0uAbpx++B7t0BMxbDkG1Lb4i9tFAG9Vy86o5IefsK9N/l/w1j9
	 Cl00fpy8PgzHnsaNfzr8KhEWMq1tpbOGDQLtS4h2N+gKmzv20rq/8XRWRYYi+EJd+b
	 ZUILZowFI3nAA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7691649318;
	Thu, 12 Nov 2026 07:08:28 +0000 (UTC)
From: Weidong Wang via B4 Relay <devnull+weidongw.illinois.edu@kernel.org>
Date: Thu, 12 Nov 2026 01:07:06 -0600
Subject: [PATCH] serial: 8250_pci: don't re-enable an enabled device on
 resume
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-c3-n108-v1-1-d48f8da5894e@illinois.edu>
X-B4-Tracking: v=1; b=H4sIAJll9WoC/yXMQQqAIBCF4avErBOcESK6SrQoHWtaWGhFEN09q
 +UH/3sXJI7CCZrigsiHJFlCBpYF2KkPIytx2UCaKkQkZY0KqGvl9KANeSZ0HnK9RvZyfk9t9zv
 tw8x2e+dw3w/SS9AMawAAAA==
X-Change-ID: 20261112-c3-n108-d0b032fe21df
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zijie Zhao <zijie4@illinois.edu>, Weidong Wang <weidongw@illinois.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794467308; l=2915;
 i=weidongw@illinois.edu; s=20261108; h=from:subject:message-id;
 bh=0/xY/OhzLDNgjLSJD2wXj/hY/A/IDIPAMgsYLiXYrAs=;
 b=nx1qBuKW7AP8OO6fTYRGSCF1fL0L0NWzb0cDILi7zFqEvGZCjKuNWjkvGhHZ2yt55OuQM4LOB
 ySXnlKw6j0CAP4XIWCdIgYTyd1EV+gysYCfdX2ZPVqk6QWapm/lTs3O
X-Developer-Key: i=weidongw@illinois.edu; a=ed25519;
 pk=DR2S1xPEa5sELrWPfOpvUphJQ2VHC+MDc/wJavE/ifg=
X-Endpoint-Received: by B4 Relay for weidongw@illinois.edu/20261108 with
 auth_id=1449
X-Original-From: Weidong Wang <weidongw@illinois.edu>
Reply-To: weidongw@illinois.edu
Content-Transfer-Encoding: 7bit

From: Weidong Wang <weidongw@illinois.edu>

pciserial_resume_one() calls pci_enable_device() on every resume. Probe
already enabled the device with pcim_enable_device() and suspend does
not disable it, so each suspend/resume cycle adds one to enable_cnt
that nothing drops. After N cycles, unbinding the driver leaves
enable_cnt at N and the device enabled.

Only re-enable the device when it is actually disabled.

Found by an AI code review agent (an LLM-based bug-finding tool
developed by Zijie Zhao and the submitter) and confirmed on an
unmodified kernel, without error injection, on x86_64 under QEMU with
the "pci-serial" device (1b36:0002), which 8250_pci drives: after five
s2idle cycles with pm_test=devices, /sys/bus/pci/devices/.../enable
read 6, and 5 after unbinding the driver; without the suspend
cycles it read 1, and 0 after unbinding.

With this patch it stays at 1 across the cycles and drops to 0 on
unbind.

The reproducer, fix and changelog were drafted with AI assistance
(Claude), then reviewed and tested by the submitter.

Cc: Zijie Zhao <zijie4@illinois.edu>
Signed-off-by: Weidong Wang <weidongw@illinois.edu>
---
Tested on v7.4-rc1 (05441d697f7f), x86_64, QEMU/KVM with -device
pci-serial (1b36:0002), pm_test=devices, five suspend-to-idle cycles
and then an unbind of the serial driver:

               5 x s2idle, then unbind         unbind only (control)
  unpatched    enable_cnt 1 -> 6, 5 after      1 -> 0
               unbind
  patched      stays 1, 0 after unbind         1 -> 0

No KASAN/UBSAN reports on the patched kernel. The code is unchanged in
mainline, linux-next (next-20261111) and tty-next.

The reproducer is available on request.
---
 drivers/tty/serial/8250/8250_pci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 1dda63be6..e9b9bcc3d 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4250,12 +4250,16 @@ static int pciserial_resume_one(struct device *dev)
 
 	if (priv) {
 		/*
-		 * The device may have been disabled.  Re-enable it.
+		 * The device may have been disabled.  Re-enable it, but only
+		 * then: probe enabled it once, and every extra enable here is
+		 * never undone.
 		 */
-		err = pci_enable_device(pdev);
-		/* FIXME: We cannot simply error out here */
-		if (err)
-			pci_err(pdev, "Unable to re-enable ports, trying to continue.\n");
+		if (!pci_is_enabled(pdev)) {
+			err = pci_enable_device(pdev);
+			/* FIXME: We cannot simply error out here */
+			if (err)
+				pci_err(pdev, "Unable to re-enable ports, trying to continue.\n");
+		}
 		pciserial_resume_ports(priv);
 	}
 	return 0;

---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261112-c3-n108-d0b032fe21df

Best regards,
--  
Weidong Wang <weidongw@illinois.edu>


