Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16BD30D41B
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511855; cv=none; b=eWVApICsNuthS+n3U1pjyqQA/gWP9XywJBT5rtadBt1K7FC/X1RD3uvWG5CpsX3LBnRTrCUrP8f27PmF6RbFSY1Rf5WK+pvurR1y7Mtx/tW0xu1IqeBVmwSpOJJjCSaznw3D+W1gefabCuOVa7JMGk8EtuWPN2/r0IwhjEqDjR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511855; c=relaxed/simple;
	bh=N638MSaY/9FWa2D7AwcPHSmd0cuTobWXPfkN0K8ftVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FY8lwpQMC/KjnbqXhjU/osQ/Te2QHjMWBBpMzqSAQ5SEIrjoA097X//T2lZd3PmTXOMfCsN3UXWrK6PBwvw0Yw0sw384ux+V3vnqk2TxIduMp5m6YoooD15gfL2MUmPovS8d9WThRZOlR7G6pu/Qi2Bwc78IUP7r90plFViAwSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tkVExGMO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tkVExGMO"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso7102375e9.1
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788511852; x=1789116652; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y3KK8ri6pIRdV8UthsbD8GyihBgeQCr9wERNybPcorE=;
        b=tkVExGMOLrEpoEk5xMcnlSrZ4WC8WvhqFbtKpuoUdpRXOFII9xVDx/kx7LrtROjrL3
         f33OzzciVROQxqJGbMIO/afAh7Ba1ro24wvaFuuoNlYIs8sjAk6DHzWVGB0bmbYDZGQf
         h8bNd/D7E+tSO3WXzrdIYblHHVxGWP9BdUIHa0AFsRFUE0EYZHaKd3m/a4s51+liRzjV
         xJ3UDsazYMgIq8vWxNEq7G8BVZhAIvBZZvBJjAOujpmw0geETvYQA9rmmTuaQkGu9DFJ
         gucwaA6fawWUKnms3QczemP0akxh2lGDwyZdWHvMdnSB8XmXMscDdttQ74w7l3VlHKFf
         NTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511852; x=1789116652;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y3KK8ri6pIRdV8UthsbD8GyihBgeQCr9wERNybPcorE=;
        b=OKDddi7/0yNjtkJ8M2MeXRAZDM55oGoImXnu55wkg3T4aArCeJOw3trnL0j4hDUPbZ
         ErlcG5qgKQWBZN4X5uBcAZpMt4dJ1XQzpHK/UeqaDKVzSs0/3koI/O0AZyR2C221j5+Q
         qT0HUcdFRJrDdKPuBZJxHqBqoxX8dpOCFjk2Yd1AmZEgYQXSfVtKoUz8GeO/q32i0yuN
         d1dKgXqMxCi45lpjxdyT3BY2icjg0rJmVYPEF6H9MFwl2fL1pADQ8yCXWGaTQNdGgUFl
         vJuLfHEo4x5ecbFrL9cqsunquphTx8XsMGte66jbnjUpQdukb45G0MGN8e8DYwnQAaGT
         jbfA==
X-Forwarded-Encrypted: i=1; AKwUvByaSNPEloVrlnMALoFZC5e5uoPX9LTGBBN0d2VMidKD3enqthaur+tgKa5s+Kdgseb9VmiTXznOL/U149U=@vger.kernel.org
X-Gm-Message-State: AFuF++mGQPfWTr75ZciL1cWm4w3gR6XU9cWEwvXYRmwstcUMzOkh6mXc
	3KDFZjUZJVXgf4pSX+NoB+KPbL1+YVEo2kTW1PaONRxGwdB960f6bGpbaaKBcuy8DjI=
X-Gm-Gg: AYBFou3mNx4ehigC8sWfDpgikatnVOH57JyvJrP0qmS3ZDYxxxWmbvXIRrEo3by0NTf
	7pZtLb1vFBmlbAY6MIWNfWsLTxZHO3kkHh2z4ouq4xCvU3914tnFH2pAAfPYuO0/tlzgUeBaxQl
	uHJv76UsXE3rNRqi3Igqwz7Kelm57tkCL9Da6SbKG4C+y7ZLZJ5qSHsSM4eyc/cQJGQbqnA/Vlc
	1HW/P/AfhEOXpbZeNsdoa3wT9n+FUr1uWz1LZUwmWE+kZGFYtjd3MfBOsKqi0s/PJ0I54Iz9cjT
	gl7ok44i2RAaikZApebAM8M2Mw8jwcGy9518zqOmPkZv7cVbUJzOLY/oGI+1lWt1OG2QQ66gkFP
	Z7JWwlBUkXIYgo7AMKTQRLl5ofU6yVkNPrkkATVHHt/9T55kedK/vhmP/nWzbaX6OsrHCsrylwD
	gjfcM8z0z8DMUj7Us3qvR22vnUrPPpXgeU04zU3vwDS+MklpmXDnx629rUu8BR/qXvUZJlxagNz
	Cs8/itW
X-Received: by 2002:a05:600c:6091:b0:49c:eb17:cf3b with SMTP id 5b1f17b1804b1-49cf8252497mr41832305e9.8.1788511852012;
        Fri, 04 Sep 2026 01:50:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75cd8d0sm48748275e9.2.2026.09.04.01.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:50:51 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 04 Sep 2026 10:50:50 +0200
Subject: [PATCH v2] tty: serial: qcom_geni: don't ida_free() the console
 port line
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v2-1-0e83d8df410c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGmGmmoC/6WOSw6DIBCGr2JYdxqg2mhXvUfjAnHUaSwYQKMx3
 r1gj9Dll/+5M4+O0LNHtjOHC3myJoK8ZEwPyvQI1EZmkss7r3gOwU6kwX/KteAwTz44VB8IYYP
 UpEbo0RB0tMaggs4hQq5EVWlZdG2Zs1g8OYz6Ofqqf+zn5o06pKXkGMgH67bz1SKS768DiwABX
 KIo9U0obNRzJKOcvVrXs/o4ji+FZKl6BwEAAA==
X-Change-ID: 20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-4a199c25fd84
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=N638MSaY/9FWa2D7AwcPHSmd0cuTobWXPfkN0K8ftVc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqmoZqFnTd1hm7wJMx0uIr+YccCAr3W1OH1qfx3Ufa
 MdFhOJWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCapqGagAKCRB33NvayMhJ0UWsEA
 C6y6ABoiD8y3pN2EG2g9aIz/L7yn/7Pjpr2xf80pz1js/Mv2vBSzsTl1m25nNLdFICtKWnBo0NJw4L
 B/vMDmYgb/MnbgOfdW1QxmEvQVhEoDQExgXLu4P4QreEMolkf9YvoqsxCW7/Bhb2am2hR2Q5Yel2cE
 fFDHaLGG+h9sAlmKsaWz40pu+fkbI2oLfcU3Kv3OzkxsHuah+IrFGSNu7UXKSz/nu56UL0OZLr/lsY
 /A5Zzz3QPSJj+OzcGoFSawBVytUZc/DJrgkxhEZCpUVxMVqt9jHVeqgxbdIAhVRQF6VuxDeSfFXIrv
 vDy9A98gcCREMeGPSzn52AuYGWD1LKDoweC+lp+qDq64xdNaTfLNHLNsIQAcjdv5vgOJHfTnmQiGY6
 srpF5pfQi+IAl2BjAIQkKmm5kHdBZVOlaxb0GjoDRrNVF0/e9nU9P5pqm8udD/MVdsUluqBXTbjCuy
 IIPPfebBgt2x5XYItb1TEbnkKxzwolyD8Kv36Ype9HWog/VW4zOfOCtlO4r4d4Uj7zVpqGYe4gho27
 LHmiMZMpSgwb9hM9cImpBlsYRdTZSeGFiTsGoVxvMtbFx3JZpdoaWLIRvXeiidYR61chBlZ6MYQmVk
 4ihdwKSUZgrWIW2Rmu/8kzOVyPOhxpLnzYCvVfWeTo2F0gITFq9pyL+g5HLg==
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
Changes in v2:
- use data->console in probe() because uart_console() return false before uart_add_one_port() (Konrad)
- Link to v1: https://patch.msgid.link/20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v1-1-02e18c31aeba@linaro.org
---
 drivers/tty/serial/qcom_geni_serial.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3633723acef8..b47f8d5bb295 100644
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

