Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F664EBACC
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535185; cv=none; b=dOZSSdisew4JmFtInvPkAaPPU6ROWtAKJ2L9jK0KEz0apNiPXw64h388FJgqUM8Qq2Wh6NW/hhkXOxJz66bALESSOPR48zbDeXIT1FbRxvHSGUL00y9eDonPkhVWMiGCtERPdWQOl/iqc7cSM9uqgKxPx1Vpc/dMks7mUgEoUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535185; c=relaxed/simple;
	bh=P6usuYnYXMY+lUKUrNREdDxz5CBWnzz3JutftfeRACM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YURFMrFi9wyXVykZHkzGwpXNaEVZx9NBaG0fHAYquy6Wdn4meSTNkkgCUGNffmzuGqUoKNt4nQNhhdZBVImt3tadleyaLDsizftyUvaAcpZfhslOvgVTm8Tu5DvuKUMnFWJCqgTVy61uQfLvw3awFsv9kOei784wC0oCqomL1jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ypB/pPGL; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypB/pPGL"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4843e9c5960so1142216f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 08:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788535182; x=1789139982; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EClKw2P25D0a1RVoGnFlThEd3iOKLQoxQmhQa7uzg8Q=;
        b=ypB/pPGL8Fc+P7mV+MJnowyoI5KfmYRJgG/C4Ge60cW4Y/jdZW/DHo2u+sZmNiBZcI
         iVJr854bjdySrNaeCQ+8bhHuBRT/KU7fGJHn/gHeEyQj8/igXbT8AUIxBY3m3WMM9m6C
         I2DUYZjLmsxG0fimeyWmJVjkE2FnS3Ye0JW3o6yiOoH5OZNKr7YGR8SjbXZqjoKeYxwR
         VlISiCYPJLsUtgP2w2Ghr78KCRMxLGdrUTUPj5rr+k6LGfBEcgg0AXDuIjg6s1B6tHIx
         4Q9VJjB/TNHN/nDGInqSRzhxuoni9RPgJCAbAs14lkNweBRE1vd8fEwP//kVL/L3ZiAN
         7RCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788535182; x=1789139982;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EClKw2P25D0a1RVoGnFlThEd3iOKLQoxQmhQa7uzg8Q=;
        b=F9RljbgfHgfhDBpklNbYh5K9TvNGPpF9QH/2QE9Aqeid0zCQPQHZOPsngZxcTOvCzg
         +KC83v5ryQRBdJkffe11/4V/cQG635xKoqlBPxEkUBGiSh1nSk2EOumqKeEDyU2UQWq8
         M1vY/wWE46NY3/nhYUN4x4NLl0dZm+lxU18H1uV7p6tkJlUiRKhncnQDBcr2wCPByi8a
         gtuKhOcl2uMX0FLcwdBQOoEWg8mvo8wiLToc3yVtRMdgw9+MBMya8NgtbsoNERt7Vv0x
         cU3y/QVAhsikUvQf6S8TrbWtXh5pLh1o74TUawrtnZ40OhWxMEZ+wQdO07u2xf0fX9ZB
         d3fQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWUvXDaHibqsUZdZY0Eosp42S3oTImZlPJYY1K+rwfAJUmJNkj4N3OjtIrSLcGpEc7DwPhqMU4umhUKxo=@vger.kernel.org
X-Gm-Message-State: AFuF++kXfbK+HkTB+2WXPws1NoSbWw2V4ftwHEw6lB2z8BxPm6HZP+50
	iiul86LGM1rwfXHDnBV/kimzw8g2lE4rvnFlJolfMfVks2/sNorzXf5DQNbrA1nflXE=
X-Gm-Gg: AYBFou26Bj+e3DjJREEvWBlzJJ00nUW5g2DNOU7Tn81ckeruazcYk8J5pTUhN5ByZnR
	tu48Q6iqHDr19osoZCNvHzdvhq0Y5eDG0q6061bjLotoleWwLf4hUCh8hNoHoG0d8f+HrSi3UuF
	Hy5hz0fPhzsiLbfRk/NcCsGbu6/L1zTq/Mkj7uimyJY5SaKdft1ZQZaNPS1UwStyZwfO2DoW3FN
	H0Sg7+7zgt/9IfiveHfAlDPmDDc1m53MTxjq/WbilHMTVXPENvlpVFHKaWP7MkmYf3FqtcXZKJP
	VyN7oYohaC4HyNi0B5y0NsgeHj9LXtQkzC+IWoDxj7r1V6TCUbS2mkO0TTp3uR4xISB5GPKjxZG
	9SvhQ0nlKheYgjlYASZpvDM67fjaJazJm82CdeDb6UBVC5MddErbll6ITkizaMc1Unfbv8VIQfc
	2GxzAgStagSwgkeiDMXW2LysgNU++KHMDelTfp52MkRR+5SiC/EprcMxJoLvODKPFhIZaWU2hzS
	CjJ43Lrjs04nyzzg5qe
X-Received: by 2002:a05:6000:2584:b0:485:8c16:5efa with SMTP id ffacd0b85a97d-4858c16617emr4578538f8f.52.1788535182108;
        Fri, 04 Sep 2026 08:19:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bf3f0sm8026663f8f.33.2026.09.04.08.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:19:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 04 Sep 2026 17:19:37 +0200
Subject: [PATCH v3] tty: serial: qcom_geni: don't ida_free() the console
 port line
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v3-1-541757ec8a95@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIjhmmoC/6WOQQ6CMBBFr0K6dkxbwBRX3sO4qGXAMUhJWxqI4
 e62uHLt8mX+/PffzKMj9OxcvJnDSJ7smKA8FMw89NgjUJuYSS5PvOEVBDuRAf9SS81hnnxwqF8
 Qwgq5SQ/Q40jQ0ZIeNXQOESotmsbIumtVxVLx5DDdd+n19mU/359oQjblxIN8sG7dV0WRc38Ni
 AIEcIlCmVJovOvLQKN29mhdz/KCKP93yOxAVbaq7SrBzY9j27YPnVpDNmsBAAA=
X-Change-ID: 20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-4a199c25fd84
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2717;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=P6usuYnYXMY+lUKUrNREdDxz5CBWnzz3JutftfeRACM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqmuGKflVLqbR9bLN3qKodFe1pGUkr4HK/19hrR+SV
 QcCHJQqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaprhigAKCRB33NvayMhJ0Xl5EA
 C9tH5rgY/NKfN1CytzbbzmoycanIKnMeI1dFNqQ/P/5WdF/CoV9V3GAsTGqWGzYFEHjh01MEo2Nxic
 UIDyup7NXmp01DiIky8U9WQa/GQWU/WiXKgq6Gt8n1ULKUDTPGY0n8rJTYspyCXDvnjUu7gCaQcGas
 y/Ja6Ws0ENZgPkX0xWDKiZxmYIXPzUuTZfUxD1ASM6b8lOr4QNIttg8k3Gs4yuH+l6K1kuKFNbqUwy
 eVR8sUJjJen5BIrQtETpbxFWja+lyGEe890lrCQP56fXjYx5NTR1M3o1tnqa6QOkk4/248KyvI8iSZ
 v0L+6wsxGpS1AKP94o36ck0FhYxfO8KW8p4eotVInyz34HqSdEyjZ0hiGOrnynOi5Hv73SWiQn4tHV
 SRMuclfT1SLi8VXLhRMPGxowbrNhte3xj2RdnsKBKBqoD/BucqXvZLt5P/n/yUui6vzJnlfgN4nbAw
 4myfdDopBDwYb+SVntwOW/gVxyUzKAkr/p7a/P7UoGTAUL5g1sKu2g+V+1wCRQLaOggS9xAs5uYT19
 LmP7xIQf40oF4xN6YRZo0nJpPIyLQSlzyD/BR5rMk/5L2mpghiGZHrLaijnL81gvG9C9hH7G1eoLCh
 jGitOnDC9JLX+8bcIIXZVXqw5ElMzTEyn2+4Ip1C8thsEpAdAYisnUON4xiQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The console port (qcom_geni_console_port) is a static instance whose
uport.line is hardcoded to 0 and is never allocated from port_ida.
Only the non-console path in get_port_from_line() calls ida_alloc_range().

Fix the qcom_geni_serial_remove() and the matching probe() error path
so unbinding the console device doesn't hit:

  WARNING: ida_free called for id=0 which is not allocated
  <snip>
  qcom_geni_serial_remove+0x58/0x80

Fixes: a53be6945f51 ("serial: qcom-geni: Remove alias dependency from qcom serial driver")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Also use data->console in remove() because it oly return true if it's the main system console (Konrad)
- Link to v2: https://patch.msgid.link/20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v2-1-0e83d8df410c@linaro.org

Changes in v2:
- use data->console in probe() because uart_console() return false before uart_add_one_port() (Konrad)
- Link to v1: https://patch.msgid.link/20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v1-1-02e18c31aeba@linaro.org
---
 drivers/tty/serial/qcom_geni_serial.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3633723acef8..1a36e9fad976 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1979,7 +1979,8 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 						port->wakeup_irq);
 		if (ret) {
 			device_init_wakeup(&pdev->dev, false);
-			ida_free(&port_ida, uport->line);
+			if (!data->console)
+				ida_free(&port_ida, uport->line);
 			goto error;
 		}
 	}
@@ -2015,6 +2016,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 static void qcom_geni_serial_remove(struct platform_device *pdev)
 {
 	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
+	const struct qcom_geni_device_data *data = port->dev_data;
 	struct uart_port *uport = &port->uport;
 	struct uart_driver *drv = port->private_data.drv;
 
@@ -2024,7 +2026,8 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
 	irq_work_sync(&port->tx_kick);
 	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
-	ida_free(&port_ida, uport->line);
+	if (!data->console)
+		ida_free(&port_ida, uport->line);
 	uart_remove_one_port(drv, &port->uport);
 
 	if (port->rx_dma_addr) {

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-4a199c25fd84

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

