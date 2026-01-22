Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D73904FE
	for <linux-serial@vger.kernel.org>; Thu, 22 Jan 2026 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101251; cv=none; b=uS/+AOGck2KlVTS3c3oAUmzL1vgPXJXBuNoCFrYqNMgfzciX6ZSapV/PvqFe3w1XncfPiqQkhYBOrB7LrSnDff8WWo+IGj32A7TLIrFcHUKTYZuJD1ii2QEjALwqv93OMreVmr6ZrJz5Psq62zcb0mFFjASZkJkN9p0dmRtdjzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101251; c=relaxed/simple;
	bh=SYQnDRy3gXye1n8xw6IAVS14uNbovqYrq5pQMsKusI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ffxLp+LjSypfmKJFIsBL/kyNAbfhJ8pbQpORJcXeJ1OFh2rzSs/HjWqUA7L6LRPpv8e8rhKgK1r8Pd4zGKCS5nMln/FZOEXn/tpP4Lwuy6fPDQnDT691CMFyN1WDiwtYPip4cXsj/ordDTK/TyTsPEOwapOjRxSr8OzJAx1ZVZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eh+9t+jy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fxAh6VRn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eh+9t+jy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fxAh6VRn"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MB4gVR2629500
	for <linux-serial@vger.kernel.org>; Thu, 22 Jan 2026 17:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2N6/IDHinoRDWXKmcT4CHhXv5X0fnjd64DC
	/fRTaml0=; b=eh+9t+jyoIXr+ztOK1/m8ShMiJZ2Ye62mt5D5BDMoYIjCdWn6RW
	t39bPS5tF+AlTr6YBRcbNRQudKMBA24Qix5gh1sJmPrOz8Q9RDDUiOUEfSHNc5Dk
	tlkjb6pKkvOsAV6v57rqm//ByBMSLiDatdKPIUf4N9okVVoP6RKvg2ZQihSgrTm9
	ewOe6TdswbZFNp1bFpjLSc7zg+9vFdisAC1huU+BYiEgSOYLXW1HDB+eL3VnQSKn
	VCmRWN1K8wN7bxUWcypBTDMoDa/Tk23U6Jood5g4mGwVNAe5Dv3CcYXNQKialxzS
	K7h9zlb9aTS7umYQpzuau9iPDfHXlyck0RA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bujq198jv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 22 Jan 2026 17:00:40 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8947c4398c4so34584866d6.3
        for <linux-serial@vger.kernel.org>; Thu, 22 Jan 2026 09:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769101239; x=1769706039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2N6/IDHinoRDWXKmcT4CHhXv5X0fnjd64DC/fRTaml0=;
        b=fxAh6VRnfySKY6jszSJGDi4MkXh1kCFrEIqhABFtAVHTuDDoswWXSCFiBvU8UHkwX5
         o69P4x3D/oV89bxyQcYPTQRIZqm2hz9mnm/Y0v9xYXMzXfQIyj/FYBdncxsirMTqTdsp
         22YmUOWgYF3af9o+49BuvUvQS3Pc9ySAIK68ZeYGLIlNhFXIej0/gJgL003vPqee8Eh9
         sH9XVDQNpj3Ahr7UkukklcQ8bvke3sLazfyjTWQ11n0Br0QOS3uTPphHI6vZRacgylgB
         IL7BPTAX4h2rTGGQJ09CuBfZ7WqKVppNr86frKp0DKWGszaVz80i0t8GjbRaf1TDQTL9
         0scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769101239; x=1769706039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2N6/IDHinoRDWXKmcT4CHhXv5X0fnjd64DC/fRTaml0=;
        b=UdPW+CGRMcnZfKgeOs0KI+FKZRPT6I8xNtTs2y4TQO7fO9MYsXDetgpIf6xeiwh++Q
         GNszTmZt7J20A2+o1i6X+wH6Dh2foKAPp8whz/FKWbj7+kQdUI3AZMyv+cDnM6dGdnxM
         /6AglJCJIuO4ft4aHDWNMJpToeqBfuNRjI/PbE7eMQ3zfFtHYqDsQsPv4NGCV01bbPIV
         WEXqs5c8JV+AWFvLVDJ1eZZ9g/+fp7gDkRBw7RhFVzvrZjPJ4uBxVuHfGINSicc5GIiB
         F5H2HZ7zSsIHOQ2LXSMKsVBijM0RUzt4gY9eE7jsGBnGz4FMdfPGeN9t7OY+WCx/KJPK
         Hy0A==
X-Forwarded-Encrypted: i=1; AJvYcCX4oNHrlUm/djyOaOflnMJOs0YpcyYFXn7D+HJqundQhREmYi0QCGeH0LtZtiCKrte95UZDd6rAzNhAzwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8X72eYLsA89JiOgGSs1d4tspGK56Wev3r9ioeMqCytmWTSmxP
	2D0T4BugF155esbMEcuRY9UkXe2AlOfE17iBEToeiM1hXrHnRyZJKWyO9n7bkWCnEhLT6fkOiYU
	WlytrD6H1RTlZEkiVfR9hw4cvwaWJLw+IIdXUD/Q155WQjf4T/B3E5BSrLzRbnlNc2G4=
X-Gm-Gg: AZuq6aI/WMi9juJke2mYpAtgJaUYoAMNF4rUF24oT4te4TPZBjq13FqFv9vxKV4IpaE
	rrje7kg7Runy07Lyam0WGeCHXP58HdnpLmw7EfAm6wPksg4d0U1hF0nHK8LqIz9YN5GX968TInG
	C/zY5NR6OHlVOYgzLBc5UZmwFU+txKjc8mkhNz9o2Eda+HVifrl1S8Bdnq1fYqsSuRmzSlpk+tq
	vi3Y1ycL9qTZ3jQimndigsHe9qVooUUKUMnye0YUZ3k6h0SUv3duD51FiZmC/G7khbo4lD4mCFd
	2+2wWlR4A38YG4YZq4ZeOW0R4JN/odBZlEE0+TN82yUUOwhnc1E6hlmINdrv9mgZul0/BDxghWQ
	neUuW5GUbwgabBYqYY9BRsf8oAw==
X-Received: by 2002:a05:620a:454d:b0:8b2:6b9e:5396 with SMTP id af79cd13be357-8c6e2e4c8abmr8932585a.83.1769101238671;
        Thu, 22 Jan 2026 09:00:38 -0800 (PST)
X-Received: by 2002:a05:620a:454d:b0:8b2:6b9e:5396 with SMTP id af79cd13be357-8c6e2e4c8abmr8916285a.83.1769101237537;
        Thu, 22 Jan 2026 09:00:37 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d26a91fsm578165e9.2.2026.01.22.09.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:00:36 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] serial: Fix not set tty->port race condition
Date: Thu, 22 Jan 2026 18:00:32 +0100
Message-ID: <20260122170031.433724-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3536; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=SYQnDRy3gXye1n8xw6IAVS14uNbovqYrq5pQMsKusI4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpclev9cxxgZkXsMxsURilU3jXG5Z15qh8tFH8r
 BurBi4FwJeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaXJXrwAKCRDBN2bmhouD
 15YVEACPEgsrQyYmGt5uibl1LL0ijwt7jnSAoHiI64wWhYYwcYSLWR8wROlbnqnTx9GXX0/rJw6
 ATM9QQ2xIMwO1y5r38utI/+TwE8VDP+me3XbOUBoc2JEmOxtfXYLpEGM5q8smw7wz+jHNPkR+fa
 Vis5yZRwvcHvNcYMCFIl2ENlfGpVKxg7hKSQb4x2sZmtNCNnMnmQk2KAB3zlrNsB0y1znrYjmL9
 YKVxtZ60eoQhbR2IMvg5RqnNX5u+bcVUMaqpeGqDmUAiLvN8oRA87CIzTbiS9npcq/5UyIiX1cd
 GXgbSgCuyCkr22p9Bn045Sk8VUW+PzyHMHKHynHqzkJziDC5NRZot3fJ7jpSeOAzyZ0fhqi+taI
 hrClK7cHMtuNM5hm/+sKTgx2ABAqvgPhL2fLwhDBApII4FSwghzxjC/523tBTbyivzwFHUXru2w
 sHCy96cCBZfA8POcMHxn4RATatunEo6AsGK7Ur5HwSdee+1OoQVf8EBL6GXQenpztWMUj7lcfP1
 aoKIUPPdJdijFJmEDvhVeYokq+Eqp7+B3aueKM/q94xsutLkZyb/wkVvLxA2BSQnceX9JIK2BZW
 JYv69gkXFzrqMswNsLOdZY8LpaKhLvvZsab9WqnY4Bp3iGIXRDmhKA9yLUE/4smw7ww7W0fmknb CgRu0hjNCxAnfGA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cKPo2CJpkuWeVElcqu2Eyq3AHxV56iPr
X-Authority-Analysis: v=2.4 cv=O480fR9W c=1 sm=1 tr=0 ts=697257b8 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=10lJyrFIdA-fwsh8KigA:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: cKPo2CJpkuWeVElcqu2Eyq3AHxV56iPr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyOCBTYWx0ZWRfX6PXZ1ThTGIL6
 ots2NejgeNxcv07sS4EEbmsnk7kXDE/a4FrG5jXjMbm/8rrYMTHnkkNhJm6xb3x12daZRn0Q6Sw
 bEiDV7PSjWZgiF9Z5ule9t8b2k77FFEuPt+J3wehv2xkMd1tdFTgqGs3kYnjC3qzV+hs5Og1VBM
 HgDQqTgcMFRU3+JfdZ6XHCA+XRdF+h48hvs98DB2dYgyvqfdmaZMGA0s/F14JcWmbueYE/OC/vu
 6xrYwoG54SF49YOY/wORJoec5wrzb5CQoKt2a7n8pKuRR8V0GVI4k197Wvj2fgGYjPirUfZ/NAb
 leQ5Jmv0mbUlbQ1iM3Qs1q6Yf0pkiNToLVA1kv+KdDdhBQzIJc8HOUdAK90txKjoIwvlqIpfyI4
 mObNlG4qIB3ViERva3AwVoRArrHp28p/3rK6io1lKnLR625uawhqFtREvDTSOVu5bHpaMylo8Ma
 /ETdyHlyB43F1+39jYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220128

Revert commit bfc467db60b7 ("serial: remove redundant
tty_port_link_device()") because the tty_port_link_device() is not
redundant: the tty->port has to be confured before we call
uart_configure_port(), otherwise user-space can open console without TTY
linked to the driver.

This tty_port_link_device() was added explicitly to avoid this exact
issue in commit fb2b90014d78 ("tty: link tty and port before configuring
it as console"), so offending commit basically reverted the fix saying
it is redundant without addressing the actual race condition presented
there.

Reproducible always as tty->port warning on Qualcomm SoC with most of
devices disabled, so with very fast boot, and one serial device being
the console:

  printk: legacy console [ttyMSM0] enabled
  printk: legacy console [ttyMSM0] enabled
  printk: legacy bootconsole [qcom_geni0] disabled
  printk: legacy bootconsole [qcom_geni0] disabled
  ------------[ cut here ]------------
  tty_init_dev: ttyMSM driver does not set tty->port. This would crash the kernel. Fix the driver!
  WARNING: drivers/tty/tty_io.c:1414 at tty_init_dev.part.0+0x228/0x25c, CPU#2: systemd/1
  Modules linked in: socinfo tcsrcc_eliza gcc_eliza sm3_ce fuse ipv6
  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G S                  6.19.0-rc4-next-20260108-00024-g2202f4d30aa8 #73 PREEMPT
  Tainted: [S]=CPU_OUT_OF_SPEC
  Hardware name: Qualcomm Technologies, Inc. Eliza (DT)
  ...
  tty_init_dev.part.0 (drivers/tty/tty_io.c:1414 (discriminator 11)) (P)
  tty_open (arch/arm64/include/asm/atomic_ll_sc.h:95 (discriminator 3) drivers/tty/tty_io.c:2073 (discriminator 3) drivers/tty/tty_io.c:2120 (discriminator 3))
  chrdev_open (fs/char_dev.c:411)
  do_dentry_open (fs/open.c:962)
  vfs_open (fs/open.c:1094)
  do_open (fs/namei.c:4634)
  path_openat (fs/namei.c:4793)
  do_filp_open (fs/namei.c:4820)
  do_sys_openat2 (fs/open.c:1391 (discriminator 3))
  ...
  Starting Network Name Resolution...

Apparently the flow with this small Yocto-based ramdisk user-space is:

driver (qcom_geni_serial.c):                  user-space:
============================                  ===========
qcom_geni_serial_probe()
 uart_add_one_port()
  serial_core_register_port()
   serial_core_add_one_port()
    uart_configure_port()
     register_console()
    |
    |                                         open console
    |                                         ...
    |                                         tty_init_dev()
    |                                         driver->ports[idx] is NULL
    |
    tty_port_register_device_attr_serdev()
     tty_port_link_device() <- set driver->ports[idx]

Fixes: bfc467db60b7 ("serial: remove redundant tty_port_link_device()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/tty/serial/serial_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0534b2eb1682..116f33f0643f 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3077,6 +3077,7 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	if (uport->cons && uport->dev)
 		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
 
+	tty_port_link_device(port, drv->tty_driver, uport->line);
 	uart_configure_port(drv, state, uport);
 
 	port->console = uart_console(uport);
-- 
2.51.0

