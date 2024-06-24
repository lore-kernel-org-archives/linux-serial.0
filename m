Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6D8143744;
	Mon, 24 Jun 2024 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235901; cv=none; b=Lp8vt7p/+aVyAsHT1A9QdTrFAzEL4zDWhQsQMLkY8YKglpv1zkXWYt8XiiawLPf3ueZDVv4o4F9D4+O5hf/zNhMWht6RYYKt1aih/EV40AkHORaUTMQDIHtUFfuKILVXqfXbzDhwHGTzXQhTcvkAXNwFu/jJ9LZ6WUYawXG1y7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235901; c=relaxed/simple;
	bh=+hgftWIbBlBvZAXUD3E1PCs1OVr32meclo/Zqr2LEZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKnZr7oEhhDtfFq9QmApa+1f4yFqvOExFb3vUEH2amai1u7LYjAh2Rvqu02vpnsouaT42X7WsU3E4RGrWsHROswTsqlSy3QNp56KeiApnwZOP29rJT1ypHqZSlBCN9Jdk+UnsYG2+xNrTr5mZPZpP5dxv2JdD6t/WuxssMLk8uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9PNzTHC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9PNzTHC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1717EC32782;
	Mon, 24 Jun 2024 13:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719235901;
	bh=+hgftWIbBlBvZAXUD3E1PCs1OVr32meclo/Zqr2LEZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9PNzTHCzP5GAFoFXLzXgc38xUR/SwrOKYlQ1ZRTT1wT0pxqnjlXbA5sLd8W773x3
	 9C2rV4pIBGYFe1Ep4VseYcHNNukG5txaQYvNS4Frr7MvX0o7uGWlNjy3XzxEJLGe5h
	 VFQqZJZe4hJxYmobYtuTd1X1nT9UycaGsrc28O/sTPPWEQWzVHOfmk5oYFpdG521Ck
	 NnGk7JBuRU2FVhwhIU1sAb1XkaJEt8pyagKpGH00a1pp9PefonEnGJskSw3jIX5E+s
	 hAmzXij1JhnlP2AYYg/15i+7D9JlpqBR0S8fP1KI3g+45vR272WcQGyKPmW41uqTU+
	 S3L2Dp28Ja6Qw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sLjnO-000000001wU-40Pa;
	Mon, 24 Jun 2024 15:31:46 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/3] serial: qcom-geni: fix hard lockup on buffer flush
Date: Mon, 24 Jun 2024 15:31:33 +0200
Message-ID: <20240624133135.7445-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240624133135.7445-1-johan+linaro@kernel.org>
References: <20240624133135.7445-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Qualcomm GENI serial driver does not handle buffer flushing and used
to print garbage characters when the circular buffer was cleared. Since
commit 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo") this
instead results in a lockup due to qcom_geni_serial_send_chunk_fifo()
spinning indefinitely in the interrupt handler.

This is easily triggered by interrupting a command such as dmesg in a
serial console but can also happen when stopping a serial getty on
reboot.

Fix the immediate issue by printing NUL characters until the current TX
command has been completed.

Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
Reported-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 2bd25afe0d92..1d5d6045879a 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -862,7 +862,7 @@ static void qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
 		memset(buf, 0, sizeof(buf));
 		tx_bytes = min(remaining, BYTES_PER_FIFO_WORD);
 
-		tx_bytes = uart_fifo_out(uport, buf, tx_bytes);
+		uart_fifo_out(uport, buf, tx_bytes);
 
 		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
 
-- 
2.44.1

