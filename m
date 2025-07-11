Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7188E1EA7CE;
	Fri, 11 Jul 2025 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752264288; cv=none; b=eHo7TPPHn3UJ2Da3/522WGJ8aAtCSmOVpbfJ1slHTAVhSiU5k7dFpPi3TwWbSzwJDmrL7ySAUv/z7ctPE36JwOHp8A0HxKq/VngZsjFNTcaXua5LCW65t4yX319aTZhwpDCOEhEURtXU50noDyNtTQHV3jU/piZFy9dJ49FvMXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752264288; c=relaxed/simple;
	bh=6NorXV6tSs9hqji6X+APo2yWkkSyubB64ZcVe6A8MoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0cvs6b9Mc4fKq1OIeBySrnSiqpAB7XwsmpPc1k1XKyzt9C0zOWk6io517Gjy7/rFWqMEghjyhpaV1epjBLJGsG4RgN5uHkgAfiFMywMHfGsmtfNnAopkpYN8mc+JQ0PsK/TVABZO4o0Jf0LLQdkFsKDiXUZTbQyteVSCHLsJjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emerson.com; spf=pass smtp.mailfrom=emerson.com; dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b=eUx3ptu4; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emerson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emerson.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b="eUx3ptu4"
Received: from pps.filterd (m0484886.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BJFaql001610;
	Fri, 11 Jul 2025 20:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=email; bh=lCGm
	ygN1cRo1pNmv5ksVI7kbuIEjAbYmX9inj2jf1WQ=; b=eUx3ptu43artRaCDCq/v
	+ZGdSF8lJUjcjz/0Kx1x76g/I58E8kAEWPuXmGx2GNm+rN/u7VREvfEu3H+W/FB0
	V1wLbzDTbrbys4bzJeHOQtbSUCz33mWpCvokDr08CUTsjwXOzJyMqUUcvKcsUMMU
	bQhE56Ik3zxteoBPjC4Xw3bWOwbJDHT5vlGr6Kx0F8hbe1nioepV39XEXgf6RsYK
	I4l4GeOgqO++BDuGEaBbQjUSnvDYi2itb7FrJAh4CUiJWOXas9xhS6DnFxysxzaw
	b8nXXpKyXabj6R7UHjTW0CHSZpEMspOQHDBrQsm140sXBEURYjdUDz5p+e5xyEFz
	zw==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 47u0r1uv00-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 20:04:44 +0000 (GMT)
Received: from us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 11 Jul 2025 15:04:42 -0500
Received: from cvadrevu-p620.ni.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Fri, 11 Jul 2025 15:04:42
 -0500
From: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Chaitanya
 Vadrevu" <chaitanya.vadrevu@emerson.com>,
        Jason Smith
	<jason.smith@emerson.com>,
        Gratian Crisan <gratian.crisan@emerson.com>
Subject: [PATCH v2 2/2] serial: 8250_ni: Reorder local variables
Date: Fri, 11 Jul 2025 15:04:18 -0500
Message-ID: <20250711200418.1858682-3-chaitanya.vadrevu@emerson.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711200418.1858682-1-chaitanya.vadrevu@emerson.com>
References: <20250711200418.1858682-1-chaitanya.vadrevu@emerson.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=UthjN/wB c=1 sm=1 tr=0 ts=68716e5c cx=c_pps a=VUOoxcgKHUMpfFMIT0tLvw==:117 a=VUOoxcgKHUMpfFMIT0tLvw==:17 a=Wb1JkmetP80A:10 a=geDs06hvAAAA:8 a=VwQbUJbxAAAA:8 a=_-qth1s1uTPojGrxLXwA:9 a=7yvi0DHx91fDKfvzWsLo:22
X-Proofpoint-GUID: 9RwaMJQfKfiBPBQoeEs5IfyZCdBwIxD6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE1MCBTYWx0ZWRfX5prVm5EOSg0x zG3QDZmEb7YTWv9NaF9o6flqFQanCGNro3vFytcGezDKpjgJvR1a+Fy2cbffahacGSLssD/yU0/ Z3vJPmVWqaN9VAAwJiiM8pd9ZkyzTweAQzNYNqoDFpo32SobrTmwB89DjFdxsS5YobIxRmQdq9z
 yKRUCFIfAwFBu48OZBCyvZYdq01049s0MmywdDl80rStf+ZlOn0qJ+0S3UkEkdbF9nBPGigyz3U CurxgtEIpJB/g+k7Q0reRRhYDmo2efWe327TXMoTi1cbm22OtUy1kjSnA3CyD4QFJAg/EiQH2MS Sf7NqZ1Gb2nLhvlRAXvFXHbqull+gD71bQknYqBbqA3Yjcyj636x9eSlVn+t4lKlA1KnBnGzsQX
 olsDqhkUWeHG3+t0pyxOGnRvluMpjoislJSUxbfK17Y/kDcemLxsd82X6lJbUGowFhi6UEAX
X-Proofpoint-ORIG-GUID: 9RwaMJQfKfiBPBQoeEs5IfyZCdBwIxD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 spamscore=0 mlxlogscore=865 phishscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110150

Reorder local variables in ni16550_probe to follow reverse Christmas
tree style.

Cc: Jason Smith <jason.smith@emerson.com>
Cc: Gratian Crisan <gratian.crisan@emerson.com>
Signed-off-by: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_ni.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
index 81f2255012153..cb5b42b3609c9 100644
--- a/drivers/tty/serial/8250/8250_ni.c
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -275,12 +275,12 @@ static void ni16550_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 static int ni16550_probe(struct platform_device *pdev)
 {
+	struct uart_8250_port *uart __free(kfree) = NULL;
 	const struct ni16550_device_info *info;
 	struct device *dev = &pdev->dev;
-	struct uart_8250_port *uart __free(kfree) = NULL;
 	unsigned int txfifosz, rxfifosz;
-	unsigned int prescaler;
 	struct ni16550_data *data;
+	unsigned int prescaler;
 	const char *portmode;
 	bool rs232_property;
 	int ret;
-- 
2.43.0

