Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B833D171E41
	for <linux-serial@vger.kernel.org>; Tue, 25 Jun 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332753; cv=none; b=FTLMtzN2VCENTVa6+JsnLHqvpdm5AkzyXVBjngncFhiZS0Jspn576zHujvsl/EpDadsGJ4Q5DZxh57pvr3gd5e7ldWDumtGnVD9kAmIdll67WeT2tZfxB1ztNW43Z7uzlH527ku9USjF35F+oUuQXdH5H4hvPeAVgr2kSOPOYRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332753; c=relaxed/simple;
	bh=B2YDtkHg6fs4L+dcYvgZ3sVe0CW9/lPIvU9kwWcZ9V0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YHSMv4q0BYr4J1lgNEm5RxWW6e21sQDnM2PobSHxlDV0y0HReY+SwiVRm6lUVs1VVJAi7EnhIZHjq4VD2sSG0b7pBSRR08vltkD6l4u9daj6FK0DCwjmJlQWYzt3WXgCOvfEBmuOpyjNxEj+itplYD3vpMzVyB8UYTXqSHpkLqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BehKRk/4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BehKRk/4"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70677422857so1790110b3a.2
        for <linux-serial@vger.kernel.org>; Tue, 25 Jun 2024 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719332750; x=1719937550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V5Tt7Lc2+N1dSi7KU9Dntd7EOp1nzs8phsS0Ld5X6so=;
        b=BehKRk/4Fg9+4rrmw24bAdsawNF6eS9ayOo0Rt8dBrauNCgXgqFdAkg3avorEC7mrc
         2e9dRSltimTOxUTIpSd/BLg6FfbinxbMjlnAipEqjmJELB5zfOrnqm76rwcGtuQWUveu
         NMCUxp3w2z1pb/uDNwTEu8kDR96aJw3I0SrNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719332750; x=1719937550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5Tt7Lc2+N1dSi7KU9Dntd7EOp1nzs8phsS0Ld5X6so=;
        b=b2J8FwMWWIO2bgyDHJsEcNJXe6TURthJyS1HRtwy+/Z8u0JseopaWaoMNfj+5kFk+4
         QYegFt7eU4qRfVHucgMvVlwBeVXiBrsaQzCXvrA7wVdL+OE7z7LtzJW2t3R5Y4wG+4j4
         0n2rD8GRBzhNx+vke7oNLw400MIxxZeWd47OwGe7UMZQAuGx72/zUA8AucoN8m2ASFXG
         rjS3d7T/CR5xZtgd2tIKCUzV9PHgx2LNkvFVORYJKjuKg0gPmDmQFXuUSQraGD+qkpVr
         hEXG7vj4A/OR30XP6Z8XirA28C9POYFqGNoEeZK4tfuWKBxnXHkgKuZdRyOriZ1TCdcj
         bk6w==
X-Forwarded-Encrypted: i=1; AJvYcCXjoE2meEnokwMDAGtrnvpXKw7chV9AI9TVgFXmTJ6BVXAGq2/hGN0JYV0zl44G3/doBGPDYH4lZ4EN4SQSUCII6OgomXyxJqa3Lpb8
X-Gm-Message-State: AOJu0Yyu7eRQks+ay8werq7BXA+NehLwdbcExhBSEp03AjAF7hgo/bvC
	eniz0ZwbSeyaIDSFp2H92XYpO+GoHbVrlzmYVocedeIf4czDa29u9xbZHTv1/g==
X-Google-Smtp-Source: AGHT+IEhsjk6aekAxj8P+vBahLkJqDcR0bi6Msxsp/13kv2NwnQagIIUi6/qZFjte+RAGbc4YnBoNg==
X-Received: by 2002:aa7:8611:0:b0:706:375e:220d with SMTP id d2e1a72fcca58-706746fa56cmr7358170b3a.30.1719332749891;
        Tue, 25 Jun 2024 09:25:49 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3491:3ec9:c533:e23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7068a63c8bfsm3535919b3a.27.2024.06.25.09.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:25:49 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-serial@vger.kernel.org,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH] serial: qcom-geni: Avoid hard lockup if bytes are dropped
Date: Tue, 25 Jun 2024 09:24:44 -0700
Message-ID: <20240625092440.1.Icf914852be911b95aefa9d798b6f1cd1a180f985@changeid>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If you start sending a large chunk of text over the UART (like `cat
/var/log/messages`) and then hit Ctrl-C to stop it then, as of commit
1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo"), you'll
get a hard lockup. Specifically, the driver ends up looping in
qcom_geni_serial_send_chunk_fifo(). uart_fifo_out() will return 0
bytes were transferred and the loop will never make progress.

Avoid the hard lockup by making sure we never kick off a transfer that
is larger than we can queue up immediately.

The issue stems from the fact that the geni serial driver tried to be
more efficient by kicking off large transfers. It tried to do this
because the design of geni means that whenever we get to the end of a
transfer there is a period of time where the line goes idle while we
wait for an interrupt to start a new transfer.

The geni serial driver kicked off large transfers by peeking into the
Linux software FIFO and kicking off a transfer based on the number of
bytes there. While that worked (mostly), there was an unhandled corner
case when the Linux software FIFO shrank, as happens when you kill a
process that had queued up lots of data to send.

Prior to the recent kfifo change, the geni driver would keep sending
data that had been "removed" from the Linux software FIFO. While
definitely wrong, this didn't feel too terrible. In the above instance
of hitting Ctrl-C while catting a large file you'd see the file keep
spewing out to the console for a few hundred milliseconds after the
process died. As mentioned above, after the kfifo change we get a hard
lockup.

Digging into the geni serial driver shows a whole pile of issues and
those should be fixed. One patch series attempting to fix the issue
has had positive testing/reviews [1] but it's a fairly large change.
While debating / researching the right long term solution, this small
patch at least prevents the hard lockup.

NOTE: this change does have performance impacts. On my sc7180-trogdor
device I measured something like a 2% slowdown. Others has seen
something more like a 20-25% slowdown [2]. However, correctness trumps
performance so landing this makes sense while better solutions are
devised.

[1] https://lore.kernel.org/r/20240610222515.3023730-1-dianders@chromium.org
[2] https://lore.kernel.org/r/ZnraAlR9QeYhd628@hovoldconsulting.com

Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
As discussed with Johan [3], this probably makes sense to land as a
stopgap while we come to agreement on how to solve the larger issues.

NOTE: I'll be away from my work computer for the next 1.5 weeks.
Hopefully this can land in the meantime. If it needs spinning /
reworking I wouldn't object to someone else taking it on.

I've removed all "Tested-by" tags here since the code is pretty
different and it only solves a subset of the issues of the larger
series.

[3] https://lore.kernel.org/r/ZnraAlR9QeYhd628@hovoldconsulting.com

 drivers/tty/serial/qcom_geni_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 2bd25afe0d92..fc202233a3ee 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -904,8 +904,8 @@ static void qcom_geni_serial_handle_tx_fifo(struct uart_port *uport,
 		goto out_write_wakeup;
 
 	if (!port->tx_remaining) {
-		qcom_geni_serial_setup_tx(uport, pending);
-		port->tx_remaining = pending;
+		qcom_geni_serial_setup_tx(uport, chunk);
+		port->tx_remaining = chunk;
 
 		irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 		if (!(irq_en & M_TX_FIFO_WATERMARK_EN))
-- 
2.45.2.741.gdbec12cfda-goog

