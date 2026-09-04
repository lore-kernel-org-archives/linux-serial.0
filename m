Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971B42901C
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505800; cv=none; b=WovBQLAcEcQo4zkjxGHegQp+7JIVTw9TBSOUX40VlDaHtp5bsf49CoU6IVCJ2eBu3RIOZh0umylvTF31ES5q4TBi1WAQet8qqhWhQvRrIDHX9xtu+iY4QHyhB3H9T4iLJdwJpilWeMkeaqHKMmcBbSuog2eKJPUf4KVypaUqKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505800; c=relaxed/simple;
	bh=4XE9DmDTZMH334MsifVc62h5MaGK/g22iClMDz1bcPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dHrmhQuDQ20cIzBB4n5jncXVQhlv3Ki1vFL1BrNeEBuq7t7tD4BPNkrN0/VJPmVWNiTnoUduEXGN9iQyVzVU7hOE2axvBDNo9HYuv5JgvglznsA6vT4Unn3vjvjZ2vZK54GDki51dZ7/gaAp09W3CWDSzjgH1q0uJr2Idsy2xy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y4m3aHI2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4m3aHI2"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48436216a98so407524f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 00:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788505797; x=1789110597; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4mRkrYQfw+SaUox7nNL84QwuZBh15RG8cp8OLLTinps=;
        b=Y4m3aHI2tIj1z201c0Jh+htPH8ef4mw+9h6s8xnxHkgDYTOhxrURiXirdhwRsbJcpy
         KDNR8BUDn6+Ohega1Ryg9Xb36EXCWy7EC929F+cfSS1l397YEfr46gen3fvTfZLzxmua
         yge57ktlL6aSNmGOrt9y8Kx5GQNf65ZGNAuOSw3gm16la+wpBLQV3XR+0CQnWfGKXWUi
         RxfL13BcMu2tA+49FIPBOIpPAGUfXyQvACOW/t9k1Wh00Z0r/C2dnS5GtK8VRZhGZNaw
         t1oFmLBtryQmXl7gCG//OUM/rImIJB5iZmLOT0QyYqx3iZteMR3TDpKKncEyqHKGzqfq
         wcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788505797; x=1789110597;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4mRkrYQfw+SaUox7nNL84QwuZBh15RG8cp8OLLTinps=;
        b=Hp1x4efCjnkU07ez/kG25c4UILaBQr14VLZ/dU9YFB8hsUQBBo1fMjwdNJKdERa1TZ
         gbB9L0SPb9isuICWg67525VefUVs8v3zBFhpEM9YhFyphYSfCPxRdfhuc0BJGjEnqlwY
         4U7wQe8NISKE6d4sXeGQxDrfDQFC++sO6xlH8pRdogSbOg7s336kg9f+pM8ch4uIyPSQ
         Uc9Tl8UG1LwRrE7+dLzwrYufxwaNJquNEKvv4ppKoEUqBb8c4N4m6lK5yA7/PBJDhlwQ
         YFG18EJuE/0aUAEvDcbHw6LPcAvoSnFzAw4LfVkwJ1I2m517pxZYCXbr0yrj312o4RiF
         9NbA==
X-Forwarded-Encrypted: i=1; AKwUvByDwszruLAHwJxjloZYjVGjhatYGCsbzDi+X+6qBsP9CDIIPc5gX/RkCW3pr5jJ5VbOkrXvQaNOtcY3OZw=@vger.kernel.org
X-Gm-Message-State: AFuF++lNUf4tYjPc1GZNcQ9JwTVmZsSYB00B6wpx4xN0WaMtB/P4tJea
	E1fY1KUUIKElMmsmrDLq1Nw7AG3JeI8ISLi/nzdjCaEwereKte/faSW2SYMHT0ODZMk=
X-Gm-Gg: AYBFou0E5XKFejlCt1XIzTUzofOHicgQQKmsyNcZsVcHsBwaS7RPIzOgMwk66vflFBk
	UUq8vrUVOx3dLIb/R1N/ORJS6vH4jOYG431oYwB0wDwj0hrfCYlqEdumtG0g3lPi0TM49bLLNV8
	jdI7aptzyAesAd9RGjDnQcu9oG2FKrgvw7PmsLVTytg4vroMnK4v8GNgPtiUe84jbRFjn1e2UbH
	AdHK13/gnomH+VOvxcKgMeXpkQiDIpt2LzLh/wn6oKmucK+PHDeIisdJkyCN12QmU008hPtc0JW
	C8bqpt/EvnLIkUz6X+Uyo07xOdRmif+3yYEmJPmBTDltGKqcD2tiNYkAbkUEoVsQnMaanUyHE2P
	+XQXv1ISCNmlHoZa+vOEq+yW+cZGGhZrXMaKZVxSdntdBK8y8UWF/ltcR2B+rzxD/7YDozpZ/dA
	Al+jtHyWaDkUh48WXElKyE3UUQGk7pb3Bvm8wTR0FeVytJ5p2jZM74Mz8JwWx/DUrwa3bKEnov+
	JvXKO2C
X-Received: by 2002:a05:6000:400d:b0:485:8c17:9774 with SMTP id ffacd0b85a97d-4858c179a52mr1092686f8f.54.1788505788386;
        Fri, 04 Sep 2026 00:09:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm4059605f8f.23.2026.09.04.00.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:09:47 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 04 Sep 2026 09:09:42 +0200
Subject: [PATCH] tty: serial: qcom_geni: don't ida_free() the console port
 line
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v1-1-02e18c31aeba@linaro.org>
X-B4-Tracking: v=1; b=H4sIALZummoC/yWNQQ6CMBBFr0Jm7SSlKYZ6FeOilimOkdJ0isEQ7
 m7R5cvPf28DocwkcGk2yPRm4TlWaE8N+IeLIyEPlUErfVZWGSxzYo8y9WuncElSMrkJS/ngYXI
 vHCkyBl7r0WHIRGhca63XXRh6A1WcMtX9F73e/izL/Um+HCXY9y8zxrBklgAAAA==
X-Change-ID: 20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-4a199c25fd84
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=4XE9DmDTZMH334MsifVc62h5MaGK/g22iClMDz1bcPg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqmm67rVYyRnVtcNx9WAQGST/9pLaID/n8GdHmJTdT
 vxa/GZiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCappuuwAKCRB33NvayMhJ0YS5EA
 CMUanBZDEa5UKkVi+ZetQhSAqyBJ6xnxb+/MpOP8W1j7GaqJ30Q8IcBnUcm+w0jxcoh1lD9oJd6oaN
 f0CTTHQb0pFevbQqnk/mx2zeKvpHLqx+VFQuSGKsaeh3nZyKLkc5xLSG2/3ssht98+/ydJFgIi7LEM
 /ieev9Lb1MwYdR1bphHgLqIlrKDy9VOi78GI4EKKtYXsM9H7WzQQvz/6uo/3XG9YuEhKjMKCi9XN1M
 GPM5XD+RhMg41unKvV+rT5bSK76veF+78mpPsvHQkCf0gtgyazs7rPIVS+XQ4/BN+PhhIKWIyZaqtB
 SHERntUc8g28MTmYtvCcJ0f63mRRKnguSgorsDWauXgZfvrWG9xrCsHGOG3o1P825g8D3dbdIqG2FP
 h9+LU1ZdNnWnloiQwgBkXl8gTAac3w2l09vwIcHNaBOpJ+D+K8ZPQtUgVzob+R7jBuVEApDSIWr481
 FB4JnDfWThAhGHAIG9FpwqUwoWA/Z6l63Kf8Ak8DOQE3HqBOo7GKLt6LnmOIPZKYvPAZewMMOlVcEF
 gEemvJG5fANDMaGALaHZ/cU/3ofG16kdq6OK6HyeW9w69WEdZp3KvWHTHJjopuiRQYa+nWRFu7MfFc
 J2+vAc+OZHyfvom4UyrRMnAJ1Xnc+FjWbv89fOqooOzIO9u7lCNU2pV2gkPQ==
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
 drivers/tty/serial/qcom_geni_serial.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3633723acef8..bdbdfd7dfaac 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1979,7 +1979,8 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 						port->wakeup_irq);
 		if (ret) {
 			device_init_wakeup(&pdev->dev, false);
-			ida_free(&port_ida, uport->line);
+			if (!uart_console(uport))
+				ida_free(&port_ida, uport->line);
 			goto error;
 		}
 	}
@@ -2024,7 +2025,8 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
 	irq_work_sync(&port->tx_kick);
 	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
-	ida_free(&port_ida, uport->line);
+	if (!uart_console(uport))
+		ida_free(&port_ida, uport->line);
 	uart_remove_one_port(drv, &port->uport);
 
 	if (port->rx_dma_addr) {

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-4a199c25fd84

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

