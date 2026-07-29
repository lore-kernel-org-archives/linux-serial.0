Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E6D63CB;
	Wed, 29 Jul 2026 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346900; cv=none; b=qDkCCrlBMrPt1P0DQC3vJnxFD4FE8/pJnHcvoY0a60gkrrB3lFhewG5gO42/T55TejkesLaZLOocGp0e/dRXp3fGoplOiDc5sTLc6+u7w9zI8j/aHycPuMSCurbUrzVJW6HpN3B0ZOwQhXFwyu/SySkW1ANPUdm9Q9gObXPQtrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346900; c=relaxed/simple;
	bh=2gBApwpdXHZDv5iILGOpTOR4LXQ67JCvw5ye4Fd+EIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mfq8N0cMKFFEylhP7suMQi3gy8ap4dCGSzRBlp0ONIzVnyM1E5ZAXDTpJ18NjKEgD5WgxypsvX3sadwIRZxA/FgfORR9+e0pqYy/u9UE+xT4Gc/crIO9N73yt/HkH13TJHuefJzlirZ5Fe/p6f1hJ+0ApiWXvqy9bnwhsGe4ixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de; spf=pass smtp.mailfrom=jaseg.de; dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b=IDZO0TrS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YHjGw0e2; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaseg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b="IDZO0TrS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YHjGw0e2"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3329A1400485;
	Wed, 29 Jul 2026 13:41:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 29 Jul 2026 13:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1785346889; x=1785433289; bh=5C
	1/smUgET6TsKrn9pHhHAr435jfr9/zrBEJoOJlAMI=; b=IDZO0TrSKyTBQhmS2q
	nN1GzItrk3jdF2t2CNXrZv5M4gvmX7quiIjjAzp9IjPfA25CPoXhnZEOiHU0fZC1
	M+wP0eKewrIsL5ECCycBemRyiH1kQavqv5i2wk+903winoKW2CRcP0dB9JfqXN/p
	jKf9DrTQvu37RM0VJieypXSO18BZcHUhbwDiHtAJBseUCwrQpEAmTr85XiV05k6n
	ZzJPZpCfUmiXtbKem8y0hePhLRPjplPN8v7KImKY1v18aTnTcnKuj2g5G6zyZtAk
	dmse1pMJcexbg5wfo9b7lpQo9CBgHm4U8nfq442QIRs5xjD1cpLcSA0uwyHWEPT8
	U74Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785346889; x=1785433289; bh=5C1/smUgET6TsKrn9pHhHAr435jf
	r9/zrBEJoOJlAMI=; b=YHjGw0e254TVWrHhQ+7BKaqTVQsjgZp15vUX/j6KhOjr
	nragP/J5Gh4EVXmjfsFlTL9V9g7nwoc7J5BeUs3w9ngf3vcYB3uAhU/RVmjL53Ip
	clGv/UwaSXWGI5KEnoZdot63WJF0V49rQi5z4DTH2UQFCttrzqKbMHqR4xKOzfoE
	swRnLTyeoKh8g8YovEVOsGKS99gxQQdar6zWyBAvrz6CA25+jD8FUKm+6YYcrlkO
	IVczE6ImJ3vJj9tbZZ+Z2TUjiWiG3BFXF0OU/Cgbx9Z3Sw2tnHcJFmYu1YB2PW8o
	me5W6VuWWqq0VF80gGn3BWejq4lhrzdRI/MkB/kC0A==
X-ME-Sender: <xms:SDtqahmwC-P0-Esxv6MLp0soT4TQnfyWpV8l2kva71Kbue3qNiHUrA>
    <xme:SDtqarH2tJOnIqom9N9zyZ0b0QKnpJ84w6PCl8xtVmkesL3e3CjUCbxBLzHKe0yYb
    jfPMd5qZKBIlWUfgP2fQ8vGU732iiZbvU1tsfNzHxaVKHNb2vbO>
X-ME-Received: <xmr:SDtqag9TKlqDIw8DV1vv9xiIV3jQ5wswXko4MPfgjU2ITdVmkdLuKL3EVZaVZcftUGvjUnMRF_4fTvVT>
X-ME-Proxy-Cause: dmFkZTF3TYmFCLCNODJ3U4J5XtSQJL/TRjwwTvuXA2AX8wizCxnjvT325/2GgW/9w9t+C9
    zMIf4vlu5WnYGd3u/bfqpUY/FlmPlq/8wL7mdnqU/h29BqgC8BB9OQ9MSJxtLHHWv+LccU
    4PYzA6otDd+X6zx3B2M3/NbMQ6l0vKRMLS8Dak9sf3/cAEuCqds8F99/esZLmSI7TNHMeL
    0TD/9Q/gCoacmyq4evYp+h96FVuAA6At/x5BWjIo9jPuOJR14tkmbuzsJftBx05I5+9/EX
    rFJ8nJj6frylAVdsIT2iTDR1OXfS6j0zHq1xZMut6t6xc0+bKVKMXYNZOgcuSLH3uqH4kz
    j4oviVOX9+IhOc7Wv+mibz7oW6VRY+ltN71boXfd2uKUErTvoiNyRaxHFoAdbWpXNlW5AS
    U7TxL2zyG3RlH2Jn7WXm4S7mkoposUjUMqDJZtjyFzbUXBfEAEKnBW1uOBPEaHlL4zFc64
    kBTT0442q4mQZbZq64prTAEBCHjGJEO9jAAp44On62Di0WOmd7GnwlJEfw5TN/ErzpTNtT
    Oy1JJXHWWdJQnti3a+EsB9q0qJw/fwkmuF3Rr3cc2/YcR4uSkwjOa9/uvGvV0OMbP84sfa
    drVAC8PCdj+IqfjQt9R0jD4GHes6TZz/wgHTqpLPoZ5clkrmDoRACg8+V68g
X-ME-Proxy: <xmx:SDtqakmqXfWG4N7TOTxGAI3rrk4ajSZ1GiF3zUl9Qd34HEjwu-XW7Q>
    <xmx:SDtqajAy9rjK0bWlb-K6IapX_5_SKJRrzZWWkFhIFVuIX3w8UDyE6w>
    <xmx:SDtqalXpW5OJPMHe0SKILfg-GxYgL9YGhbAukLGd99d3xaPQOVZxTg>
    <xmx:SDtqap_wceoVDcq4BVKG0f-NqcCvUXxpbWITIup0HtG8sE0pyw2NoQ>
    <xmx:STtqajj4FCwHr66dozMO8XHFJdOuW7RR_LED8X_bSveZhhbeVBiUdTOQ>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 13:41:27 -0400 (EDT)
From: jaseg <git@jaseg.de>
To: 'Greg Kroah-Hartman ' <gregkh@linuxfoundation.org>,
	'Jiri Slaby ' <jirislaby@kernel.org>,
	'Bartosz Golaszewski ' <bartosz.golaszewski@oss.qualcomm.com>
Cc: 'Praveen Talari ' <praveen.talari@oss.qualcomm.com>,
	'Viken Dadhaniya ' <viken.dadhaniya@oss.qualcomm.com>,
	'Zong Jiang ' <quic_zongjian@quicinc.com>,
	'Krzysztof Kozlowski ' <krzk@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	=?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>
Subject: [PATCH 0/1] serial: qcom-geni: fix TX DMA buffer flush
Date: Wed, 29 Jul 2026 19:41:04 +0200
Message-ID: <20260729174105.21838-1-git@jaseg.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jan Sebastian Götte <linux@jaseg.de>

I ran into a weird issue using the UART on an Arduino Uno Q (Qualcomm
QRB2210) target. When doing a write immediately followed by a transmit
flush, the UART would get stuck infinitely repeating a stale DMA buffer
and become unresponsive to further write() calls.

With some assistance from an LLM, I tracked down the issue to the geni
serial driver's DMA mode code. There are at least two issues in the code
that contribute to this behavior:

(1) In DMA mode, uart_ops.flush_buffer is missing, leading to an
underflow in handle_tx_dma, which leads to an infinite loop of
page-sized buffers being sent out.

(2) In DMA mode, uart_ops.stop_tx was fishy, and unmapped the DMA buffer
without actually stopping the peripheral's DMA engine which led to a
stuck state where the UART wouldn't transmit any more bytes.

Qualcomm refused to give me access to their documentation, so I'm left
guessing and vibe checking LLM output on some of this, but I've
confirmed looking at hardware with an oscilloscope that both the fixes
in stop_tx, and the new flush_buffer are necessary to solve the issue.

What's left is that I'm pretty sure that even with my rework, stop_tx
will still lead to buffer contents being re-transmitted after restarting
when it's called during an ongoing DMA transfer. AFAICT there never was
anything here that would keep track of partial transfers, so I think I
didn't make things worse. I don't have a nice way to debug this, and I
don't know what the original intention of whoever wrote that code was,
so I'm leaving that for maybe someone at Qualcomm to have a look at.

Below is a reproducer that when the bug is present hangs and leads to an
infinite stream of alphabet soup on the UART TX pin.

(*snip*)
#include <fcntl.h>
#include <stdio.h>
#include <termios.h>
#include <unistd.h>

int main(int argc, char **argv)
{
	char buf[4096];
	int fd, i;
	for (i = 0; i < (int)sizeof(buf); i++)
		buf[i] = 'A' + i % 26;
	fd = open(argc > 1 ? argv[1] : "/dev/ttyHS1", O_RDWR | O_NOCTTY);
	write(fd, buf, sizeof(buf));
	usleep(20000);
	tcflush(fd, TCOFLUSH);
    write(fd, "foo\r\n", 5);
    usleep(100000);
	puts("tcdrain: hangs forever when wedged");
	tcdrain(fd);
	puts("tcdrain returned: NOT wedged");
	return 0;
}
(*snip*)

Jan Sebastian Götte (1):
  serial: qcom-geni: fix TX DMA buffer flush

 drivers/tty/serial/qcom_geni_serial.c | 43 ++++++++++++++-------------
 1 file changed, 22 insertions(+), 21 deletions(-)

-- 
2.53.0

