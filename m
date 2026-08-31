Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37339D3FC
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174864; cv=none; b=F9opG3xLZhdty+8DokMY+7Fy2sF7HulR05zyADJ5JcAOL/nfIG45nul0BRHzf/NJapgOGPde/Jyem3DcX0E8Yy74OqrM3Hk21l6ldvM5DV3jDem9zjrMMN78kEqKAV2/oqployhNgN3Q1eQd2te/QbQbxxmDNLKoUt0sW6NWpsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174864; c=relaxed/simple;
	bh=+fNxniTWhzyxcOhfMd8bwaVM/PFHGf4wj5tA20m1Tjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d7W1CK8rv1XpDDjvmh+oenaD4McHfVAIRZzrXBQb6lTcr1+CftcYSscBEG5wjHxrkZ/CnE9T0lv1CBgE53w3YyshMPysjeKgmlVbDiHgQyQPccYXUX1DP2KSIZQnjXKxFnLwV7qBafaVI9pfLIx5NdI+uJJinZQX1SeoA96mC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QKneuApu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XbD/Zd9S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QKneuApu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XbD/Zd9S"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBA0uG320555
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 11:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FlxgoT/rlG1y3sPXJVKCOC
	lbjTbOEW0HyqxMqkpbpck=; b=QKneuApuLZ100BopGhbqf1dS/IFYT04kORARpj
	4e1Pgzcb36a9D7Qdma/7kiSy8AmybVeKxOo/oHdu2MPe27rtHZ3a3U71VIUABbbh
	vPMSo1KXoukeUXmbaLxx5A6oGlIKfGg08u4nmP2wKX9YjSA63J2PCjL9/LTSf/DI
	fx2zoUZZHbRmZ5SJTyGyluDEXYMQYPnK8XWwh+2XxfGjnhXgahS5B4M9dFMf6Qvz
	5lvm06I13UJ098EOIpChY07VFMzB0DX9GSj+DRz3/SHiamXkdinx5PSim580VePT
	snda84YgP5CUml8VlfCQ6wAnbk3RFDhAQc3bTaFVr59mbe+Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd8cvr1b6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 11:14:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d7293f13c6so43392015ad.2
        for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 04:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788174862; x=1788779662; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FlxgoT/rlG1y3sPXJVKCOClbjTbOEW0HyqxMqkpbpck=;
        b=XbD/Zd9SlUTbhCFHZrjiG1Gqz14CciiSpuNQVA4iuKnI6AQ89VDO/oMmcl7rtyoJDl
         ZoX/U7xj91RrwPN1D0Lhd/0ol2jccICiTX5cweTkmHbq+65mQ6ITPVOUCj4rjtx3yqg7
         PnhyH7tTgl7icNdOvqLLCMRWjo7ezRatSBHrncHPtwppFAKgMsO+ZgONV1kM1TFPU1/O
         a1FG1SSUdQd+bsi2CwtrU9kQNyTSPhqI83mevD3Q1H1CCoyoRXB/mMb2KQQLAce+Exuw
         F3VegR5h7jMH8k/DJdDwMdBy4KKLldYbnY/VgWyj2ZR1XhujFwX4g2BGnciYkA6oVc3a
         ehpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788174862; x=1788779662;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FlxgoT/rlG1y3sPXJVKCOClbjTbOEW0HyqxMqkpbpck=;
        b=N8muytBt3tImQbaKIHCSLIyLF5MY91VbDn9BWYLbDdJrgN9zZx/eaxE4BTU9exfTFS
         7os4xNqFxirvbLSmx5flu5tUgE5AgrXG3q35gH+z/mYjrfE8XtLS1UVxgl354F0QkHyi
         MT+hxD2SKgbzV+ViZHhwt7b4xuMsrOjep/yfpV9nI3SxwxYzjyYApTitKRDsi1Nw4Ea1
         k4jThZrLUvUfS8MD6uS+XRM4xW+l0mhSW1vD8wUtzMXdyNmURoMR5YCN0uMGUiMSoiE2
         Owr7dQLLkCjH2alS++n3ZejitgubsErYu+vQz4bYbKPX5J7AV3vtPmrg1t8200oOl0cs
         F9cA==
X-Forwarded-Encrypted: i=1; AHgh+RqutyJooWgx5JqW/18v0QhL5zjc1rf3sFxouY9Y95Frk4tQrH6jkZorEyL871MvcoS0OrZMdhlWi8d5MyQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nq5vqH2pssGTghaLIsECYXyvZO6Qi+Twfau5G6nBsCqjiaEtMM
	Vjh15jp+QxaXst0No148afp5XVKH6U/SZI0iE90PtctCeOpjWtc5y+EUnKT7kUlBz/f3totIgJF
	xVwMeoN/dxg1DOFIL3K7rI8I1Om7SjRHyAE/oMlnlTiQgmsaJcp9y8TFMFJqLeowWWsY=
X-Gm-Gg: AR+sD11ULTBV7RuxdjKRG7tuDaXOuMPfIM2NWHCtuQmrFgs30t5EcTWGZD6vxWTdztk
	kCdXKwCp612RWhy5rn+dHD3de8QVZ3Jz2gmLZ6BMzTBIsiYJcCJVUtj2V+/HT9Ew97ubF87Caey
	u41rDq9rR5LMwKWXmVm9iEnB3TcooJXdv36xBkwtVae2+cXWAxPtJf6vA7VC5SSwm06jRhQB85p
	YbfB5ywZkOZiUhEKTuVXhVWHD9rQ+BWnnHigRi5EHI1cRjZpyiDa8DS1aoOELc97oA4e0xU5R7+
	4csytA8ITgKFfuosqTlV3Ef6Pxn++UUi7UB7FOpBunFlBlHlasP38D843txKyxcZaxo61mwWNrh
	l3StsLcdDTCJN8M/bG66L20BkuhZOizK8mn0=
X-Received: by 2002:a05:6a20:431e:b0:3d0:8cbb:8c2d with SMTP id adf61e73a8af0-3d7ad993a15mr234484637.4.1788174861844;
        Mon, 31 Aug 2026 04:14:21 -0700 (PDT)
X-Received: by 2002:a05:6a20:431e:b0:3d0:8cbb:8c2d with SMTP id adf61e73a8af0-3d7ad993a15mr234424637.4.1788174861403;
        Mon, 31 Aug 2026 04:14:21 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b0451sm35215969eec.16.2026.08.31.04.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 04:14:20 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:42:59 +0530
Subject: [PATCH v2] serial: qcom-geni: Fix port_ida handling for console
 and probe errors
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-master-v2-1-0032ec7fd1ca@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALphlWoC/2WNQQ6CMBBFr0JmbQkMSqor72FYlDKVGqHYKURDu
 LstLs1PJnnJm/9XYPKWGC7ZCp4Wy9aNEfCQge7VeCdhu8iABdaFRCkGxYG8qEgWdauq4xk7iPL
 kydj3XnRrfsxz+yAd0ncyesvB+c++tJTJ+ytdShFjpDLqZCRqvDrm/DWrp3bDkMcDzbZtX8fWF
 ZO1AAAA
X-Change-ID: 20260828-master-3e806ba3492d
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788174858; l=3786;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=+fNxniTWhzyxcOhfMd8bwaVM/PFHGf4wj5tA20m1Tjo=;
 b=iLZlFKtH6xym0nMpMNgyko1x7hHJ2ZtwN0pOD50GGOfC1BMP92Y337H8mr7hoh2nl1adpQ1KS
 2RSeXkSMtDhDy4bh1OcLZSbmc3nvJ5VdijJPujUbFIT7wlpgh2uxKxi
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5NiBTYWx0ZWRfXxEjjNlh2RBa9
 7MptTItF8CvhBXIq8sLcPfS/bcFneDLUacRQfWJyDm89rEDAyNvdS8sZpYGnxU5TbJAUYWrOKl8
 CT7MbserXXRJuFn7vQ5xwk84nIlFAE0=
X-Authority-Analysis: v=2.4 cv=JtnBas4C c=1 sm=1 tr=0 ts=6a95620e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=MkzWPs_5gGyycmrQSsMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5NiBTYWx0ZWRfX2UfRLkV1FJws
 b+3GbF81+u85T4v6Ii924qUjUMa6aLiRP4F7keFhI8lXd1gnRfkqselEXny9v/ncE5Wch1Q9WPB
 9Is0Dcz1stUOq//UrihO/LegQ3ZuSO3ohhRZl0bNlGgvIkAfI9/lHAATSr6wFQCS/OC4aNWANJx
 UWy9xVBXf+AlvM3KCYCBofNeU5VpfBdwuKnZnf5XXEYEmG/THELyJ7ahCSBEMR6VG4clwAtSVGu
 NFVzB7ExRafJUMMNwRlNlWw6uImjUZnq/AjCDpsBOOL8jIhd/+IpgcZvIDg0diZoJaGEKI5GI7H
 aVRTtx/h0+vrWQ/nqgEWftvO+QPHxYENZ+e0/WbU/3FhfZUqpThEGhzuW1TlbkA1rWLWemMRdmh
 Pbe3+fsjKJpO6n5Xu3lzrOfVIbbZv5TllyeTiNuR8E50jQqmDoBxIlRLIwk/UKmZB4nI9RtM7Wn
 bGCui1GZFSa1uBHtVyw==
X-Proofpoint-GUID: vWwMELSKMD03h4s6eu9RFZAG_a8xuQv5
X-Proofpoint-ORIG-GUID: vWwMELSKMD03h4s6eu9RFZAG_a8xuQv5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310096

The console port uses a fixed line number and is not allocated from
port_ida. However, qcom_geni_serial_remove() unconditionally frees the
line number for all ports, including the console port.

Skip ida_free() for console ports so that only IDs allocated from
port_ida are returned.

Also release allocated IDs from the common probe error path. Currently,
IDs are freed only on the wake-IRQ failure path, causing leaks when
probe fails after a successful allocation. Move the ida_free() call to
the common error path and guard it for console ports.

Route resources_init() failures through the common error path so the
allocated line number is released correctly.

Allocate the port structure before calling ida_alloc_range() in
get_port_from_line(). This prevents IDs from being left allocated when
memory allocation fails.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
Changes in v2:
- Route port->dev_data->resources_init() failures through the common
error path so allocated line numbers are not leaked.
- Allocate the port structure before ida_alloc_range() in
get_port_from_line() to prevent ID leaks on memory-allocation
failures.
---
Link to v1: https://patch.msgid.link/20260828-master-v1-1-1f8afa5f82c2@oss.qualcomm.com
---
 drivers/tty/serial/qcom_geni_serial.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3633723acef8..ceaf560fd8dd 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -289,6 +289,10 @@ static struct qcom_geni_serial_port *get_port_from_line(int line, bool console,
 	} else {
 		int max_alias_num = of_alias_get_highest_id("serial");
 
+		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+		if (!port)
+			return ERR_PTR(-ENOMEM);
+
 		if (line < 0 || line >= nr_ports)
 			line = ida_alloc_range(&port_ida, max_alias_num + 1,
 					       nr_ports - 1, GFP_KERNEL);
@@ -299,10 +303,6 @@ static struct qcom_geni_serial_port *get_port_from_line(int line, bool console,
 		if (line < 0)
 			return ERR_PTR(-ENXIO);
 
-		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
-		if (!port)
-			return ERR_PTR(-ENOMEM);
-
 		port->uport.iotype = UPIO_MEM;
 		port->uport.ops = &qcom_geni_uart_pops;
 		port->uport.flags = UPF_BOOT_AUTOCONF;
@@ -1897,7 +1897,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 
 	ret = port->dev_data->resources_init(&port->se);
 	if (ret)
-		return ret;
+		goto error;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -1979,7 +1979,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 						port->wakeup_irq);
 		if (ret) {
 			device_init_wakeup(&pdev->dev, false);
-			ida_free(&port_ida, uport->line);
 			goto error;
 		}
 	}
@@ -2003,6 +2002,8 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	return 0;
 
 error:
+	if (!data->console)
+		ida_free(&port_ida, uport->line);
 	if (port->rx_dma_addr) {
 		dma_unmap_single(pdev->dev.parent, port->rx_dma_addr,
 				 DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);
@@ -2024,7 +2025,8 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
 	irq_work_sync(&port->tx_kick);
 	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
-	ida_free(&port_ida, uport->line);
+	if (!port->dev_data->console)
+		ida_free(&port_ida, uport->line);
 	uart_remove_one_port(drv, &port->uport);
 
 	if (port->rx_dma_addr) {

---
base-commit: a8406e6c0b793ce0788019683837c40855b55995
change-id: 20260828-master-3e806ba3492d

Best regards,
--  
Aniket Randive <aniket.randive@oss.qualcomm.com>

